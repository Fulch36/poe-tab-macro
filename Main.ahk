; Bugs:
; 1 - UI flashes white on first appearance or on rapid toggling, could possibly try rendering window offscreen first?
; 2 - Hotkeys do not properly trigger when holding down Ctrl and changing tabs, user must release Ctrl each time. Refer to HotkeyFix.ahk

; To do:
; 1 - Get OCR working

; Enhancements:
; 1 - Continue to iterate on button design. Try both the textures from simple patterns as well at the tab pngs from POE-Trades-Companion
; 2 - Extract cursor from the game and make the button hover event on the buttons use the game cursor
; 3 - Enable an alternate mode for the tabs, buttons that use arrow icons and simply jump forward or back x number of tabs.
;     Can achieve this by simply sending the left and right arrow keys X number of times instead of text
; 4 - Support different Config.ini files for each league. Will need to use private API to get league of last played char to choose correct ini
; 5 - Add support for Ctrl + MouseWheel to scroll tabs left and right, just enable a hotkey that sends Left arrow on WheelUp, Right arrow on WheelDown

; ****************************************************
;
; AHK
;
; ****************************************************

#NoEnv
#Singleinstance force
#HotkeyInterval 1000
#MaxHotkeysPerInterval 10
SetWorkingDir %A_ScriptDir%
SetMouseDelay 1, Play ; Minor artificial delay to allow click events to work in the game
#Include Resources\Class_CustomFont.ahk

; ****************************************************
;
; Init
;
; ****************************************************

; Await launch of the game, once launched get the path to the exe file and then client file
loop {
  WinGet, exe_steam_path, ProcessPath, ahk_exe PathOfExile_x64Steam.exe
  WinGet, exe_path, ProcessPath, ahk_exe PathOfExile_x64.exe
  if (exe_steam_path) {
    client_path := getFilePath(exe_steam_path)
    steam_version := true
    break
  }
  else if (exe_path) {
    client_path := getFilePath(exe_path)
    steam_version := false
    break
  }
  else {
    Sleep 1000
  }
}

; ****************************************************
;
; Config
;
; ****************************************************

; Import font
if !FileExist("Resources\Fontin-Regular.ttf") {
  MsgBox Error while opening Fontin-Regular.ttf ; File not found
  ExitApp, -1
}
font_fontin := New CustomFont("Resources\Fontin-Regular.ttf")

; Locate html file
html_file := A_WorkingDir "\Web\Gui.html"
if !FileExist(html_file) {
  MsgBox Error while opening Gui.html ; File not found
  ExitApp, -1
}

; Open handle to Client.txt
client_handle := FileOpen(client_path, "r")
if !IsObject(client_handle) {
  MsgBox Error while opening Path of Exile's Client.txt ; File not found
  ExitApp, -1
}
client_handle.seek(0, 2) ; Seek to the end of the file, ensures all lines read are relevant to current session

; Open handle to Zones.txt
zones_file := "Resources\Zones.txt"
zones_handle := FileOpen(zones_file, "r")
if !IsObject(zones_handle) {
  MsgBox Error while opening Zones.txt ; File not found
  ExitApp, -1
}
zones := zones_handle.read()
zones := StrReplace(zones, "`r`n", ",")
zones_handle.Close()

; Prepare to open Config.ini
if !FileExist("Config\Config.ini") {
  MsgBox Error while opening Config.ini ; File not found
  ExitApp, -1
}
readConfigFile()

; Configure timers
SetTimer updateLoop, %update_rate%
SetTimer gameClosed, 10000

; ****************************************************
;
; GUI
;
; ****************************************************

