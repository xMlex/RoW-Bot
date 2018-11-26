package model.logic.commands.lottery {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.lotteries.LotteryManager;

public class GetLotteriesInfoCmd extends BaseCmd {


    private var _requestDto;

    public function GetLotteriesInfoCmd(param1:Boolean = false) {
        super();
        this._requestDto = LotteryManager.getLotteryRefreshInputDto();
        if (param1) {
            this._requestDto.w = true;
        }
    }

    override public function execute():void {
        new JsonCallCmd("GetLotteriesAndTypeInfos", this._requestDto, "POST").ifResult(function (param1:*):void {
            LotteryManager.updateFromDto(param1);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
