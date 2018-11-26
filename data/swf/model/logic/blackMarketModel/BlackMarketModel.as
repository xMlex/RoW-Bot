package model.logic.blackMarketModel {
import flash.utils.Dictionary;

import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.builders.util.BuilderFactory;
import model.logic.blackMarketModel.core.BlackMarketItemBase;
import model.logic.blackMarketModel.interfaces.IBlackMarketItemBuilder;
import model.logic.blackMarketModel.interfaces.IBlackMarketModel;
import model.logic.blackMarketModel.interfaces.IBlackMarketTypeResolver;
import model.logic.blackMarketModel.interfaces.IRawItemsProvider;

public class BlackMarketModel implements IBlackMarketModel {


    private var _initialized:Boolean;

    private var _builder:IBlackMarketItemBuilder;

    private var _resolver:IBlackMarketTypeResolver;

    private var _dataProvider:IRawItemsProvider;

    private var _itemType:int;

    private var _data:Vector.<BlackMarketItemBase>;

    private var _dataByType:Dictionary;

    public function BlackMarketModel(param1:IRawItemsProvider) {
        super();
        this._itemType = -1;
        this._data = new Vector.<BlackMarketItemBase>();
        this._resolver = new ItemTypeResolver();
        this._dataProvider = param1;
    }

    public function initialize():void {
        var _loc3_:BlackMarketItemRaw = null;
        var _loc4_:BlackMarketItemBase = null;
        var _loc5_:int = 0;
        if (this._initialized) {
            return;
        }
        this._dataByType = new Dictionary();
        this._data = new Vector.<BlackMarketItemBase>();
        var _loc1_:Array = this._dataProvider.getRawItems();
        var _loc2_:int = _loc1_.length;
        var _loc6_:int = 0;
        while (_loc6_ < _loc2_) {
            _loc3_ = _loc1_[_loc6_] as BlackMarketItemRaw;
            _loc5_ = this._resolver.resolve(_loc3_);
            if (_loc5_ != -1) {
                if (this._itemType != _loc5_) {
                    this._builder = BuilderFactory.getBuilder(_loc5_);
                    this._itemType = _loc5_;
                }
                if (this._dataByType[this._itemType] == null) {
                    this._dataByType[this._itemType] = new Vector.<BlackMarketItemBase>();
                }
                _loc4_ = this._builder.build(_loc3_);
                if (_loc4_ != null) {
                    (this._dataByType[this._itemType] as Vector.<BlackMarketItemBase>).push(_loc4_);
                    this._data.push(_loc4_);
                }
            }
            _loc6_++;
        }
        this._initialized = true;
    }

    public function getItems():Vector.<BlackMarketItemBase> {
        if (!this._initialized) {
            throw new Error("Модель BlackMarketModel не была инициализирована до вызова getItems().");
        }
        return this._data;
    }

    public function getItemsByType(param1:int):Vector.<BlackMarketItemBase> {
        if (!this._initialized) {
            throw new Error("Модель BlackMarketModel не была инициализирована до вызова getItemsByType().");
        }
        return this._dataByType[param1] != null ? this._dataByType[param1] : new Vector.<BlackMarketItemBase>(0);
    }
}
}
