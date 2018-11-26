package model.logic.ratings.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class UserPvPRatingGetCmd extends BaseCmd {


    public function UserPvPRatingGetCmd() {
        super();
    }

    override public function execute():void {
        new JsonCallCmd("Rating.GetUserPvPRating", null, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = param1;
            var _loc3_:* = {
                "Pos": -1,
                "Points": 0,
                "Prize": null
            };
            if (_loc2_) {
                _loc3_.Pos = _loc2_.p;
                _loc3_.Points = _loc2_.i;
                _loc3_.Prize = _loc2_.b;
            }
            if (_onResult != null) {
                _onResult(_loc3_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
