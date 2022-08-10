local Application = require "atlas.application"
local Route = require "atlas.route"
local Response = require "atlas.response"

local leds = io.open("/dev/userleds", "wb")

function home()
    local uname = luv.os_uname()

    local hello = "Hello from " .. uname.sysname .. " " .. uname.release
    local mem = "Using " .. collectgarbage("count") .. " Kb"
    local links = "Go to <a href=/on>On</a> or <a href=/off>Off</a> to set Led"

    local response = ""
    for _, content in ipairs({hello, mem, links}) do
        response = response .. "<p>" .. content .. "</p>"
    end

    return response
end

function led(state)
    leds:ioctl(ioctls.ULEDIOC_SETLED, 0, state)
    return "Led set " .. (state and "On" or "Off")
end

local controllers = {
    home = function(request) return Response(home()) end,
    on = function(request) return Response(led(true), "text/plain") end,
    off = function(request) return Response(led(false), "text/plain") end
}

local routes = {
    Route("/", controllers.home), Route("/on", controllers.on),
    Route("/off", controllers.off)
}

local app = Application(routes)

return {app = app}
