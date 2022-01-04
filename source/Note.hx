package;

import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flash.display.BitmapData;
import editors.ChartingState;

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var ignoreNote:Bool = false;
	public var hitByOpponent:Bool = false;
	public var noteWasHit:Bool = false;
	public var prevNote:Note;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;
	public var noteType(default, set):String = null;

	public var eventName:String = '';
	public var eventLength:Int = 0;
	public var eventVal1:String = '';
	public var eventVal2:String = '';

	public var colorSwap:ColorSwap;
	public var inEditor:Bool = false;
	public var gfNote:Bool = false;
	private var earlyHitMult:Float = 0.5;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	// Lua shit
	public var noteSplashDisabled:Bool = false;
	public var noteSplashTexture:String = null;
	public var noteSplashHue:Float = 0;
	public var noteSplashSat:Float = 0;
	public var noteSplashBrt:Float = 0;

	public var offsetX:Float = 0;
	public var offsetY:Float = 0;
	public var offsetAngle:Float = 0;
	public var multAlpha:Float = 1;

	public var copyX:Bool = true;
	public var copyY:Bool = true;
	public var copyAngle:Bool = true;
	public var copyAlpha:Bool = true;

	public var hitHealth:Float = 0.023;
	public var missHealth:Float = 0.0475;

	public var texture(default, set):String = null;

	public var noAnimation:Bool = false;
	public var hitCausesMiss:Bool = false;
	public var distance:Float = 2000;//plan on doing scroll directions soon -bb

	public var mania:Int = 1;

	var ogW:Float;
	var ogH:Float;

	var defaultWidth:Float = 0;
	var defaultHeight:Float = 0;

	public var isParent:Bool; //ke input shits
	public var childs:Array<Note> = [];
	public var parent:Note;
	public var susActive:Bool = true;
	public var spotInLine:Int = 0;

	private function set_texture(value:String):String {
		if(texture != value) {
			reloadNote('', value);
		}
		texture = value;
		return value;
	}

	private function set_noteType(value:String):String {
		noteSplashTexture = PlayState.SONG.splashSkin;
		colorSwap.hue = ClientPrefs.arrowHSV[Note.NoteData.getKeyMap(PlayState.mania, noteData, 0) % Note.NoteData.getAmmo(PlayState.mania)][0] / 360;
		colorSwap.saturation = ClientPrefs.arrowHSV[Note.NoteData.getKeyMap(PlayState.mania, noteData, 0) % Note.NoteData.getAmmo(PlayState.mania)][1] / 100;
		colorSwap.brightness = ClientPrefs.arrowHSV[Note.NoteData.getKeyMap(PlayState.mania, noteData, 0) % Note.NoteData.getAmmo(PlayState.mania)][2] / 100;

		if(noteData > -1 && noteType != value) {
			switch(value) {
				case 'Hurt Note':
					ignoreNote = mustPress;
					reloadNote('HURT');
					noteSplashTexture = 'HURTnoteSplashes';
					colorSwap.hue = 0;
					colorSwap.saturation = 0;
					colorSwap.brightness = 0;
					if(isSustainNote) {
						missHealth = 0.1;
					} else {
						missHealth = 0.3;
					}
					hitCausesMiss = true;
				case 'No Animation':
					noAnimation = true;
				case 'GF Sing':
					gfNote = true;
			}
			noteType = value;
		}
		noteSplashHue = colorSwap.hue;
		noteSplashSat = colorSwap.saturation;
		noteSplashBrt = colorSwap.brightness;
		return value;
	}

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, ?inEditor:Bool = false)
	{
		super();

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;
		this.inEditor = inEditor;

		x += (ClientPrefs.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X) + 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		this.strumTime = strumTime;
		if(!inEditor) this.strumTime += ClientPrefs.noteOffset;

		this.noteData = noteData;

		if(noteData > -1) {
			texture = '';
			colorSwap = new ColorSwap();
			shader = colorSwap.shader;

			x += swagWidth * (noteData % Note.NoteData.getAmmo(PlayState.mania));
			if(!isSustainNote) { //Doing this 'if' check to fix the warnings on Senpai songs
				var animToPlay:String = '';
				animToPlay = Note.NoteData.getLetter(Note.NoteData.getKeyMap(PlayState.mania, noteData, 0));
				animation.play(animToPlay);
			}
		}

		// trace(prevNote);

		if (isSustainNote && prevNote != null)
		{
			alpha = 0.6;
			multAlpha = 0.6;
			if(ClientPrefs.downScroll) flipY = true;

			offsetX += width / 2;
			copyAngle = false;

			animation.play(Note.NoteData.getLetter(Note.NoteData.getKeyMap(PlayState.mania, noteData, 0)) + ' tail');

			updateHitbox();

			offsetX -= width / 2;

			if (PlayState.isPixelStage)
				offsetX += 30 * Note.NoteData.getPixelSize(PlayState.mania);

			if (prevNote.isSustainNote)
			{
				prevNote.animation.play(Note.NoteData.getLetter(Note.NoteData.getKeyMap(PlayState.mania, noteData, 0)) + ' hold');

				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.05;
				if(PlayState.instance != null)
				{
					prevNote.scale.y *= PlayState.instance.songSpeed;
				}

				if(PlayState.isPixelStage) { ///Y E  A H
					prevNote.scale.y *= 1.19;
				}
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}

			if(PlayState.isPixelStage) {
				scale.y *= PlayState.daPixelZoom;
				updateHitbox();
			}
		} else if(!isSustainNote) {
			earlyHitMult = 1;
		}
		x += offsetX;
	}

	function reloadNote(?prefix:String = '', ?texture:String = '', ?suffix:String = '') {
		if(prefix == null) prefix = '';
		if(texture == null) texture = '';
		if(suffix == null) suffix = '';
		
		var skin:String = texture;
		if(texture.length < 1) {
			skin = PlayState.SONG.arrowSkin;
			if(skin == null || skin.length < 1) {
				skin = 'NOTE_assets';
			}
		}

		var animName:String = null;
		if(animation.curAnim != null) {
			animName = animation.curAnim.name;
		}

		var arraySkin:Array<String> = skin.split('/');
		arraySkin[arraySkin.length-1] = prefix + arraySkin[arraySkin.length-1] + suffix;

		var lastScaleY:Float = scale.y;
		var blahblah:String = arraySkin.join('/');

		defaultWidth = 157;
		defaultHeight = 154;
		if(PlayState.isPixelStage) {
			if(isSustainNote) {
				loadGraphic(Paths.image('pixelUI/' + blahblah + 'ENDS'));
				width = width / 18;
				height = height / 2;
				loadGraphic(Paths.image('pixelUI/' + blahblah + 'ENDS'), true, Math.floor(width), Math.floor(height));
			} else {
				loadGraphic(Paths.image('pixelUI/' + blahblah));
				width = width / 18;
				height = height / 5;
				loadGraphic(Paths.image('pixelUI/' + blahblah), true, Math.floor(width), Math.floor(height));
			}
			defaultWidth = width;
			setGraphicSize(Std.int(width * PlayState.daPixelZoom * Note.NoteData.getPixelSize(PlayState.mania)));
			loadPixelNoteAnims();
			antialiasing = false;
		} else {
			frames = Paths.getSparrowAtlas(blahblah);
			loadNoteAnims();
			antialiasing = ClientPrefs.globalAntialiasing;
		}
		if(isSustainNote) {
			scale.y = lastScaleY;
			if(ClientPrefs.keSustains) {
				scale.y *= 0.75;
			}
		}
		updateHitbox();

		if(animName != null)
			animation.play(animName, true);

		if(inEditor) {
			setGraphicSize(ChartingState.GRID_SIZE, ChartingState.GRID_SIZE);
			updateHitbox();
		}
	}

	function loadNoteAnims() {
		for (i in 0...9)
			{
				animation.addByPrefix(Note.NoteData.getLetter(i), Note.NoteData.getLetter(i) + '0');
	
				if (isSustainNote)
				{
					animation.addByPrefix(Note.NoteData.getLetter(i) + ' hold', Note.NoteData.getLetter(i) + ' hold');
					animation.addByPrefix(Note.NoteData.getLetter(i) + ' tail', Note.NoteData.getLetter(i) + ' tail');
				}
			}
				
			ogW = width;
			ogH = height;
			if (!isSustainNote)
				setGraphicSize(Std.int(defaultWidth * Note.NoteData.getScale(PlayState.mania)));
			else
				setGraphicSize(Std.int(defaultWidth * Note.NoteData.getScale(PlayState.mania)), Std.int(defaultHeight * Note.NoteData.getScale(0)));
			updateHitbox();
	}

	function loadPixelNoteAnims() {
		if(isSustainNote) {
			for (i in 0...9) {
				animation.add(Note.NoteData.getLetter(i) + ' hold', [i]);
				animation.add(Note.NoteData.getLetter(i) + ' tail', [i + 18]);
			}
		} else {
			for (i in 0...9) {
				animation.add(Note.NoteData.getLetter(i), [i + 18]);
			}
		}
	}

	public function applyManiaChange()
	{
		if (PlayState.isPixelStage) loadPixelNoteAnims();
		else loadNoteAnims();
		if (!isSustainNote)
		{
			var animToPlay:String = '';
			animToPlay = Note.NoteData.getLetter(Note.NoteData.getKeyMap(PlayState.mania, noteData, 0));
			animation.play(animToPlay);
		}

		if (isSustainNote && prevNote != null)
		{
			animation.play(Note.NoteData.getLetter(Note.NoteData.getKeyMap(PlayState.mania, noteData, 0)) + ' tail');
			if (prevNote.isSustainNote)
			{
				prevNote.animation.play(Note.NoteData.getLetter(Note.NoteData.getKeyMap(PlayState.mania, noteData, 0)) + ' hold');
				prevNote.updateHitbox();
			}
		}

		updateHitbox();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (mustPress)
		{
			// ok river
			if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
				&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * earlyHitMult))
				canBeHit = true;
			else
				canBeHit = false;

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				tooLate = true;
		}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (isSustainNote && !susActive) multAlpha = 0.2;

		if (tooLate && !inEditor)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}
}

