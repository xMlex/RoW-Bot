package model.data.users.misc {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

import model.logic.StaticDataManager;

public class KnownUsersData extends ObservableObject {

    public static const CLASS_NAME:String = "KnownUsersData";

    public static const KNOWN_USERS_CHANGED:String = CLASS_NAME + "KnownUsersChanged";

    public static const FAVOURITES_CHANGED:String = CLASS_NAME + "FavouritesChanged";


    public var friendUserIds:ArrayCustom;

    public var mateUserIds:ArrayCustom;

    public var enemyUserIds:ArrayCustom;

    public var allianceEnemyUserIds:ArrayCustom;

    public var favouriteUsers:ArrayCustom;

    public var extraFavoriteUsersCount:int;

    public var enemyUserIdsWithTime:ArrayCustom;

    public var robberyLimit:Number = 0;

    public var knownTowers:ArrayCustom;

    public var dirty:Boolean = false;

    public var favouritesDirty:Boolean = false;

    public function KnownUsersData() {
        super();
    }

    private static function shrink(param1:ArrayCustom, param2:int):void {
        while (param1.length > param2) {
            param1.removeItemAt(param2);
        }
    }

    public static function fromDto(param1:*):KnownUsersData {
        var _loc3_:EnemyUser = null;
        var _loc2_:KnownUsersData = new KnownUsersData();
        _loc2_.friendUserIds = new ArrayCustom(param1.u);
        _loc2_.mateUserIds = new ArrayCustom(param1.f);
        _loc2_.allianceEnemyUserIds = new ArrayCustom(param1.b);
        _loc2_.favouriteUsers = param1.k == null ? new ArrayCustom() : FavouriteUser.fromDtos(param1.k);
        _loc2_.extraFavoriteUsersCount = param1.a;
        _loc2_.enemyUserIdsWithTime = param1.n == null ? new ArrayCustom() : EnemyUser.fromDtos(param1.n);
        _loc2_.robberyLimit = param1.kd;
        _loc2_.enemyUserIds = new ArrayCustom();
        for each(_loc3_ in _loc2_.enemyUserIdsWithTime) {
            _loc2_.enemyUserIds.addItem(_loc3_.userId);
        }
        _loc2_.knownTowers = param1.l == null ? new ArrayCustom() : FavouriteTower.fromDtos(param1.l);
        return _loc2_;
    }

    public function isFriend(param1:Number):Boolean {
        var _loc2_:Number = NaN;
        if (this.friendUserIds != null) {
            for each(_loc2_ in this.friendUserIds) {
                if (_loc2_ == param1) {
                    return true;
                }
            }
        }
        return false;
    }

    public function isMate(param1:Number):Boolean {
        var _loc2_:Number = NaN;
        if (this.mateUserIds != null) {
            for each(_loc2_ in this.mateUserIds) {
                if (_loc2_ == param1) {
                    return true;
                }
            }
        }
        return false;
    }

    public function isEnemy(param1:Number):Boolean {
        var _loc2_:Number = NaN;
        if (this.enemyUserIds != null) {
            for each(_loc2_ in this.enemyUserIds) {
                if (_loc2_ == param1) {
                    return true;
                }
            }
        }
        return false;
    }

    public function isAllianceEnemy(param1:Number):Boolean {
        var _loc2_:Number = NaN;
        if (this.allianceEnemyUserIds != null) {
            for each(_loc2_ in this.allianceEnemyUserIds) {
                if (_loc2_ == param1) {
                    return true;
                }
            }
        }
        return false;
    }

    public function getFavorite(param1:Number):FavouriteUser {
        var _loc2_:FavouriteUser = null;
        if (this.favouriteUsers != null) {
            for each(_loc2_ in this.favouriteUsers) {
                if (_loc2_.userId == param1) {
                    return _loc2_;
                }
            }
        }
        return null;
    }

    public function getTimeAddToEnemy(param1:Number):Date {
        var _loc2_:EnemyUser = null;
        if (this.enemyUserIdsWithTime != null) {
            for each(_loc2_ in this.enemyUserIdsWithTime) {
                if (_loc2_.userId == param1) {
                    return _loc2_.dateAddToEnemy;
                }
            }
        }
        return null;
    }

    public function addMate(param1:Number):void {
        this.addUserImpl(param1, this.mateUserIds, StaticDataManager.knownUsersData.matesLimit);
    }

    public function addEnemy(param1:Number):void {
        this.addUserImpl(param1, this.enemyUserIds, StaticDataManager.knownUsersData.enemiesLimit);
    }

    public function removeUser(param1:Number):void {
        var _loc2_:int = this.mateUserIds.getItemIndex(param1);
        if (_loc2_ != -1) {
            this.mateUserIds.removeItemAt(_loc2_);
        }
        var _loc3_:int = this.enemyUserIds.getItemIndex(param1);
        if (_loc3_ != -1) {
            this.enemyUserIds.removeItemAt(_loc3_);
        }
    }

    public function addAllianceEnemy(param1:Number):void {
        this.removeAllianceEnemy(param1);
        this.allianceEnemyUserIds.addItemAt(param1, 0);
        shrink(this.allianceEnemyUserIds, StaticDataManager.knownUsersData.allianceEnemiesLimit);
    }

    public function removeAllianceEnemy(param1:Number):void {
        var _loc2_:int = this.allianceEnemyUserIds.getItemIndex(param1);
        if (_loc2_ != -1) {
            this.allianceEnemyUserIds.removeItemAt(_loc2_);
        }
    }

    private function addUserImpl(param1:Number, param2:ArrayCustom, param3:int):void {
        this.removeUser(param1);
        param2.addItemAt(param1, 0);
        shrink(param2, param3);
    }

    public function dispatchEvents():void {
        if (this.dirty == true) {
            this.dirty = false;
            dispatchEvent(KNOWN_USERS_CHANGED);
        }
        if (this.favouritesDirty == true) {
            this.favouritesDirty = false;
            dispatchEvent(FAVOURITES_CHANGED);
        }
    }

    public function toDto():* {
        var _loc1_:* = {
            "u": this.friendUserIds,
            "f": this.mateUserIds,
            "e": this.enemyUserIds,
            "b": this.allianceEnemyUserIds,
            "k": FavouriteUser.toDtos(this.favouriteUsers)
        };
        return _loc1_;
    }
}
}
