package model.data.users.misc {
import common.ArrayCustom;
import common.localization.LocaleUtil;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

public class UserChatSettings {

    private static const CLASS_NAME:String = "UserChatSettings";

    public static const REGIONAL_DATA_CHANGED:String = CLASS_NAME + "ChangedRegionalChat";


    public var chatSettings:Dictionary;

    private var _selectedRegionalChat:String;

    public var dirty:Boolean;

    private var events:EventDispatcher;

    public function UserChatSettings() {
        this.chatSettings = new Dictionary();
        this.events = new EventDispatcher();
        super();
        this.chatSettings[UserChatSettingsTypeId.RADIO_DIPLOMATIC_RELATION] = false;
        this.chatSettings[UserChatSettingsTypeId.RADIO_TOWER_ACTION] = false;
        this.chatSettings[UserChatSettingsTypeId.RADIO_ACHIEVEMENTS] = false;
        this.chatSettings[UserChatSettingsTypeId.RADIO_MINES_ADDED] = true;
        this.chatSettings[UserChatSettingsTypeId.RADIO_TOWER_ADDED] = true;
        this.chatSettings[UserChatSettingsTypeId.ALLIANCE_DIPLOMATIC_RELATION] = true;
        this.chatSettings[UserChatSettingsTypeId.ALLIANCE_TOWER_ACTION] = true;
        this.chatSettings[UserChatSettingsTypeId.ALLIANCE_ACHIEVEMENTS] = true;
        this.chatSettings[UserChatSettingsTypeId.ALLIANCE_MINES_ADDED] = true;
        this.chatSettings[UserChatSettingsTypeId.ALLIANCE_TOWER_ADDED] = true;
    }

    public static function fromDto(param1:*):UserChatSettings {
        var _loc2_:UserChatSettings = new UserChatSettings();
        _loc2_.chatSettings[UserChatSettingsTypeId.RADIO_DIPLOMATIC_RELATION] = !!param1.rd ? true : false;
        _loc2_.chatSettings[UserChatSettingsTypeId.RADIO_TOWER_ACTION] = !!param1.rt ? true : false;
        _loc2_.chatSettings[UserChatSettingsTypeId.RADIO_ACHIEVEMENTS] = !!param1.rc ? true : false;
        _loc2_.chatSettings[UserChatSettingsTypeId.RADIO_MINES_ADDED] = !!param1.rm ? true : false;
        _loc2_.chatSettings[UserChatSettingsTypeId.RADIO_TOWER_ADDED] = !!param1.ra ? true : false;
        _loc2_.chatSettings[UserChatSettingsTypeId.ALLIANCE_DIPLOMATIC_RELATION] = !!param1.ad ? true : false;
        _loc2_.chatSettings[UserChatSettingsTypeId.ALLIANCE_TOWER_ACTION] = !!param1.at ? true : false;
        _loc2_.chatSettings[UserChatSettingsTypeId.ALLIANCE_ACHIEVEMENTS] = !!param1.ac ? true : false;
        _loc2_.chatSettings[UserChatSettingsTypeId.ALLIANCE_MINES_ADDED] = !!param1.am ? true : false;
        _loc2_.chatSettings[UserChatSettingsTypeId.ALLIANCE_TOWER_ADDED] = !!param1.aa ? true : false;
        _loc2_._selectedRegionalChat = !!param1.sc ? new String(param1.sc) : null;
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

    public function get selectedRegionalChat():String {
        if (this._selectedRegionalChat != null) {
            return this._selectedRegionalChat;
        }
        return LocaleUtil.currentLocale.replace("_", "-");
    }

    public function set selectedRegionalChat(param1:String):void {
        if (this._selectedRegionalChat != param1) {
            this._selectedRegionalChat = param1;
            this.dirty = true;
        }
    }

    public function toDto():* {
        var _loc1_:* = {
            "ad": this.chatSettings[UserChatSettingsTypeId.ALLIANCE_DIPLOMATIC_RELATION],
            "at": this.chatSettings[UserChatSettingsTypeId.ALLIANCE_TOWER_ACTION],
            "ac": this.chatSettings[UserChatSettingsTypeId.ALLIANCE_ACHIEVEMENTS],
            "ar": this.chatSettings[UserChatSettingsTypeId.ALLIANCE_WEEKLY_RATING],
            "am": this.chatSettings[UserChatSettingsTypeId.ALLIANCE_MINES_ADDED],
            "aa": this.chatSettings[UserChatSettingsTypeId.ALLIANCE_TOWER_ADDED],
            "rd": this.chatSettings[UserChatSettingsTypeId.RADIO_DIPLOMATIC_RELATION],
            "rt": this.chatSettings[UserChatSettingsTypeId.RADIO_TOWER_ACTION],
            "rc": this.chatSettings[UserChatSettingsTypeId.RADIO_ACHIEVEMENTS],
            "rr": this.chatSettings[UserChatSettingsTypeId.RADIO_WEEKLY_RATING],
            "rm": this.chatSettings[UserChatSettingsTypeId.RADIO_MINES_ADDED],
            "ra": this.chatSettings[UserChatSettingsTypeId.RADIO_TOWER_ADDED]
        };
        return _loc1_;
    }

    public function toDtoSpecial():* {
        var _loc1_:* = {"sc": this.selectedRegionalChat};
        return _loc1_;
    }

    public function toDtos(param1:ArrayCustom):Array {
        var _loc3_:UserChatSettings = null;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            this.events.dispatchEvent(new Event(REGIONAL_DATA_CHANGED, true));
        }
    }

    public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        this.events.addEventListener(param1, param2, param3, param4, param5);
    }

    public function removeEventListener(param1:String, param2:Function):void {
        this.events.removeEventListener(param1, param2);
    }
}
}