class NoteData
{
    public static var keyMaps:Map<Int, Array<Dynamic>> = [
        0       =>      [
							[4],
							[4]
						],

        1       =>      [
							[0, 3], 
							[0, 3]
						],

        2       =>      [
							[0, 4, 3], 
							[0, 4, 3]
						],

        3       =>      [
							[0, 1, 2, 3], 
							[0, 1, 2, 3]
						],

        4       =>      [
							[0, 1, 4, 2, 3], 
							[0, 1, 4, 2, 3]
						],

        5       =>      [	
							[0, 2, 3, 5, 1, 8], 
							[0, 2, 3, 0, 1, 3]
						],

        6       =>      [
							[0, 2, 3, 4, 5, 1, 8], 
							[0, 2, 3, 4, 0, 1, 3]
						],

        7       =>      [
							[0, 1, 2, 3, 5, 6, 7, 8], 
							[0, 1, 2, 3, 0, 1, 2, 3]
						],

        8       =>      [
							[0, 1, 2, 3, 4, 5, 6, 7, 8], 
							[0, 1, 2, 3, 4, 0, 1, 2, 3]
						],

		9		=>		[
							[0, 1, 2, 3, 4, 4, 5, 6, 7, 8],
							[0, 1, 2, 3, 4, 4, 0, 1, 2, 3]
						],

		10		=>		[
							[0, 1, 2, 3, 9, 13, 12, 0, 1, 2, 3],
							[0, 1, 2, 3, 0, 13, 3, 0, 1, 2, 3]
						]
    ];

