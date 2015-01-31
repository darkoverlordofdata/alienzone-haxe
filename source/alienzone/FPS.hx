package alienzone;

import alienzone.Reg;
import flixel.FlxG;
import flixel.text.FlxText;


class FPS extends FlxText {

    private var total_frames:Int = 0;       //  frame counter
    private var elapsed_time:Float = 0.0;   //  accumulated elapsed time
    private var fps:Int = 0;                //  last fps count


    /**
     * Create a new component
     */
    public function new(x:Float = 10.0, y:Float = 10.0, color:Int = 0x000000) {
        super(x, y, 0, "[??]", 12, true);
        font = Reg.font;
    }

    /**
     * update - calculate the frame rate
     */
    override public function update():Void {
        super.update();
        elapsed_time += FlxG.elapsed;
        if (elapsed_time > 1.0) {
            fps = total_frames;
            total_frames = 0;
            elapsed_time = 0;
        }
    }

    /**
     * draw - display the frame rate
     */
    override public function draw():Void {
        total_frames++;
        text = (fps == 0) ? '[??]' : '[${fps}]';
        super.draw();
    }

}
