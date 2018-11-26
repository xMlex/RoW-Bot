package model.data.alliances {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

public class KnownAllianceProposalSearchItem extends ObservableObject {


    public var allianceId:Number;

    public var proposal:KnownAllianceProposal;

    public function KnownAllianceProposalSearchItem() {
        super();
    }

    public static function fromDto(param1:*):KnownAllianceProposalSearchItem {
        var _loc2_:KnownAllianceProposalSearchItem = new KnownAllianceProposalSearchItem();
        _loc2_.allianceId = param1.i;
        _loc2_.proposal = param1.p == null ? null : KnownAllianceProposal.fromDto(param1.p);
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
}
}
