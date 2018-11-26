package model.logic.quests.periodicQuests {
import model.data.Resources;
import model.data.scenes.objects.GeoSceneObject;
import model.logic.quests.data.Quest;
import model.logic.quests.data.QuestState;
import model.logic.skills.data.Skill;
import model.modules.dragonAbilities.logic.UserDragonData;

public class ComplexSource {


    public var troopsTypeId:int;

    public var count:Number = NaN;

    public var experience:Number = NaN;

    public var sceneObject:GeoSceneObject;

    public var skill:Skill;

    public var inventoryItemTier:int;

    public var inventoryItemLevel:int;

    public var resources:Resources;

    public var allianceHelpRequestTypeId:int;

    public var powderedInventoryItems:Number = NaN;

    public var userDragonData:UserDragonData;

    public var quest:Quest;

    public var questState:QuestState;

    public function ComplexSource() {
        super();
    }

    public static function fromDragonData(param1:UserDragonData):ComplexSource {
        var _loc2_:ComplexSource = new ComplexSource();
        _loc2_.userDragonData = param1;
        return _loc2_;
    }

    public static function fromHelpRequest(param1:int, param2:int):ComplexSource {
        var _loc3_:ComplexSource = new ComplexSource();
        _loc3_.allianceHelpRequestTypeId = param1;
        _loc3_.count = param2;
        return _loc3_;
    }

    public static function fromInventoryItem(param1:int, param2:int):ComplexSource {
        var _loc3_:ComplexSource = new ComplexSource();
        _loc3_.inventoryItemTier = param1;
        _loc3_.inventoryItemLevel = param2;
        return _loc3_;
    }

    public static function fromTroopsType(param1:int, param2:int):ComplexSource {
        var _loc3_:ComplexSource = new ComplexSource();
        _loc3_.troopsTypeId = param1;
        _loc3_.count = param2;
        return _loc3_;
    }

    public static function fromSceneObject(param1:GeoSceneObject, param2:int = 1):ComplexSource {
        var _loc3_:ComplexSource = new ComplexSource();
        _loc3_.sceneObject = param1;
        _loc3_.count = param2;
        return _loc3_;
    }

    public static function fromSkill(param1:Skill):ComplexSource {
        var _loc2_:ComplexSource = new ComplexSource();
        _loc2_.skill = param1;
        return _loc2_;
    }

    public static function fromResources(param1:Resources):ComplexSource {
        var _loc2_:ComplexSource = new ComplexSource();
        _loc2_.resources = param1;
        return _loc2_;
    }

    public static function fromQuestData(param1:Quest, param2:QuestState):ComplexSource {
        var _loc3_:ComplexSource = new ComplexSource();
        _loc3_.quest = param1;
        _loc3_.questState = param2;
        return _loc3_;
    }

    public function setExperience(param1:Number):ComplexSource {
        this.experience = param1;
        return this;
    }

    public function setPowderedInventoryItems(param1:Number):ComplexSource {
        this.powderedInventoryItems = param1;
        return this;
    }
}
}
