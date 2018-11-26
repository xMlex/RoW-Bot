package model.logic.blackMarketModel.refreshableBehaviours.string {
import model.logic.blackMarketModel.interfaces.temporary.ISeveralValuesConverter;

public class StandardSeveralValuesConverter implements ISeveralValuesConverter {


    public function StandardSeveralValuesConverter() {
        super();
    }

    public function convertValue(param1:int, param2:int):String {
        return (param1 * param2).toString();
    }
}
}
