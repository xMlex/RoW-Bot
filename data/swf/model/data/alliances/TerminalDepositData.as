package model.data.alliances {
import common.ArrayCustom;

public class TerminalDepositData {


    public var depositInfo:ArrayCustom;

    public function TerminalDepositData() {
        super();
    }

    public static function fromDto(param1:Object):TerminalDepositData {
        var _loc2_:TerminalDepositData = new TerminalDepositData();
        _loc2_.depositInfo = TerminalDepositInfo.fromDtos(param1) != null ? TerminalDepositInfo.fromDtos(param1) : null;
        return _loc2_.depositInfo != null ? _loc2_ : null;
    }
}
}
