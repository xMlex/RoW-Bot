package model.logic.commands.gameSettings {
public class PreferenceByCategory {


    public var c:int;

    public var p;

    public function PreferenceByCategory(param1:int, param2:Object = null) {
        super();
        this.c = param1;
        this.p = param2;
    }

    public function getCategory():int {
        return this.c;
    }

    public function getPreference():Object {
        return this.p;
    }
}
}
