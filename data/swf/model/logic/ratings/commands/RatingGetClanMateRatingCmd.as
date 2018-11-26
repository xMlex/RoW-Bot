package model.logic.ratings.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.ratings.commands.Dtos.RatingDto;

public class RatingGetClanMateRatingCmd extends BaseCmd {


    private var _dto;

    public function RatingGetClanMateRatingCmd(param1:int, param2:Array) {
        super();
        this._dto = {
            "p": param1,
            "f": param2
        };
    }

    override public function execute():void {
        new JsonCallCmd("Rating.GetFriendRating", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = RatingDto.fromDto(param1);
            if (_onResult != null) {
                _onResult(_loc2_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
