import type { Plugin } from "@opencode-ai/plugin"

export const NotificationPlugin: Plugin = async ({ project, client, $, directory, worktree }) => {
  return {
    event: async ({ event }) => {
      // Send notification on session completion
      if (event.type === "session.idle") {
        await $`notify-send -t 0 "Opencode:" "Session Complete!"`
      }
      if (event.type === "permission.asked") {
        await $`notify-send -t 0 "Opencode:" "Need Permission!"`
      }
    },
  }
}
