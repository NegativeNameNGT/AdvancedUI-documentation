# AdvancedUI-documentation

Example:

![image](https://user-images.githubusercontent.com/79408258/179121633-1eda1f4a-98d1-4d52-b677-65da8acb415f.png)

```lua
Package.RequirePackage("advancedui")

Client.SetMouseEnabled(true)
local myWindow = Window(50, 50, 400, 300, "Character Creator")
local Container = VerticalBox(0, 0, 10, 10)
local CreateBtn = Button(0, 0, 10, 10)
local name_txtbox = TextBox(0, 0, 10, 10, "", 24, "Name")
local city_txtbox = TextBox(0, 0, 10, 10, "", 24, "City")
local label = Text(0, 0, 0, 0, "Create", 24, Justify.Center)

myWindow:AddChild(Container)
Container:AddChild(name_txtbox)
Container:AddChild(city_txtbox)
Container:AddChild(CreateBtn)
CreateBtn:AddChild(label)
city_txtbox:SetPadding(0, 10)
CreateBtn:SetPadding(0, 10)

CreateBtn:Subscribe("OnClicked", function()
    local name = name_txtbox:GetText()
    local city = city_txtbox:GetText()
end)

myWindow:Subscribe("OnCloseButtonClicked", function()
    myWindow:SetIsVisible(false)
end)
```

Elements

- Containers

```lua
local box = HorizontalBox(posx, posy, sizex, sizey)

local box = VerticalBox(posx, posy, sizex, sizey)

local box = ScrollBox(posx, posy, sizex, sizey, isHorizontalScroll)

local box = TabSwitcher(posx, posy, sizex, sizey)
```

- Constructors

```lua
local myWindow = Window(posx, posy, sizex, sizey, displayedname)

local myButton = Button(posx, posy, sizex, sizey)

local myText = Text(posx, posy, sizex, sizey, text, fontsize, justify)

local myTextBox = TextBox(posx, posy, sizex, sizey, text, fontsize, hint_text)

local myImage = Image(posx, posy, sizex, sizey, text, url) -- only works with url! example: https://docs.nanos.world/img/nanos-world.png

local mySlider = Slider(posx, posy, sizex, sizey, min, max)

local myComboBox = ComboBox(posx, posy, sizex, sizey)

local myCheckBox = CheckBox(posx, posy, sizex, sizey)

local myProgressBar = ProgressBar(posx, posy, sizex, sizey)

local mySpacer = Spacer(posx, posy, sizex, sizey, spacerx, spacery) -- spacerx & spacery are number arguments

```

Methods

- Global

```lua
Widget:AddChild(widget)

Widget:SetPadding(posx, posy)

Widget:GetPadding() -- returns a table of numbers; [1] = x, [2] = y

Widget:SetTranslation(posx, posy)

Widget:GetTranslation() -- returns a table of numbers; [1] = x, [2] = y

Widget:SetSize(sizex, sizey)

Widget:GetSize() -- returns a table of numbers; [1] = x, [2] = y

Widget:SetIsVisible(is_visible)

Widget:IsVisible() -- returns a boolean
```

- Slider

```lua
Widget:SetSliderValue(value)

Widget:GetSliderValue(widget) -- returns a number
```

- Text/TextBox

```lua
Widget:SetText(text)

Widget:GetText()

```
- Tab Switcher

```lua
Widget:SetTab(id)

Widget:GetTab() -- returns a number
```

- ComboBox

```lua
Widget:SetSelectedOption(string)

Widget:GetSelectedOption() -- returns a string

Widget:ClearOptions()

Widget:AddOption(name)

Widget:RemoveOption(name)
```

- Checkbox

```lua
Widget:SetCheckedState(ischecked)

Widget:GetCheckedState() -- returns a boolean
```

- Progress Bar

```lua
Widget:SetProgressBarValue(value)

Widget:GetProgressBarValue()

Widget:SetProgressBarColor(color)

Widget:GetProgressBarColor()
```
Events:

- Window

```lua
myWindow:Subscribe("OnCloseButtonClicked", function()

end)
```

- TextBox

```lua
myTextBox:Subscribe("OnTextChanged", function(new_text)

end)
```

- Slider

```lua
mySlider:Subscribe("Slider_Begin", function()

end)

mySlider:Subscribe("Slider_End", function()

end)

mySlider:Subscribe("Slider_ValueChanged", function(new_value)

end)
```

- Image

```lua
myImage:Subscribe("OnClicked", function()

end)
```

- Button

```lua
myButton:Subscribe("OnClicked", function()

end)

myButton:Subscribe("OnHovered", function()

end)

myButton:Subscribe("OnUnHovered", function()

end)
```

- Combo Box

```lua
myCombobox:Subscribe("OnSelectionChanged", function(selected)

end)
```

- Checkbox

```lua
myCheckbox:Subscribe("StateChanged", function(checked)

end)
```
