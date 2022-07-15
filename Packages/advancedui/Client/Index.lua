bridge = Blueprint(Vector(0,0,0), Rotator(0,0,0), "advancedui::AdvancedUIManager")
properties = Blueprint(Vector(0,0,0), Rotator(0,0,0), "advancedui::AUI_Properties")

local timer_interval = 50

local function ParseIntoArray(s, delimiter)
    local result = {};
        for match in (s..delimiter):gmatch("(.-)"..delimiter) do
            table.insert(result, match)
        end
        return result
end

Package.Subscribe("Load", function()
    Timer.SetInterval(function()
         for k,v in pairs(bridge:GetActorTags()) do
             local name = ParseIntoArray(v, "&")
             local params = ParseIntoArray(name[2], "||")
             Events.Call(name[1], params)
             bridge:RemoveActorTag(v)
         end
    end, timer_interval)
end)

Package.Require("advancedui.lua")