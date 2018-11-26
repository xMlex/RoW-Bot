package model.logic.commands.blackMarcket {
import model.data.users.blackMarket.UserBmiData;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.dtoSerializer.DtoDeserializer;

public class RemoveSelectedExpiredItemsCmd extends BaseCmd {


    private var requestDto;

    public function RemoveSelectedExpiredItemsCmd(param1:Array) {
        super();
        var _loc2_:Object = {};
        if (param1 != null) {
            _loc2_.z = param1;
        }
        this.requestDto = UserRefreshCmd.makeRequestDto(_loc2_);
    }

    override public function execute():void {
        new JsonCallCmd("BlackMarket.RemoveSelectedExpiredItems", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                if (param1.o != null) {
                    _loc2_ = DtoDeserializer.toArray(param1.o.z, UserBmiData.fromDto);
                    UserManager.user.gameData.blackMarketData.updateExpiredItemsWithRemoved(_loc2_);
                }
            }
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
