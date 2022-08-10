local main = require("atlas.server.main")

local config = { host = "0.0.0.0", port = 80, app = "app.app:app" }

-- kick off coroutine
coroutine.wrap(function()
    local status = main.run(config)
    os.exit(status)
end)()
