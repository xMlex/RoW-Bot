package model.logic.ratings.commands {
import model.data.users.UserNote;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.ratings.commands.Dtos.RatingDto;

public class RatingFindUserCmd extends BaseCmd {


    private var _dto;

    public function RatingFindUserCmd(param1:int, param2:Number, param3:int) {
        super();
        this._dto = {
            "r": param1,
            "u": param2,
            "c": param3
        };
    }

    override public function execute():void {
        new JsonCallCmd("Rating.FindUser", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = UserNote.fromDtos(param1.u);
            UserNoteManager.update(_loc2_);
            var _loc3_:* = RatingDto.fromDto(param1);
            if (_onResult != null) {
                _onResult(_loc3_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
