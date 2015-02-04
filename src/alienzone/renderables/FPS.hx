/**
 *--------------------------------------------------------------------+
 * FPS.hx
 *--------------------------------------------------------------------+
 * Copyright DarkOverlordOfData (c) 2014
 *--------------------------------------------------------------------+
 *
 * This file is a part of Alien Zone
 *
 * Alien Zone is free software; you can copy, modify, and distribute
 * it under the terms of the GPLv3 License
 *
 *--------------------------------------------------------------------+
 *
 */
package alienzone.renderables;

import flixel.FlxG;
import flixel.text.FlxText;

/**
 * Display Frames Per Second
 */
class FPS extends FlxText {

    private var total_frames:Int = 0;       //  frame counter
    private var elapsed_time:Float = 0.0;   //  accumulated elapsed time
    private var fps:Int = 0;                //  last fps count


    /**
     * Create a new component
     */
    public function new(x:Float = 10.0, y:Float = 10.0, color:Int = 0x000000) {
        super(x, y, 0, "[??]", 12, true);
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
