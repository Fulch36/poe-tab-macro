; To do:
; 1 - Make sure that colours start with a # when writing to ini file, loop through colour properties and adjust accordingly
; 2 - Shrink the UI down a bit, it doesn't need to be so wide
; 3 - Change name format of gui labels to: gui_b1_text etc
; 4 - COMMENTS, YOU LAZY PIECE OF SHIT

#NoEnv
#Singleinstance force
SetWorkingDir %A_ScriptDir%

; ****************************************************
;
; Init
;
; ****************************************************

if !FileExist("Config\Config.ini") {
  default_ini := "[variables]`n"
  default_ini .= "UpdateRate=250`n"
  default_ini .= "Ocr=0`n"
  default_ini .= "OcrRate=200`n"
  default_ini .= "[tabs]`n"
  default_ini .= "Button1Text=`n"
  default_ini .= "Button1Colour=#CFCFCF`n"
  default_ini .= "Button1Alias=`n"
  default_ini .= "Button2Text=`n"
  default_ini .= "Button2Colour=#CFCFCF`n"
  default_ini .= "Button2Alias=`n"
  default_ini .= "Button3Text=`n"
  default_ini .= "Button3Colour=#CFCFCF`n"
  default_ini .= "Button3Alias=`n"
  default_ini .= "Button4Text=`n"
  default_ini .= "Button4Colour=#CFCFCF`n"
  default_ini .= "Button4Alias=`n"
  default_ini .= "Button5Text=`n"
  default_ini .= "Button5Colour=#CFCFCF`n"
  default_ini .= "Button5Alias=`n"
  default_ini .= "Button6Text=`n"
  default_ini .= "Button6Colour=#CFCFCF`n"
  default_ini .= "Button6Alias=`n"
  default_ini .= "Button7Text=`n"
  default_ini .= "Button7Colour=#CFCFCF`n"
  default_ini .= "Button7Alias=`n"
  default_ini .= "Button8Text=`n"
  default_ini .= "Button8Colour=#CFCFCF`n"
  default_ini .= "Button8Alias=`n"
  default_ini .= "Button9Text=`n"
  default_ini .= "Button9Colour=#CFCFCF`n"
  default_ini .= "Button9Alias=`n"
  default_ini .= "Button10Text=`n"
  default_ini .= "Button10Colour=#CFCFCF`n"
  default_ini .= "Button10Alias=`n"
  default_ini .= "[hotkeys]`n"
  default_ini .= "OverlayToggleHotkey=^F2`n"
  default_ini .= "Button1Hotkey=^1`n"
  default_ini .= "Button2Hotkey=^2`n"
  default_ini .= "Button3Hotkey=^3`n"
  default_ini .= "Button4Hotkey=^4`n"
  default_ini .= "Button5Hotkey=^5`n"
  default_ini .= "Button6Hotkey=^6`n"
  default_ini .= "Button7Hotkey=^7`n"
  default_ini .= "Button8Hotkey=^8`n"
  default_ini .= "Button9Hotkey=^9`n"
  default_ini .= "Button10Hotkey=^0"

  FileAppend %default_ini%, Config\Config.ini, UTF-16
  no_config := true
}

readConfigFile()

if (!FileExist("Web\Gui.css") or no_config) {
  writeStyles() 
}

; ****************************************************
;
; GUI
;
; ****************************************************

Gui Add, Text, x10 y14 w120 h23, Client Read Rate:
Gui Add, Edit, vguiUpdate_rate x145 y10 w120 h23, %update_rate%

Gui Add, Text, x10 y44 w120 h23, Screen Scan Rate:
Gui Add, Edit, vguiOcr_rate x145 y40 w120 h23, %ocr_rate%

Gui Add, Text, x415 y14 w120 h23, Auto Show Overlay:
Gui Add, Checkbox, vguiOcr x550 y10 w120 h23 Checked%ocr%

Gui Add, Text, x415 y44 w120 h23, Overlay Hotkey:
Gui Add, Hotkey, vguiHotkeyOverlay x550 y40 w120 h23, %overlay_toggle_hk%

Gui Add, Text, x145 y100 w120 h23, Tab Name:
Gui Add, Text, x280 y100 w120 h23, Tab Colour:
Gui Add, Text, x415 y100 w120 h23, Tab Alias:
Gui Add, Text, x550 y100 w120 h23, Tab Hotkey:

