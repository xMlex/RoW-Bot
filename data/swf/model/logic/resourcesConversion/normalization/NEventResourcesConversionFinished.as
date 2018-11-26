package model.logic.resourcesConversion.normalization {
import model.data.User;
import model.data.normalization.NEventUser;
import model.logic.resourcesConversion.ResourcesConversionManager;
import model.logic.resourcesConversion.data.ResourcesConversionJob;

public class NEventResourcesConversionFinished extends NEventUser {


    private var _job:ResourcesConversionJob;

    public function NEventResourcesConversionFinished(param1:ResourcesConversionJob, param2:Date) {
        super(param2);
        this._job = param1;
    }

    override protected function postProcess(param1:User, param2:Date):void {
        ResourcesConversionManager.finishJob(param1, this._job);
    }
}
}
