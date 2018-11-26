package model.logic.ratings.commands {
import model.data.alliances.AllianceNote;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.ratings.commands.Dtos.RatingDto;

public class RatingFindAllianceCmd extends BaseCmd {


    private var _dto;

    public function RatingFindAllianceCmd(param1:Number, param2:int) {
        super();
        this._dto = {
            "a": param1,
            "c": param2
        };
    }

    override public function execute():void {
        new JsonCallCmd("Rating.FindAlliance", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = AllianceNote.fromDtos(param1.u);
            UserNoteManager.update(_loc2_);
            var _loc3_:* = RatingDto.fromDto(param1);
            if (_onResult != null) {
                _onResult(_loc3_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
