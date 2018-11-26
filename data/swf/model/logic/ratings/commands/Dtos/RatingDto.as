package model.logic.ratings.commands.Dtos {
import common.ArrayCustom;

import flash.utils.Dictionary;

import model.data.alliances.AllianceNote;
import model.data.users.UserNote;
import model.logic.AllianceNoteManager;
import model.logic.UserNoteManager;

public class RatingDto {


    public var thisWeekRatingTime:Date;

    public var lastWeekRatingTime:Date;

    public var tops:Dictionary;

    public function RatingDto() {
        super();
    }

    public static function fromDto(param1:*):RatingDto {
        var _loc3_:ArrayCustom = null;
        var _loc4_:* = undefined;
        var _loc2_:RatingDto = new RatingDto();
        _loc2_.thisWeekRatingTime = param1.c == null ? null : new Date(param1.c);
        _loc2_.lastWeekRatingTime = param1.l == null ? null : new Date(param1.l);
        _loc2_.tops = new Dictionary();
        if (param1.t != null) {
            for (_loc4_ in param1.t) {
                _loc2_.tops[_loc4_] = TopDto.fromDto(param1.t[_loc4_]);
            }
        }
        if (param1.u) {
            _loc3_ = UserNote.fromDtos(param1.u);
            UserNoteManager.update(_loc3_);
        }
        if (param1.o) {
            _loc3_ = UserNote.fromDtos(param1.o);
            UserNoteManager.update(_loc3_);
        }
        if (param1.x) {
            _loc3_ = AllianceNote.fromDtos(param1.x);
            AllianceNoteManager.update(_loc3_);
        }
        if (param1.a) {
            _loc3_ = AllianceNote.fromDtos(param1.a);
            AllianceNoteManager.update(_loc3_);
        }
        return _loc2_;
    }
}
}
