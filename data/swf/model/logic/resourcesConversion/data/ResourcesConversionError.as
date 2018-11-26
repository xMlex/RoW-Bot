package model.logic.resourcesConversion.data {
import model.data.Resources;

public class ResourcesConversionError {


    public var code:int;

    public var resources:Resources;

    public function ResourcesConversionError(param1:int, param2:Resources = null) {
        super();
        this.code = param1;
        this.resources = param2;
    }
}
}
