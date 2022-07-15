
Widget = {}
Widget.__index = Widget

local ids = {}
local subscriptions = {}

Justify = {"Left", "Center", "Right"}

-- Global methods
function Widget.new()
    return setmetatable({}, Widget)
end

function Widget:AddChild(ins)
    local key = self.id
    bridge:CallBlueprintEvent("AddChild", key, ins.id)
end


function Widget:SetPadding(posx, posy)
    local id = self.id
    bridge:CallBlueprintEvent("SetPadding", posx, posy, id)
end

function Widget:SetTranslation(posx, posy)
    local id = self.id
    bridge:CallBlueprintEvent("SetPadding", id, posx, posy)
end

function Widget:SetSize(sizex, sizey)
    local id = self.id
    bridge:CallBlueprintEvent("SetWidgetSize", sizex, sizey, id)
end


function Widget:SetIsVisible(visible)
    bridge:CallBlueprintEvent("SetIsVisible", visible, self.id)
end

function Widget:SetSliderValue(value)
    bridge:CallBlueprintEvent("SetSliderValue", self.id, value)
end


function Widget:Subscribe(name, func)
    if not subscriptions[name] then
        subscriptions[name] = {}
    end

    table.insert(subscriptions[name], {func, tostring(self.id)})
end

function Widget:Unsubscribe(name, func)
    if not subscriptions[name] then
        subscriptions[name] = {}
    end

    for k,v in ipairs(subscriptions[name]) do
        if v.func == func then
            table.remove(subscriptions, k)
        end

    end
end

function TriggerElement(name, id, ...)
    if not subscriptions[name] then return end
    for k,v in ipairs(subscriptions[name]) do
        if v[2] == id then
            v[1](table.unpack(...))
        end

    end
end


function Widget:SetText(name)
    bridge:CallBlueprintEvent("SetText", self.id, name)
end

function Widget:SetTab(id)
    bridge:CallBlueprintEvent("SetTab", self.id, id)
end

function Widget:SetSelectedOption(name)
    bridge:CallBlueprintEvent("SetSelectedOption", self.id, name)
end

function Widget:ClearOptions()
    bridge:CallBlueprintEvent("ClearOptions", self.id)
end

function Widget:AddOption(name)
    bridge:CallBlueprintEvent("AddOption", self.id, name)
end

function Widget:RemoveOption(name)
    bridge:CallBlueprintEvent("RemoveOption", self.id, name)
end


-- Callers
Events.Subscribe("AUI_Trigger", function(args)
    local id = args[1]
    local event = args[2]

    local new_args = args
    table.remove(new_args, #new_args)

    table.remove(new_args, 1)
    table.remove(new_args, 1)

    if(new_args[1] ~= nil) then
        for k, v in ipairs(new_args) do
            local type = Split(v, "\\")
            local val = type[3]
            if type[1] == "number" then
                val = tonumber(val)
            end
            new_args[k] = val
        end

    end

    TriggerElement(event, id, new_args)
end)

-- Constructors
function Window(posx, posy, sizex, sizey, name)
    local ins = Widget.new()

    local key = #ids+1
    ids[key] = ins
    ins.id = key
    bridge:CallBlueprintEvent("CreateWindow", posx, posy, sizex, sizey, name, key)
    return ins
end

function Button(posx, posy, sizex, sizey)
    local ins = Widget.new()

    local key = #ids+1
    ids[key] = ins
    ins.id = key
    bridge:CallBlueprintEvent("CreateButton", posx, posy, sizex, sizey, key)
    return ins
end


function Text(posx, posy, sizex, sizey, text, fontsize, justify)
    local ins = Widget.new()

    local key = #ids+1
    ids[key] = ins
    ins.id = key

    local justifyid = 0
    if justify == "Left" then justifyid = 0 end
    if justify == "Center" then justifyid = 1 end
    if justify == "Right" then justifyid = 2 end

    
    bridge:CallBlueprintEvent("CreateText", posx, posy, sizex, sizey, key, text, fontsize, justifyid)
    return ins
end

function TextBox(posx, posy, sizex, sizey, text, fontsize, hinttext)
    local ins = Widget.new()

    local key = #ids+1
    ids[key] = ins
    ins.id = key
    
    bridge:CallBlueprintEvent("CreateTextbox", posx, posy, sizex, sizey, key, text, fontsize, hinttext)
    return ins
end

function Image(posx, posy, sizex, sizey, url)
    local ins = Widget.new()

    local key = #ids+1
    ids[key] = ins
    ins.id = key
    
    bridge:CallBlueprintEvent("CreateImage", posx, posy, sizex, sizey, key, url)
    return ins
end

function Slider(posx, posy, sizex, sizey, min, max)
    local ins = Widget.new()

    local key = #ids+1
    ids[key] = ins
    ins.id = key

    local s_min = tostring(min)
    local s_max = tostring(max)

    bridge:CallBlueprintEvent("CreateSlider", posx, posy, sizex, sizey, key, s_min, s_max)
    return ins
end

function ComboBox(posx, posy, sizex, sizey)
    local ins = Widget.new()

    local key = #ids+1
    ids[key] = ins
    ins.id = key

    bridge:CallBlueprintEvent("CreateComboBox", posx, posy, sizex, sizey, key)
    return ins
end



-- Panels constructors
function HorizontalBox(posx, posy, sizex, sizey)
    local ins = Widget.new()

    local key = #ids+1
    ids[key] = ins
    ins.id = key
    bridge:CallBlueprintEvent("CreateHorizontalPanel", posx, posy, sizex, sizey, key)
    return ins
end

function VerticalBox(posx, posy, sizex, sizey)
    local ins = Widget.new()

    local key = #ids+1
    ids[key] = ins
    ins.id = key
    bridge:CallBlueprintEvent("CreateVerticalPanel", posx, posy, sizex, sizey, key)
    return ins
end

function ScrollBox(posx, posy, sizex, sizey, isHorizontal)
    local ins = Widget.new()

    local key = #ids+1
    ids[key] = ins
    ins.id = key
    bridge:CallBlueprintEvent("CreateScrollbox", posx, posy, sizex, sizey, key, isHorizontal)
    return ins
end

function TabSwitcher(posx, posy, sizex, sizey)
    local ins = Widget.new()

    local key = #ids+1
    ids[key] = ins
    ins.id = key
    bridge:CallBlueprintEvent("CreateTabSwitcher", posx, posy, sizex, sizey, key, isHorizontal)
    return ins
end

-- HELPERS

function GetValue(name, id)
    bridge:CallBlueprintEvent(name, id)
    local tags = properties:GetActorTags()
    properties:RemoveActorTag(tags[1])
    return tags[1]
end

function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
-- GET METHODS


function Widget:GetText()
    return GetValue("GetText", self.id)
end

function Widget:IsVisible()
    local value = false
    
    local v = GetValue("GetIsVisible", self.id)
    if v == "true" then
        value = true
    else
        value = false
    end

    return value
end

function Widget:GetSliderValue()
    return tonumber(GetValue("GetSliderValue", self.id))
end

function Widget:GetSize()
    local value = GetValue("GetSliderValue", self.id)
    local splitted = Split(value, "''")

    local x = tonumber(splitted[1])
    local y = tonumber(splitted[2])

    return x,y
end

function Widget:GetTab()
    return tonumber(GetValue("GetTab", self.id))
end

function Widget:GetSelectedOption()
    return GetValue("GetSelectedOption", self.id)
end

