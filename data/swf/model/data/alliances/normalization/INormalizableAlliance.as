package model.data.alliances.normalization {
import model.data.alliances.Alliance;

public interface INormalizableAlliance {


    function getNextEvent(param1:Alliance, param2:Date):INEventAlliance;
}
}
