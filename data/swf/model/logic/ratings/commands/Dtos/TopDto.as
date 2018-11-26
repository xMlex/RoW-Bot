package model.logic.ratings.commands.Dtos {
import common.ArrayCustom;

import model.data.ratings.RatingItem;

public class TopDto {


    public var items:ArrayCustom;

    public var startPosition:int;

    public var itemPositions:Array;

    public var posOffset:int;

    public function TopDto() {
        super();
    }

    public static function fromDto(param1:*):TopDto {
        var _loc2_:TopDto = new TopDto();
        _loc2_.items = RatingItem.fromDtos(param1.t);
        if (_loc2_.items == null) {
            return null;
        }
        _loc2_.startPosition = param1.p;
        _loc2_.itemPositions = param1.i;
        _loc2_.posOffset = 0;
        return _loc2_;
    }

    public function get pos():int {
        return this.startPosition;
    }

    public function set pos(param1:int):void {
        this.startPosition = param1;
    }
}
}
