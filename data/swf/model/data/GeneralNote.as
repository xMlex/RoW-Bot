package model.data {
import common.GameType;

import model.data.locations.LocationNote;
import model.data.map.DistanceFromUser;
import model.data.map.MapPos;
import model.data.raids.RaidLocationNote;
import model.data.users.UserNote;
import model.logic.LocationManager;
import model.logic.LocationNoteManager;
import model.logic.RaidLocationNoteManager;
import model.logic.RaidLocationType;
import model.logic.RaidManager;
import model.logic.ServerManager;
import model.logic.StaticDataManager;
import model.logic.UserDemoManager;
import model.logic.UserNoteManager;
import model.logic.character.StaticCharacterData;

public class GeneralNote {

    public static const USER_TYPE:int = 1;

    public static const TOWER_TYPE:int = 2;

    public static const MINE_TYPE:int = 3;

    public static const STORAGE_TYPE:int = 4;

    public static const ALLIANCE_CITY_TYPE:int = 5;

    public static const RAID_LOCATION_TYPE:int = 6;


    public var id:int;

    public var mapPos:MapPos;

    public var mapPos2:MapPos;

    public var name:String;

    public var noteTypeId:int;

    public var smallIcon:String;

    private var _level:int;

    private var _occupantUserId:Number;

    public function GeneralNote() {
        super();
    }

    public static function build(param1:Number, param2:Boolean = false):GeneralNote {
        var _loc4_:LocationNote = null;
        var _loc5_:RaidLocationNote = null;
        var _loc6_:UserNote = null;
        var _loc3_:GeneralNote = new GeneralNote();
        if (param1 < 0) {
            _loc4_ = LocationNoteManager.getById(-param1);
            _loc3_ = fromLocationNote(_loc4_);
        }
        else if (param2) {
            _loc5_ = RaidLocationNoteManager.getById(param1);
            _loc3_ = fromRaidLocationNote(_loc5_);
        }
        else {
            _loc6_ = UserNoteManager.getById(param1);
            _loc3_ = fromUserNote(_loc6_);
        }
        return _loc3_;
    }

    private static function fromUserNote(param1:UserNote):GeneralNote {
        var _loc3_:int = 0;
        var _loc2_:GeneralNote = new GeneralNote();
        _loc2_.id = param1.id;
        _loc2_.mapPos = param1.mapPos;
        _loc2_.level = param1.level;
        _loc2_.name = !!GameType.isNords ? param1.sectorName : param1.fullName;
        if (GameType.isNords && UserDemoManager.DemoUserId != param1.id) {
            _loc3_ = StaticCharacterData.getCharacterUserId(param1 as UserNote);
            _loc2_.smallIcon = ServerManager.buildContentUrl(StaticCharacterData.urlHeroAvatarControl(_loc3_));
        }
        else {
            _loc2_.smallIcon = param1.photoUrl.toString();
        }
        _loc2_.noteTypeId = USER_TYPE;
        _loc2_.occupantUserId = param1.occupantUserId;
        return _loc2_;
    }

    private static function fromLocationNote(param1:LocationNote):GeneralNote {
        var _loc2_:GeneralNote = new GeneralNote();
        _loc2_.id = -param1.id;
        _loc2_.mapPos = param1.mapPos;
        _loc2_.mapPos2 = param1.mapPos2;
        _loc2_.level = param1.level;
        _loc2_.name = getNameForLocation(param1);
        _loc2_.smallIcon = getLocationPhotoUrl(param1);
        _loc2_.noteTypeId = getTypeLocation(param1);
        _loc2_.occupantUserId = param1.occupantUserId;
        return _loc2_;
    }

    private static function fromRaidLocationNote(param1:RaidLocationNote):GeneralNote {
        var _loc2_:GeneralNote = new GeneralNote();
        var _loc3_:RaidLocationType = StaticDataManager.getRaidLocationTypeById(param1.typeId);
        _loc2_.id = param1.id;
        _loc2_.mapPos = param1.mapPos;
        _loc2_.mapPos2 = param1.mapPos2;
        _loc2_.level = param1.level;
        _loc2_.name = _loc3_.name;
        _loc2_.smallIcon = RaidManager.getLocationIconSmallByURL(_loc3_.picture);
        _loc2_.noteTypeId = RAID_LOCATION_TYPE;
        return _loc2_;
    }

    private static function getNameForLocation(param1:LocationNote):String {
        var _loc2_:String = null;
        if (param1.isStorage) {
            _loc2_ = StaticDataManager.mineData.getMineType(param1.mineInfo.typeId).typeName;
        }
        else {
            _loc2_ = param1.name;
        }
        return _loc2_;
    }

    private static function getLocationPhotoUrl(param1:LocationNote):String {
        var _loc2_:String = null;
        if (param1.isStorage) {
            _loc2_ = LocationManager.getStorageMiniImageByType(param1.mineTypeId);
        }
        else if (param1.isMine) {
            _loc2_ = LocationManager.getMineIconSmallById(param1.mineTypeId);
        }
        else if (param1.isAllianceCity) {
            _loc2_ = LocationManager.getAllianceCityIconSmallByLevel(param1.allianceCityInfo.level);
        }
        else if (param1.towerInfo) {
            _loc2_ = LocationManager.getTowerIconSmallByLevel(param1.towerInfo.level);
        }
        return _loc2_;
    }

    public static function getTypeLocation(param1:LocationNote):int {
        if (param1.isStorage) {
            return STORAGE_TYPE;
        }
        if (param1.isMine) {
            return MINE_TYPE;
        }
        if (param1.isAllianceCity) {
            return ALLIANCE_CITY_TYPE;
        }
        if (param1.towerInfo) {
            return TOWER_TYPE;
        }
        return -1;
    }

    public function get level():int {
        return this._level;
    }

    public function set level(param1:int):void {
        this._level = param1;
    }

    public function get occupantUserId():Number {
        return this._occupantUserId;
    }

    public function set occupantUserId(param1:Number):void {
        this._occupantUserId = param1;
    }

    public function getDistanceFromUser():Number {
        return new DistanceFromUser(this.mapPos).calculate();
    }
}
}
