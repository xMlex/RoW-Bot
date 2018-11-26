package model.data.users.messages {
import common.StringUtil;

public class GlobalMessage {


    public var id:int;

    public var type:int;

    public var header:String;

    public var text:String;

    public var serviceText:String;

    public var path:String;

    public var linkToSmallImage:String;

    public var isRead:Boolean;

    public var useBigImage:Boolean;

    public var action:CompleteAction;

    public var discussion:Discussion;

    public var activeTo:Date;

    public function GlobalMessage() {
        super();
    }

    public static function fromDto(param1:*):GlobalMessage {
        var _loc2_:GlobalMessage = new GlobalMessage();
        _loc2_.id = param1.i;
        _loc2_.type = param1.k;
        _loc2_.action = param1.a != null ? CompleteAction.fromDto(param1.a) : null;
        _loc2_.header = param1.h != null ? param1.h.c : StringUtil.EMPTY;
        _loc2_.text = param1.t != null ? param1.t.c : null;
        _loc2_.path = param1.p;
        _loc2_.linkToSmallImage = param1.s;
        _loc2_.useBigImage = param1.b;
        _loc2_.discussion = param1.d != null ? Discussion.fromDto(param1.d) : null;
        _loc2_.activeTo = param1.e != null ? new Date(param1.e) : null;
        _loc2_.serviceText = param1.v != null ? param1.v : StringUtil.EMPTY;
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }
}
}
