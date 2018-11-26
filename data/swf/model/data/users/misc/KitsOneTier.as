package model.data.users.misc {
public class KitsOneTier {


    public var elementArray:Array;

    public var tier:int;

    public function KitsOneTier() {
        this.elementArray = new Array();
        super();
    }

    public function get locked():Boolean {
        return false;
    }
}
}
