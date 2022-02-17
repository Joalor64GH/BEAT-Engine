This is a fork from [tposejank](https://github.com/tposejank) / [FNF-PsychEngine-ExtraKeys](https://github.com/tposejank/FNF-PsychEngine-ExtraKeys)

IF YOU MADE PULL REQUEST I WILL UPDATE THE ENGINE WITH THE PULL

# Friday Night Funkin' - BEAT! Engine

Engine was made using a lot of different Source Codes.

- Made/Modified in Brazil (Yeah, Brazil Moment 🇧🇷).

![banner_final](https://user-images.githubusercontent.com/69995597/150093578-965240fa-71b3-4ea8-a541-fb50a2be8064.jpg)

## Social Media

- [Discord Server](https://discord.gg/f8CUrTchuT)
- [Twitter](https://twitter.com/beat_engine)

# Compiling

> ### Dependencies

- Git
- Haxel (LATEST VERSION ONLY, PLEASE, STOP USING 4.1.5!!!!)
- Visual Studio Community (Windows Only)

> ### OPTIONAL Dependencies

- Visual Studio Code (for modifying the code itself)

> ### Recommended VS Code Extensions

- Lime
- Bracket Pair Colorizer 2
- HXCPP Debugger
- Tabnine

> ### Optional Visual Studio Code Extensions

- Haxe blocks
- Haxe Checkstyle
- Haxe JSX
- Haxe Extension Pack
- HaxeUI
- indent-rainbow
- Lua Extension by keyring

# Dependencies

### Git & Haxe

Windows and macOS: 

- https://git-scm.com/downloads
- https://haxe.org/download

macOS with homebrew:
```
brew install git
brew install haxe
```

Ubuntu based Linux distros:
```
sudo add-apt-repository ppa:haxe/releases -y
sudo apt update
sudo apt install git haxe -y
mkdir ~/haxelib && haxelib setup ~/haxelib
```

Debian based Linux distros:
```
sudo apt-get install git haxe -y
mkdir ~/haxelib && haxelib setup ~/haxelib
```

Arch based Linux distros:
```
sudo pacman -S git haxe
mkdir ~/haxelib && haxelib setup ~/haxelib
```

Redhat based Linux distros:
```
sudo dnf install git haxe -y
mkdir ~/haxelib && haxelib setup ~/haxelib
```

openSuse based Linux distros: 
```
sudo zypper install git haxe
mkdir ~/haxelib && haxelib setup ~/haxelib
```

### Post installation on all platforms, run
```
haxelib setup
```

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

```bash
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit.git
haxelib git hxvm-luajit https://github.com/nebulazorua/hxvm-luajit
haxelib git faxe https://github.com/uhrobots/faxe
haxelib git polymod https://github.com/MasterEric/polymod.git
haxelib git extension-webm https://github.com/KadeDev/extension-webm
haxelib install lime 7.9.0
haxelib install openfl
haxelib install flixel
haxelib install flixel-tools
haxelib install flixel-ui
haxelib install hscript
haxelib install flixel-addons
haxelib install actuate
haxelib run lime setup
haxelib run lime setup flixel
haxelib run flixel-tools setup
```

**_Read Carefully:_** When it prompts for you to do anything (like: setup the lime command, setup flixel tools, etc)

Compiling test version:

```
lime test PLATFORM # linux, windows, mac
```

### for Debug Builds

Append `-debug` at the end of `lime test PLATFORM`

### Visual Studio Code Installation

Windows and Mac: https://code.visualstudio.com/Download

Linux: https://code.visualstudio.com/docs/setup/linux

In case you don't want your mod to be able to run .lua scripts, delete the `LUA_ALLOWED` line on `Project.xml`

───────────────────────────────────────────────────────────────────────────

## BEAT! Engine

- [AquaStrikr](https://twitter.com/aqua_strikr) - Art, Director, Charting
- [Luisinhi010](https://www.youtube.com/c/Luisinho%E3%83%84/) - Coding, Animation, Charting
- [Gui-iago](https://twitter.com/Fan_de_RPG) - Additional Coding, Charting
- [NooBZiiTo](https://twitter.com/NooBZiiTo1) - Animation
- [Re.Xuadoz.2.5](https://www.reddit.com/user/JulioHaHaHa) - Ideas

## Psych Engine

- [Shadow Mario](https://twitter.com/shadow_mario_) - Engine Developer
- [RiverOaken](https://twitter.com/RiverOaken) - Arts and Animations
- [bbpanzu](https://twitter.com/bbpanzu) - Assistant Programmer
- [tposejank](https://www.youtube.com/c/tpobuddy) - Psych Extra Keys

### Special Thanks
 
- [Salt for Some Reason](https://twitter.com/7saltybro) - Logo
- [AshoXD](https://twitter.com/ashomoment) - Rich Presence Header Design
- [El_Cyaan](https://twitter.com/El_Cyaan) - Guns Mania Chart, GF ALT, BanduFrein
- [LeNinethGames](https://twitter.com/LeNineth) - Menu Remix
- [a gorila guy/Renan](https://twitter.com/LaysEnjoyer) - Parasite Cover (Composed by TheInnuendo)
- [superpowers04](https://github.com/superpowers04) - Character Selection Script
- [shubs](https://twitter.com/Yoshubs) - New Input System
- [SqirraRNG](https://twitter.com/gedehari) - Chart Editor's Sound Waveform base code
- [iFlicky](https://twitter.com/flicky_i) - Delay/Combo Menu Song Composer + Dialogue Sounds
- [PolybiusProxy](https://gamebanana.com/members/1833635) - .MP4 Loader Extension
- [Keoiki](https://twitter.com/Keoiki_) - Note Splash Animations
- Smokey - Spritemap Texture Atlas support
- [gedehari](https://twitter.com/gedehari) - Chart Editor's Sound Waveform base
- Cary - OG Resolution code
- [Nebula_Zorua](https://twitter.com/nebula_zorua) - VCR Shader code

## Kade Engine

- [KadeDev](https://www.youtube.com/c/KadeDev/) - Input and Time Bar
  
## TheZoroForce240
  
- [TheZoroForce240](https://gamebanana.com/members/1708748) - Input

## Skin Credits

- [Uniianimates](https://twitter.com/uniianimates) - BF/GF (High Effort Erect Remixes)
- [CarKeys](https://gamebanana.com/members/1994795) - BF/GF (Just a Little BF/GF Remake)
- [Luisinhi010](https://www.youtube.com/c/Luisinho%E3%83%84/) - ALT BoyFriend (BEAT!Engine BF)
- [NooBZiiTo](https://twitter.com/NooBZiiTo1) - Scarf Pico, X-Mas Mommy Mearest (Scarf Pico, based on Phantom Fear's Design and X-mas MM based on Week 5's outfit)
- [theoriginalalex](https://twitter.com/theoogalex) - Only Speakers/No GF Skin
- [kazzyrus](https://gamebanana.com/members/1944760) - Mommy Mearest over GF Skin

# Features

## Mania Difficulty + Charts

- Extra Keys and Charts for all weeks (Even Tutorial)

https://user-images.githubusercontent.com/69995597/150059551-02c76ed2-bee4-4537-aaf5-e2ac73ed43a2.mp4

## Revamped Menu

- Transitions Based on Mic'd Up Engine
- Random Icon appearing on the screen (also changes the Icon BG Color)
- Socials Button (Discord and Twitter)

![kbjrew](https://user-images.githubusercontent.com/69995597/150060251-2c901806-db80-4818-aebd-5555a5fbdbff.png)

> ### Simplified Menu Option

- This option was created for Low End Devices, Simplifies the Main Menu in order to decrease Loading times and improve performance
- May not decrease the loading so much, because still use one of the large file of the main menu (the bg)

![FIzLMsBX0AI4ans](https://user-images.githubusercontent.com/69995597/150060301-6e288d57-d610-48b9-bc9a-74a9ff9ea6da.jpeg)

## Xtras

- Winning Icons
- New Health Bar
- Multiple Inputs
- New Grafix (Marvelous, Sick, Good, Bad, Shit)
- Opponent Mode (Yeah, you can play as the opponent, but it's rlly funkin' cool, y'know?)
- AND MORE!