Gui Add, Text, x10 y122 w120 h23, Tab 1:
Gui Add, Edit, vguiB1_text x145 y118 w120 h23, %b1_text%
Gui Add, Edit, vguiB1_colour x280 y118 w120 h23, %b1_colour%
Gui Add, Edit, vguiB1_alias x415 y118 w120 h23, %b1_alias%
Gui Add, Hotkey, vguiB1_hk x550 y118 w120 h23, %b1_hk%

Gui Add, Text, x10 y152 w120 h23, Tab 2:
Gui Add, Edit, vguiB2_text x145 y148 w120 h23, %b2_text%
Gui Add, Edit, vguiB2_colour x280 y148 w120 h23, %b2_colour%
Gui Add, Edit, vguiB2_alias x415 y148 w120 h23, %b2_alias%
Gui Add, Hotkey, vguiB2_hk x550 y148 w120 h23, %b2_hk%

Gui Add, Text, x10 y182 w120 h23, Tab 3:
Gui Add, Edit, vguiB3_text x145 y178 w120 h23, %b3_text%
Gui Add, Edit, vguiB3_colour x280 y178 w120 h23, %b3_colour%
Gui Add, Edit, vguiB3_alias x415 y178 w120 h23, %b3_alias%
Gui Add, Hotkey, vguiB3_hk x550 y178 w120 h23, %b3_hk%

Gui Add, Text, x10 y212 w120 h23, Tab 4:
Gui Add, Edit, vguiB4_text x145 y208 w120 h23, %b4_text%
Gui Add, Edit, vguiB4_colour x280 y208 w120 h23, %b4_colour%
Gui Add, Edit, vguiB4_alias x415 y208 w120 h23, %b4_alias%
Gui Add, Hotkey, vguiB4_hk x550 y208 w120 h23, %b4_hk%

Gui Add, Text, x10 y242 w120 h23, Tab 5:
Gui Add, Edit, vguiB5_text x145 y238 w120 h23, %b5_text%
Gui Add, Edit, vguiB5_colour x280 y238 w120 h23, %b5_colour%
Gui Add, Edit, vguiB5_alias x415 y238 w120 h23, %b5_alias%
Gui Add, Hotkey, vguiB5_hk x550 y238 w120 h23, %b5_hk%

Gui Add, Text, x10 y272 w120 h23, Tab 6:
Gui Add, Edit, vguiB6_text x145 y268 w120 h23, %b6_text%
Gui Add, Edit, vguiB6_colour x280 y268 w120 h23, %b6_colour%
Gui Add, Edit, vguiB6_alias x415 y268 w120 h23, %b6_alias%
Gui Add, Hotkey, vguiB6_hk x550 y268 w120 h23, %b6_hk%

Gui Add, Text, x10 y302 w120 h23, Tab 7:
Gui Add, Edit, vguiB7_text x145 y298 w120 h23, %b7_text%
Gui Add, Edit, vguiB7_colour x280 y298 w120 h23, %b7_colour%
Gui Add, Edit, vguiB7_alias x415 y298 w120 h23, %b7_alias%
Gui Add, Hotkey, vguiB7_hk x550 y298 w120 h23, %b7_hk%

Gui Add, Text, x10 y332 w120 h23, Tab 8:
Gui Add, Edit, vguiB8_text x145 y328 w120 h23, %b8_text%
Gui Add, Edit, vguiB8_colour x280 y328 w120 h23, %b8_colour%
Gui Add, Edit, vguiB8_alias x415 y328 w120 h23, %b8_alias%
Gui Add, Hotkey, vguiB8_hk x550 y328 w120 h23, %b8_hk%

Gui Add, Text, x10 y362 w120 h23, Tab 9:
Gui Add, Edit, vguiB9_text x145 y358 w120 h23, %b9_text%
Gui Add, Edit, vguiB9_colour x280 y358 w120 h23, %b9_colour%
Gui Add, Edit, vguiB9_alias x415 y358 w120 h23, %b9_alias%
Gui Add, Hotkey, vguiB9_hk x550 y358 w120 h23, %b9_hk%

