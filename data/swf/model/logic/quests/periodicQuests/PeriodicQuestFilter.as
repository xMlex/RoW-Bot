package model.logic.quests.periodicQuests {
import model.logic.dtoSerializer.DtoDeserializer;

public class PeriodicQuestFilter {


    public var prototypeId:int;

    public var minTypeId:int;

    public var maxTypeId:int;

    public var troopsGroupId:int;

    public var troopsTypeIds:Array;

    public var questCategoryIds:Array;

    public var questCategoryIgnoredIds:Array;

    public var periodicQuestGroupIds:Array;

    public var questPrototypeIgnoredIds:Array;

    public var minItemTier:int;

    public var minItemLevel:int;

    public var targetObjectTypeIds:Array;

    public var resourceTypeIds:Array;

    public var ignoreTargetIds:Array;

    public var buildingGroupIds:Array;

    public var allianceHelpRespondTypeIds:Array;

    public var technologiesTypeIds:Array;

    public var existTechTypeByLevel:Object;

    public var minRatingPos:int;

    public function PeriodicQuestFilter() {
        super();
    }

    public static function fromDto(param1:*):PeriodicQuestFilter {
        if (param1 == null) {
            return null;
        }
        var _loc2_:PeriodicQuestFilter = new PeriodicQuestFilter();
        _loc2_.prototypeId = param1.p;
        _loc2_.minTypeId = param1.m;
        _loc2_.maxTypeId = param1.h;
        _loc2_.troopsGroupId = param1.t == null ? -1 : int(param1.t);
        _loc2_.troopsTypeIds = DtoDeserializer.toArray(param1.ti);
        _loc2_.questCategoryIds = DtoDeserializer.toArray(param1.q);
        _loc2_.questCategoryIgnoredIds = DtoDeserializer.toArray(param1.i);
        _loc2_.periodicQuestGroupIds = DtoDeserializer.toArray(param1.z);
        _loc2_.questPrototypeIgnoredIds = DtoDeserializer.toArray(param1.ip);
        _loc2_.minItemTier = param1.k;
        _loc2_.minItemLevel = param1.l;
        _loc2_.targetObjectTypeIds = DtoDeserializer.toArray(param1.n);
        _loc2_.resourceTypeIds = DtoDeserializer.toArray(param1.r);
        _loc2_.ignoreTargetIds = DtoDeserializer.toArray(param1.s);
        _loc2_.buildingGroupIds = DtoDeserializer.toArray(param1.b);
        _loc2_.allianceHelpRespondTypeIds = DtoDeserializer.toArray(param1.j);
        _loc2_.technologiesTypeIds = DtoDeserializer.toArray(param1.tc);
        _loc2_.existTechTypeByLevel = DtoDeserializer.toObject(param1.et);
        _loc2_.minRatingPos = param1.rt;
        return _loc2_;
    }
}
}
