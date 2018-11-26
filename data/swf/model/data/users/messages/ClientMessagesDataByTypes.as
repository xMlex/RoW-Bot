package model.data.users.messages {
import flash.utils.Dictionary;

public class ClientMessagesDataByTypes {


    public var usersMessagesDictionary:Dictionary;

    public var allianceMessages:Dictionary;

    public var messagesFromAllianceMemberships:Dictionary;

    public var unReadCount:int = 0;

    public var unReadCountFromAlliance:int = 0;

    public function ClientMessagesDataByTypes() {
        this.usersMessagesDictionary = new Dictionary();
        this.allianceMessages = new Dictionary();
        this.messagesFromAllianceMemberships = new Dictionary();
        super();
    }
}
}