Gui Add, Text, x10 y392 w120 h23, Tab 10:
Gui Add, Edit, vguiB10_text x145 y388 w120 h23, %b10_text%
Gui Add, Edit, vguiB10_colour x280 y388 w120 h23, %b10_colour%
Gui Add, Edit, vguiB10_alias x415 y388 w120 h23, %b10_alias%
Gui Add, Hotkey, vguiB10_hk x550 y388 w120 h23, %b10_hk%

Gui Add, Button, x10 y428 h35 w390 gupdateConfig, Save
Gui Add, Button, x415 y428 h35 w255 gGuiClose, Cancel

Gui Show
return

; ****************************************************
;
; Functions
;
; ****************************************************

readConfigFile() {
	global
  ; Vars
  IniRead, update_rate, Config\Config.ini, variables, UpdateRate
  IniRead, ocr, Config\Config.ini, variables, Ocr
  IniRead, ocr_rate, Config\Config.ini, variables, OcrRate

  ; Tab buttons
  IniRead, b1_text, Config\Config.ini, tabs, Button1Text
  IniRead, b1_colour, Config\Config.ini, tabs, Button1Colour
  IniRead, b1_alias, Config\Config.ini, tabs, Button1Alias
  IniRead, b2_text, Config\Config.ini, tabs, Button2Text
  IniRead, b2_colour, Config\Config.ini, tabs, Button2Colour
  IniRead, b2_alias, Config\Config.ini, tabs, Button2Alias
  IniRead, b3_text, Config\Config.ini, tabs, Button3Text
  IniRead, b3_colour, Config\Config.ini, tabs, Button3Colour
  IniRead, b3_alias, Config\Config.ini, tabs, Button3Alias
  IniRead, b4_text, Config\Config.ini, tabs, Button4Text
  IniRead, b4_colour, Config\Config.ini, tabs, Button4Colour
  IniRead, b4_alias, Config\Config.ini, tabs, Button4Alias
  IniRead, b5_text, Config\Config.ini, tabs, Button5Text
  IniRead, b5_colour, Config\Config.ini, tabs, Button5Colour
  IniRead, b5_alias, Config\Config.ini, tabs, Button5Alias
  IniRead, b6_text, Config\Config.ini, tabs, Button6Text
  IniRead, b6_colour, Config\Config.ini, tabs, Button6Colour
  IniRead, b6_alias, Config\Config.ini, tabs, Button6Alias
  IniRead, b7_text, Config\Config.ini, tabs, Button7Text
  IniRead, b7_colour, Config\Config.ini, tabs, Button7Colour
  IniRead, b7_alias, Config\Config.ini, tabs, Button7Alias
  IniRead, b8_text, Config\Config.ini, tabs, Button8Text
  IniRead, b8_colour, Config\Config.ini, tabs, Button8Colour
  IniRead, b8_alias, Config\Config.ini, tabs, Button8Alias
  IniRead, b9_text, Config\Config.ini, tabs, Button9Text
  IniRead, b9_colour, Config\Config.ini, tabs, Button9Colour
  IniRead, b9_alias, Config\Config.ini, tabs, Button9Alias
  IniRead, b10_text, Config\Config.ini, tabs, Button10Text
  IniRead, b10_colour, Config\Config.ini, tabs, Button10Colour
  IniRead, b10_alias, Config\Config.ini, tabs, Button10Alias

  ; Hotkeys
  IniRead, overlay_toggle_hk, Config\Config.ini, hotkeys, OverlayToggleHotkey, %A_Space%
  IniRead, b1_hk, Config\Config.ini, hotkeys, Button1Hotkey, %A_Space%
  IniRead, b2_hk, Config\Config.ini, hotkeys, Button2Hotkey, %A_Space%
  IniRead, b3_hk, Config\Config.ini, hotkeys, Button3Hotkey, %A_Space%
  IniRead, b4_hk, Config\Config.ini, hotkeys, Button4Hotkey, %A_Space%
  IniRead, b5_hk, Config\Config.ini, hotkeys, Button5Hotkey, %A_Space%
  IniRead, b6_hk, Config\Config.ini, hotkeys, Button6Hotkey, %A_Space%
  IniRead, b7_hk, Config\Config.ini, hotkeys, Button7Hotkey, %A_Space%
  IniRead, b8_hk, Config\Config.ini, hotkeys, Button8Hotkey, %A_Space%
  IniRead, b9_hk, Config\Config.ini, hotkeys, Button9Hotkey, %A_Space%
  IniRead, b10_hk, Config\Config.ini, hotkeys, Button10Hotkey, %A_Space%
}

