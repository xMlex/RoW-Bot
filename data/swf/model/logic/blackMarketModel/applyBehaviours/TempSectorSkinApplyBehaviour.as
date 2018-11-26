package model.logic.blackMarketModel.applyBehaviours {
import Utils.Guard;

import model.data.users.UserNote;
import model.logic.UserManager;
import model.logic.UserNoteManager;
import model.logic.blackMarketModel.applyBehaviours.contexts.ApplyContext;
import model.logic.blackMarketModel.applyBehaviours.contexts.SkinApplyContext;
import model.logic.commands.temporarySkin.ActivateTemporarySkinCmd;

public class TempSectorSkinApplyBehaviour extends ApplyBehaviourBase {


    private var _commandCache:ActivateTemporarySkinCmd;

    private var _skinTemplateId:int;

    public function TempSectorSkinApplyBehaviour() {
        super();
    }

    override public function prepareApply(param1:int, param2:ApplyContext):void {
        var _loc3_:SkinApplyContext = param2 as SkinApplyContext;
        Guard.againstNull(_loc3_);
        if (_loc3_ != null) {
            this._skinTemplateId = _loc3_.temporaryTemplateId;
            if (this._commandCache == null) {
                this._commandCache = new ActivateTemporarySkinCmd(this._skinTemplateId);
            }
            else {
                this._commandCache.skinTemplateId = this._skinTemplateId;
            }
        }
    }

    override public function invoke():void {
        if (this._commandCache != null) {
            this._commandCache.ifResult(this.resultHanlder).ifFault(this.faultHandler).execute();
        }
    }

    private function resultHanlder(param1:*):void {
        var _loc2_:UserNote = new UserNote(UserManager.user);
        UserNoteManager.updateOne(_loc2_);
        dispatchResult();
    }

    private function faultHandler(param1:*):void {
        dispatchFault(param1);
    }
}
}
