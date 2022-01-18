# Friday Night Funkin' - BEAT! Engine
Engine was made using lot of different Source Codes (btw, made/modified in Brazil)

## Social Media
* [Discord Server](https://discord.gg/f8CUrTchuT)
* [Twitter](https://twitter.com/beat_engine)

# Compiling


> ### Dependencies

- Git
- Haxel (LATEST VERSION, STOP USING 4.1.5!!!!)
- VS Community (windows only!)

> ### OPTIONAL Dependencies 

- Visual Studio Code (for modifying the code itself)

> ### Recommended VS Code Extensions

- Lime
- Bracket Pair Colorizer 2
- HXCPP Debugger
- Tabnine

> ### optional VS Code Extensions
- Haxe blocks
- Haxe Checkstyle
- Haxe JSX
- Haxe Extension Pack
- HaxeUI
- indent-rainbow
- Lua Extension by keyring

# Downloads

### Git 
for Windows and Mac: https://git-scm.com/downloads
* **after installing, open a Command Prompt or Terminal, and type in:**
haxelib setup

Linux (Ubuntu and Debian based Distros): 

* sudo apt-get update
* sudo apt-get install git -y

Linux (Arch based Distros): 

* sudo pacman -Sy git --noconfirm

### Haxel

for Windows and Mac: https://haxe.org/download/

Linux (Ubuntu and Debian based Distros):

* sudo add-apt-repository ppa:haxe/releases -y
* sudo apt-get update
* sudo apt-get install haxe -y
* mkdir ~/haxelib && haxelib setup ~/haxelib

Linux (Arch based Distros)

* sudo pacman -Sy haxe --noconfirm

### VS Community
https://my.visualstudio.com/Downloads?q=visual%20studio%202017&wt.mc_id=o~msft~vscom~older-downloads

> ### VS Community Setup

once you download and install VS Community, on the "Workloads" tab, select "Desktop Development with C++"

near the "Install" button, there's a Drop-Down menu, click on it, Select "Download first, then Install"

now wait until it finishes, it is recommended to reboot your PC once it finishes, but it's not needed at all

# Terminal Setup & Compiling Game

on Windows, press "Windows+R" and type in "cmd", if you don't like cmd, or you just use something different, open that program instead
cmd is usually faster, that's why I'm recommending it!

on Linux, press "CTRL+ALT+T" and a Terminal window should open -- although, if you are on linux, you probably know that already

type in these commands

* haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
* haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit.git
* haxelib git hxvm-luajit https://github.com/nebulazorua/hxvm-luajit
* haxelib git faxe https://github.com/uhrobots/faxe
* haxelib git polymod https://github.com/MasterEric/polymod.git
* haxelib git extension-webm https://github.com/KadeDev/extension-webm
* haxelib install lime 7.9.0
* haxelib install openfl
* haxelib install flixel
* haxelib install flixel-tools
* haxelib install flixel-ui
* haxelib install hscript
* haxelib install flixel-addons
* haxelib install actuate
* haxelib run lime setup
* haxelib run lime setup flixel
* haxelib run flixel-tools setup 

***read carefully*** when it prompts for you to do anything (like: setup the lime command, setup flixel tools, etc)

once it's done, do this command to compile the game

### Windows

lime test windows

### Linux

lime test linux

### Mac
lime test mac

### for Debug Builds

add a "-debug" flag at the end of "lime test <platform>"

### VS Code Installation
Windows and Mac: https://code.visualstudio.com/Download

Linux (Ubuntu and Debian based Distros):
* sudo apt install software-properties-common apt-transport-https wget
* wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
* sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
* sudo apt install code

Linux (Arch based distros):
* sudo pacman -Sy code

In case you don't want your mod to be able to run .lua scripts, delete the "LUA_ALLOWED" line on Project.xml

_____________________________________
### BEAT! Devs
* Luisinhi010, Gui-iago - Coding/Mania Charts
* aquastrikr, NooBZiiTo,  - Arts and Animations
* a gorila guy - Secret Stuff

### Contributors
* Asho - Rich Presence Header Design
* Salt for Some Reason - Logo
* El_Cyaan - Guns Mania Chart
* LeNinethGames - Menu Remix

### Special Thanks
* Shadow Mario - Psych Engine
* tposejank - Psych Extra Keys
_____________________________________

# Features
## Week 7
* Yeah, it's what you read, Week 7, lol
* Contains: UGH, Guns, Stress (ofc lol)

## Mania Difficulty + Charts
* Extra Keys for all weeks (Week 1 to 7)

## Revamped Menu
* Transitions Based on Mic'd Up Engine
* Random Icon appearing on the screen (also changes the Menu BG Color)
* Socials Button
  * Twitter and Discord
> ### Simplified Menu Option
* This option was created for Low End Devices, Simplifies the Main Menu in order to decrease Loading times and improve performance
> ### Osu! Style Menu (Alt Menu)
* Osu! Menu, if you like Osu! (lmao)

## Xtras
* Winning Icons
* New Health Bar
* New Grafix (Sick, Good, Bad, Shit)
* LOTS OF STUFF
