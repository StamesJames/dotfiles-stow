function pycalc --description "Open a Python REPL pre-loaded as a calculator (math, numpy, scipy)"
    set -l config_dir ~/.config/pycalc
    set -l config_file $config_dir/calc_config.py
    set -l startup_file $config_dir/startup.py

    mkdir -p $config_dir

    # Create a default config file the first time pycalc is run.
    if not test -f $config_file
        echo "# pycalc custom config
#
# Anything you define here (functions, constants, imports) becomes
# directly available inside the pycalc REPL - no import needed.
#
# Examples:
#
# def deg2rad(x):
#     return x * pi / 180
#
# def rad2deg(x):
#     return x * 180 / pi
#
# GOLDEN_RATIO = (1 + sqrt(5)) / 2
" > $config_file
        echo "pycalc: created default config at $config_file"
    end

    # (Re)generate the startup script every run, so it always matches
    # this function's version. Customize calc_config.py instead.
    echo "
import math
from math import *
import numpy as np
from numpy import *
import scipy
import scipy as sp
import scipy.integrate
import scipy.optimize
import scipy.linalg
import scipy.stats

import os as _os
_config_file = _os.path.expanduser('$config_file')
if _os.path.exists(_config_file):
    with open(_config_file) as _f:
        exec(_f.read(), globals())
    del _f
del _os, _config_file

print('pycalc ready -> math functions are bare (exp, sin, sqrt, pi, ...), '
      'numpy as np, scipy as sp/scipy. Edit $config_file to add your own.')
" > $startup_file

    env PYTHONSTARTUP=$startup_file python3 -i
end
