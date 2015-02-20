package alienzone.model;
class LeaderData {

    public var id:String;
    public var title:String;
    public var image:String;
    public var score:Int;

    public function new(id:String, title:String, image:String, score:Int) {
        this.id = id;
        this.title = title;
        this.image = image;
        this.score = score;
    }
}
