package model.logic.blackMarketModel.providers {
import model.data.units.resurrection.enums.LossesType;

public class FlagTournamentHospitalUnitsProvider extends HospitalUnitsProvider {


    public function FlagTournamentHospitalUnitsProvider() {
        super();
    }

    override protected function get lossesType():int {
        return LossesType.FLAG_TOURNAMENT;
    }
}
}
