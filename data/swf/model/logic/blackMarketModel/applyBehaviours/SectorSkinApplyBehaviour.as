package model.logic.blackMarketModel.applyBehaviours {
import model.data.SectorSkinType;
import model.data.users.UserNote;
import model.logic.UserManager;
import model.logic.UserNoteManager;
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.applyBehaviours.contexts.SkinApplyContext;
import model.logic.commands.sector.SelectSectorSkinCmd;

public class SectorSkinApplyBehaviour extends ApplyBehaviourBase {


    private var _commandCache:SelectSectorSkinCmd;

    public function SectorSkinApplyBehaviour() {
        super();
    }

    override public function prepareApply(param1:int, param2:ApplyContext):void {
        var _loc3_:SkinApplyContext = param2 as SkinApplyContext;
        if (!_loc3_) {
            throw new Error("В SectorSkinApplyBehaviour попал неправильный контекст!");
        }
        var _loc4_:int = !!_loc3_.isCancel ? int(SectorSkinType.SectorSkinTypeId_Default) : int(param1);
        if (!this._commandCache) {
            this._commandCache = new SelectSectorSkinCmd(_loc4_);
        }
        else {
            this._commandCache.typeId = _loc4_;
        }
    }

    override public function invoke():void {
        this._commandCache.ifResult(this.resultHanlder).ifFault(this.faultHandler).execute();
    }

    private function resultHanlder(param1:*):void {
        var _loc2_:int = param1;
        var _loc3_:UserNote = new UserNote(UserManager.user);
        _loc3_.sectorSkinTypeId = _loc2_;
        UserNoteManager.updateOne(_loc3_);
        dispatchResult();
    }

    private function faultHandler(param1:*):void {
        dispatchFault(param1);
    }
}
}
