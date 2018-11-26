package model.logic.inviteFriend {
public class SocialInvitation {


    public var userSocialId:String;

    public var userId:Number = -1;

    public var name:String;

    public var avatarUrl:String;

    public var dateCreated:Date;

    public function SocialInvitation() {
        super();
    }

    public static function fromDto(param1:Object):SocialInvitation {
        if (param1 == null) {
            return null;
        }
        var _loc2_:SocialInvitation = new SocialInvitation();
        if (param1.i) {
            _loc2_.userSocialId = param1.i;
        }
        if (param1.u) {
            _loc2_.userId = param1.u;
        }
        if (param1.n) {
            _loc2_.name = param1.n;
        }
        if (param1.p) {
            _loc2_.avatarUrl = param1.p;
        }
        if (param1.d) {
            _loc2_.dateCreated = new Date(param1.d);
        }
        return _loc2_;
    }

    public function toDto():Object {
        var _loc1_:Object = {};
        if (this.userSocialId) {
            _loc1_.i = this.userSocialId;
        }
        if (this.userId != -1) {
            _loc1_.u = this.userId;
        }
        if (this.name) {
            _loc1_.n = this.name;
        }
        if (this.avatarUrl) {
            _loc1_.p = this.avatarUrl;
        }
        return _loc1_;
    }
}
}
