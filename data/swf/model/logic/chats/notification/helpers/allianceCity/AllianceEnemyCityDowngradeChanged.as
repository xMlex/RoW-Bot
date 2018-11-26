package model.logic.chats.notification.helpers.allianceCity {
import model.logic.AllianceManager;
import model.logic.chats.notification.INotificationTypeHelper;
import model.logic.chats.notification.NotificationHelper;
import model.logic.chats.notification.events.allianceCity.AllianceEnemyDowngradeEvent;
import model.logic.chats.notification.objects.allianceCity.AllianceNotificationData;

public class AllianceEnemyCityDowngradeChanged implements INotificationTypeHelper {


    private var _data:AllianceNotificationData;

    private var _enemyCityId:Number;

    private var _newLevel:int;

    public function AllianceEnemyCityDowngradeChanged(param1:AllianceNotificationData) {
        super();
        if (param1 == null) {
            return;
        }
        this._data = param1;
        this.setData();
    }

    private function setData():void {
        this._enemyCityId = this._data.enemyCityId;
        this._newLevel = this._data.level;
    }

    public function get getData():Object {
        return this._data;
    }

    public function execute():void {
        if (AllianceManager.currentAlliance.gameData.cityData.enemyDowngrades[this._newLevel]) {
            AllianceManager.currentAlliance.gameData.cityData.enemyDowngrades[this._newLevel]++;
        }
        else {
            AllianceManager.currentAlliance.gameData.cityData.enemyDowngrades[this._newLevel] = 1;
        }
        var _loc1_:AllianceEnemyDowngradeEvent = new AllianceEnemyDowngradeEvent(AllianceEnemyDowngradeEvent.ALLIANCE_ENEMY_DOWNGRADE_CHANGED);
        NotificationHelper.events.dispatchEvent(_loc1_);
    }
}
}
