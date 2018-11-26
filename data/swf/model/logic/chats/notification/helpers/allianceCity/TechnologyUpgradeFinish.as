package model.logic.chats.notification.helpers.allianceCity {
import model.data.locations.allianceCity.AllianceCityTechnology;
import model.data.scenes.objects.info.ConstructionObjInfo;
import model.logic.AllianceManager;
import model.logic.chats.notification.INotificationTypeHelper;
import model.logic.chats.notification.NotificationHelper;
import model.logic.chats.notification.events.allianceCity.TechnologyUpgradeFinishEvent;
import model.logic.chats.notification.objects.allianceCity.AllianceNotificationData;

public class TechnologyUpgradeFinish implements INotificationTypeHelper {


    private var _data:AllianceNotificationData;

    private var _techId:int;

    public function TechnologyUpgradeFinish(param1:AllianceNotificationData) {
        super();
        if (param1 == null) {
            return;
        }
        this._data = param1;
        this.setData();
    }

    private function setData():void {
        this._techId = this._data.techId;
    }

    public function get getData():Object {
        return this._data;
    }

    public function execute():void {
        var _loc2_:AllianceCityTechnology = null;
        var _loc4_:int = 0;
        var _loc1_:Boolean = false;
        if (AllianceManager.currentAllianceCity.gameData.allianceCityData.technologyData.technologies) {
            _loc4_ = 0;
            while (_loc4_ < AllianceManager.currentAllianceCity.gameData.allianceCityData.technologyData.technologies.length) {
                if (AllianceManager.currentAllianceCity.gameData.allianceCityData.technologyData.technologies[_loc4_].typeId == this._techId) {
                    AllianceManager.currentAllianceCity.gameData.allianceCityData.technologyData.technologies[_loc4_].constructionObjInfo.level++;
                    AllianceManager.currentAllianceCity.gameData.allianceCityData.technologyData.technologies[_loc4_].constructionObjInfo.constructionStartTime = null;
                    AllianceManager.currentAllianceCity.gameData.allianceCityData.technologyData.technologies[_loc4_].constructionObjInfo.constructionFinishTime = null;
                    _loc1_ = true;
                    break;
                }
                _loc4_++;
            }
        }
        if (!_loc1_) {
            _loc2_ = new AllianceCityTechnology();
            _loc2_.constructionObjInfo = new ConstructionObjInfo();
            _loc2_.constructionObjInfo.level++;
            AllianceManager.currentAllianceCity.gameData.allianceCityData.technologyData.technologies.push(_loc2_);
        }
        var _loc3_:TechnologyUpgradeFinishEvent = new TechnologyUpgradeFinishEvent(TechnologyUpgradeFinishEvent.TECHNOLOGY_UPGRADE_FINISH);
        NotificationHelper.events.dispatchEvent(_loc3_);
    }
}
}
