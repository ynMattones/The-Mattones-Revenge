package stages;

import flixel.FlxSprite;
import flixel.FlxState;

class Stage extends FlxState
{
    public function new()
    {
        super();

        var background = new FlxSprite();
        background.loadGraphic('');
        background.setGraphicSize(100);
        background.scrollFactor.set(1, 1);
        background.x = -500;
        background.y = -100;
        add(background);
        background.antialiasing = false;
    }
}
