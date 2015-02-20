package alienzone.model;
class AwardData {

    public var id:String;
    public var title:String;
    public var desc:String;
    public var image:String;
    public var lock:Bool;

    public function new(id:String, title:String, desc:String, image:String, lock:Bool) {
        this.id = id;
        this.title = title;
        this.desc = desc;
        this.image = image;
        this.lock = lock;
    }
}
