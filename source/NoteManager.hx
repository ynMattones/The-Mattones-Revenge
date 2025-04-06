package;

import flixel.FlxG;
import flixel.FlxSprite;

class NoteManager extends FlxSprite
{
    public function new(type:String, delay:Int)
    {
        super(x);

        y = delay * 150;

        loadGraphic('assets/images/arrowNote.png');
        setGraphicSize(80);
        antialiasing = false;
        if(type == 'left')
        {
            angle = 0;
            x = 100;
        }
        else if(type == 'down')
        {
            angle = -90;
            x = 200;
        }
        else if(type == 'up')
        {
            angle = 90;
            x = 300;
        }
        else if(type == 'right')
        {
            angle = 180;
            x = 400;
        }
    }
    
    
}
