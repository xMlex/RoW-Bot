package model.logic.blackMarketModel.providers {
import model.data.units.resurrection.enums.LossesType;

public class MassacreHospitalUnitsProvider extends HospitalUnitsProvider {


    public function MassacreHospitalUnitsProvider() {
        super();
    }

    override protected function get lossesType():int {
        return LossesType.MASSACRE;
    }
}
}
