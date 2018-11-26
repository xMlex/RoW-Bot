package model.logic.commands.cyborgs {
import model.data.scenes.types.info.TroopsTypeId;
import model.data.users.troops.Troops;
import model.logic.UserManager;
import model.logic.UserStatsManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.units.UnitUtility;

public class CreateCyborgCmd extends BaseCmd {


    private var requestDto;

    private var _friendId:Number;

    private var _autoHideBunker:Boolean;

    public function CreateCyborgCmd(param1:Number, param2:Boolean) {
        super();
        this._friendId = param1;
        this._autoHideBunker = param2;
        this.requestDto = UserRefreshCmd.makeRequestDto({"u": this._friendId});
    }

    override public function execute():void {
        new JsonCallCmd("CreateCyborg", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user;
                if (_autoHideBunker) {
                    _loc3_ = Troops.from(TroopsTypeId.CyborgUnit1, 1);
                    UnitUtility.AddTroopsToBunker(UserManager.user, _loc3_);
                }
                else {
                    _loc2_.gameData.troopsData.troops.addTroops2(TroopsTypeId.CyborgUnit1, 1);
                }
                _loc2_.gameData.cyborgData.cyborgsCreated++;
                _loc2_.gameData.cyborgData.cyborgUserIds.addItem(_friendId);
                _loc2_.gameData.cyborgData.dirty = true;
                UserStatsManager.cyborgCreated(_loc2_);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
