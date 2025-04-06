package;

import characters.Mattones;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.util.typeLimit.NextState;
import stages.Stage;

#if desktop
import hxwindowmode.WindowColorMode;
#end

class PlayState extends FlxState
{
	//Tutorial
		var stage = new Stage();
		var mattones = new Mattones(0, 0);

	public var curArrow:String = 'arrow_pressed';
	public var curSong:String = '';
	public var curSpeed:Float = 0;
	public var Song:String = 'Tutorial'; //Put your song name here!
	public var inPause:String = 'false';

	var curNote1 = new NoteManager('down', 3);
	var curNote2 = new NoteManager('up', 4);
	var curNote3 = new NoteManager('left', 5);
	var curNote4 = new NoteManager('right', 6);

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

		curLeftArrow.setGraphicSize(80);
		curDownArrow.setGraphicSize(80);
		curUpArrow.setGraphicSize(80);
		curRightArrow.setGraphicSize(80);

		curLeftArrow.antialiasing = false;
		curDownArrow.antialiasing = false;
		curUpArrow.antialiasing = false;
		curRightArrow.antialiasing = false;

		add(curLeftArrow);
		add(curDownArrow);
		add(curUpArrow);
		add(curRightArrow);

		curLeftArrow.x = 100;
		curDownArrow.x = 200;
		curUpArrow.x = 300;
		curRightArrow.x = 400;
		curLeftArrow.y = 100;
		curDownArrow.y = 100;
		curUpArrow.y = 100;
		curRightArrow.y = 100;

		curLeftArrow.scrollFactor.set();
		curDownArrow.scrollFactor.set();
		curUpArrow.scrollFactor.set();
		curRightArrow.scrollFactor.set();

		add(curNote1);
		add(curNote2);
		add(curNote3);
		add(curNote4);

		curNote1.scrollFactor.set();
		curNote2.scrollFactor.set();
		curNote3.scrollFactor.set();
		curNote4.scrollFactor.set();

		mattones.animation.play('idle');
		mattones.scrollFactor.set(1, 1);

		FlxG.sound.playMusic(curSong);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		var PauseText = new FlxText(0,0,0,"Game Paused, Press R to return to the game",32);
		PauseText.screenCenter();
		PauseText.scrollFactor.set();
		if(inPause == 'false')
		{
			remove(PauseText);
			FlxG.camera.follow(mattones, FlxCameraFollowStyle.PLATFORMER);
			if(curArrow == 'up')
			{
				mattones.animation.play('up');
				new FlxTimer().start(15 / 60, function(tmr:FlxTimer)
				{
					curArrow = '';
				});
			}
			else if(curArrow == 'down')
			{
				mattones.animation.play('down');
				new FlxTimer().start(15 / 60, function(tmr:FlxTimer)
					{
						curArrow = '';
					});
			}
			else if(curArrow == 'left')
			{
				mattones.animation.play('left');
				new FlxTimer().start(15 / 60, function(tmr:FlxTimer)
					{
						curArrow = '';
					});
			}
			else if(curArrow == 'right')
			{
				mattones.animation.play('right');
				new FlxTimer().start(15 / 60, function(tmr:FlxTimer)
					{
						curArrow = '';
					});
			}
			curNote1.y += curSpeed;
			curNote2.y += curSpeed;
			curNote3.y += curSpeed;
			curNote4.y += curSpeed;
			if(FlxG.keys.pressed.DOWN)
			{
				if (FlxG.overlap(curNote1, curDownArrow))
				{
					curArrow = 'down';
					remove(curNote1);
				}
			}
			if(FlxG.keys.pressed.UP)
			{
				if (FlxG.overlap(curNote2, curUpArrow))
				{
					curArrow = 'up';
					remove(curNote2);
				}
			}
			if(FlxG.keys.pressed.LEFT)
			{
				if (FlxG.overlap(curNote3, curLeftArrow))
				{
					curArrow = 'left';
					remove(curNote3);
				}
			}
			if(FlxG.keys.pressed.RIGHT)
			{
				if (FlxG.overlap(curNote4, curRightArrow))
				{
					curArrow = 'right';
					remove(curNote4);
				}
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
		new FlxTimer().start(5 / 60, function(tmr:FlxTimer)
		{
			return;
		});
	}
}
