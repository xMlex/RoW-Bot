package model.logic.blackMarketModel.refreshableBehaviours.itemCounts {
import model.data.temporarySkins.TemporarySkin;
import model.data.temporarySkins.TemporarySkinBox;
import model.data.users.misc.UserSectorSkinData;
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicInteger;
import model.logic.blackMarketModel.temporaryCore.DynamicStateObject;

public class TemporarySectorSkinCount extends DynamicStateObject implements IDynamicInteger {


    private var _tempSkin:TemporarySkin;

    private var _value:int;

    public function TemporarySectorSkinCount(param1:TemporarySkin) {
        super();
        this._tempSkin = param1;
    }

    public function get value():int {
        return this._value;
    }

    public function refresh():void {
        var _loc2_:TemporarySkinBox = null;
        var _loc1_:UserSectorSkinData = UserManager.user.gameData.sectorSkinsData;
        if (_loc1_ == null || _loc1_.temporarySectorSkinData == null) {
            this._value = 0;
        }
        else {
            _loc2_ = _loc1_.temporarySectorSkinData.skinBoxes[this._tempSkin.skinTemplateId];
            this._value = _loc2_ != null ? int(_loc2_.count) : 0;
        }
    }
}
}
