package model.logic.blackMarketModel.refreshableBehaviours.dates {
import model.data.temporarySkins.TemporarySectorSkinData;
import model.data.temporarySkins.TemporarySkin;
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicDate;

public class TemporarySkinExpirableDate implements IDynamicDate {


    private var _tempSkin:TemporarySkin;

    private var _expirationDate:IDynamicDate;

    public function TemporarySkinExpirableDate(param1:TemporarySkin, param2:IDynamicDate) {
        super();
        this._tempSkin = param1;
        this._expirationDate = param2;
    }

    public function get isExpired():Boolean {
        return this._expirationDate.isExpired;
    }

    public function get value():Date {
        return this._expirationDate.value;
    }

    public function set value(param1:Date):void {
    }

    public function refresh():void {
        this.resetDate();
        this._expirationDate.refresh();
    }

    private function resetDate():void {
        var _loc1_:TemporarySectorSkinData = null;
        if (UserManager.user.gameData.sectorSkinsData != null && UserManager.user.gameData.sectorSkinsData.temporarySectorSkinData != null && UserManager.user.gameData.sectorSkinsData.temporarySectorSkinData.currentActiveSkin != null && UserManager.user.gameData.sectorSkinsData.temporarySectorSkinData.currentActiveSkin.skinTemplateId == this._tempSkin.skinTemplateId) {
            _loc1_ = UserManager.user.gameData.sectorSkinsData.temporarySectorSkinData;
            this._expirationDate.value = _loc1_.getCurrentSkinExpirationDate();
        }
        else {
            this._expirationDate.value = null;
        }
    }
}
}
