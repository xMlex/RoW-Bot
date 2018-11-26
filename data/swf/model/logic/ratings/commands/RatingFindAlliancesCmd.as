package model.logic.ratings.commands {
import model.data.alliances.AllianceNote;
import model.data.users.UserNote;
import model.logic.AllianceNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.alliances.BaseAllianceCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.ratings.commands.Dtos.RatingDto;

public class RatingFindAlliancesCmd extends BaseAllianceCmd {


    private var _dto;

    public function RatingFindAlliancesCmd(param1:String, param2:int, param3:int) {
        super();
        this._dto = {
            "n": param1,
            "f": param2,
            "c": param3
        };
    }

    override public function execute():void {
        new JsonCallCmd("Rating.FindAlliances", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc2_:* = AllianceNote.fromDtos(param1.a);
            AllianceNoteManager.update(_loc2_);
            if (param1.x) {
                _loc4_ = AllianceNote.fromDtos(param1.x);
                AllianceNoteManager.update(_loc4_);
            }
            if (param1.o) {
                _loc5_ = UserNote.fromDtos(param1.o);
                UserNoteManager.update(_loc5_);
            }
            var _loc3_:* = RatingDto.fromDto(param1);
            if (_onResult != null) {
                _onResult(_loc3_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
