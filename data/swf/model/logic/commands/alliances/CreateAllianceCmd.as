package model.logic.commands.alliances {
import model.data.Resources;
import model.data.alliances.AllianceMemberRankId;
import model.data.alliances.AllianceNote;
import model.logic.AllianceManager;
import model.logic.AllianceNoteManager;
import model.logic.UserManager;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class CreateAllianceCmd extends BaseAllianceCmd {


    private var requestDto;

    private var _name:String;

    private var _flag:String;

    private var _price:Number;

    private var _shortName:String;

    public function CreateAllianceCmd(param1:String, param2:String, param3:Number, param4:String = "") {
        super();
        this._name = param1;
        this._flag = param2;
        this._price = param3;
        this._shortName = param4;
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "n": this._name,
            "f": this._flag,
            "s": this._shortName
        });
    }

    override public function execute():void {
        new JsonCallCmd("CreateAlliance", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            AllianceNoteManager.updateOne(AllianceNote.fromDto(param1.o.n));
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = param1.o.i;
                _loc3_ = UserManager.user;
                _loc4_ = _loc3_.gameData.allianceData;
                _loc5_ = Resources.fromGoldMoney(_price);
                _loc3_.gameData.account.resources.substract(_loc5_);
                _loc4_.allianceId = _loc2_;
                _loc4_.rankId = AllianceMemberRankId.LEADER;
                AllianceManager.loadAlliance(_loc3_);
                _loc4_.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
