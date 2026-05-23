local mod = "SUPER"
local terminal = "ghostty"
local hs = require("hyprsplit")

hs.config({
  num_workspaces = 10,
  persistent_workspaces = true,
})

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({ output = "DP-3", mode = "3440x1440@165", position = "0x0", scale = 1.25 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "2752x0", scale = 1 })

hl.config({
  general = {
    layout = "scrolling",
  },
  input = {
    kb_layout = "us",
    kb_variant = "intl",
  },
})

hl.bind(mod .. " + M", hl.dsp.exit())
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + D", hl.dsp.exec_cmd("dms ipc spotlight toggle"))

for i = 1, 9 do
  hl.bind(mod .. " + " .. i, hs.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. i, hs.dsp.window.move({ workspace = i, follow = true }))
end
hl.bind(mod .. " + 0", hs.dsp.focus({ workspace = 10 }))
hl.bind(mod .. " + SHIFT + 0", hs.dsp.window.move({ workspace = 10, follow = true }))

hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "d" }))
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "d" }))

hl.bind(mod .. " + F", hl.dsp.window.fullscreen({}))
hl.bind(mod .. " + V", hl.dsp.window.float({}))

hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind(mod .. " + space", hl.dsp.exec_cmd("dms ipc spotlight toggle"))
hl.bind(mod .. " + C", hl.dsp.exec_cmd("dms ipc clipboard toggle"))
hl.bind(mod .. " + A", hl.dsp.exec_cmd("dms ipc control-center toggle"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("dms ipc notifications toggle"))
hl.bind(mod .. " + escape", hl.dsp.exec_cmd("dms ipc powermenu toggle"))
hl.bind(mod .. " + slash", hl.dsp.exec_cmd("dms ipc keybinds toggle"))

hl.bind(mod .. " + bracketright", hl.dsp.layout("colresize +conf"))
hl.bind(mod .. " + P", hl.dsp.layout("promote"))
hl.bind(mod .. " + comma", hl.dsp.layout("consume_or_expel prev"))
hl.bind(mod .. " + period", hl.dsp.layout("consume_or_expel next"))

hl.bind(mod .. " + tab", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mod .. " + SHIFT + tab", hl.dsp.window.move({ monitor = "+1", follow = true }))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc audio increment"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc audio decrement"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("dms ipc brightness increment"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("dms ipc brightness decrement"), { repeating = true, locked = true })

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("dms ipc audio mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("dms ipc audio micmute"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("dms ipc mpris playPause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("dms ipc mpris playPause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("dms ipc mpris next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("dms ipc mpris previous"), { locked = true })
