package model.logic.ratings.commands {
import model.data.alliances.AllianceNote;
import model.data.users.UserNote;
import model.logic.AllianceNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.ratings.commands.Dtos.RatingDto;

public class RatingGetCmd extends BaseCmd {


    private var _dto;

    public function RatingGetCmd(param1:int, param2:int) {
        super();
        this._dto = {
            "p": param1,
            "c": param2
        };
    }

    override public function execute():void {
        new JsonCallCmd("Rating.Get", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc3_:* = undefined;
            var _loc5_:* = undefined;
            var _loc2_:* = UserNote.fromDtos(param1.u);
            UserNoteManager.update(_loc2_);
            if (param1.x) {
                _loc3_ = AllianceNote.fromDtos(param1.x);
                AllianceNoteManager.update(_loc3_);
            }
            if (param1.a) {
                _loc3_ = AllianceNote.fromDtos(param1.a);
                AllianceNoteManager.update(_loc3_);
            }
            if (param1.o) {
                _loc5_ = UserNote.fromDtos(param1.o);
                UserNoteManager.update(_loc5_);
            }
            var _loc4_:* = RatingDto.fromDto(param1);
            if (_onResult != null) {
                _onResult(_loc4_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
