package model.data.locations.allianceCity {
import model.data.scenes.objects.info.ConstructionObjInfo;

public class AllianceCityTechnology {


    public var typeId:int;

    public var constructionObjInfo:ConstructionObjInfo;

    public function AllianceCityTechnology() {
        super();
    }

    public static function fromDto(param1:*):AllianceCityTechnology {
        var _loc2_:AllianceCityTechnology = new AllianceCityTechnology();
        _loc2_.typeId = param1.i;
        _loc2_.constructionObjInfo = param1.c == null ? null : ConstructionObjInfo.fromDto(param1.c);
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.typeId,
            "c": this.constructionObjInfo.toDto()
        };
        return _loc1_;
    }
}
}