	public static var keysShit:Map<Int, Map<String, Dynamic>> = [
		0 => ["letters" => ["E"], "anims" => ["UP"], "strumAnims" => ["UP"], "pixelAnimIndex" => [4]],
		1 => ["letters" => ["A", "D"], "anims" => ["LEFT", "RIGHT"], "strumAnims" => ["LEFT", "RIGHT"], "pixelAnimIndex" => [0, 3]],
		2 => ["letters" => ["A", "E", "D"], "anims" => ["LEFT", "UP", "RIGHT"], "strumAnims" => ["LEFT", "SPACE", "RIGHT"], "pixelAnimIndex" => [0, 4, 3]],
		3 => ["letters" => ["A", "B", "C", "D"], "anims" => ["LEFT", "DOWN", "UP", "RIGHT"], "strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT"], "pixelAnimIndex" => [0, 1, 2, 3]],

		4 => ["letters" => ["A", "B", "E", "C", "D"], "anims" => ["LEFT", "DOWN", "UP", "UP", "RIGHT"],
			 "strumAnims" => ["LEFT", "DOWN", "SPACE", "UP", "RIGHT"], "pixelAnimIndex" => [0, 1, 4, 2, 3]],

		5 => ["letters" => ["A", "C", "D", "F", "B", "I"], "anims" => ["LEFT", "UP", "RIGHT", "LEFT", "DOWN", "RIGHT"],
			 "strumAnims" => ["LEFT", "UP", "RIGHT", "LEFT", "DOWN", "RIGHT"], "pixelAnimIndex" => [0, 2, 3, 5, 1, 8]],

