package model.data {
import common.ArrayCustom;

import flash.events.Event;
import flash.events.EventDispatcher;

import model.logic.inviteFriend.SocialInvitation;

public class UserInvitationData {

    private static const CLASS_NAME:String = "UserInvitationData";

    public static const DATA_CHANGED:String = CLASS_NAME + "Changed";


    public var sentInvitations:ArrayCustom;

    public var acceptedInvitations:ArrayCustom;

    public var reachedLevelInvitations:ArrayCustom;

    public var constructionBlockCount:int;

    public var dirty:Boolean;

    private var events:EventDispatcher;

    public function UserInvitationData() {
        this.events = new EventDispatcher();
        super();
    }

    public static function fromDto(param1:*):UserInvitationData {
        var _loc3_:Object = null;
        var _loc2_:UserInvitationData = new UserInvitationData();
        _loc2_.sentInvitations = new ArrayCustom();
        _loc2_.acceptedInvitations = new ArrayCustom();
        _loc2_.reachedLevelInvitations = new ArrayCustom();
        if (param1.s) {
            for each(_loc3_ in param1.s) {
                _loc2_.sentInvitations.push(SocialInvitation.fromDto(_loc3_));
            }
        }
        if (param1.a) {
            for each(_loc3_ in param1.a) {
                _loc2_.acceptedInvitations.push(SocialInvitation.fromDto(_loc3_));
            }
        }
        if (param1.r) {
            for each(_loc3_ in param1.r) {
                _loc2_.reachedLevelInvitations.push(SocialInvitation.fromDto(_loc3_));
            }
        }
        _loc2_.constructionBlockCount = param1.c;
        return _loc2_;
    }

    public function addEventListener(param1:String, param2:Function):void {
        this.events.addEventListener(param1, param2);
    }

    public function removeEventListener(param1:String, param2:Function):void {
        this.events.removeEventListener(param1, param2);
    }

    public function dispatchEvents():void {
        if (this.dirty) {
            this.dirty = false;
            this.events.dispatchEvent(new Event(DATA_CHANGED, true));
        }
    }

    public function clone(param1:UserInvitationData, param2:UserInvitationData):void {
        if (!param1 || !param2) {
            return;
        }
        param1.sentInvitations = param2.sentInvitations;
        param1.acceptedInvitations = param2.acceptedInvitations;
        param1.reachedLevelInvitations = param2.reachedLevelInvitations;
        param1.constructionBlockCount = param2.constructionBlockCount;
    }
}
}
