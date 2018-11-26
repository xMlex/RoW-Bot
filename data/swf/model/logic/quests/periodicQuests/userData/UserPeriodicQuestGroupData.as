package model.logic.quests.periodicQuests.userData {
import common.queries.util.query;

import model.logic.dtoSerializer.DtoDeserializer;

public class UserPeriodicQuestGroupData {


    public var groupId:int;

    public var startTime:Date;

    public var deadline:Date;

    public var periodicQuestsData:Array;

    public function UserPeriodicQuestGroupData() {
        super();
    }

    public static function fromDto(param1:*):UserPeriodicQuestGroupData {
        var _loc2_:UserPeriodicQuestGroupData = new UserPeriodicQuestGroupData();
        _loc2_.groupId = param1.g;
        _loc2_.startTime = new Date(param1.s);
        _loc2_.deadline = param1.d == null ? null : new Date(param1.d);
        _loc2_.periodicQuestsData = DtoDeserializer.toArray(param1.p, UserPeriodicQuestStateData.fromDto);
        return _loc2_;
    }

    public function getQuestStateByPrototype(param1:int, param2:int):UserPeriodicQuestStateData {
        var prototypeId:int = param1;
        var questId:int = param2;
        return query(this.periodicQuestsData).firstOrDefault(function (param1:UserPeriodicQuestStateData):Boolean {
            return param1.questStaticData.prototypeId == prototypeId && param1.questId == questId;
        });
    }
}
}
