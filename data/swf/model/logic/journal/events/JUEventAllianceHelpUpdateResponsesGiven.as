package model.logic.journal.events {
import model.logic.UserManager;
import model.logic.journal.IJEventUser;
import model.logic.journal.JEventUser;
import model.modules.allianceHelp.data.user.UserAllianceHelpData;

public class JUEventAllianceHelpUpdateResponsesGiven extends JEventUser {


    public var change:int;

    public function JUEventAllianceHelpUpdateResponsesGiven() {
        super();
    }

    public static function fromDto(param1:*):IJEventUser {
        var _loc2_:JUEventAllianceHelpUpdateResponsesGiven = new JUEventAllianceHelpUpdateResponsesGiven();
        _loc2_.change = param1.c;
        return _loc2_;
    }

    override public function apply():void {
        var _loc1_:UserAllianceHelpData = UserManager.user.gameData.allianceData.allianceHelpData;
        var _loc2_:int = Math.max(_loc1_.responsesGivenCount + this.change, 0);
        _loc1_.responsesGivenCount = _loc2_;
    }
}
}
