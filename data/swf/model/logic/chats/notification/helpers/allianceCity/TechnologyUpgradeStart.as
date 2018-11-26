package model.logic.chats.notification.helpers.allianceCity {
import model.data.locations.allianceCity.AllianceCityTechnology;
import model.data.scenes.objects.info.ConstructionObjInfo;
import model.logic.AllianceManager;
import model.logic.chats.notification.INotificationTypeHelper;
import model.logic.chats.notification.NotificationHelper;
import model.logic.chats.notification.events.allianceCity.TechnologyUpgradeStartEvent;
import model.logic.chats.notification.objects.allianceCity.AllianceNotificationData;

public class TechnologyUpgradeStart implements INotificationTypeHelper {


    private var _data:AllianceNotificationData;

    private var _techId:int;

    private var _dateStart:Date;

    private var _dateFinish:Date;

    public function TechnologyUpgradeStart(param1:AllianceNotificationData) {
        super();
        if (param1 == null) {
            return;
        }
        this._data = param1;
        this.setData();
    }

    private function setData():void {
        this._techId = this._data.techId;
        this._dateStart = this._data.startTime;
        this._dateFinish = this._data.finishTime;
    }

    public function get getData():Object {
        return this._data;
    }

    public function execute():void {
        var _loc3_:AllianceCityTechnology = null;
        var _loc1_:Boolean = false;
        var _loc2_:int = 0;
        while (_loc2_ < AllianceManager.currentAllianceCity.gameData.allianceCityData.technologyData.technologies.length) {
            if (AllianceManager.currentAllianceCity.gameData.allianceCityData.technologyData.technologies[_loc2_].typeId == this._techId) {
                AllianceManager.currentAllianceCity.gameData.allianceCityData.technologyData.technologies[_loc2_].constructionObjInfo.constructionStartTime = this._dateStart;
                AllianceManager.currentAllianceCity.gameData.allianceCityData.technologyData.technologies[_loc2_].constructionObjInfo.constructionFinishTime = this._dateFinish;
                _loc1_ = true;
                break;
            }
            _loc2_++;
        }
        if (!_loc1_) {
            _loc3_ = new AllianceCityTechnology();
            _loc3_.typeId = this._techId;
            _loc3_.constructionObjInfo = new ConstructionObjInfo();
            _loc3_.constructionObjInfo.constructionStartTime = this._dateStart;
            _loc3_.constructionObjInfo.constructionFinishTime = this._dateFinish;
            AllianceManager.currentAllianceCity.gameData.allianceCityData.technologyData.technologies.push(_loc3_);
        }
        var _loc4_:TechnologyUpgradeStartEvent = new TechnologyUpgradeStartEvent(TechnologyUpgradeStartEvent.TECHNOLOGY_UPGRADE_START);
        NotificationHelper.events.dispatchEvent(_loc4_);
    }
}
}
