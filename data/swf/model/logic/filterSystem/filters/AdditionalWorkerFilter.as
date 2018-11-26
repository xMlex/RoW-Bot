package model.logic.filterSystem.filters {
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.filterSystem.interfaces.IDataFilter;

public class AdditionalWorkerFilter implements IDataFilter {


    public function AdditionalWorkerFilter() {
        super();
    }

    public function filter(param1:Array):Array {
        if (UserManager.user.gameData.constructionData.constructionWorkersCount < StaticDataManager.constructionData.getMaxWorkersCount()) {
            return param1;
        }
        return [];
    }
}
}
