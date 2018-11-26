package model.logic.building {
public class RequiredObjectsService {

    private static var _updateRequiredObjectsFunction:Function;


    public function RequiredObjectsService() {
        super();
    }

    public static function updateRequiredObjects():void {
        if (_updateRequiredObjectsFunction != null) {
            _updateRequiredObjectsFunction();
        }
    }

    public static function set updateRequiredObjectsFunction(param1:Function):void {
        _updateRequiredObjectsFunction = param1;
    }
}
}
