package model.data.normalization {
import model.data.scenes.objects.info.ConstructionObjInfo;
import model.data.scenes.types.GeoSceneObjectType;

public interface INConstructible {


    function get objectType():GeoSceneObjectType;

    function get constructionObjInfo():ConstructionObjInfo;

    function set constructionObjInfo(param1:ConstructionObjInfo):void;
}
}
