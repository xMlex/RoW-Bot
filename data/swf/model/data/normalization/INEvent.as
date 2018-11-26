package model.data.normalization {
import model.data.User;

public interface INEvent {


    function get time():Date;

    function process(param1:User, param2:Date):void;
}
}
