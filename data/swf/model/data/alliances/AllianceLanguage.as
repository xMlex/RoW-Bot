package model.data.alliances {
import common.LocalesEnum;
import common.localization.LocaleUtil;

public class AllianceLanguage {

    public static const NONE:int = 0;

    public static const ENGLISH:int = 1;

    public static const RUSSIAN:int = 2;

    public static const GERMAN:int = 3;

    public static const FRENCH:int = 4;

    public static const SPANISH:int = 5;

    public static const ITALIAN:int = 6;

    public static const TURKISH:int = 7;

    public static const PORTUGUESE:int = 8;

    public static const UKRAINIAN:int = 9;

    private static var _allianceLanguageByLocale:Object;


    public function AllianceLanguage() {
        super();
    }

    public static function getAllianceLanguage(param1:String):int {
        if (_allianceLanguageByLocale == null) {
            initialize();
        }
        if (param1 == null) {
            param1 = LocaleUtil.currentLocale.replace("_", "-").toLowerCase();
        }
        else {
            param1 = param1.replace("_", "-").toLowerCase();
        }
        var _loc2_:* = _allianceLanguageByLocale[param1];
        return _loc2_ == null ? int(NONE) : int(_loc2_);
    }

    public static function getAllianceLanguageByIndex(param1:int):String {
        var _loc2_:String = "";
        if (_allianceLanguageByLocale == null) {
            initialize();
        }
        var _loc3_:Array = LocalesEnum.toArray();
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_.length) {
            if (_allianceLanguageByLocale[_loc3_[_loc4_].replace("_", "-").toLowerCase()] == param1) {
                return _loc3_[_loc4_];
            }
            _loc4_++;
        }
        return _loc2_;
    }

    private static function initialize():void {
        _allianceLanguageByLocale = {};
        _allianceLanguageByLocale["en-us"] = ENGLISH;
        _allianceLanguageByLocale["en-zw"] = ENGLISH;
        _allianceLanguageByLocale["ru-ru"] = RUSSIAN;
        _allianceLanguageByLocale["de-de"] = GERMAN;
        _allianceLanguageByLocale["fr-fr"] = FRENCH;
        _allianceLanguageByLocale["es-es"] = SPANISH;
        _allianceLanguageByLocale["it-it"] = ITALIAN;
        _allianceLanguageByLocale["tr-tr"] = TURKISH;
        _allianceLanguageByLocale["pt-pt"] = PORTUGUESE;
        _allianceLanguageByLocale["uk-ua"] = UKRAINIAN;
    }
}
}
