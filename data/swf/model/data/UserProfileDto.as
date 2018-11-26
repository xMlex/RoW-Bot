package model.data {
import common.ArrayCustom;
import common.GameType;
import common.localization.LocaleUtil;

import model.data.alliances.AllianceNote;
import model.data.users.UserNote;
import model.data.users.achievements.Achievement;
import model.logic.StaticDataManager;

public class UserProfileDto {


    public var userNote:UserNote;

    public var allianceNote:AllianceNote;

    public var experience:Number;

    public var achievements:ArrayCustom;

    public var ratingAttackerPoints:Number;

    public var ratingDefenderPoints:Number;

    public var ratingRobberPoints:Number;

    public var ratingOccupantPoints:Number;

    public var playedDays:Number;

    public var sectorSkinUrl:String;

    public var sectorSkinName:String;

    public var isNewRank:Boolean;

    public function UserProfileDto() {
        super();
    }

    public static function fromDto(param1:*):UserProfileDto {
        var _loc2_:UserProfileDto = new UserProfileDto();
        _loc2_.userNote = UserNote.fromDto(param1.t);
        _loc2_.allianceNote = param1.e == null ? null : AllianceNote.fromDto(param1.e);
        _loc2_.experience = param1.x;
        _loc2_.achievements = Achievement.fromDtos(param1.a);
        _loc2_.ratingAttackerPoints = param1.ra;
        _loc2_.ratingDefenderPoints = param1.rd;
        _loc2_.ratingRobberPoints = param1.rr;
        _loc2_.ratingOccupantPoints = param1.ro;
        _loc2_.playedDays = param1.d;
        setSkinTypeParams(_loc2_);
        return _loc2_;
    }

    public static function setSkinTypeParams(param1:UserProfileDto):void {
        var _loc3_:String = null;
        var _loc4_:SectorSkinType = null;
        var _loc2_:int = 0;
        if (param1.userNote.sectorSkinTypeId >= 0 && StaticDataManager.getSectorSkinType(param1.userNote.sectorSkinTypeId)) {
            _loc2_ = param1.userNote.sectorSkinTypeId;
        }
        else if (param1.userNote.level <= 8) {
            _loc2_ = -1000;
        }
        else if (param1.userNote.level <= 15) {
            _loc2_ = -2000;
        }
        else if (param1.userNote.level <= 30) {
            _loc2_ = -3000;
        }
        else if (param1.userNote.level <= 50) {
            _loc2_ = -4000;
        }
        else if (param1.userNote.level <= 80) {
            _loc2_ = -5000;
        }
        else {
            _loc2_ = -6000;
        }
        switch (_loc2_) {
            case -1000:
                _loc3_ = !!GameType.isTotalDomination ? "ui/globalMap/skins_default/sector01.png" : "ui/globalMap/sector01.png";
                break;
            case -2000:
                _loc3_ = !!GameType.isTotalDomination ? "ui/globalMap/skins_default/sector02.png" : "ui/globalMap/sector02.png";
                break;
            case -3000:
                _loc3_ = !!GameType.isTotalDomination ? "ui/globalMap/skins_default/sector03.png" : "ui/globalMap/sector03.png";
                break;
            case -4000:
                _loc3_ = !!GameType.isTotalDomination ? "ui/globalMap/skins_default/sector04.png" : "ui/globalMap/sector04.png";
                break;
            case -5000:
                if (GameType.isTotalDomination) {
                    _loc3_ = "ui/globalMap/skins_default/sector04.png";
                }
                else if (GameType.isPirates) {
                    _loc3_ = "ui/globalMap/sector05.png";
                }
                else if (GameType.isElves) {
                    _loc3_ = "ui/globalMap/sector05.swf";
                }
                else if (GameType.isMilitary) {
                    _loc3_ = "ui/globalMap/sector05.swf";
                }
                break;
            case -6000:
                if (GameType.isTotalDomination) {
                    _loc3_ = "ui/globalMap/skins_default/sector04.png";
                }
                else if (GameType.isPirates) {
                    _loc3_ = "ui/globalMap/sector05.png";
                }
                else if (GameType.isElves) {
                    _loc3_ = "ui/globalMap/sector06.swf";
                }
                else if (GameType.isMilitary) {
                    _loc3_ = "ui/globalMap/sector06.swf";
                }
                break;
            case -1:
                _loc3_ = "ui/globalMap/mineTest.png";
                break;
            default:
                _loc4_ = StaticDataManager.getSectorSkinType(_loc2_);
                _loc3_ = _loc4_.urlMap;
        }
        param1.sectorSkinName = _loc2_ < 0 ? LocaleUtil.getText("model-data-userProfileDto-sector") : _loc4_.name;
        param1.sectorSkinUrl = _loc3_;
    }
}
}
