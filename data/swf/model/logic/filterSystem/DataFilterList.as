package model.logic.filterSystem {
import flash.utils.Dictionary;

import model.logic.filterSystem.interfaces.IContextDataFilter;
import model.logic.filterSystem.interfaces.IDataFilter;
import model.logic.filterSystem.interfaces.IDataFilterList;
import model.logic.filterSystem.interfaces.IFilterContext;

public class DataFilterList implements IDataFilterList {


    private var _keys:Vector.<String>;

    private var _filters:Dictionary;

    private var _filtersList:Vector.<IDataFilter>;

    public function DataFilterList() {
        super();
        this._keys = new Vector.<String>();
        this._filters = new Dictionary();
        this._filtersList = new Vector.<IDataFilter>();
    }

    public function addContext(param1:IFilterContext):void {
        var _loc2_:IContextDataFilter = this._filters[param1.name] as IContextDataFilter;
        if (_loc2_ == null) {
            throw new Error("В список фильтров попал неизвестный беглец, либо вы пытались добавить контекст к несуществующему фильтру!");
        }
        _loc2_.setContext(param1);
    }

    public function addContextFilter(param1:IContextDataFilter):void {
        var _loc2_:String = param1.getContext().name;
        if (this._filters[_loc2_] == null) {
            this._keys.push(_loc2_);
        }
        this._filters[_loc2_] = param1;
    }

    public function addFilter(param1:IDataFilter):void {
        this._filtersList.push(param1);
    }

    public function filter(param1:Array):Array {
        var _loc5_:IDataFilter = null;
        var _loc2_:Array = param1;
        var _loc3_:int = 0;
        while (_loc3_ < this._keys.length) {
            _loc5_ = this._filters[this._keys[_loc3_]] as IDataFilter;
            _loc2_ = _loc5_.filter(_loc2_);
            _loc3_++;
        }
        var _loc4_:int = 0;
        while (_loc4_ < this._filtersList.length) {
            _loc2_ = this._filtersList[_loc4_].filter(_loc2_);
            _loc4_++;
        }
        return _loc2_;
    }
}
}
