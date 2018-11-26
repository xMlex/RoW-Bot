package model.logic.ratings.commands {
import model.data.alliances.AllianceNote;
import model.data.ratings.RatingItem;
import model.data.users.UserNote;
import model.logic.AllianceNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class RatingGetTopCmd extends BaseCmd {


    private var _dto;

    public function RatingGetTopCmd(param1:int, param2:int, param3:Number, param4:Number, param5:int, param6:int) {
        super();
        this._dto = {
            "t": param1,
            "r": param2,
            "u": param3,
            "p": param4,
            "m": param5,
            "c": param6
        };
    }

    override public function execute():void {
        new JsonCallCmd("Rating.GetTop", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            var _loc7_:* = undefined;
            var _loc2_:* = RatingItem.fromDtos(param1.t);
            var _loc3_:* = param1.d == null ? null : RatingItem.fromDtos(param1.d);
            if (param1.u) {
                _loc4_ = UserNote.fromDtos(param1.u);
                UserNoteManager.update(_loc4_);
            }
            if (param1.a) {
                _loc5_ = AllianceNote.fromDtos(param1.a);
                AllianceNoteManager.update(_loc5_);
            }
            if (param1.x) {
                _loc6_ = AllianceNote.fromDtos(param1.x);
                AllianceNoteManager.update(_loc6_);
            }
            if (param1.o) {
                _loc7_ = UserNote.fromDtos(param1.o);
                UserNoteManager.update(_loc7_);
            }
            if (_onResult != null) {
                _onResult(_loc2_, _loc3_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
