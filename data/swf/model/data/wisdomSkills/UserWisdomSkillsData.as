package model.data.wisdomSkills {
import common.queries.util.query;

import configs.Global;

import gameObjects.observableObject.ObservableObject;

import model.logic.StaticDataManager;
import model.logic.filterSystem.ArrayChangesChecker;

public class UserWisdomSkillsData extends ObservableObject {

    private static const CLASS_NAME:String = "UserWisdomSkillsData";

    public static const WISDOM_LEVEL_CHANGED:String = CLASS_NAME + "WisdomLevelChanged";

    public static const WISDOM_POINTS_CHANGED:String = CLASS_NAME + "WisdomPointsChanged";

    public static const ACTIVE_SKILLS_CHANGED:String = CLASS_NAME + "ActiveSkillChanged";


    public var currentWisdomLevel:int;

    public var wisdomPoints:int;

    public var activeSkills:Array;

    private var _activeBonusPercentByType:Object;

    private var _arrayChangesChecker:ArrayChangesChecker;

    private var _wisdomLevelDirty:Boolean;

    private var _wisdomPointsDirty:Boolean;

    private var _activeSkillsDirty:Boolean;

    public function UserWisdomSkillsData() {
        this._arrayChangesChecker = new ArrayChangesChecker();
        super();
    }

    public static function fromDto(param1:*):UserWisdomSkillsData {
        var _loc3_:* = undefined;
        var _loc2_:UserWisdomSkillsData = new UserWisdomSkillsData();
        _loc2_.activeSkills = [];
        if (param1 != null) {
            _loc2_.currentWisdomLevel = param1.l;
            _loc2_.wisdomPoints = param1.w;
            if (param1.s != null) {
                for each(_loc3_ in param1.s) {
                    _loc2_.activeSkills.push(UserWisdomSkill.fromDto(_loc3_));
                }
            }
            _loc2_.recalculateActiveBonuses();
        }
        return _loc2_;
    }

    public function get nextWisdomLevel():int {
        return this.currentWisdomLevel + 1;
    }

    public function get activeSkillsCount():int {
        return this.activeSkills.length;
    }

    public function get lastSkillId():int {
        var _loc2_:UserWisdomSkill = null;
        var _loc1_:Number = -1;
        for each(_loc2_ in this.activeSkills) {
            if (_loc2_.id > _loc1_) {
                _loc1_ = _loc2_.id;
            }
        }
        return _loc1_;
    }

    public function dispatchEvents():void {
        if (this._wisdomLevelDirty) {
            this._wisdomLevelDirty = false;
            dispatchEvent(WISDOM_LEVEL_CHANGED);
        }
        if (this._wisdomPointsDirty) {
            this._wisdomPointsDirty = false;
            dispatchEvent(WISDOM_POINTS_CHANGED);
        }
        if (this._activeSkillsDirty) {
            this._activeSkillsDirty = false;
            this.recalculateActiveBonuses();
            dispatchEvent(ACTIVE_SKILLS_CHANGED);
        }
    }

    public function update(param1:UserWisdomSkillsData):void {
        if (param1 == null) {
            return;
        }
        if (this.currentWisdomLevel != param1.currentWisdomLevel) {
            this.currentWisdomLevel = param1.currentWisdomLevel;
            this._wisdomLevelDirty = true;
        }
        if (this.wisdomPoints != param1.wisdomPoints) {
            this.wisdomPoints = param1.wisdomPoints;
            this._wisdomPointsDirty = true;
        }
        if (this._arrayChangesChecker.hasChanges(this.activeSkills, param1.activeSkills)) {
            this.activeSkills = param1.activeSkills;
            this._activeSkillsDirty = true;
        }
    }

    public function addWisdomPoints(param1:int):void {
        if (!Global.WISDOM_SKILLS_ENABLED) {
            return;
        }
        this.wisdomPoints = this.wisdomPoints + param1;
        this._wisdomPointsDirty = true;
        if (this.wisdomPoints >= StaticDataManager.wisdomSkillsData.getPointsToAchieveByLevel(this.nextWisdomLevel)) {
            this.incrementWisdomLevel();
        }
        this.dispatchEvents();
    }

    public function incrementWisdomLevel():void {
        if (this.currentWisdomLevel < StaticDataManager.wisdomSkillsData.maxLevel) {
            this.currentWisdomLevel++;
            this._wisdomLevelDirty = true;
            this.dispatchEvents();
        }
    }

    public function activateWisdomSkill(param1:WisdomSkill, param2:Boolean):void {
        if (param2) {
            this.removeDependedSkillFromActive(param1);
        }
        this.addSkillToActive(param1);
        this._activeSkillsDirty = true;
        this.dispatchEvents();
    }

    public function getActiveBonusPercentByType(param1:int):int {
        if (this._activeBonusPercentByType == null) {
            return 0;
        }
        if (this._activeBonusPercentByType[param1] == undefined) {
            return 0;
        }
        return this._activeBonusPercentByType[param1];
    }

    private function addSkillToActive(param1:WisdomSkill):void {
        this.activeSkills.push(UserWisdomSkill.fromId(param1.id));
    }

    private function removeDependedSkillFromActive(param1:WisdomSkill):void {
        var wisdomSkill:WisdomSkill = param1;
        if (!wisdomSkill.hasDependedSkill) {
            return;
        }
        var skill:UserWisdomSkill = query(this.activeSkills).firstOrDefault(function (param1:UserWisdomSkill):Boolean {
            return param1.id == wisdomSkill.dependedSkillId;
        });
        if (skill == null) {
            return;
        }
        var dependedSkillIndexInActiveSkills:int = this.activeSkills.indexOf(skill);
        this.activeSkills.splice(dependedSkillIndexInActiveSkills, 1);
    }

    private function recalculateActiveBonuses():void {
        var _loc1_:WisdomSkill = null;
        var _loc2_:UserWisdomSkill = null;
        if (this.activeSkillsCount == 0) {
            return;
        }
        this._activeBonusPercentByType = {};
        for each(_loc2_ in this.activeSkills) {
            _loc1_ = StaticDataManager.wisdomSkillsData.getWisdomSkillById(_loc2_.id);
            this.addSkillBonusesToDictionary(_loc1_);
        }
    }

    private function addSkillBonusesToDictionary(param1:WisdomSkill):void {
        this.addBonus(param1.firstBonus);
        if (param1.hasMultipleBonuses) {
            this.addBonus(param1.secondBonus);
        }
    }

    private function addBonus(param1:WisdomSkillBonusInfo):void {
        if (this._activeBonusPercentByType[param1.type] == undefined) {
            this._activeBonusPercentByType[param1.type] = param1.percent;
        }
        else {
            this._activeBonusPercentByType[param1.type] = this._activeBonusPercentByType[param1.type] + param1.percent;
        }
    }
}
}
