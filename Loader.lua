local StarterGui = game:GetService("StarterGui")
print("version: 0.0.2")
local function safeLoad(name, url)

    local function notify(msg)
        StarterGui:SetCore("SendNotification", {
            Title = "[Script Loader]",
            Text = msg,
            Duration = 6
        })
    end


    local successFetch, result = pcall(function()
        return game:HttpGet(url)
    end)

    if not successFetch then
        warn("["..name.."] Failed to fetch URL:", result)
        notify(name .. " failed to load (fetch error)")
        return
    end


    local successCompile, func = pcall(function()
        return loadstring(result)
    end)

    if not successCompile then
        warn("["..name.."] Syntax error:", func)
        notify(name .. " has syntax error")
        return
    end


    local successRun, runtimeError = pcall(func)

    if not successRun then
        warn("["..name.."] Runtime error:", runtimeError)
        notify(name .. " encountered runtime error")
        return
    end

    print("["..name.."] Loaded successfully!")
end

safeLoad("GR Loader", "https://other.4x4z.lol/v1/gr")
safeLoad("OPTIMIZER Loader", "https://other.4x4z.lol/v1/optimizer")
