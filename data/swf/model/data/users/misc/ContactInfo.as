package model.data.users.misc {
public class ContactInfo {


    public var id:int;

    public var isAllianceMember:Boolean;

    public var isLocationNote:Boolean;

    public var isAllianceCity:Boolean;

    public function ContactInfo() {
        super();
    }

    public function get isUserNote():Boolean {
        return !this.isLocationNote && !this.isAllianceCity;
    }
}
}
