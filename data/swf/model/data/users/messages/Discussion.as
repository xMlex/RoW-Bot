package model.data.users.messages {
public class Discussion {


    public var enabled:Boolean;

    public var discussionLink:String;

    public var minUserLevel:int;

    public function Discussion() {
        super();
    }

    public static function fromDto(param1:*):Discussion {
        var _loc2_:Discussion = new Discussion();
        _loc2_.enabled = param1.e;
        _loc2_.discussionLink = param1.u;
        _loc2_.minUserLevel = param1.l;
        return _loc2_;
    }
}
}
