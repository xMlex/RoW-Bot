package model.logic.blackMarketModel.services {
import model.logic.blackMarketModel.deleteBehaviours.contexts.DeleteContext;
import model.logic.blackMarketModel.interfaces.temporary.IActionResult;
import model.logic.blackMarketModel.services.interfaces.IDeleteService;
import model.logic.blackMarketModel.temporaryCore.StubActionResult;

public class StubDeleteService implements IDeleteService {


    public function StubDeleteService() {
        super();
    }

    public function deleteItem(param1:DeleteContext):IActionResult {
        return new StubActionResult();
    }

    public function tryDeleteItem():IActionResult {
        return new StubActionResult();
    }
}
}
