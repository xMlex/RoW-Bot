package model.logic.journal.events {
import model.logic.AllianceManager;
import model.logic.UserManager;
import model.logic.journal.IJEventUser;
import model.logic.journal.JEventUser;
import model.modules.allianceHelp.AllianceHelpRequestState;
import model.modules.allianceHelp.AllianceHelpRequestTypeId;
import model.modules.allianceHelp.data.alliance.AllianceHelpData;
import model.modules.allianceHelp.data.alliance.AllianceHelpRequest;
import model.modules.allianceHelp.data.user.AllianceHelpBuildingShortInfo;
import model.modules.allianceHelp.data.user.UserAllianceHelpData;
import model.modules.allianceHelp.data.user.UserAllianceHelpRequest;

public class JUEventAllianceHelpApproveUserRequest extends JEventUser {


    public var allianceRequest:AllianceHelpRequest;

    public var personalRequestId:Number;

    public function JUEventAllianceHelpApproveUserRequest() {
        super();
    }

    public static function fromDto(param1:*):IJEventUser {
        var _loc2_:JUEventAllianceHelpApproveUserRequest = new JUEventAllianceHelpApproveUserRequest();
        _loc2_.allianceRequest = param1.r == null ? null : AllianceHelpRequest.fromDto(param1.r);
        _loc2_.personalRequestId = param1.p;
        return _loc2_;
    }

    override public function apply():void {
        var _loc3_:UserAllianceHelpRequest = null;
        var _loc6_:AllianceHelpRequest = null;
        var _loc7_:UserAllianceHelpRequest = null;
        var _loc8_:Array = null;
        var _loc9_:Boolean = false;
        var _loc10_:AllianceHelpBuildingShortInfo = null;
        var _loc11_:AllianceHelpBuildingShortInfo = null;
        var _loc1_:UserAllianceHelpData = UserManager.user.gameData.allianceData.allianceHelpData == null ? UserManager.user.gameData.allianceData.allianceHelpData = new UserAllianceHelpData() : UserManager.user.gameData.allianceData.allianceHelpData;
        var _loc2_:Boolean = false;
        for each(_loc3_ in _loc1_.requests) {
            if (_loc3_.personalRequestId == this.personalRequestId) {
                _loc3_.id = this.allianceRequest.id;
                _loc3_.state = AllianceHelpRequestState.APPROVED;
                _loc2_ = true;
                break;
            }
        }
        if (!_loc2_) {
            _loc7_ = new UserAllianceHelpRequest();
            _loc7_.id = this.allianceRequest.id;
            _loc7_.allianceId = AllianceManager.currentAlliance.id;
            _loc7_.typeId = this.allianceRequest.typeId;
            _loc7_.important = this.allianceRequest.important;
            _loc7_.description = this.allianceRequest.description;
            _loc7_.state = AllianceHelpRequestState.APPROVED;
            _loc7_.requestTime = this.allianceRequest.requestTime;
            _loc7_.validTill = this.allianceRequest.validTill;
            _loc7_.respondedUserIds = this.allianceRequest.respondedUserIds;
            _loc7_.responsesCount = this.allianceRequest.responsesCount;
            _loc7_.buildingInfo = this.allianceRequest.buildingInfo;
            _loc7_.resourcesInfo = this.allianceRequest.resourcesInfo;
            _loc7_.attackInfo = this.allianceRequest.attackInfo;
            _loc7_.personalRequestId = this.personalRequestId;
            _loc1_.requests.push(_loc7_);
        }
        if (this.allianceRequest.typeId == AllianceHelpRequestTypeId.BUILDINGS) {
            _loc8_ = _loc1_.lastRequestedBuildingsLevels != null ? _loc1_.lastRequestedBuildingsLevels : _loc1_.lastRequestedBuildingsLevels = [];
            _loc9_ = false;
            for each(_loc10_ in _loc8_) {
                if (_loc10_.buildingId != this.allianceRequest.buildingInfo.buildingId) {
                    continue;
                }
                _loc10_.level = this.allianceRequest.buildingInfo.buildingLevel;
                _loc9_ = true;
                break;
            }
            if (!_loc9_) {
                _loc11_ = new AllianceHelpBuildingShortInfo();
                _loc11_.buildingId = this.allianceRequest.buildingInfo.buildingId;
                _loc11_.level = this.allianceRequest.buildingInfo.buildingLevel;
                _loc8_.push(_loc11_);
            }
        }
        var _loc4_:AllianceHelpData = AllianceManager.currentAlliance.gameData.helpData == null ? AllianceManager.currentAlliance.gameData.helpData = new AllianceHelpData() : AllianceManager.currentAlliance.gameData.helpData;
        if (_loc4_.requests == null) {
            _loc4_.requests = [];
        }
        var _loc5_:Boolean = false;
        for each(_loc6_ in _loc4_.requests) {
            if (_loc6_.id == this.allianceRequest.id && this.allianceRequest.userId != UserManager.user.id) {
                _loc5_ = true;
                break;
            }
        }
        if (!_loc5_) {
            if (_loc4_.requests == null) {
                _loc4_.requests = [];
            }
            if (this.allianceRequest.userId != UserManager.user.id) {
                _loc4_.requests.push(this.allianceRequest);
            }
        }
    }
}
}
