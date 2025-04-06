package;

import characters.Mattones;
import characters.Player;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.util.typeLimit.NextState;
import haxe.Json;
import openfl.Assets;
import stages.Stage;

#if desktop
import hxwindowmode.WindowColorMode;
#end

class PlayState extends FlxState
{
	private var fpsText:FlxText;
    private var frameCount:Int = 0;
    private var timer:Float = 0;

	private var gameTime:Float = 0;

	private var notes:Array<Dynamic>;
	private var noteSprites:Array<FlxSprite>;

	private var textScore:FlxText;

	//Tutorial
		var stage = new Stage();
		var mattones = new Mattones(500, 0);
		var player = new Player(0, 0);

	public var curScore:Int = 0;
	public var curArrow:String = 'arrow_pressed';
	public var curSong:String = '';
	public var curSpeed:Float = 0;
	public var Song:String = 'Tutorial'; //Put your song name here!
	public var inPause:String = 'false';

	public var curLeftArrow:FlxSprite;
    public var curDownArrow:FlxSprite;
    public var curUpArrow:FlxSprite;
    public var curRightArrow:FlxSprite;
	override public function create()
	{
		super.create();
		FlxG.autoPause = false;
		FlxG.mouse.visible = false;

		switch (Song)
		{
			case 'Tutorial':
				curSong = '';
				curSpeed = -3;
				add(mattones);
				add(player);
				add(stage);
		}

		#if desktop
		WindowColorMode.setDarkMode();
		#end

		FlxAssets.FONT_DEFAULT = 'assets/font/default.ttf';

		var text = new FlxText(0,625,0,"Instructions:
		UP Arrow
		DOWN Arrow
		LEFT Arrow
		RIGHT Arrow", 15);
		add(text);
		text.scrollFactor.set();

		curLeftArrow = new FlxSprite();
        curDownArrow = new FlxSprite();
        curUpArrow = new FlxSprite();
        curRightArrow = new FlxSprite();

		curLeftArrow.loadGraphic('assets/images/arrowNote.png');
		curLeftArrow.angle = 0;
		curDownArrow.loadGraphic('assets/images/arrowNote.png');
		curDownArrow.angle = -90;
		curUpArrow.loadGraphic('assets/images/arrowNote.png');
		curUpArrow.angle = 90;
		curRightArrow.loadGraphic('assets/images/arrowNote.png');
		curRightArrow.angle = 180;

		curLeftArrow.setGraphicSize(100);
		curDownArrow.setGraphicSize(100);
		curUpArrow.setGraphicSize(100);
		curRightArrow.setGraphicSize(100);

		curLeftArrow.antialiasing = false;
		curDownArrow.antialiasing = false;
		curUpArrow.antialiasing = false;
		curRightArrow.antialiasing = false;

		add(curLeftArrow);
		add(curDownArrow);
		add(curUpArrow);
		add(curRightArrow);

		curLeftArrow.x = 100;
		curDownArrow.x = 220;
		curUpArrow.x = 340;
		curRightArrow.x = 460;
		curLeftArrow.y = 100;
		curDownArrow.y = 100;
		curUpArrow.y = 100;
		curRightArrow.y = 100;

		curLeftArrow.scrollFactor.set();
		curDownArrow.scrollFactor.set();
		curUpArrow.scrollFactor.set();
		curRightArrow.scrollFactor.set();

		mattones.animation.play('idle');
		mattones.scrollFactor.set(1, 1);

		player.animation.play('idle');
		player.scrollFactor.set(1, 1);

		FlxG.sound.playMusic(curSong);

		fpsText = new FlxText(0, 0, 0, "FPS: ", 16);
        add(fpsText);
		fpsText.scrollFactor.set();

		textScore = new FlxText(65,0,0,'Score: ');
		textScore.size = 16;
		add(textScore);
		textScore.scrollFactor.set();

		var json:String = Assets.getText("assets/data/song.json");
        notes = Json.parse(json).notes;

		noteSprites = [];

        for (note in notes) {
            var sprite:FlxSprite = new FlxSprite(400, 600 - (note.time * 100));
            sprite.loadGraphic('assets/images/arrowNote.png');
			sprite.scrollFactor.set();
			sprite.antialiasing = false;
			sprite.setGraphicSize(100);
            add(sprite);
			if(note.type == "left")
				{
					sprite.angle = 0;
					sprite.x = 100;
				}
				else if(note.type == "down")
				{
					sprite.angle = -90;
					sprite.x = 220;
				}
				else if(note.type == "up")
				{
					sprite.angle = 90;
					sprite.x = 340;
				}
				else if(note.type == "right")
				{
					sprite.angle = 180;
					sprite.x = 460;
				}

            noteSprites.push(sprite);
        }
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		for (sprite in noteSprites) {
			sprite.y += -100 * elapsed;
		}
		for (i in 0...noteSprites.length) {
			var sprite = noteSprites[i];
			var noteData = notes[i];
	
			if (FlxG.keys.justPressed.UP && noteData.type == "up" && FlxG.overlap(sprite, curUpArrow)) {
				curScore += 50;
				curArrow = 'up';
				sprite.kill();
				noteSprites.remove(sprite);
			}
			if (FlxG.keys.justPressed.DOWN && noteData.type == "down" && FlxG.overlap(sprite, curDownArrow)) {
				curScore += 50;
				curArrow = 'down';
				sprite.kill();
				noteSprites.remove(sprite);
			}
			if (FlxG.keys.justPressed.LEFT && noteData.type == "left" && FlxG.overlap(sprite, curLeftArrow)) {
				curScore += 50;
				curArrow = 'left';
				sprite.kill();
				noteSprites.remove(sprite);
			}
			if (FlxG.keys.justPressed.RIGHT && noteData.type == "right" && FlxG.overlap(sprite, curRightArrow)) {
				curScore += 50;
				curArrow = 'right';
				sprite.kill();
				noteSprites.remove(sprite);
			}
		}

		frameCount++;
        timer += elapsed;

		textScore.text = 'Score: ' + curScore;

        if (timer >= 1) 
		{
            var fps:Int = frameCount;
            fpsText.text = "FPS: " + fps;
            frameCount = 0;
            timer = 0;
        }

		var PauseText = new FlxText(0,0,0,"Game Paused, Press R to return to the game",32);
		PauseText.screenCenter();
		PauseText.scrollFactor.set();
		if(inPause == 'false')
		{
			remove(PauseText);
			FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
			if(curArrow == 'up')
			{
				player.animation.play('up');
				new FlxTimer().start(15 / 60, function(tmr:FlxTimer)
				{
					curArrow = '';
				});
			}
			else if(curArrow == 'down')
			{
				player.animation.play('down');
				new FlxTimer().start(15 / 60, function(tmr:FlxTimer)
					{
						curArrow = '';
					});
			}
			else if(curArrow == 'left')
			{
				player.animation.play('left');
				new FlxTimer().start(15 / 60, function(tmr:FlxTimer)
					{
						curArrow = '';
					});
			}
			else if(curArrow == 'right')
			{
				player.animation.play('right');
				new FlxTimer().start(15 / 60, function(tmr:FlxTimer)
					{
						curArrow = '';
					});
			}
		}
		else if(inPause == 'true')
		{
			add(PauseText);
		}
		if(FlxG.keys.pressed.R)
		{
			inPause == 'true';
		}
	
	}

	public function AnimationFinished()
	{
		trace('Animation Finished');
		new FlxTimer().start(5 / 60, function(tmr:FlxTimer)
		{
			return;
		});
	}
}
