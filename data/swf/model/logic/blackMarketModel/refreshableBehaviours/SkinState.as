package model.logic.blackMarketModel.refreshableBehaviours {
import model.data.SectorSkinType;
import model.data.users.misc.UserSectorSkinData;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicState;

public class SkinState implements IDynamicState {


    public var isNew:Boolean;

    public var isLocked:Boolean;

    public var isLimited:Boolean;

    public var isCurrentlySelected:Boolean;

    public var isInvisible:Boolean;

    public var isForBankSells:Boolean;

    public var isTemporary:Boolean;

    public var templateId:int;

    protected var skinType:SectorSkinType;

    private var _changeHandler:Function;

    public function SkinState(param1:int) {
        super();
        this.skinType = StaticDataManager.getSectorSkinType(param1);
    }

    public function getSkinTypeId():int {
        var _loc1_:int = 0;
        if (this.skinType != null) {
            _loc1_ = this.skinType.id;
        }
        return _loc1_;
    }

    private function dispatchChange():void {
        if (this._changeHandler != null) {
            this._changeHandler();
        }
    }

    private function subscribe():void {
        var _loc1_:UserSectorSkinData = UserManager.user.gameData.sectorSkinsData;
        if (_loc1_) {
            _loc1_.addEventHandler(UserSectorSkinData.CURRENT_SKIN_TYPE_ID_CHANGED, this.refreshHandler);
        }
    }

    private function unsubscribe():void {
        var _loc1_:UserSectorSkinData = UserManager.user.gameData.sectorSkinsData;
        if (_loc1_) {
            _loc1_.removeEventHandler(UserSectorSkinData.CURRENT_SKIN_TYPE_ID_CHANGED, this.refreshHandler);
        }
    }

    private function refreshHandler(param1:Object):void {
        this.refresh();
    }

    public function refresh():void {
        this.isCurrentlySelected = this.isSelected;
        this.isLimited = this.skinType.limitCount > 0;
        this.isNew = this.skinType.status == SectorSkinType.SectorSkinTypeStatus_New;
        this.isLocked = this.skinType.requiredLevel > 0 && this.skinType.requiredLevel > UserManager.user.gameData.account.level;
        this.isInvisible = this.skinType.status == SectorSkinType.SectorSkinTypeStatus_Invisible;
        this.isForBankSells = this.skinType.isForBankSells;
        this.isTemporary = this.skinType.isTemporary;
        this.dispatchChange();
    }

    private function get isSelected():Boolean {
        var _loc3_:int = 0;
        var _loc1_:* = false;
        var _loc2_:UserSectorSkinData = UserManager.user.gameData.sectorSkinsData;
        if (_loc2_ != null) {
            _loc3_ = _loc2_.currentSkinTypeId;
            _loc1_ = _loc3_ == this.skinType.id;
            if (_loc2_.hasActiveTemporarySkin) {
                _loc1_ = Boolean(_loc1_ && _loc2_.temporarySectorSkinData.currentActiveSkin.skinTemplateId == this.templateId);
            }
        }
        return _loc1_;
    }

    public function onChange(param1:Function):void {
        if (param1 == null) {
            this.unsubscribe();
            this._changeHandler = param1;
            return;
        }
        this.subscribe();
        this._changeHandler = param1;
    }
}
}
