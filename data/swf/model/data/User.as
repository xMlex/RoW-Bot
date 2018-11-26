package model.data {
import common.ArrayCustom;
import common.localization.LocaleUtil;

import model.data.users.misc.UserSectorSkinData;
import model.logic.UserDemoManager;
import model.logic.UserManager;

public class User {


    public var id:Number;

    public var socialData:UserSocialData;

    public var gameData:UserGameData;

    public var canBeCyborg:Boolean = false;

    public function User() {
        super();
    }

    public static function fromDto(param1:*):User {
        var _loc2_:Boolean = !!UserManager.user ? UserManager.user.id == param1.i : true;
        var _loc3_:User = new User();
        _loc3_.id = param1.i;
        _loc3_.socialData = UserSocialData.fromDto(param1.s);
        _loc3_.gameData = UserGameData.fromDto(param1.g, _loc2_);
        return _loc3_;
    }

    public static function fromVisitUserDto(param1:*):User {
        var dto:* = param1;
        var entity:User = new User();
        try {
            entity.id = dto.i;
            entity.socialData = UserSocialData.fromDto(dto.s);
            entity.gameData = UserGameData.fromVisitUserDto(dto.g);
            entity.canBeCyborg = dto.c;
        }
        catch (err:Error) {
        }
        return entity;
    }

    public static function fromDemoUserDto(param1:*):User {
        var dto:* = param1;
        var entity:User = new User();
        try {
            entity.id = UserDemoManager.DemoUserId;
            entity.socialData = UserSocialData.fromDto(dto.s);
            entity.socialData.fullName = LocaleUtil.getText("model-data-user-lapidus");
            entity.gameData = UserGameData.fromDemoUserDto(dto.g);
            entity.gameData.sectorSkinsData = new UserSectorSkinData();
            entity.gameData.sectorSkinsData.currentSkinTypeId = 1;
        }
        catch (err:Error) {
        }
        return entity;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function toString():String {
        if (this.socialData == null) {
            return "[User] socialData == null";
        }
        return "[User] " + (this.socialData.socialId != null ? this.socialData.socialId.toString() : "") + " " + (this.socialData.fullName != null ? this.socialData.fullName : "");
    }

    public function getLocale():String {
        return this.gameData.userGameSettings && this.gameData.userGameSettings.locale != null && this.gameData.userGameSettings.locale != "" ? this.gameData.userGameSettings.locale : this.socialData.locale;
    }
}
}
