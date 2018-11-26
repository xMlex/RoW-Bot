package model.logic.commands.user {
import model.data.users.raids.RaidLocationStoryType;
import model.data.users.raids.RaidLocationStoryTypeStep;
import model.logic.StaticDataManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetRaidLocationStoryTypeStepCmd extends BaseCmd {


    private var _dto;

    public function GetRaidLocationStoryTypeStepCmd(param1:int, param2:int) {
        super();
        this._dto = new {
            "y": param1,
            "p": param2
        }();
    }

    override public function execute():void {
        new JsonCallCmd("Raid.GetRaidLocationStoryTypeStep", this._dto, "POST").ifResult(function (param1:*):void {
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            if (param1 == null) {
                return;
            }
            var _loc2_:* = RaidLocationStoryTypeStep.fromDto(param1);
            for each(_loc4_ in StaticDataManager.raidLocationStoryTypes) {
                if (_loc4_.storyId == _loc2_.storyId) {
                    _loc3_ = _loc4_;
                }
            }
            if (_loc3_ == null) {
                _loc3_ = new RaidLocationStoryType();
                StaticDataManager.raidLocationStoryTypes.addItem(_loc3_);
            }
            _loc3_.steps.addItem(_loc2_);
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
