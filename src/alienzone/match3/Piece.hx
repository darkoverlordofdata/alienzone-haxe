/**
 *--------------------------------------------------------------------+
 * Piece.hx
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
 *
 * @see https://github.com/hugeen/jmatch3
 */
package alienzone.match3;

class Piece extends Point {

    public var grid:Grid;
    public var object:MatchObject;

    /**
     * Params:
     * - grid
     * - x
     * - y
     */
    public function new(grid:Grid, x:Int, y:Int) {
        super(x, y);
        this.grid = grid;
        clear();
    }

    public function clear():Void {
        object = new MatchObject();
    }

    public function relativeCoordinates(direction:Point, distance:Int):Point {
        return new Point(x + distance * direction.x, y + distance * direction.y);
    }

    public function neighbour(direction:Point):Piece {
        return grid.neighbourOf(this, direction);
    }

    public function neighbours():Map<String,Piece> {
        return grid.neighboursOf(this);
    }

    public function matchingNeighbours():Array<Piece> {
        var matches:Array<Piece> = [];

        for (neighbour in neighbours()) {
            if (neighbour != null) {
                if (neighbour.object.type == object.type) {
                    matches.push(neighbour);
                }
            }
        }
        return matches;
    }

    public function deepMatchingNeighbours():Array<Piece> {
        var deepMatches:Array<Piece> = [];

        function deepMatchingNeighbours(piece:Piece) {
            var matchingNeighbours = piece.matchingNeighbours();

            for (matchingNeighbour in matchingNeighbours) {
                if (deepMatches.indexOf(matchingNeighbour) == -1) {
                    deepMatches.push(matchingNeighbour);
                    deepMatchingNeighbours(matchingNeighbour);
                }
            }
        }
        deepMatchingNeighbours(this);
        return deepMatches;
    }
}
