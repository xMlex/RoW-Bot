package model.logic.blackMarketModel.providers {
import model.data.units.resurrection.enums.LossesType;

public class FreeHospitalUnitsProvider extends HospitalUnitsProvider {


    public function FreeHospitalUnitsProvider() {
        super();
    }

    override protected function get lossesType():int {
        return LossesType.FREE;
    }
}
}
