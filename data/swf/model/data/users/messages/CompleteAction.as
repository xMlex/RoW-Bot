package model.data.users.messages {
public class CompleteAction {


    public var type:int;

    public var id:int;

    public var argument:String;

    public var tab:int;

    public function CompleteAction() {
        super();
    }

    public static function fromDto(param1:*):CompleteAction {
        var _loc2_:CompleteAction = new CompleteAction();
        _loc2_.type = param1.t;
        _loc2_.id = param1.i;
        _loc2_.argument = param1.s;
        _loc2_.tab = param1.z != null ? int(param1.z) : -1;
        return _loc2_;
    }
}
}