		6 => ["letters" => ["A", "C", "D", "E", "F", "B", "I"], "anims" => ["LEFT", "UP", "RIGHT", "UP", "LEFT", "DOWN", "RIGHT"],
			 "strumAnims" => ["LEFT", "UP", "RIGHT", "SPACE", "LEFT", "DOWN", "RIGHT"], "pixelAnimIndex" => [0, 2, 3, 4, 5, 1, 8]],
			
		7 => ["letters" => ["A", "B", "C", "D", "F", "G", "H", "I"], "anims" => ["LEFT", "UP", "DOWN", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"],
			 "strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP", "RIGHT"], "pixelAnimIndex" => [0, 1, 2, 3, 5, 6, 7, 8]],
		
		8 => ["letters" => ["A", "B", "C", "D", "E", "F", "G", "H", "I"], "anims" => ["LEFT", "DOWN", "UP", "RIGHT", "UP", "LEFT", "DOWN", "UP", "RIGHT"],
			 "strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SPACE", "LEFT", "DOWN", "UP", "RIGHT"], "pixelAnimIndex" => [0, 1, 2, 3, 4, 5, 6, 7, 8]],

		9 => ["letters" => ["A", "B", "C", "D", "E", "N", "F", "G", "H", "I"], "anims" => ["LEFT", "DOWN", "UP", "RIGHT", "UP", "UP", "LEFT", "DOWN", "UP", "RIGHT"],
			 "strumAnims" => ["LEFT", "DOWN", "UP", "RIGHT", "SPACE", "SPACE", "LEFT", "DOWN", "UP", "RIGHT"], "pixelAnimIndex" => [0, 1, 2, 3, 4, 13, 5, 6, 7, 8]]
	];

    public static function getKeyMap(mania:Int, key:Int, type:Int):Int
    {
        return keyMaps.get(mania)[type][key];
    }

    public static function getAmmo(mania:Int)
    {
        var ammo:Array<Int> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

		return ammo[mania];
    }

	public static function getAnimation(data:Int, type:Int) {
		var gfxDir:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'SPACE', 'CIRCLE'];
		var charDir:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT', 'UP', 'UP'];

		var str:String = '';
		switch(type)
		{
			case 0:
				str = gfxDir[data];
			case 1:
				str = charDir[data];
		}

		return str;
	}

	public static function getLetter(data:Int) {
		var gfxLetter:Array<String> = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 
		'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R'];

		return gfxLetter[data];
	}

	public static function getScale(mania:Int) {
		var scales:Array<Float> = [0.9, 0.85, 0.8, 0.7, 0.66, 0.6, 0.55, 0.50, 0.46, 0.39, 0.29];

		return scales[mania];
	}

	public static function getSwagWidth(mania:Int) {
		var swidths:Array<Float> = [141, 124, 116, 108, 102, 93, 85, 77, 71, 60, 49];

		return swidths[mania];
	}

	public static function getRestPosition(mania:Int) {
		var posRest:Array<Int> = [0, 0, 0, 0, 25, 32, 46, 52, 60, 40, 30];

		return posRest[mania];
	}

	public static function getLessXStrumNote(mania:Int) {
	var lessX:Array<Int> = [0, 0, 0, 0, 0, 8, 7, 8, 8, 7, 6];

		return lessX[mania];
	}

	public static function getXtraX(mania:Int) {
		var xtra:Array<Int> = [150, 89, 0, 0, 0, 0, 0, 0, 0, 0, 0];

		return xtra[mania];
	}

	public static function getMiddleScrollSeparator(mania:Int) {
		var separator:Array<Int> = [0, 0, 1, 1, 2, 2, 2, 3, 3, 4, 4];

		return separator[mania];
	}

	public static function getGridSize(mania:Int) {
		var gridSizes:Array<Int> = [40, 40, 40, 40, 40, 40, 40, 40, 40, 35, 30];

		return gridSizes[mania];
	}

	public static function getNoteSplashOffset(mania:Int, animNum:Int) {
		var offsets:Array<Dynamic> = [
			[20, 10],
			[10, 10],
			[10, 10],
			[10, 10],
			[10, 10],
			[10, 10],
			[10, 10],
			[10, 10],
			[10, 10],
			[10, 20],
			[10, 10]
		];

		return offsets[mania][animNum];
	}

	public static function getPixelSize(mania:Int) {
		var Scales:Array<Float> = [1.2, 1.15, 1.1, 1, 0.9, 0.83, 0.8, 0.74, 0.7, 0.6];

		return Scales[mania];
	}
}