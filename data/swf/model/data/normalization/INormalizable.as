package model.data.normalization {
import model.data.User;

public interface INormalizable {


    function getNextEvent(param1:User, param2:Date):INEvent;
}
}
