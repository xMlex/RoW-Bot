package model.logic.commands.alliances {
import model.data.alliances.AllianceAcademyData;
import model.logic.AllianceManager;
import model.logic.commands.server.JsonCallCmd;

public class UpdateAllianceSettingsCmd extends BaseAllianceCmd {


    private var _description:String;

    private var _extendedDescription:String;

    private var _requiredMemberLevel:int = -1;

    private var _newMembersEnabled:Boolean = true;

    private var _language:int = 0;

    private var _academyData:AllianceAcademyData;

    private var _timeZone:Number;

    private var _dto;

    public function UpdateAllianceSettingsCmd(param1:String, param2:String, param3:int = -1, param4:Boolean = true, param5:int = 0, param6:AllianceAcademyData = null, param7:Number = 0) {
        super();
        this._description = param1;
        if (param1 == null) {
            this._extendedDescription = param2;
            this._requiredMemberLevel = param3;
            this._newMembersEnabled = param4;
            this._language = param5;
            this._academyData = param6;
            this._timeZone = param7;
        }
        this._dto = makeRequestDto({});
        if (this._description != null) {
            this._dto.o.d = this._description;
        }
        if (this._extendedDescription != null) {
            this._dto.o.e = this._extendedDescription;
        }
        if (this._requiredMemberLevel != -1) {
            this._dto.o.r = this._requiredMemberLevel;
        }
        if (param1 != null) {
            this._newMembersEnabled = AllianceManager.currentAlliance.gameData.membershipData.newMembersEnabled;
        }
        this._dto.o.n = this._newMembersEnabled;
        if (this._language > 0) {
            this._dto.o.l = this._language;
        }
        if (this._academyData != null) {
            this._dto.o.a = this._academyData.toDto();
        }
        this._dto.o.t = this._timeZone;
    }

    override public function execute():void {
        new JsonCallCmd("Alliance.UpdateSettings", this._dto, "POST").setSegment(AllianceManager.currentAlliance.segmentId).ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            if (!updateAllianceByResultDto(param1)) {
                _loc2_ = AllianceManager.currentAlliance.gameData;
                if (_description) {
                    _loc2_.appearanceData.description = _description;
                }
                if (_extendedDescription) {
                    _loc2_.appearanceData.extendedDescription = _extendedDescription;
                }
                if (_requiredMemberLevel != -1) {
                    _loc2_.membershipData.requiredMemberLevel = _requiredMemberLevel;
                }
                _loc2_.membershipData.newMembersEnabled = _newMembersEnabled;
                if (_language > 0) {
                    _loc2_.membershipData.language = _language;
                }
                if (_academyData != null) {
                    _loc2_.academyData = _academyData;
                }
                _loc2_.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
