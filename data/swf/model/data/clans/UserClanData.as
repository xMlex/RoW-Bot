package model.data.clans {
import common.ArrayCustom;
import common.GameType;

import gameObjects.observableObject.ObservableObject;

import integration.SocialNetworkIdentifier;

import model.data.User;

public class UserClanData extends ObservableObject {

    public static const CLASS_NAME:String = "UserClanData";

    public static const EVENT_CHANGED:String = CLASS_NAME + "_CHANGED";


    public var members:ArrayCustom;

    public var invitations:ArrayCustom;

    public var dirty:Boolean = true;

    public function UserClanData() {
        this.members = new ArrayCustom();
        this.invitations = new ArrayCustom();
        super();
    }

    public static function refreshFriendIds(param1:User):void {
        if (GameType.isPirates || !SocialNetworkIdentifier.isKabamClusters) {
            return;
        }
        param1.gameData.knownUsersData.friendUserIds = param1.gameData.clanData.getAlliesIds();
        param1.gameData.knownUsersData.dirty = true;
    }

    public static function fromDto(param1:*):UserClanData {
        var _loc2_:UserClanData = new UserClanData();
        _loc2_.members = ClanMember.fromDtos(param1.m);
        _loc2_.invitations = ClanInvitation.fromDtos(param1.i);
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            dispatchEvent(EVENT_CHANGED);
        }
    }

    public function getAllies():ArrayCustom {
        var _loc2_:ClanMember = null;
        var _loc1_:ArrayCustom = new ArrayCustom();
        for each(_loc2_ in this.members) {
            if (_loc2_.state == ClanMember.State_Normal) {
                _loc1_.addItem(_loc2_);
            }
        }
        return _loc1_;
    }

    public function getAlliesIds():ArrayCustom {
        var _loc2_:ClanMember = null;
        var _loc1_:ArrayCustom = new ArrayCustom();
        for each(_loc2_ in this.members) {
            if (_loc2_.state == ClanMember.State_Normal) {
                _loc1_.addItem(_loc2_.userId);
            }
        }
        return _loc1_;
    }

    public function isMemberIsAlly(param1:Number):Boolean {
        var _loc2_:ClanMember = null;
        for each(_loc2_ in this.members) {
            if (_loc2_.state == ClanMember.State_Normal && _loc2_.userId == param1) {
                return true;
            }
        }
        return false;
    }

    public function getSortedMembers():ArrayCustom {
        var _loc3_:ClanMember = null;
        var _loc4_:ArrayCustom = null;
        var _loc1_:ArrayCustom = new ArrayCustom();
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in this.members) {
            if (_loc3_.state == ClanMember.State_Normal) {
                _loc1_.addItem(_loc3_);
            }
            else if (_loc3_.state == ClanMember.State_Invited) {
                _loc2_.addItem(_loc3_);
            }
        }
        _loc4_ = new ArrayCustom();
        _loc4_.addAll(_loc1_);
        _loc4_.addAll(_loc2_);
        return _loc4_;
    }

    public function getMember(param1:Number):ClanMember {
        var _loc2_:ClanMember = null;
        for each(_loc2_ in this.members) {
            if (_loc2_.userId == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function addMember(param1:ClanMember):void {
        this.removeMember(param1.userId);
        this.members.addItem(param1);
        this.dirty = true;
    }

    public function removeMember(param1:Number):ClanMember {
        var _loc3_:ClanMember = null;
        var _loc2_:int = -1;
        for each(_loc3_ in this.members) {
            _loc2_++;
            if (_loc3_.userId == param1) {
                this.members.removeItemAt(_loc2_);
                this.dirty = true;
                return _loc3_;
            }
        }
        return null;
    }

    public function removeInvitation(param1:Number):void {
        var _loc3_:ClanInvitation = null;
        var _loc2_:int = -1;
        for each(_loc3_ in this.invitations) {
            _loc2_++;
            if (_loc3_.inviterUserId == param1) {
                this.invitations.removeItemAt(_loc2_);
                this.dirty = true;
                break;
            }
        }
    }
}
}
