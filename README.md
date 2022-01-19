# Friday Night Funkin' - BEAT! Engine
Engine was made using lot of different Source Codes (btw, made/modified in Brazil)

## Social Media
* [Discord Server](https://discord.gg/f8CUrTchuT)
* [Twitter](https://twitter.com/beat_engine)

# Compiling


> ### Dependencies

- Git
- Haxel (LATEST VERSION ONLY, STOP USING 4.1.5!!!!)
- Visual Studio Community (Windows Only)


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
Windows and Mac: https://haxe.org/download/ (Latest Version)

Linux (Ubuntu and Debian based Distros):
* sudo add-apt-repository ppa:haxe/releases -y
* sudo apt-get update
* sudo apt-get install haxe -y
* mkdir ~/haxelib && haxelib setup ~/haxelib

Linux (Arch based Distros)
* sudo pacman -Sy haxe --noconfirm


### Visual Studio Community
https://my.visualstudio.com/Downloads?q=visual%20studio%202017&wt.mc_id=o~msft~vscom~older-downloads

> ### Visual Studo Community Setup

Once you download and install VS Community, on the "Workloads" tab, select "Desktop Development with C++"
Near the "Install" button, there's a Drop-Down menu, click on it, Select "Download first, then Install"
Now wait until it finishes, it is recommended to reboot your PC once it finishes, but it's not needed at all

# Terminal Setup & Compiling Game

Windows: Press "Windows + R" and type in "cmd", if you don't like cmd, or you just use something different, open that program instead
cmd is usually faster, that's why I'm recommending it!

Linux: press "CTRL + ALT + T" and a Terminal window should open -- although, if you are on linux, you probably know that already

### Type in these commands:

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

***Read Carefully:*** When it prompts for you to do anything (like: setup the lime command, setup flixel tools, etc)

Once it's done, do this command to compile the game


### Windows
lime test windows

### Linux
lime test linux

### Mac
lime test mac

### for Debug Builds
add a "-debug" flag at the end of "lime test <platform>"

### Visual Studio Code Installation
Windows and Mac: https://code.visualstudio.com/Download

Linux (Ubuntu and Debian based Distros):
* sudo apt install software-properties-common apt-transport-https wget
* wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
* sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
* sudo apt install code

Linux (Arch based distros):
* sudo pacman -Sy code

In case you don't want your mod to be able to run .lua scripts, delete the "LUA_ALLOWED" line on Project.xml

──────────────────────────────────────

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

──────────────────────────────────────

# Features

 ## Week 7
* Yeah, it's what you read, Week 7, lol
* Contains: UGH, Guns, Stress (ofc lol)
 ![unknown](https://user-images.githubusercontent.com/69995597/150059799-db3c2624-e47c-4af7-9819-31792011669d.png)

 ## Mania Difficulty + Charts
* Extra Keys and Charts for all weeks (Even Tutorial)
 
 https://user-images.githubusercontent.com/69995597/150059551-02c76ed2-bee4-4537-aaf5-e2ac73ed43a2.mp4

 ## Revamped Menu
* Transitions Based on Mic'd Up Engine
* Random Icon appearing on the screen (also changes the Menu BG Color)
* Socials Button (Discord and Twitter, UPCOMING)
 ![kbjrew](https://user-images.githubusercontent.com/69995597/150060251-2c901806-db80-4818-aebd-5555a5fbdbff.png)

 > ### Simplified Menu Option
* This option was created for Low End Devices, Simplifies the Main Menu in order to decrease Loading times and improve performance
![FIzLMsBX0AI4ans](https://user-images.githubusercontent.com/69995597/150060301-6e288d57-d610-48b9-bc9a-74a9ff9ea6da.jpeg)

 
 > ### Osu! Style Menu (Alt Menu, UPCOMING)
* Osu! Menu, if you like Osu! (lmao)
![concep-menu](https://user-images.githubusercontent.com/69995597/150062868-1177f151-2327-445f-9c41-99c583c9986d.jpg)


 ## Xtras
* Winning Icons
* New Health Bar
* New Grafix (Sick, Good, Bad, Shit)
* LOTS OF STUFF
