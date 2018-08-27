# Path of Exile - Stash Tab Macro
An [AutoHotkey](https://autohotkey.com/) macro for [Path of Exile](https://www.pathofexile.com/), which adds an additional row of user configurable stash tab buttons.

## Features
This macro generates buttons that allow you to jump to any tab in your personal stash with a single click. Each button can be configured to feature a text label, colour and hotkey of your choosing.

## Requirements
The only requirement at this stage is a recent release of AutoHotkey. You can download it [here](https://autohotkey.com/download/).

Make sure you get a v1.1.X release by clicking the 'Download AutoHotkey Installer' button and **not** a v2.x release from the 'Other Releases' section.

# Quick start
The use of this macro requires a little bit of configuration before you can smoothly navigate your stash like never before. The macro comes with a handy configuration tool that we'll need to use to customise our tab buttons.

1. Download the latest version from the [releases](https://github.com/Fulch36/poe-tab-macro/releases) page here on Github.
2. Extract the contents of the zip file to a folder of your choosing.
3. Run the 'Configurator.ahk' file. This window may look complicated but for now just enter the names of the tabs you'd like buttons for, in the 'Tab Name' field. You can configure up to 10 buttons but less is fine as well.
4. Once you're done adding tabs, click the 'Save' button at the bottom of the window.
5. Run the 'Main.ahk' file.
6. Launch the game.
7. Head to your stash in a town or your hideout and use Ctrl + F2 (by default) to toggle the button overlay.

# Configuration
**Further details to follow in the wiki**

# Known issues
* The overlay window flashes white on first appearance or when rapidly toggling it's state.
* Tab button hotkeys require you to release any modifier keys (Ctrl, Shift etc.) before you can input another one.
* The 'Auto Show Overlay' option doesn't do anything.
* The macro is untested on any screen resolutions other than 1920 x 1080. Whilst there shouldn't be issues with resolutions higher than this, those with lower resolution screens may find that the UI doesn't appear in the right location.

# Future enhancements
* Continue to iterate on button design to attempt to get a closer match to the in-game UI.
* Replace generic mouse cursor with the in-game one to make the overlay fit in a little better.
* Allow for different tab button configurations per league.
* An alternative mode for the tab buttons, which allows the user to jump forward and back by a set number of tabs.
* An additional set of hotkeys to allow the user to scroll forward and back through their tabs.

# Attributions
This project makes use of the following:
* CustomFont V2.00 (2016-2-24) by tmplinshi (https://autohotkey.com/boards/viewtopic.php?t=813)
