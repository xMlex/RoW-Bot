package model.logic.dtoSerializer {
import flash.utils.Dictionary;

public class DtoDeserializer {


    public function DtoDeserializer() {
        super();
    }

    public static function toArray(param1:*, param2:Function = null):Array {
        if (param1 == null) {
            return null;
        }
        return new ArrayDeserializer(param1, param2).deserialize();
    }

    public static function toObject(param1:*, param2:Function = null):Object {
        if (param1 == null) {
            return null;
        }
        return new ObjectDeserializer(param1, param2).deserialize();
    }

    public static function toDictionary(param1:*, param2:Function = null, param3:Function = null):Dictionary {
        if (param1 == null) {
            return null;
        }
        return new DictionaryDeserializer(param1, param2, param3).deserialize();
    }
}
}
