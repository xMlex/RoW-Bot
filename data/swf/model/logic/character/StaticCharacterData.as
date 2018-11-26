package model.logic.character {
import common.localization.LocaleUtil;

import flash.utils.Dictionary;

import model.data.users.UserNote;
import model.logic.StaticDataManager;
import model.logic.UserManager;

public class StaticCharacterData {

    private static var lostTheLastTrack:Dictionary = new Dictionary();


    public var characters:Vector.<CharacterInfo>;

    public function StaticCharacterData() {
        super();
    }

    public static function fromDto(param1:*):StaticCharacterData {
        var _loc3_:Vector.<CharacterInfo> = null;
        var _loc4_:* = undefined;
        var _loc2_:StaticCharacterData = new StaticCharacterData();
        if (param1) {
            _loc3_ = new Vector.<CharacterInfo>();
            for each(_loc4_ in param1.c) {
                _loc3_.push(CharacterInfo.fromDto(_loc4_));
            }
            _loc2_.characters = _loc3_;
        }
        return _loc2_;
    }

    public static function getCharacterInfo(param1:int):CharacterInfo {
        var _loc2_:CharacterInfo = null;
        var _loc3_:Vector.<CharacterInfo> = StaticDataManager.characterData.characters;
        var _loc4_:int = _loc3_.length;
        while (--_loc4_ >= 0) {
            if (_loc3_[_loc4_].id == param1) {
                _loc2_ = _loc3_[_loc4_];
                break;
            }
        }
        return _loc2_;
    }

    public static function urlBigHeroSWF(param1:int):String {
        var _loc2_:String = "ui/hero/heroChoose/hero_big_";
        _loc2_ = _loc2_ + buildStringIdHero(param1);
        return _loc2_ + ".swf";
    }

    public static function urlBigHero(param1:int):String {
        var _loc2_:String = "ui/hero/heroChoose/big/hero_big_";
        _loc2_ = _loc2_ + buildStringIdHero(param1);
        return _loc2_ + ".png";
    }

    public static function urlBigHeroImage(param1:int):String {
        var _loc2_:String = "ui/hero/heroChoose/hero_";
        return _loc2_ + ".png";
    }

    public static function urlHeroFace(param1:int):String {
        var _loc2_:String = "ui/hero/heroChoose/hero_face_";
        _loc2_ = _loc2_ + buildStringIdHero(param1);
        return _loc2_ + ".png";
    }

    public static function urlHeroAvatars(param1:int):String {
        var _loc2_:String = "ui/hero/avatars/heroControl/hero_";
        _loc2_ = _loc2_ + buildStringIdHero(param1);
        return _loc2_ + ".png";
    }

    public static function urlHeroAvatarsFriendsList(param1:int):String {
        var _loc2_:String = "ui/hero/friendsPanel/hero_";
        _loc2_ = _loc2_ + buildStringIdHero(param1);
        return _loc2_ + ".png";
    }

    public static function urlHeroVisualBattle(param1:int):String {
        var _loc2_:String = "ui/hero/swf/hero_";
        _loc2_ = _loc2_ + buildStringIdHero(param1);
        return _loc2_ + ".swf";
    }

    public static function urlHeroEquipment(param1:int):String {
        var _loc2_:String = "ui/hero/inventory/heroImage/hero_";
        _loc2_ = _loc2_ + buildStringIdHero(param1);
        return _loc2_ + ".png";
    }

    public static function urlHeroSfEquipment(param1:int):String {
        var _loc2_:String = "ui/sfHero/inventory/heroImage01/hero_";
        _loc2_ = _loc2_ + buildStringIdHero(param1);
        return _loc2_ + ".swf";
    }

    public static function urlHeroUserStatistics(param1:int):String {
        var _loc2_:String = "ui/hero/info/heroImage/hero_";
        _loc2_ = _loc2_ + buildStringIdHero(param1);
        return _loc2_ + ".png";
    }

    public static function urlHeroBattleReport(param1:int):String {
        var _loc2_:String = "ui/hero/avatars/battleReport/hero_";
        _loc2_ = _loc2_ + buildStringIdHero(param1);
        return _loc2_ + ".png";
    }

    public static function urlHeroAvatarControl(param1:int):String {
        var _loc2_:String = "ui/hero/avatars/avatarControl/hero_";
        _loc2_ = _loc2_ + buildStringIdHero(param1);
        return _loc2_ + ".jpg";
    }

    public static function buildStringIdHero(param1:int):String {
        var _loc2_:String = null;
        if (param1 < 10) {
            _loc2_ = "00" + param1;
        }
        else if (param1 < 100) {
            _loc2_ = "0" + param1;
        }
        else {
            _loc2_ = param1.toString();
        }
        return _loc2_;
    }

    public static function urlSectorImage(param1:int, param2:int):String {
        var _loc3_:String = "ui/globalMap/portal/race_" + param1 + "_lvl_" + param2;
        return _loc3_ + ".jpg";
    }

    public static function generateRandomSpeech(param1:int):String {
        var _loc2_:String = "hero/1/";
        _loc2_ = _loc2_ + (LocaleUtil.currentLocale + "/hero_");
        _loc2_ = _loc2_ + (buildStringIdHero(param1) + "_");
        if (!lostTheLastTrack[param1]) {
            lostTheLastTrack[param1] = 1;
        }
        _loc2_ = _loc2_ + (buildStringIdHero(lostTheLastTrack[param1]) + ".mp3");
        if (lostTheLastTrack[param1] != 12) {
            lostTheLastTrack[param1]++;
        }
        else {
            lostTheLastTrack[param1] = 1;
        }
        return _loc2_;
    }

    public static function getCharacterUserId(param1:UserNote):int {
        var _loc2_:int = 1;
        if (param1.id != UserManager.user.id) {
            _loc2_ = !!param1.characterData ? int(param1.characterData.typeId) : 0;
        }
        else {
            _loc2_ = UserManager.user.gameData.characterData.typeId;
        }
        return _loc2_;
    }
}
}
