function makemkv_fish
  docker run -d \
      --name=makemkv \
      -p 5800:5800 \
      -v /docker/appdata/makemkv:/config:rw \
      -v $HOME/hdd1/dvds_raw/:/storage:ro \
      -v $HOME/hdd1/dvds_raw/output:/output:rw \
      --device /dev/sr0 \
      jlesage/makemkv
end
