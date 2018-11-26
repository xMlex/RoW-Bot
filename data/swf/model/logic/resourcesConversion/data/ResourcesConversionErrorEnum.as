package model.logic.resourcesConversion.data {
public class ResourcesConversionErrorEnum {

    public static var OK:int = 0;

    public static var MAX_LIMIT:int = 1;

    public static var NOT_ENOUGH_RESOURCES:int = 2;


    public function ResourcesConversionErrorEnum() {
        super();
        throw new Error("Class is static!");
    }
}
}
