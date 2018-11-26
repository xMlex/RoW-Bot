package model.data.alliances {
import common.ArrayCustom;
import common.UTCTime;
import common.queries.util.query;

import flash.utils.Dictionary;

import model.data.locations.allianceCity.flags.AllianceTacticsEffect;
import model.data.locations.allianceCity.flags.TacticsEffectsBonuses;
import model.logic.ServerTimeManager;
import model.logic.StaticDataManager;
import model.logic.flags.BuffDebuffHelper;

public class AllianceNote {


    public var id:Number;

    public var segmentId:int;

    public var revision:Number;

    public var ownerUserId:Number;

    public var name:String;

    public var shortName:String;

    public var logo:String;

    public var membersCount:Number;

    public var membersAddedByMobilizersCnt:int;

    public var requiredMemberLevel:int;

    public var completedAchievementTypeIds:Array;

    public var completedAchievementLevels:Dictionary;

    public var academyData:AllianceAcademyData;

    public var language:int;

    public var deletionTime:Date;

    public var allianceCityId:Number;

    public var maxBonusLevelTowersCount:int;

    public var timeZone:UTCTime;

    public var activeTacticsEffects:Array;

    public var activeTacticsBonuses:Array;

    public function AllianceNote() {
        this.activeTacticsEffects = [];
        this.activeTacticsBonuses = [];
        super();
    }

    public static function fromDto(param1:*):AllianceNote {
        var _loc3_:Array = null;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:* = undefined;
        var _loc2_:AllianceNote = new AllianceNote();
        _loc2_.id = param1.i;
        _loc2_.segmentId = param1.g;
        _loc2_.revision = param1.v;
        _loc2_.ownerUserId = param1.o;
        _loc2_.name = param1.a;
        _loc2_.shortName = param1.s;
        _loc2_.logo = param1.f;
        _loc2_.membersCount = param1.m;
        _loc2_.requiredMemberLevel = param1.r == null ? -1 : int(param1.r);
        _loc2_.completedAchievementTypeIds = param1.t == null ? [] : param1.t;
        _loc2_.membersAddedByMobilizersCnt = param1.x == null ? 0 : int(param1.x);
        _loc2_.academyData = param1.y == null ? null : AllianceAcademyData.fromDto(param1.y);
        _loc2_.language = param1.n;
        _loc2_.completedAchievementLevels = new Dictionary();
        _loc2_.deletionTime = !!param1.h ? new Date(param1.h) : null;
        _loc2_.timeZone = new UTCTime(param1.tz);
        if (param1.c != null) {
            _loc3_ = new Array();
            _loc3_ = param1.c;
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                if (param1.c[_loc5_] > 0) {
                    _loc2_.completedAchievementLevels[_loc5_ + 1] = param1.c[_loc5_];
                }
                _loc5_++;
            }
        }
        else {
            for each(_loc6_ in _loc2_.completedAchievementTypeIds) {
                _loc2_.completedAchievementLevels[_loc6_] = 1;
            }
        }
        _loc2_.allianceCityId = param1.ac;
        _loc2_.maxBonusLevelTowersCount = param1.tc == null ? 0 : int(param1.tc);
        _loc2_.activeTacticsEffects = !!param1.te ? AllianceTacticsEffect.fromDtos(param1.te) : [];
        _loc2_.activeTacticsBonuses = !!param1.tb ? TacticsEffectsBonuses.fromDtos(param1.tb) : [];
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:AllianceNote = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function getBonusAllianceRating():Number {
        var _loc2_:AllianceAchievementType = null;
        var _loc3_:* = null;
        var _loc4_:AllianceAchievementType = null;
        var _loc5_:AllianceAchievementLevelInfo = null;
        var _loc6_:AlianceAchievementBonusInfo = null;
        var _loc1_:Number = 0;
        for (_loc3_ in this.completedAchievementLevels) {
            _loc4_ = StaticDataManager.allianceData.getAchievementType(int(_loc3_));
            _loc5_ = _loc4_.getLevel(this.completedAchievementLevels[_loc3_]);
            _loc6_ = _loc5_.bonusInfo;
            _loc1_ = _loc1_ + _loc6_.bonusAllianceRatingK * 1000;
        }
        return int(_loc1_) * 0.1;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.id,
            "g": this.segmentId,
            "v": this.revision,
            "o": this.ownerUserId,
            "a": this.name,
            "s": this.shortName,
            "f": this.logo,
            "m": this.membersCount
        };
        if (this.requiredMemberLevel != -1) {
            _loc1_.r = this.requiredMemberLevel;
        }
        if (this.membersAddedByMobilizersCnt != 0) {
            _loc1_.x = this.membersAddedByMobilizersCnt;
        }
        return _loc1_;
    }

    public function getFlagTournamentReward():TacticsEffectsBonuses {
        return query(this.activeTacticsBonuses).firstOrDefault(function (param1:TacticsEffectsBonuses):Boolean {
            return param1.tournamentPrototypeId == BuffDebuffHelper.instance.currentEffectBonus.tournamentPrototypeId;
        });
    }

    public function getMaxEffectCount(param1:Boolean):int {
        var _loc2_:TacticsEffectsBonuses = null;
        var _loc3_:int = 0;
        if (param1) {
            return StaticDataManager.allianceData.tacticsData.allianceBuffsTotal;
        }
        _loc2_ = this.getFlagTournamentReward();
        _loc3_ = !!_loc2_ ? int(_loc2_.maxDebuffsNumber) : -1;
        if (_loc3_ != -1) {
            return _loc3_;
        }
        return StaticDataManager.allianceData.tacticsData.allianceDebuffsTotal;
    }

    public function get hasActiveEffects():Boolean {
        return query(this.activeTacticsEffects).any(function (param1:AllianceTacticsEffect):Boolean {
            return param1.toTime.time >= ServerTimeManager.serverTimeNow.time;
        });
    }
}
}
