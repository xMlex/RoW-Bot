package model.logic.resourcesConversion.commands {
import model.data.Resources;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.resourcesConversion.ResourcesConversionManager;
import model.logic.resourcesConversion.data.ResourcesConversionJob;
import model.logic.resourcesConversion.data.ResourcesConversionJobType;

public class StartResourcesConversionJobCmd extends BaseCmd {


    private var requestDto;

    private var _type:ResourcesConversionJobType;

    private var _scaleFactor:int;

    public function StartResourcesConversionJobCmd(param1:ResourcesConversionJobType, param2:int) {
        super();
        if (param2 < 1) {
            throw new Error("Invalid scaleFactor");
        }
        this._type = param1;
        this._scaleFactor = param2;
        this.requestDto = UserRefreshCmd.makeRequestDto({
            "i": this._type.id,
            "f": this._scaleFactor
        });
    }

    override public function execute():void {
        new JsonCallCmd("StartConversionJob", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc5_:* = undefined;
            var _loc2_:* = UserManager.user;
            var _loc3_:* = _loc2_.gameData.resourcesConversionData;
            var _loc4_:* = param1.o != null && param1.o.p != null ? Resources.fromDto(param1.o.p) : _type.inResources;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc5_ = ResourcesConversionJob.fromDto(param1.o.j);
                _loc2_.gameData.account.resources.substract(_loc4_);
                if (_loc5_.conversionStartTime == null) {
                    ResourcesConversionManager.finishJob(_loc2_, _loc5_);
                }
                else {
                    _loc3_.currentJobs.addItem(_loc5_);
                    _loc3_.nextJobId = _loc5_.id + 1;
                }
                _loc3_.dirty = true;
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