writeConfigFile() {
  global
  Gui Submit
  updated_ini := "[variables]`n"
  updated_ini .= "UpdateRate=" . guiUpdate_rate . "`n"
  updated_ini .= "Ocr=" . guiOcr . "`n"
  updated_ini .= "OcrRate=" . guiOcr_rate . "`n"
  updated_ini .= "[tabs]`n"
  updated_ini .= "Button1Text=" . guiB1_text . "`n"
  updated_ini .= "Button1Colour=" . guiB1_colour . "`n"
  updated_ini .= "Button1Alias=" . guiB1_alias . "`n"
  updated_ini .= "Button2Text=" . guiB2_text . "`n"
  updated_ini .= "Button2Colour=" . guiB2_colour . "`n"
  updated_ini .= "Button2Alias=" . guiB2_alias . "`n"
  updated_ini .= "Button3Text=" . guiB3_text . "`n"
  updated_ini .= "Button3Colour=" . guiB3_colour . "`n"
  updated_ini .= "Button3Alias=" . guiB3_alias . "`n"
  updated_ini .= "Button4Text=" . guiB4_text . "`n"
  updated_ini .= "Button4Colour=" . guiB4_colour . "`n"
  updated_ini .= "Button4Alias=" . guiB4_alias . "`n"
  updated_ini .= "Button5Text=" . guiB5_text . "`n"
  updated_ini .= "Button5Colour=" . guiB5_colour . "`n"
  updated_ini .= "Button5Alias=" . guiB5_alias . "`n"
  updated_ini .= "Button6Text=" . guiB6_text . "`n"
  updated_ini .= "Button6Colour=" . guiB6_colour . "`n"
  updated_ini .= "Button6Alias=" . guiB6_alias . "`n"
  updated_ini .= "Button7Text=" . guiB7_text . "`n"
  updated_ini .= "Button7Colour=" . guiB7_colour . "`n"
  updated_ini .= "Button7Alias=" . guiB7_alias . "`n"
  updated_ini .= "Button8Text=" . guiB8_text . "`n"
  updated_ini .= "Button8Colour=" . guiB8_colour . "`n"
  updated_ini .= "Button8Alias=" . guiB8_alias . "`n"
  updated_ini .= "Button9Text=" . guiB9_text . "`n"
  updated_ini .= "Button9Colour=" . guiB9_colour . "`n"
  updated_ini .= "Button9Alias=" . guiB9_alias . "`n"
  updated_ini .= "Button10Text=" . guiB10_text . "`n"
  updated_ini .= "Button10Colour=" . guiB10_colour . "`n"
  updated_ini .= "Button10Alias=" . guiB10_alias . "`n"
  updated_ini .= "[hotkeys]`n"
  updated_ini .= "OverlayToggleHotkey=" . guiHotkeyOverlay . "`n"
  updated_ini .= "Button1Hotkey=" . guiB1_hk . "`n"
  updated_ini .= "Button2Hotkey=" . guiB2_hk . "`n"
  updated_ini .= "Button3Hotkey=" . guiB3_hk . "`n"
  updated_ini .= "Button4Hotkey=" . guiB4_hk . "`n"
  updated_ini .= "Button5Hotkey=" . guiB5_hk . "`n"
  updated_ini .= "Button6Hotkey=" . guiB6_hk . "`n"
  updated_ini .= "Button7Hotkey=" . guiB7_hk . "`n"
  updated_ini .= "Button8Hotkey=" . guiB8_hk . "`n"
  updated_ini .= "Button9Hotkey=" . guiB9_hk . "`n"
  updated_ini .= "Button10Hotkey=" . guiB10_hk

  FileDelete Config\Config.ini
  FileAppend %updated_ini%, Config\Config.ini, UTF-16
  readConfigFile()
}

