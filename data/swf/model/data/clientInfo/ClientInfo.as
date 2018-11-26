package model.data.clientInfo {
import integration.SocialNetworkIdentifier;

public class ClientInfo {


    public var platformId:int = 1;

    public var platformVersion:String = "1.0";

    public var hostType:String;

    public var portalHostType:String;

    public function ClientInfo() {
        super();
        this.initialize();
    }

    public function toDto():* {
        var _loc1_:Object = {
            "i": this.platformId,
            "v": this.platformVersion,
            "ht": this.hostType,
            "pht": this.portalHostType
        };
        return _loc1_;
    }

    private function initialize():void {
        if (SocialNetworkIdentifier.flashvars != null) {
            this.hostType = SocialNetworkIdentifier.flashvars.ht as String;
            this.portalHostType = SocialNetworkIdentifier.flashvars.pht as String;
        }
    }
}
}
