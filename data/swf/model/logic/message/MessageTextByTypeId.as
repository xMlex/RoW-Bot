package model.logic.message {
import common.localization.LocaleUtil;

import model.data.users.UserNote;
import model.data.users.messages.Message;
import model.data.users.messages.MessageTypeId;
import model.logic.StaticDataManager;
import model.logic.UserNoteManager;
import model.modules.allianceCity.data.AllianceCityTechnologyType;

public class MessageTextByTypeId {


    public function MessageTextByTypeId() {
        super();
    }

    public static function getTextByTypeId(param1:Message):String {
        var _loc2_:String = null;
        var _loc3_:UserNote = null;
        var _loc4_:AllianceCityTechnologyType = null;
        switch (param1.typeId) {
            case MessageTypeId.AllianceCityUpgradeStart:
                _loc3_ = UserNoteManager.getById(param1.allianceCityMessageInfo.userInitiator);
                _loc2_ = LocaleUtil.buildString("forms-formMessages_userUpgradeCityForGold", _loc3_.fullName, param1.allianceCityMessageInfo.cityLevel);
                break;
            case MessageTypeId.AllianceCityTechnologyUpgradeStart:
                _loc3_ = UserNoteManager.getById(param1.allianceCityMessageInfo.userInitiator);
                _loc4_ = StaticDataManager.allianceCityData.getTechnologyByType(param1.allianceCityMessageInfo.technologyId);
                _loc2_ = LocaleUtil.buildString("forms-formMessages_userUpgradeTechnologyForGold", _loc3_.fullName, _loc4_.name, param1.allianceCityMessageInfo.technologyLevel);
                break;
            case MessageTypeId.AllianceCityBuyResourcesResult:
                _loc3_ = UserNoteManager.getById(param1.allianceCityMessageInfo.userInitiator);
                if (param1.allianceCityMessageInfo.allianceResources.cash > 0) {
                    _loc2_ = LocaleUtil.buildString("forms-formMessages_userBuyAllianceCash", _loc3_.fullName, param1.allianceCityMessageInfo.allianceResources.cash);
                }
                else {
                    _loc2_ = LocaleUtil.buildString("forms-formMessages_userBuyTechPoints", _loc3_.fullName, param1.allianceCityMessageInfo.allianceResources.techPoints);
                }
                break;
            case MessageTypeId.AllianceCityTeleportationResult:
                _loc2_ = LocaleUtil.buildString("controls-chatControl-allianceCity_cityWasTransferred", param1.toMapPos.getString());
                break;
            case MessageTypeId.TeleportationTargetIsInactive:
                _loc2_ = LocaleUtil.getText("forms-formAdvisers_messages_messageDetailsBattle_sectorTransformedToPortal");
                break;
            case MessageTypeId.TeleportationTargetHasMoved:
                _loc2_ = LocaleUtil.getText("forms-formAdvisers_messages_messageDetailsBattle_sectorMovedToAnotherPlace");
                break;
            case MessageTypeId.DynamicMineTargetMineHasExpired:
                _loc2_ = LocaleUtil.getText("forms-formAdvisers_messages_messageDetailsBattle_ExpiredStorage");
                break;
            case MessageTypeId.AllianceCityUnitsMoveBack:
                _loc2_ = LocaleUtil.getText("MessageAllianceCityUnitsCancellation");
                break;
            default:
                _loc2_ = param1.text;
        }
        return _loc2_;
    }
}
}
