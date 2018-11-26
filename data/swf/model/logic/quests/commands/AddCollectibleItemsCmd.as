package model.logic.quests.commands {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class AddCollectibleItemsCmd extends BaseCmd {


    private var _itemId:int;

    private var _count:int;

    private var _source:int;

    private var _requestDto:Object;

    public function AddCollectibleItemsCmd(param1:int, param2:int, param3:int) {
        super();
        this._itemId = param1;
        this._count = param2;
        this._source = param3;
        this._requestDto = UserRefreshCmd.makeRequestDto({
            "i": param1,
            "c": param2,
            "s": param3
        });
    }

    override public function execute():void {
        new JsonCallCmd("CollectableItems.Add", this._requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _requestDto)) {
                _loc2_ = UserManager.user.gameData.questData.activeThemedEvent;
                if (_loc2_ != null) {
                    _loc3_ = _loc2_.completion.collectibleThemedItemsEvent;
                    _loc3_.collectItem(_itemId, _count, _source);
                }
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