Gui Font, s12 c000000, Fontin ; Enable custom font
Gui Margin, 0, 0
Gui -Caption +AlwaysOnTop +LastFound +ToolWindow ; No toolbar, always topmost window, only shown in system tray, lastfound is needed for transparency
Gui Add, ActiveX, x0 y0 w627 h33 vWB, Shell.Explorer  ; The final parameter is the name of the ActiveX component.
WB.silent := true ; Surpress JS Error boxes
WB.Navigate("file://" . html_file) ; Open HTML file
WinSet ExStyle, 0x08000000 ; Prevent window from being activated
WinSet Transcolor, 03445B ; Make background transparent
while WB.readystate != 4 or WB.busy { ; Wait for browser to render HTML file
	Sleep 100
}
addButtonHandlers()

; ****************************************************
;
; Functions
;
; ****************************************************

; Get Client.txt path from game exe path
getFilePath(path) {
  char_pos := InStr(path, "\", true, 0)
  path := SubStr(path, 1, char_pos)
  path := path . "logs\Client.txt"
  return path
}

; Read from ini file
readConfigFile() {
  global
  ; Vars
  IniRead, update_rate, Config\Config.ini, variables, UpdateRate
  IniRead, ocr, Config\Config.ini, variables, Ocr
  IniRead, ocr_rate, Config\Config.ini, variables, OcrRate

  ; Tab buttons
  IniRead, b1_text, Config\Config.ini, tabs, Button1Text
  IniRead, b2_text, Config\Config.ini, tabs, Button2Text
  IniRead, b3_text, Config\Config.ini, tabs, Button3Text
  IniRead, b4_text, Config\Config.ini, tabs, Button4Text
  IniRead, b5_text, Config\Config.ini, tabs, Button5Text
  IniRead, b6_text, Config\Config.ini, tabs, Button6Text
  IniRead, b7_text, Config\Config.ini, tabs, Button7Text
  IniRead, b8_text, Config\Config.ini, tabs, Button8Text
  IniRead, b9_text, Config\Config.ini, tabs, Button9Text
  IniRead, b10_text, Config\Config.ini, tabs, Button10Text

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

  ; Activate hotkeys
  If (overlay_toggle_hk) {
	  Hotkey % overlay_toggle_hk, overlayCommand, On
  }
  If (b1_hk and b1_text) {
	  Hotkey % b1_hk, b1Command, On
  }
  If (b2_hk and b2_text) {
	  Hotkey % b2_hk, b2Command, On
  }
  If (b3_hk and b3_text) {
	  Hotkey % b3_hk, b3Command, On
  }
  If (b4_hk and b4_text) {
	  Hotkey % b4_hk, b4Command, On
  }
  If (b5_hk and b5_text) {
	  Hotkey % b5_hk, b5Command, On
  }
  If (b6_hk and b6_text) {
	  Hotkey % b6_hk, b6Command, On
  }
  If (b7_hk and b7_text) {
	  Hotkey % b7_hk, b7Command, On
  }
  If (b8_hk and b8_text) {
	  Hotkey % b8_hk, b8Command, On
  }
  If (b9_hk and b9_text) {
	  Hotkey % b9_hk, b9Command, On
  }
  If (b10_hk and b10_text) {
	  Hotkey % b10_hk, b10Command, On
  }
}

; Connect button events to AHK functions
addButtonHandlers() {
  global
  Loop % wb.document.getElementsByTagName("Button").length {
    ComObjConnect(b_%A_Index%:=wb.document.getElementsByTagName("Button")[A_Index-1], b_%A_Index%.GetAttribute("Id") "_")
  }
}

; Button 1 click event
b1_OnClick() {
  global b1_text
  if (b1_text != "") {
    changeTab(b1_text)
  }
}

; Button 2 click event
b2_OnClick() {
  global b2_text
  if (b2_text != "") {
    changeTab(b2_text)
  }
}

; Button 3 click event
b3_OnClick() {
  global b3_text
  if (b3_text != "") {
    changeTab(b3_text)
  }
}

; Button 4 click event
b4_OnClick() {
  global b4_text
  if (b4_text != "") {
    changeTab(b4_text)
  }
}

; Button 5 click event
b5_OnClick() {
  global b5_text
  if (b5_text != "") {
    changeTab(b5_text)
  }
}

; Button 6 click event
b6_OnClick() {
  global b6_text
  if (b6_text != "") {
    changeTab(b6_text)
  }
}

; Button 7 click event
b7_OnClick() {
  global b7_text
  if (b7_text != "") {
    changeTab(b7_text)
  }
}

; Button 8 click event
b8_OnClick() {
  global b8_text
  if (b8_text != "") {
    changeTab(b8_text)
  }
}

; Button 9 click event
b9_OnClick() {
  global b9_text
  if (b9_text != "") {
    changeTab(b9_text)
  }
}

; Button 10 click event
b10_OnClick() {
  global b10_text
  if (b10_text != "") {
    changeTab(b10_text)
  }
}

; Change stash tab to match the passed in 'tab_name' parameter
changeTab(tab_name) {
  if (tab_name != "") {
    BlockInput On
    MouseGetPos x_pos, y_pos
    SendPlay {Click 640, 145}
    Send {Text}%tab_name%
    Send {Enter}
    SendPlay {Click}
    SendPlay {Click %x_pos%, %y_pos%, 0}
    BlockInput Off
  }
}

; Check if PoE is active window
checkActiveWindow() {
  global
  if (WinActive("ahk_exe PathOfExile_x64Steam.exe") or WinActive("ahk_exe PathOfExile_x64.exe")) {
    window_active := true
  }
  else {
    window_active := false
    hideOverlay()
  }
}

; Check if PoE is running
checkGameRunning() {
  if (!WinExist("ahk_exe PathOfExile_x64Steam.exe") and !WinExist("ahk_exe PathOfExile_x64.exe")) {
    ExitApp
  }
}

; Read Client.txt file
readClientFile() {
  global client_handle, zones
  loop {
    line := client_handle.readline()
    if (line) { ; If not EOF
      string_pos := InStr(line, ": You have entered", true, -1, 1)
      if (string_pos > 0) {  ; Probable zone change detected
        line := StrReplace(line, ":", ":", count) ; Replace colons with colons, count = occurences replaced
        if (count = 3) { ; Only 3 colons found, must be a log file message and not a troll trying to mess with the script
          string_pos := string_pos + 19 ; string_pos = 53 so need to add an offset of 19
          location := SubStr(line, string_pos, -3) ; Parsed zone name, excluding trailing full stop and new line

          if location in %zones% ; Compare location to list of zones and set town boolean
            global town := true
          else
            global town := false
        }
      }
    }
    else {
      break
    }
  }
}

; Toggle overlay if game is active window
hotkeyOverlay() {
  global
  if (town and window_active) {
    if (overlay_shown) {
      hideOverlay()
    }
    else {
      showOverlay()
    }
  }
}

; Show window in correct position for 1920 x 1080
showOverlay() {
  Gui Show, x18 y97 NoActivate
  global overlay_shown := true
}

; Hide window
hideOverlay() {
  Gui Hide
  global overlay_shown := false
}

; ****************************************************
;
; Hotkeys
;
; ****************************************************

overlayCommand:
  hotkeyOverlay()
return

b1Command:
  if overlay_shown {
    b1_OnClick()
  }
return

b2Command:
  if overlay_shown {
    b2_OnClick()
  }
return

b3Command:
  if overlay_shown {
    b3_OnClick()
  }
return

b4Command:
  if overlay_shown {
    b4_OnClick()
  }
return

b5Command:
  if overlay_shown {
    b5_OnClick()
  }
return

b6Command:
  if overlay_shown {
    b6_OnClick()
  }
return

b7Command:
  if overlay_shown {
    b7_OnClick()
  }
return

b8Command:
  if overlay_shown {
    b8_OnClick()
  }
return

b9Command:
  if overlay_shown {
    b9_OnClick()
  }
return

b10Command:
  if overlay_shown {
    b10_OnClick()
  }
return

; ****************************************************
;
; Subroutines
;
; ****************************************************

; Poll game state
updateLoop:
  readClientFile()
  checkActiveWindow()
return

gameClosed:
  checkGameRunning()
return