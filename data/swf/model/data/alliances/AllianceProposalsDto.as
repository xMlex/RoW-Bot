package model.data.alliances {
import common.ArrayCustom;

public class AllianceProposalsDto {


    public var minRating:Number;

    public var maxRating:Number;

    public var proposals:ArrayCustom;

    public var moreItemsBack:Boolean;

    public var moreItemsForward:Boolean;

    public function AllianceProposalsDto() {
        super();
    }

    public static function fromDto(param1:*):AllianceProposalsDto {
        var _loc2_:AllianceProposalsDto = new AllianceProposalsDto();
        _loc2_.proposals = param1.i == null ? new ArrayCustom() : KnownAllianceProposalSearchItem.fromDtos(param1.i);
        _loc2_.minRating = param1.l;
        _loc2_.maxRating = param1.h;
        _loc2_.moreItemsForward = param1.f == null ? false : Boolean(param1.f);
        _loc2_.moreItemsBack = param1.b == null ? false : Boolean(param1.b);
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
