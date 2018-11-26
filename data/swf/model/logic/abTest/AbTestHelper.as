package model.logic.abTest {
import model.logic.UserManager;

public class AbTestHelper {


    public function AbTestHelper() {
        super();
    }

    public static function addClientTestGroups():void {
    }

    public static function checkAbTestGroupMembership(param1:int):Boolean {
        return UserManager.abTestGroupIds.contains(param1);
    }
}
}
