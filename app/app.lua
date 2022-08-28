local Application = require("atlas.application")
local Route = require("atlas.route")
local Response = require("atlas.response")
local luv = luv or require("luv")

function home()
    local uname = luv.os_uname()

    local hello = "Hello from " .. uname.sysname .. " " .. uname.release
    local mem = "Using " .. collectgarbage("count") .. " Kb"
    local links = "Go to <a href=/on>On</a> or <a href=/off>Off</a> to set Led"

    local html =
        "<html><head><link rel=stylesheet href=http://cdn.jsdelivr.net/npm/water.css/out/water.css></head><body>"

    for _, content in ipairs({hello, mem, links}) do
        html = html .. "<p>" .. content .. "</p>"
    end

    return html .. "</body></html>"
end

function led(state)
    local leds = io.open("/dev/userleds", "wb")
    if leds then
        leds:ioctl(ioctls.ULEDIOC_SETLED, 0, state)
        io.close(leds)
    end
    return "Led set " .. (state and "On" or "Off")
end

local controllers = {
    on = function(request) return Response(led(true), "text/plain") end,
    off = function(request) return Response(led(false), "text/plain") end,
    home = function(request) return Response(home()) end
}

local routes = {
    Route("/on", controllers.on), Route("/off", controllers.off),
    Route("/", controllers.home)
}
local app = Application(routes)
return {app = app}
