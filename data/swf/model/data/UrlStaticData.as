package model.data {
import flash.utils.Dictionary;

import model.data.scenes.types.info.TroopsTypeId;

public class UrlStaticData {

    private static const UNIT_URL:String = "sector/units/2/visualBattle/";

    private static var dic:Dictionary = new Dictionary();


    public function UrlStaticData() {
        super();
        dic[TroopsTypeId.InfantryUnit1] = "01.swf";
        dic[TroopsTypeId.InfantryUnit2] = "02.swf";
        dic[TroopsTypeId.InfantryUnit3] = "03.swf";
        dic[TroopsTypeId.InfantryUnit4] = "04.swf";
        dic[TroopsTypeId.ArmoredUnit1] = "05.swf";
        dic[TroopsTypeId.ArmoredUnit2] = "06.swf";
        dic[TroopsTypeId.ArmoredUnit3] = "07.swf";
        dic[TroopsTypeId.ArmoredUnit4] = "08.swf";
        dic[TroopsTypeId.ArtilleryUnit1] = "09.swf";
        dic[TroopsTypeId.ArtilleryUnit2] = "10.swf";
        dic[TroopsTypeId.ArtilleryUnit3] = "11.swf";
        dic[TroopsTypeId.ArtilleryUnit4] = "12.swf";
        dic[TroopsTypeId.AirUnit1] = "13.swf";
        dic[TroopsTypeId.AirUnit2] = "14.swf";
        dic[TroopsTypeId.AirUnit3] = "15.swf";
        dic[TroopsTypeId.AirUnit4] = "16.swf";
        dic[TroopsTypeId.TowerGuard1] = "53.swf";
        dic[TroopsTypeId.TowerGuard2] = "54.swf";
        dic[TroopsTypeId.TowerGuard3] = "55.swf";
        dic[TroopsTypeId.TowerGuard4] = "56.swf";
        dic[TroopsTypeId.TowerGuard5] = "57.swf";
        dic[TroopsTypeId.TowerGuard6] = "58.swf";
        dic[TroopsTypeId.StrategyUnit1] = "91.swf";
        dic[TroopsTypeId.StrategyUnit2] = "strategy_92.swf";
        dic[TroopsTypeId.StrategyUnit3] = "strategy_93.swf";
        dic[TroopsTypeId.StrategyUnit4] = "strategy_94.swf";
        dic[TroopsTypeId.StrategyUnit5] = "strategy_95.swf";
        dic[TroopsTypeId.StrategyUnit6] = "strategy_96.swf";
        dic[TroopsTypeId.StrategyUnit7] = "strategy_97.swf";
        dic[TroopsTypeId.StrategyUnit8] = "strategy_98.swf";
        dic[TroopsTypeId.StrategyUnit9] = "strategy_9005.swf";
        dic[TroopsTypeId.RedUnit1] = "07.swf";
        dic[TroopsTypeId.RedUnit2] = "06.swf";
        dic[TroopsTypeId.RedUnit3] = "09.swf";
        dic[TroopsTypeId.RedUnit4] = "12.swf";
        dic[TroopsTypeId.RedUnit5] = "14.swf";
        dic[TroopsTypeId.RedUnit6] = "16.swf";
        dic[TroopsTypeId.InfantryUnit1Mutant] = "01.swf";
        dic[TroopsTypeId.InfantryUnit2Mutant] = "02.swf";
        dic[TroopsTypeId.InfantryUnit3Mutant] = "03.swf";
        dic[TroopsTypeId.InfantryUnit4Mutant] = "04.swf";
        dic[TroopsTypeId.ArmoredUnit1Mutant] = "05.swf";
        dic[TroopsTypeId.ArmoredUnit2Mutant] = "06.swf";
        dic[TroopsTypeId.ArmoredUnit3Mutant] = "07.swf";
        dic[TroopsTypeId.ArmoredUnit4Mutant] = "08.swf";
        dic[TroopsTypeId.ArtilleryUnit1Mutant] = "09.swf";
        dic[TroopsTypeId.ArtilleryUnit2Mutant] = "10.swf";
        dic[TroopsTypeId.ArtilleryUnit3Mutant] = "11.swf";
        dic[TroopsTypeId.ArtilleryUnit4Mutant] = "12.swf";
        dic[TroopsTypeId.AirUnit1Mutant] = "13.swf";
        dic[TroopsTypeId.AirUnit2Mutant] = "14.swf";
        dic[TroopsTypeId.AirUnit3Mutant] = "15.swf";
        dic[TroopsTypeId.AirUnit4Mutant] = "16.swf";
        dic[TroopsTypeId.SpecialForcesInfantryUnit1] = "45.swf";
        dic[TroopsTypeId.SpecialForcesInfantryUnit2] = "46.swf";
        dic[TroopsTypeId.SpecialForcesInfantryUnit3] = "47.swf";
        dic[TroopsTypeId.SpecialForcesInfantryUnit4] = "48.swf";
        dic[TroopsTypeId.SpecialForcesInfantryUnit5] = "9032.swf";
        dic[TroopsTypeId.SpecialForcesInfantryUnit1Mutant] = "45.swf";
        dic[TroopsTypeId.SpecialForcesInfantryUnit2Mutant] = "46.swf";
        dic[TroopsTypeId.SpecialForcesInfantryUnit3Mutant] = "47.swf";
        dic[TroopsTypeId.SpecialForcesInfantryUnit4Mutant] = "48.swf";
        dic[TroopsTypeId.EarlyIncubatorUnit1] = "9024.swf";
        dic[TroopsTypeId.EarlyIncubatorUnit2] = "9025.swf";
        dic[TroopsTypeId.EarlyIncubatorUnit3] = "9026.swf";
        dic[TroopsTypeId.EarlyIncubatorUnit4] = "9027.swf";
        dic[TroopsTypeId.IncubatorUnit1] = "59.swf";
        dic[TroopsTypeId.IncubatorUnit2] = "62.swf";
        dic[TroopsTypeId.IncubatorUnit3] = "9000.swf";
        dic[TroopsTypeId.IncubatorUnit4] = "9003.swf";
        dic[TroopsTypeId.IncubatorUnit1Mutant] = "59.swf";
        dic[TroopsTypeId.IncubatorUnit2Mutant] = "62.swf";
        dic[TroopsTypeId.IncubatorUnit3Mutant] = "9000.swf";
    }

    public function getUrlByType(param1:int):String {
        if (dic[param1] == "undefined") {
            throw new Error("Invalid url. Troops TypeId: " + param1);
        }
        return UNIT_URL + dic[param1];
    }
}
}
