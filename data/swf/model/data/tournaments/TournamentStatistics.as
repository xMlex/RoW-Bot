package model.data.tournaments {
import common.queries.util.query;

import model.logic.quests.data.TournamentStatisticsType;

public class TournamentStatistics {


    public var prototypeId:int;

    public var questId:int;

    public var statistics:Array;

    public function TournamentStatistics() {
        super();
    }

    public static function fromDto(param1:*):TournamentStatistics {
        var _loc2_:TournamentStatistics = new TournamentStatistics();
        _loc2_.prototypeId = param1.p;
        _loc2_.questId = param1.q;
        _loc2_.statistics = param1.s == null ? [] : TournamentStatisticsItem.fromDtos(param1.s);
        return _loc2_;
    }

    public static function fromDtos(param1:*):Array {
        var _loc3_:* = undefined;
        if (param1 == null) {
            return null;
        }
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function containsStatisticsType(param1:Array, param2:int):Boolean {
        var statistics:Array = param1;
        var statsType:int = param2;
        return query(statistics).any(function (param1:TournamentStatisticsItem):Boolean {
            return param1.statsType == statsType;
        });
    }

    public function get hasAny():Boolean {
        return this.statistics && this.statistics.length > 0;
    }

    public function sumByStatisticsType(param1:int):Number {
        var statsType:int = param1;
        return query(this.statistics).sum(function (param1:TournamentStatisticsItem):Number {
            var _loc2_:* = 0;
            if (param1.statsType == statsType || statsType == TournamentStatisticsType.None) {
                _loc2_ = param1.value;
            }
            return _loc2_;
        });
    }

    public function containsStatisticsType(param1:int):Boolean {
        return TournamentStatistics.containsStatisticsType(this.statistics, param1);
    }
}
}
