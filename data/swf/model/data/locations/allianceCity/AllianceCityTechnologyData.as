package model.data.locations.allianceCity {
public class AllianceCityTechnologyData {


    public var technologies:Array;

    public function AllianceCityTechnologyData() {
        super();
    }

    public static function fromDto(param1:*):AllianceCityTechnologyData {
        var _loc2_:AllianceCityTechnologyData = new AllianceCityTechnologyData();
        _loc2_.technologies = param1.t == null ? [] : AllianceCityTechnology.fromDtos(param1.t);
        return _loc2_;
    }

    public function toDto():* {
        var _loc2_:AllianceCityTechnology = null;
        var _loc1_:* = {"t": []};
        if (this.technologies != null) {
            for each(_loc2_ in this.technologies) {
                _loc1_.t.push(_loc2_.toDto());
            }
        }
        return _loc1_;
    }

    public function getTechnologyByType(param1:int):AllianceCityTechnology {
        var _loc2_:int = 0;
        while (_loc2_ < this.technologies.length) {
            if (this.technologies[_loc2_].typeId == param1) {
                return this.technologies[_loc2_];
            }
            _loc2_++;
        }
        return null;
    }
}
}
