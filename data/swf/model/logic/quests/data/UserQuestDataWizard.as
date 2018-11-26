package model.logic.quests.data {
public class UserQuestDataWizard {


    public var completedWizards:Array;

    public function UserQuestDataWizard() {
        this.completedWizards = new Array();
        super();
    }

    public static function fromDto(param1:*):UserQuestDataWizard {
        var _loc2_:UserQuestDataWizard = new UserQuestDataWizard();
        _loc2_.completedWizards = param1.l == null ? null : param1.l;
        return _loc2_;
    }
}
}
