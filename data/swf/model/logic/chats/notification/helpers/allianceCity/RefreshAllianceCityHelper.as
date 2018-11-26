package model.logic.chats.notification.helpers.allianceCity {
import model.logic.AllianceManager;
import model.logic.chats.notification.INotificationTypeHelper;

public class RefreshAllianceCityHelper implements INotificationTypeHelper {


    public function RefreshAllianceCityHelper() {
        super();
    }

    public function execute():void {
        if (AllianceManager.currentAlliance && AllianceManager.currentAlliance.gameData.cityData && !isNaN(AllianceManager.currentAlliance.gameData.cityData.allianceCityId)) {
            AllianceManager.getAllianceCity(AllianceManager.currentAlliance.id);
        }
    }

    public function get getData():Object {
        return null;
    }
}
}
