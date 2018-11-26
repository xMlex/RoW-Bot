package model.logic.ratings.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.ratings.commands.Dtos.UserRatingsDto;

public class RatingGetUserRatingsCmd extends BaseCmd {


    private var _dto;

    public function RatingGetUserRatingsCmd(param1:Number) {
        super();
        this._dto = param1;
    }

    override public function execute():void {
        new JsonCallCmd("Rating.GetUserRatings", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = UserRatingsDto.fromDto(param1);
            if (_onResult != null) {
                _onResult(_loc2_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
