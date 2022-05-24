package;

import flixel.util.FlxTimer;
import flixel.util.FlxGradient;
#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxBackdrop;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import flash.ui.Mouse;
import flixel.FlxG;
import flixel.input.IFlxInputManager;
import flixel.input.FlxInput.FlxInputState;
import flixel.input.mouse.FlxMouseButton.FlxMouseButtonID;
import flixel.system.FlxAssets;
import flixel.system.replay.MouseRecord;
import flixel.util.FlxDestroyUtil;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var fridayVersion:String = '0.2.7.1';
	public static var psychEngineVersion:String = '0.5.1';
	public static var beatEngineVersion:String = '0.0.4'; // this is used for Discord RPC
	public static var beatEngineGit:String = '0.0.4a';
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;

	public var camHUD:FlxCamera;

	private var camAchievement:FlxCamera;

	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		#if MODS_ALLOWED 'mods', #end
		'socials',
		#if !switch 'donate', #end
		'credits',
		'options'
	];

	public var iconBG:FlxSprite;

	public var icon:HealthIcon;

	public static var lastRoll:String = "bf";

	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	var checker:FlxBackdrop = new FlxBackdrop(Paths.image('Main_Checker'), 0.2, 0.2, true, true);

	var gradientBar:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, 300, 0xFFAA00AA);

	var bg:FlxSprite;

	var bgdiferent:FlxSprite;

	var date = Date.now();

	var logoBl:FlxSprite;

	var noname:Bool = false;

	var shit:FlxText;

	#if !mac
	var name:String = Sys.environment()["USERNAME"];
	#else
	var name:String = Sys.environment()["USER"];
	#end

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		#if desktop
		trace(Sys.environment()["COMPUTERNAME"]); // sussy test for a next menu x1
		#end

		trace(name);

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		FlxG.mouse.visible = true;
		FlxG.mouse.useSystemCursor = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		bg = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175 * scaleRatio));
		bg.color = FlxColor.YELLOW;
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		bgdiferent = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		bgdiferent.scrollFactor.set(0, yScroll);
		bgdiferent.setGraphicSize(Std.int(bg.width * 1.175));
		bgdiferent.updateHitbox();
		bgdiferent.screenCenter();
		bgdiferent.alpha = 0;
		bgdiferent.color = FlxColor.MAGENTA;
		bgdiferent.antialiasing = ClientPrefs.globalAntialiasing;
		add(bgdiferent);

		if (!ClientPrefs.lowQuality)
		{
			gradientBar = FlxGradient.createGradientFlxSprite(Math.round(FlxG.width), 512, [0x00ff0000, 0x55AE59E4, 0xAA19ECFF], 1, 90, true);
			gradientBar.y = FlxG.height - gradientBar.height;
			add(gradientBar);
			gradientBar.scrollFactor.set(0, 0);

			add(checker);
			checker.scrollFactor.set(0, 0.07);
		}

		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(FlxG.width + 0, (i * 140) + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if (optionShit.length < 3)
				scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			// menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			FlxTween.tween(menuItem, {y: 30 + (i * 120)}, 1 + (i * 0.25), {
				ease: FlxEase.expoInOut,
				onComplete: function(flxTween:FlxTween)
				{
					changeItem();
				}
			});
			menuItem.updateHitbox();
			menuItem.scrollFactor.set(0, scr);
		}

		if (!ClientPrefs.lowQuality)
		{
			logoBl = new FlxSprite(-100, -100);

			logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
			logoBl.scrollFactor.set();
			logoBl.antialiasing = ClientPrefs.globalAntialiasing;
			logoBl.animation.addByPrefix('bump', 'logo bumpin', 24, false);
			logoBl.setGraphicSize(Std.int(logoBl.width * 0.5));
			logoBl.animation.play('bump');
			logoBl.alpha = 0;
			logoBl.angle = -4;
			logoBl.updateHitbox();
			add(logoBl);
			FlxTween.tween(logoBl, {
				y: logoBl.y + 150,
				x: logoBl.x + 150,
				angle: -4,
				alpha: 1
			}, 1.4, {ease: FlxEase.expoInOut});
		}

		shit = new FlxText(24, 48, 0, 'Hello ' + name + '!', 48);
		shit.scrollFactor.set();
		shit.setFormat("VCR OSD Mono", 16, FlxColor.RED, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		shit.screenCenter(X);
		/*if (FlxG.random.bool(0.4))
			add(shit); */

		FlxG.camera.follow(camFollowPos, null, 1); // todo: fix this mf camera

		var versionShit:FlxText = new FlxText(12, FlxG.height - 64, 0, "", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShitpsych:FlxText = new FlxText(12, FlxG.height - 44, 0, "", 12);
		versionShitpsych.scrollFactor.set();
		versionShitpsych.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShitpsych);
		#if !debug
		versionShit.text = "BEAT! Engine v" + beatEngineGit;
		#end
		#if debug
		versionShit.text = "BEAT! Engine v" + beatEngineVersion + ' (debug)';
		#end
		versionShitpsych.text = "Psych Engine v" + psychEngineVersion;
		versionShit.screenCenter(X);
		versionShitpsych.screenCenter(X);
		var versionShitFriday:FlxText = new FlxText(12, FlxG.height - 24, 0, "FNF v" + fridayVersion, 12);
		versionShitFriday.scrollFactor.set();
		versionShitFriday.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		versionShitFriday.screenCenter(X);
		add(versionShitFriday);

		if (!ClientPrefs.lowQuality)
		{
			iconBG = new FlxSprite().loadGraphic(Paths.image('iconbackground'));
			iconBG.scrollFactor.set();
			iconBG.updateHitbox();
			iconBG.antialiasing = ClientPrefs.globalAntialiasing;
			add(iconBG);

			switch (FlxG.random.int(1, 5))
			{
				case 1:
					icon = new HealthIcon('bf');
					icon.setGraphicSize(Std.int(icon.width * 2));
					iconBG.color = FlxColor.CYAN;
				case 2:
					icon = new HealthIcon('gf');
					icon.setGraphicSize(Std.int(icon.width * 2));
					iconBG.color = FlxColor.RED;
				case 3:
					icon = new HealthIcon('dad');
					icon.setGraphicSize(Std.int(icon.width * 1.7));
					iconBG.color = FlxColor.PURPLE;
				case 4:
					icon = new HealthIcon('mom');
					icon.setGraphicSize(Std.int(icon.width * 1.8));
					iconBG.color = FlxColor.PURPLE;
				case 5:
					icon = new HealthIcon('spooky');
					icon.setGraphicSize(Std.int(icon.width * 2));
					switch (FlxG.random.int(1, 2))
					{
						case 1:
							iconBG.color = FlxColor.ORANGE;
						case 2:
							iconBG.color = FlxColor.WHITE;
					}
			} // YES, I WILL PUT THE HAXE COLORS INSTEAD THE NORMAL ONES

			// icon = new HealthIcon('bf');
			// icon.setGraphicSize(Std.int(icon.width * 2));
			icon.antialiasing = ClientPrefs.globalAntialiasing;
			icon.x = 70;
			icon.y = FlxG.height - 180;
			icon.scrollFactor.set();
			icon.updateHitbox();
			add(icon);
			trace(iconBG.color);
			trace(icon);
		}

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
		{
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if (!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2]))
			{ // It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement()
	{
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		Conductor.songPosition = FlxG.sound.music.time;

		checker.x -= 0.45 / (ClientPrefs.framerate / 60);
		checker.y -= 0.16 / (ClientPrefs.framerate / 60);

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (-1 * Math.floor(FlxG.mouse.wheel) != 0)
			{
				changeItem(-1 * Math.floor(FlxG.mouse.wheel));
				FlxG.sound.play(Paths.sound('scrollMenu'));
				trace('lol ' + curSelected);
			}

			/*if (FlxG.mouse.overlaps(menuItems))
				{
					menuItems.forEach(function(spr:FlxSprite)
					{
						if (FlxG.mouse.overlaps(spr))
						{
							var selected:FlxSprite;
							var selectedInt:Int;
							selected = spr;
							selectedInt = curSelected;
							changeItem(-selectedInt);
						}
					});
			}*/ // cursed coding

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
				// Main Menu Back Animations
				FlxTween.tween(FlxG.camera, {zoom: 5}, 0.8, {ease: FlxEase.expoIn});
				FlxTween.tween(bg, {angle: 45}, 0.8, {ease: FlxEase.expoIn});
				FlxTween.tween(bgdiferent, {angle: 45}, 0.8, {ease: FlxEase.expoIn});
				FlxTween.tween(bg, {alpha: 0}, 0.8, {ease: FlxEase.expoIn});
				FlxTween.tween(bgdiferent, {alpha: 0}, 0.8, {ease: FlxEase.expoIn});
				if (!ClientPrefs.lowQuality)
				{
					FlxTween.tween(logoBl, {
						alpha: 0,
						x: -100,
						y: -100,
						angle: 4
					}, 0.5, {ease: FlxEase.quadOut});
					FlxTween.tween(icon, {x: icon.x - 20, y: icon.y + 20}, 0.5, {ease: FlxEase.quadOut});
				}
			}

			if (controls.ACCEPT || FlxG.mouse.justPressed)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
					// Main Menu Select Animations
					FlxTween.tween(FlxG.camera, {zoom: 5}, 0.8, {ease: FlxEase.expoIn});
					FlxTween.tween(bg, {angle: 45}, 0.8, {ease: FlxEase.expoIn});
					FlxTween.tween(bgdiferent, {angle: 45}, 0.8, {ease: FlxEase.expoIn});
					if (!ClientPrefs.lowQuality)
					{
						FlxTween.tween(checker, {angle: 45}, 0.8, {ease: FlxEase.expoIn});
						FlxTween.tween(logoBl, {
							alpha: 0,
							x: logoBl.x - 30,
							y: logoBl.y - 30,
							angle: 4
						}, 0.8, {ease: FlxEase.quadOut});
						FlxTween.tween(icon, {x: icon.x - 10, y: icon.y + 10}, 0.8, {ease: FlxEase.quadOut});
					}
					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						hideit(0.6);
					});

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0.1, x: 1500}, 1, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
							FlxTween.tween(spr, {x: 1500}, 1, {
								ease: FlxEase.quadOut
							});
						}
						else
						{
							spr.updateHitbox();
							// spr.x += -300;
							FlxTween.tween(spr, {x: spr.x - 240, y: 260}, 0.5, {ease: FlxEase.quadOut});
							FlxTween.tween(spr.scale, {x: 1.2, y: 1.2}, 0.8, {ease: FlxEase.quadOut});

							new FlxTimer().start(1, function(tmr:FlxTimer)
							{
								goToState();
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		if (!selectedSomethin)
		{
			menuItems.forEach(function(spr:FlxSprite)
			{
				spr.screenCenter(X);
				spr.x += 240;
			});
		}
	}

	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'story_mode':
				MusicBeatState.switchState(new StoryMenuState());
			case 'freeplay':
				MusicBeatState.switchState(new FreeplayState());
			case 'socials':
				MusicBeatState.switchState(new SocialsState());
			#if MODS_ALLOWED
			case 'mods':
				MusicBeatState.switchState(new ModsMenuState());
			#end
			case 'awards':
				MusicBeatState.switchState(new AchievementsMenuState());
			case 'credits':
				MusicBeatState.switchState(new CreditsState());
			case 'options':
				MusicBeatState.switchState(new options.OptionsState());
		}
	}

	function hideit(time:Float)
	{
		menuItems.forEach(function(spr:FlxSprite)
		{
			FlxTween.tween(spr, {alpha: 0.0}, time, {ease: FlxEase.quadOut});
		});
		FlxTween.tween(bg, {alpha: 0}, time, {ease: FlxEase.expoIn});
		FlxTween.tween(bgdiferent, {alpha: 0}, time, {ease: FlxEase.expoIn});
		if (!ClientPrefs.lowQuality)
		{
			FlxTween.tween(checker, {alpha: 0}, time, {ease: FlxEase.expoIn});
			FlxTween.tween(gradientBar, {alpha: 0}, time, {ease: FlxEase.expoIn});
		}
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if (menuItems.length > 4)
				{
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();

				if (curSelected == 3)
				{
					if (spr.y != 30)
					{
						spr.y == 30;
					}
				}
				else
					spr.y == 0;
			}
		});
	}

	override function beatHit()
	{
		super.beatHit();

		if (logoBl != null)
			logoBl.animation.play('bump', true);
	}
}
