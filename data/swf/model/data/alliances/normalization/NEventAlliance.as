package model.data.alliances.normalization {
import model.data.alliances.Alliance;

public class NEventAlliance implements INEventAlliance {


    private var _time:Date;

    public function NEventAlliance(param1:Date) {
        super();
        this._time = param1;
    }

    public function get time():Date {
        return this._time;
    }

    public function process(param1:Alliance, param2:Date):void {
        if (param2 > this._time) {
            this._time = param2;
        }
        this.preProcess(param1, param2);
        this.postProcess(param1, param2);
    }

    protected function preProcess(param1:Alliance, param2:Date):void {
    }

    protected function postProcess(param1:Alliance, param2:Date):void {
    }
}
}
