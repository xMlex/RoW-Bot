package model.data.alliances.normalization {
import model.data.alliances.Alliance;

public interface INEventAlliance {


    function get time():Date;

    function process(param1:Alliance, param2:Date):void;
}
}
