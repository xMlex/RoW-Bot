package model.logic.ratings.commands {
import model.data.alliances.AllianceNote;
import model.data.users.UserNote;
import model.logic.AllianceNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.ratings.commands.Dtos.RatingDto;

public class RatingPvPGetCmd extends BaseCmd {


    private var requestDto;

    public function RatingPvPGetCmd(param1:int, param2:int = -1, param3:int = -1) {
        super();
        this.requestDto = {
            "c": param1,
            "l": param2
        };
        if (param3 > 0) {
            this.requestDto.i = param3;
        }
    }

    override public function execute():void {
        new JsonCallCmd("Rating.GetPvPRating", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc4_:* = undefined;
            var _loc6_:* = undefined;
            var _loc2_:* = param1;
            var _loc3_:* = UserNote.fromDtos(_loc2_.u);
            UserNoteManager.update(_loc3_);
            if (_loc2_.x) {
                _loc4_ = AllianceNote.fromDtos(_loc2_.x);
                AllianceNoteManager.update(_loc4_);
            }
            if (_loc2_.a) {
                _loc4_ = AllianceNote.fromDtos(_loc2_.a);
                AllianceNoteManager.update(_loc4_);
            }
            if (_loc2_.o) {
                _loc6_ = UserNote.fromDtos(_loc2_.o);
                UserNoteManager.update(_loc6_);
            }
            var _loc5_:* = RatingDto.fromDto(_loc2_);
            if (_onResult != null) {
                _onResult(_loc5_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
