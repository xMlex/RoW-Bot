package model.logic.commands.pvp {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetPvPPrizesCmd extends BaseCmd {


    private var _ratingType:int;

    public function GetPvPPrizesCmd(param1:int) {
        super();
        this._ratingType = param1;
    }

    override public function execute():void {
        new JsonCallCmd("Rating.GetPrizes", this._ratingType, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = param1;
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
