package characters;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;

class Mattones extends FlxSprite
{
    public function new(x:Float, y:Float)
    {
        super(x, y);

        var character = FlxAtlasFrames.fromSparrow(AssetPaths.Mattones__png, AssetPaths.Mattones__xml);
        frames = character;
        animation.addByPrefix('idle', 'Mattones idle', 20, false, true, false);
        animation.addByPrefix('down', 'Mattones down', 20, false, true, false);
        animation.addByPrefix('up', 'Mattones up', 20, false, true, false);
        animation.addByPrefix('left', 'Mattones left', 20, false, true, false);
        animation.addByPrefix('right', 'Mattones right', 20, false, true, false);
        scale.x = 2.7;
        scale.y = 2.7;
        character.setFrameOffset('idle', 0, 0);
        character.setFrameOffset('down', 0, 0);
        character.setFrameOffset('up', 0, 0);
        character.setFrameOffset('left', 0, 0);
        character.setFrameOffset('right', 0, 0);
        antialiasing = false;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if(animation.finished)
        {
            new FlxTimer().start(15 / 60, function(tmr:FlxTimer)
            {
                animation.play('idle');
            });
        }
    }
}
