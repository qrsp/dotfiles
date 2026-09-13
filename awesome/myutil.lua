local awful = require("awful")
local naughty = require("naughty")

local myutil = {}

-- notify
naughty.config.defaults.position = "top_middle"

function myutil.replaced_notify(args)
  if _notification ~= nil then
    args["replaces_id"] = _notification.id
  end
  _notification = naughty.notify(args)
end

-- volume
function myutil.volume_stat()
  local cmd = {"bash", "-c", "sleep 0.1; amixer -D pipewire get Master"}
  awful.spawn.easy_async(cmd, function(stdout, stderr, reason, exit_code)
    local _, _, vol, state = string.find(stdout, "%[(%d+)%%%] %[(%a+)%]")
    myutil.replaced_notify({
      title = "Volume",
      text = string.format("%4s%4s", vol, state),
      timeout = 2,
      position = "top_middle" })
  end)
end

-- tab overview
local overview_tab = nil
function myutil.overview()
  if overview_tab == nil then
    overview_tab = awful.tag.add("0", {
        screen = awful.screen.focused(),
        layout = awful.layout.suit.fair,
        volatile = true })

    for _, c in ipairs(client.get()) do
        c:toggle_tag(overview_tab)
    end

    overview_tab:view_only()
  else
    for _, c in ipairs(overview_tab:clients()) do
        c:toggle_tag(overview_tab)
    end
    overview_tab = nil
  end
end

function myutil.delete_tag()
    local t = awful.screen.focused().selected_tag
    if not t then return end
    t:delete()
end

-- xrandr
function myutil.xrandr(delta)
  local cmd = {"bash", "-c", "xrandr --current --verbose"}
  awful.spawn.easy_async(cmd,
    function(stdout, stderr, reason, exit_code)
      if myutil.xrandr_info == nil then
        myutil.xrandr_info = {}
        local out = string.match(stdout, "([%w%-]+) connected primary")
        if out == nil then
          out = string.match(stdout, "([%w%-]+) connected")
        end
        myutil.xrandr_info["out"] = out
        myutil.xrandr_info["brightness"] = string.match(stdout, "Brightness: ([%d.]+)")
      end

      myutil.xrandr_info["brightness"] = myutil.xrandr_info["brightness"] + delta
      awful.util.spawn("xrandr --output " .. myutil.xrandr_info["out"] .. " --brightness " .. myutil.xrandr_info["brightness"])

      myutil.replaced_notify({
        title = "Brightness",
        text = string.format("%-6s %.2f", myutil.xrandr_info["out"], myutil.xrandr_info["brightness"]),
        timeout = 2,
        position = "top_middle" })
    end)
end

-- xgamma
myutil.gamma = 1

function myutil.xgamma(delta)
  myutil.gamma = myutil.gamma + delta
  awful.util.spawn("xgamma -gamma " .. myutil.gamma)

  myutil.replaced_notify({
    title = "Gamma",
    text = string.format("   %.2f", myutil.gamma),
    timeout = 2,
    position = "top_middle" })
end


-- focus
function myutil.focus_without_ontop(idx)
  local focused_client = awful.client.focus
  local i = idx
  local next_client = nil

  repeat
    next_client = awful.client.next(i)
    if next_client.ontop and next_client.sticky then
      local direction = (idx > 0) and 1 or -1
      i = i + direction
    else
      break
    end
  until focused_client ~= next_client

  awful.client.focus.byidx(i)
end

-- -- nb
-- do
--   local cmd = {"bash", "-c", "xrandr --current --verbose"}
--   awful.spawn.easy_async(cmd,
--     function(stdout, stderr, reason, exit_code)
--       local out = string.match(stdout, "([%w%-]+) connected primary")
--       if out == nil then
--         redvalue = {brightness = 1, gamma = 0.6, temp = 5000}
--       else
--         -- more than one monitor connected
--         redvalue = {brightness = 1, gamma = 0.95, temp = 3900}
--       end
--       redshift()
--   end)
-- end

return myutil
