package model.logic.commands.sector {
import model.logic.UserManager;
import model.logic.UserStatsManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class SellArtifactCmd extends BaseCmd {


    private var _artifactId:Number;

    private var requestDto;

    public function SellArtifactCmd(param1:Number) {
        super();
        this._artifactId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto(this._artifactId);
    }

    override public function execute():void {
        new JsonCallCmd("SellArtifact", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            var _loc7_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user;
                _loc3_ = UserManager.user.gameData.artifactData;
                if (_loc3_.artifacts[_artifactId] != null) {
                    _loc6_ = _loc3_.artifacts[_artifactId];
                    _loc7_ = _loc6_.objectType.artifactInfo.sellingPrice;
                    delete _loc3_.artifacts[_artifactId];
                    _loc2_.gameData.account.resources.add(_loc7_);
                    UserStatsManager.minedResources(_loc2_, _loc7_);
                }
                _loc4_ = _loc3_.artifactsLayout;
                _loc5_ = 0;
                while (_loc5_ < _loc4_.length) {
                    if (_loc4_[_loc5_] == _artifactId) {
                        _loc4_[_loc5_] = 0;
                        break;
                    }
                    _loc5_++;
                }
                _loc2_.gameData.constructionData.updateAcceleration(_loc2_.gameData, _loc2_.gameData.normalizationTime);
                _loc3_.artifactsDirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
