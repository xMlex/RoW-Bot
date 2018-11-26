package model.logic.ratings.commands {
import model.data.alliances.AllianceNote;
import model.data.users.UserNote;
import model.logic.AllianceNoteManager;
import model.logic.UserNoteManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.locations.LocationGetNotesCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.ratings.commands.Dtos.RatingDto;

public class RatingGetAlliancesCmd extends BaseCmd {


    private var _dto;

    public function RatingGetAlliancesCmd(param1:int, param2:int) {
        super();
        this._dto = {
            "p": param1,
            "c": param2
        };
    }

    override public function execute():void {
        new JsonCallCmd("Rating.GetAlliances", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc6_:* = undefined;
            var _loc7_:* = undefined;
            var _loc2_:* = AllianceNote.fromDtos(param1.a);
            AllianceNoteManager.update(_loc2_);
            if (param1.x) {
                _loc4_ = AllianceNote.fromDtos(param1.x);
                AllianceNoteManager.update(_loc4_);
                if (_loc4_ != null && _loc4_.length > 0) {
                    _loc5_ = [];
                    for each(_loc6_ in _loc4_) {
                        if (_loc6_.allianceCityId > 0) {
                            _loc5_.push(_loc6_.allianceCityId);
                        }
                    }
                    if (_loc5_.length > 0) {
                        new LocationGetNotesCmd(_loc5_).execute();
                    }
                }
            }
            if (param1.o) {
                _loc7_ = UserNote.fromDtos(param1.o);
                UserNoteManager.update(_loc7_);
            }
            var _loc3_:* = RatingDto.fromDto(param1);
            if (_onResult != null) {
                _onResult(_loc3_);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
