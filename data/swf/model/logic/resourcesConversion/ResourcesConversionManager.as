package model.logic.resourcesConversion {
import model.data.User;
import model.data.UserGameData;
import model.logic.quests.completions.QuestCompletionResourceConversion;
import model.logic.resourcesConversion.data.ResourcesConversionJob;

public class ResourcesConversionManager {


    public function ResourcesConversionManager() {
        super();
    }

    public static function finishJob(param1:User, param2:ResourcesConversionJob):void {
        var _loc3_:UserGameData = param1.gameData;
        _loc3_.account.resources.add(param2.outResources);
        var _loc4_:int = _loc3_.resourcesConversionData.currentJobs.getItemIndex(param2);
        if (_loc4_ >= 0) {
            _loc3_.resourcesConversionData.currentJobs.removeItemAt(_loc4_);
        }
        QuestCompletionResourceConversion.tryComplete(param2.outResourcesTypeId);
        _loc3_.resourcesConversionData.dirty = true;
    }
}
}
