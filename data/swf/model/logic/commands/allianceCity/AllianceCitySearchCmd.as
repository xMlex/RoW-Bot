package model.logic.commands.allianceCity {
import model.data.allianceCitySearch.GetCitiesDto;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class AllianceCitySearchCmd extends BaseCmd {


    private var _dto;

    private var _request:GetCitiesDto;

    public function AllianceCitySearchCmd(param1:GetCitiesDto) {
        super();
        this._request = param1;
        this._dto = makeRequestDto(param1);
    }

    private static function makeRequestDto(param1:GetCitiesDto):* {
        var _loc2_:* = {
            "k": param1.cityLevel,
            "e": param1.count,
            "o": param1.orderTypeId,
            "d": param1.desc,
            "l": param1.searchLevel,
            "s": param1.startIndex
        };
        return _loc2_;
    }

    override public function execute():void {
        new JsonCallCmd("CitySearch", this._dto, "POST").ifResult(function (param1:*):void {
            if (_onResult != null) {
                _onResult(param1, _request);
            }
        }).ifFault(function (param1:*):void {
            if (_onFault != null) {
                _onFault(param1);
            }
        }).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
