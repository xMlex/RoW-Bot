package model.logic.quests.data.userPrizeFilter {
public class UserPrizeFilter {


    private var _subFilters:Vector.<IUserPrizeFilter>;

    private var _property:String;

    public function UserPrizeFilter(param1:String, ...rest) {
        super();
        this._property = param1;
        this._subFilters = new Vector.<IUserPrizeFilter>();
        this.parseArguments(rest);
    }

    public function get property():String {
        return this._property;
    }

    public function apply(param1:UserPrizeFilterContext):void {
        var _loc4_:IUserPrizeFilter = null;
        var _loc2_:int = this._subFilters.length;
        var _loc3_:int = 0;
        while (_loc3_ < _loc2_) {
            _loc4_ = this._subFilters[_loc3_];
            _loc4_.apply(param1);
            _loc3_++;
        }
    }

    public function addSubFilters(...rest):UserPrizeFilter {
        this.parseArguments(rest);
        return this;
    }

    private function parseArguments(param1:Array):void {
        var _loc3_:IUserPrizeFilter = null;
        var _loc2_:int = 0;
        while (_loc2_ < param1.length) {
            _loc3_ = param1[_loc2_] as IUserPrizeFilter;
            if (this._subFilters != null) {
                this._subFilters.push(_loc3_);
            }
            _loc2_++;
        }
    }
}
}
