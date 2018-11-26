package model.logic.skills.commands {
import flash.utils.Dictionary;

import model.data.scenes.types.info.BlackMarketItemsTypeId;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.skills.SkillManager;

public class DiscardPointsByItemCmd extends BaseCmd {


    private var requestDto;

    private var _pointsBySkillTypeId:Dictionary;

    public function DiscardPointsByItemCmd(param1:Dictionary) {
        var _loc2_:* = undefined;
        super();
        this._pointsBySkillTypeId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto();
        this.requestDto.o = {"i": {}};
        for (_loc2_ in this._pointsBySkillTypeId) {
            this.requestDto.o.i[_loc2_] = this._pointsBySkillTypeId[_loc2_];
        }
    }

    override public function execute():void {
        new JsonCallCmd("DiscardPointsByItem", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            var _loc7_:* = undefined;
            var _loc2_:* = UserManager.user;
            var _loc3_:* = _loc2_.gameData.skillData;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                if (StaticDataManager.skillData.getDiscardPrice().goldMoney != 0) {
                    _loc2_.gameData.blackMarketData.boughtItems[BlackMarketItemsTypeId.Item_Spreader_Skills].paidCount--;
                }
                _loc4_ = 0;
                for (_loc5_ in _pointsBySkillTypeId) {
                    _loc6_ = _pointsBySkillTypeId[_loc5_];
                    _loc7_ = SkillManager.getSkill(_loc3_, _loc5_);
                    _loc7_.constructionInfo.level = _loc7_.constructionInfo.level - _loc6_;
                    _loc4_ = _loc4_ + _loc6_;
                }
                _loc3_.skillPoints = _loc3_.skillPoints + _loc4_;
                _loc2_.gameData.skillData.pointDiscardsCount++;
                _loc2_.gameData.skillData.updateStatus();
                _loc2_.gameData.constructionData.updateAcceleration(_loc2_.gameData, ServerTimeManager.serverTimeNow);
                _loc3_.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