colourSplit(colour) {
  colour_red := "0x" . SubStr(colour, 2, 2)
  colour_green := "0x" . SubStr(colour, 4, 2)
  colour_blue := "0x" . SubStr(colour, 6, 2)
  colour_red := colour_red + 0
  colour_green := colour_green + 0
  colour_blue := colour_blue + 0
  return split_colours := {red: colour_red, green: colour_green, blue: colour_blue}
}

fontColour(colours) {
  colour_average := (colours.red + colours.green + colours.blue) / 3
  if (colour_average > 127) {
    return "#080808"
  }
  else {
    return "#C68C53"
  }
}

buttonText(name, alias) {
  if (alias != "") {
    return alias
  }
  else {
    return name
  }
}

writeStyles() {
  global
  if (b1_text != "") {
    updated_css := "#b1{background-color:" . b1_colour . ";color:" . fontColour(colourSplit(b1_colour)) . "}"
    updated_css .= "#b1::after{content:'" . buttonText(b1_text, b1_alias) . "'}"
  }
  else {
    updated_css := "#b1{display:none}"
  }

  if (b2_text != "") {
    updated_css .= "#b2{background-color:" . b2_colour . ";color:" . fontColour(colourSplit(b2_colour)) . "}"
    updated_css .= "#b2::after{content:'" . buttonText(b2_text, b2_alias) . "'}"
  }
  else {
    updated_css .= "#b2{display:none}"
  }

  if (b3_text != "") {
    updated_css .= "#b3{background-color:" . b3_colour . ";color:" . fontColour(colourSplit(b3_colour)) . "}"
    updated_css .= "#b3::after{content:'" . buttonText(b3_text, b3_alias) . "'}"
  }
  else {
    updated_css .= "#b3{display:none}"
  }

  if (b4_text != "") {
    updated_css .= "#b4{background-color:" . b4_colour . ";color:" . fontColour(colourSplit(b4_colour)) . "}"
    updated_css .= "#b4::after{content:'" . buttonText(b4_text, b4_alias) . "'}"
  }
  else {
    updated_css .= "#b4{display:none}"
  }

  if (b5_text != "") {
    updated_css .= "#b5{background-color:" . b5_colour . ";color:" . fontColour(colourSplit(b5_colour)) . "}"
    updated_css .= "#b5::after{content:'" . buttonText(b5_text, b5_alias) . "'}"
  }
  else {
    updated_css .= "#b5{display:none}"
  }

  if (b6_text != "") {
    updated_css .= "#b6{background-color:" . b6_colour . ";color:" . fontColour(colourSplit(b6_colour)) . "}"
    updated_css .= "#b6::after{content:'" . buttonText(b6_text, b6_alias) . "'}"
  }
  else {
    updated_css .= "#b6{display:none}"
  }

  if (b7_text != "") {
    updated_css .= "#b7{background-color:" . b7_colour . ";color:" . fontColour(colourSplit(b7_colour)) . "}"
    updated_css .= "#b7::after{content:'" . buttonText(b7_text, b7_alias) . "'}"
  }
  else {
    updated_css .= "#b7{display:none}"
  }

  if (b8_text != "") {
    updated_css .= "#b8{background-color:" . b8_colour . ";color:" . fontColour(colourSplit(b8_colour)) . "}"
    updated_css .= "#b8::after{content:'" . buttonText(b8_text, b8_alias) . "'}"
  }
  else {
    updated_css .= "#b8{display:none}"
  }

  if (b9_text != "") {
    updated_css .= "#b9{background-color:" . b9_colour . ";color:" . fontColour(colourSplit(b9_colour)) . "}"
    updated_css .= "#b9::after{content:'" . buttonText(b9_text, b9_alias) . "'}"
  }
  else {
    updated_css .= "#b9{display:none}"
  }

  if (b10_text != "") {
    updated_css .= "#b10{background-color:" . b10_colour . ";color:" . fontColour(colourSplit(b10_colour)) . "}"
    updated_css .= "#b10::after{content:'" . buttonText(b10_text, b10_alias) . "'}"
  }
  else {
    updated_css .= "#b10{display:none}"
  }

  FileDelete Web\Gui.css
  FileAppend %updated_css%, Web\Gui.css, UTF-8
}

; ****************************************************
;
; Subroutines
;
; ****************************************************

updateConfig:
  writeConfigFile()
  writeStyles()
  ExitApp
return

GuiEscape:
GuiClose:
  ExitApp