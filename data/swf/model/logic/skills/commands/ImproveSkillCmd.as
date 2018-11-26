package model.logic.skills.commands {
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.skills.SkillManager;
import model.logic.skills.data.Skill;

public class ImproveSkillCmd extends BaseCmd {


    private var requestDto;

    private var _skillTypeId:int;

    public function ImproveSkillCmd(param1:int) {
        super();
        this._skillTypeId = param1;
        this.requestDto = UserRefreshCmd.makeRequestDto({"i": this._skillTypeId});
    }

    override public function execute():void {
        new JsonCallCmd("ImproveSkill", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            var _loc2_:* = UserManager.user;
            var _loc3_:* = _loc2_.gameData.skillData;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc4_ = Skill.fromDto(param1.o.s);
                _loc5_ = SkillManager.getSkill(_loc3_, _skillTypeId);
                if (_loc5_ == null) {
                    _loc3_.skills.addItem(_loc4_);
                }
                else {
                    _loc5_.constructionInfo.level = _loc4_.constructionInfo.level;
                    _loc5_.constructionInfo.constructionStartTime = _loc4_.constructionInfo.constructionStartTime;
                    _loc5_.constructionInfo.constructionFinishTime = _loc4_.constructionInfo.constructionFinishTime;
                    _loc5_.dirtyNormalized = true;
                }
                _loc3_.dirty = true;
            }
            _loc3_.skillPoints--;
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
