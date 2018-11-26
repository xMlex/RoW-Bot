package model.data.alliances {
import gameObjects.observableObject.ObservableObject;

public class KnownAllianceProposal extends ObservableObject {


    public var type:int;

    public var date:Date;

    public function KnownAllianceProposal() {
        super();
    }

    public static function fromDto(param1:*):KnownAllianceProposal {
        var _loc2_:KnownAllianceProposal = new KnownAllianceProposal();
        _loc2_.type = param1.t;
        _loc2_.date = new Date(param1.d);
        return _loc2_;
    }
}
}
