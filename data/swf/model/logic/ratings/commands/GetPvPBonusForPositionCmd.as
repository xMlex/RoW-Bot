package model.logic.ratings.commands {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetPvPBonusForPositionCmd extends BaseCmd {


    private var _dto;

    public function GetPvPBonusForPositionCmd(param1:int) {
        super();
        this._dto = {"p": param1};
    }

    override public function execute():void {
        new JsonCallCmd("Rating.GetPvPBonusForPosition", this._dto, "POST").ifResult(_onResult).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
