package model.logic.quests.periodicQuests.userData {
import model.logic.dtoSerializer.DtoDeserializer;

public class UserPeriodicQuestData {


    public var groups:Array;

    public var dirty:Boolean;

    public function UserPeriodicQuestData() {
        super();
    }

    public static function fromDto(param1:*):UserPeriodicQuestData {
        var _loc2_:UserPeriodicQuestData = new UserPeriodicQuestData();
        _loc2_.groups = DtoDeserializer.toArray(param1.g, UserPeriodicQuestGroupData.fromDto);
        return _loc2_;
    }

    public function getGroupById(param1:int):UserPeriodicQuestGroupData {
        var _loc2_:UserPeriodicQuestGroupData = null;
        var _loc3_:UserPeriodicQuestGroupData = null;
        for each(_loc3_ in this.groups) {
            if (_loc3_.groupId == param1) {
                _loc2_ = _loc3_;
                break;
            }
        }
        return _loc2_;
    }
}
}
