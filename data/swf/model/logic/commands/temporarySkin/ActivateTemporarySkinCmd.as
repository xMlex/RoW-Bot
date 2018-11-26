package model.logic.commands.temporarySkin {
import model.data.UserGameData;
import model.data.effects.EffectItem;
import model.data.effects.EffectsManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class ActivateTemporarySkinCmd extends BaseCmd {


    private var _requestDto;

    private var _skinTemplateId:Number;

    public function ActivateTemporarySkinCmd(param1:Number) {
        super();
        this.skinTemplateId = param1;
    }

    public function set skinTemplateId(param1:Number):void {
        this._skinTemplateId = param1;
        this._requestDto = UserRefreshCmd.makeRequestDto({"i": this._skinTemplateId});
    }

    override public function execute():void {
        new JsonCallCmd("TemporarySkinManager.ActivateTempSkin", this._requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, _requestDto)) {
                if (param1.o.e != null) {
                    _loc3_ = EffectItem.fromDtos(param1.o.e);
                    EffectsManager.addEffects(_loc3_);
                }
                _loc2_ = UserManager.user.gameData;
                _loc2_.constructionData.updateAcceleration(_loc2_, _loc2_.normalizationTime);
                _loc2_.sectorSkinsData.setCurrentTemporarySkin(_skinTemplateId, _loc2_.normalizationTime);
                _loc2_.dispatchEvent(UserGameData.SECTOR_SKIN_DATA_CHANGED);
            }
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
