package model.logic.chats {
import common.ArrayCustom;
import common.ObjectUtil;
import common.localization.LocaleUtil;

import model.logic.StaticDataManager;
import model.logic.chats.notification.handlers.AllianceCityNotificationHandlerFactory;
import model.logic.chats.notification.objects.allianceCity.AllianceCityMessageObject;
import model.logic.chats.notification.objects.allianceCity.AllianceNotification;
import model.logic.chats.notification.types.AllianceCityNotificationType;
import model.modules.allianceCity.data.AllianceCityTechnologyType;

public class ChatMessageHelper {


    public function ChatMessageHelper() {
        super();
    }

    public static function convertNotificationsToMessages(param1:ArrayCustom):ArrayCustom {
        var _loc3_:ChatMessage = null;
        var _loc4_:AllianceCityMessageObject = null;
        var _loc5_:AllianceNotification = null;
        var _loc6_:ChatMessage = null;
        var _loc7_:Boolean = false;
        var _loc8_:int = 0;
        var _loc9_:String = null;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc6_ in param1) {
            _loc4_ = AllianceCityNotificationHandlerFactory.notificationDataConvert(_loc6_.text);
            _loc3_ = ChatMessage(ObjectUtil.trueClone(_loc6_));
            _loc3_.text = null;
            _loc7_ = true;
            _loc8_ = 0;
            while (_loc8_ < _loc4_.typesList.length) {
                _loc5_ = _loc4_.typesList[_loc8_];
                _loc9_ = getACTextByMessageType(_loc5_);
                if (_loc9_ != null) {
                    if (_loc7_) {
                        _loc7_ = false;
                        _loc3_.text = _loc9_;
                    }
                    else {
                        _loc3_.text = _loc3_.text + ("\n" + _loc9_);
                    }
                }
                _loc8_++;
            }
            if (_loc3_.text != null) {
                _loc2_.push(_loc3_);
            }
        }
        return _loc2_;
    }

    private static function getACTextByMessageType(param1:AllianceNotification):String {
        var _loc3_:AllianceCityTechnologyType = null;
        var _loc2_:String = "";
        switch (param1.type) {
            case AllianceCityNotificationType.CITY_TECHNOLOGY_UPGRADE_FINISHED:
                _loc3_ = StaticDataManager.allianceCityData.getTechnologyByType(param1.data.techId);
                _loc2_ = LocaleUtil.buildString("controls-chatControl-allianceCity_techLevelChanged", _loc3_.name, param1.data.level);
                break;
            case AllianceCityNotificationType.CITY_UPGRADE_FINISHED:
                _loc2_ = LocaleUtil.buildString("controls-chatControl-allianceCity_levelChanged", param1.data.level);
                break;
            case AllianceCityNotificationType.CITY_CREATED:
                _loc2_ = LocaleUtil.buildString("controls-chatControl-allianceCity_cityWasBuilt", param1.data.position.getString());
                break;
            case AllianceCityNotificationType.CITY_TELEPORTED:
                _loc2_ = LocaleUtil.buildString("controls-chatControl-allianceCity_cityWasTransferred", param1.data.position.getString());
                break;
            case AllianceCityNotificationType.CITY_DOWNGRADE:
                _loc2_ = LocaleUtil.buildString("controls-chatControl-allianceCity_levelDowngraded", param1.data.level.toString(), param1.data.allianceResources.cash);
                break;
            case AllianceCityNotificationType.CITY_UPGRADE_INTERRUPTED:
                _loc2_ = LocaleUtil.buildString("controls-chatControl-allianceCity_upgradeInterrupted", param1.data.allianceResources.cash);
                break;
            default:
                _loc2_ = null;
        }
        return _loc2_;
    }
}
}
