package model.data.ratings {
public class UserPrizeOrder {


    private var _resourcesGoldOrder:int;

    private var _resourcesBlackCrystalsOrder:int;

    private var _troopsOrder:Object;

    private var _blackMarketItemsOrder:Object;

    private var _skillPointsOrder:int;

    private var _vipPointsOrder:int;

    private var _constructionWorkersOrder:int;

    private var _dragonResourcesJadeOrder:int;

    private var _dragonResourcesRubyOrder:int;

    private var _dragonResourcesOpalOrder:int;

    public function UserPrizeOrder() {
        super();
    }

    public static function fromDto(param1:*):UserPrizeOrder {
        var _loc3_:* = undefined;
        var _loc2_:UserPrizeOrder = new UserPrizeOrder();
        _loc2_._resourcesGoldOrder = param1.rgo;
        _loc2_._resourcesBlackCrystalsOrder = param1.rbco;
        _loc2_._skillPointsOrder = param1.spo;
        _loc2_._vipPointsOrder = param1.vpo;
        _loc2_._constructionWorkersOrder = param1.cwo;
        _loc2_._dragonResourcesJadeOrder = param1.drjo;
        _loc2_._dragonResourcesRubyOrder = param1.drro;
        _loc2_._dragonResourcesOpalOrder = param1.droo;
        if (param1.to != null) {
            _loc2_._troopsOrder = new Object();
            for (_loc3_ in param1.to) {
                _loc2_._troopsOrder[_loc3_] = param1.to[_loc3_];
            }
        }
        if (param1.bio != null) {
            _loc2_._blackMarketItemsOrder = new Object();
            for (_loc3_ in param1.bio) {
                _loc2_._blackMarketItemsOrder[_loc3_] = param1.bio[_loc3_];
            }
        }
        return _loc2_;
    }

    public static function getIntersection(param1:UserPrizeOrder, param2:UserPrizeOrder):UserPrizeOrder {
        var _loc4_:* = undefined;
        if (param1 == null || param2 == null) {
            return null;
        }
        var _loc3_:UserPrizeOrder = new UserPrizeOrder();
        if (param1._resourcesGoldOrder > 0 && param2._resourcesGoldOrder > 0) {
            _loc3_._resourcesGoldOrder = param2._resourcesGoldOrder;
        }
        if (param1._resourcesBlackCrystalsOrder > 0 && param2._resourcesBlackCrystalsOrder > 0) {
            _loc3_._resourcesBlackCrystalsOrder = param2._resourcesBlackCrystalsOrder;
        }
        if (param1._skillPointsOrder > 0 && param2._skillPointsOrder > 0) {
            _loc3_._skillPointsOrder = param2._skillPointsOrder;
        }
        if (param1._vipPointsOrder > 0 && param2._vipPointsOrder > 0) {
            _loc3_._vipPointsOrder = param2._vipPointsOrder;
        }
        if (param1._constructionWorkersOrder > 0 && param2._constructionWorkersOrder > 0) {
            _loc3_._constructionWorkersOrder = param2._constructionWorkersOrder;
        }
        if (param1._dragonResourcesJadeOrder > 0 && param2._dragonResourcesJadeOrder > 0) {
            _loc3_._dragonResourcesJadeOrder = param2._dragonResourcesJadeOrder;
        }
        if (param1._dragonResourcesRubyOrder > 0 && param2._dragonResourcesRubyOrder > 0) {
            _loc3_._dragonResourcesRubyOrder = param2._dragonResourcesRubyOrder;
        }
        if (param1._dragonResourcesOpalOrder > 0 && param2._dragonResourcesOpalOrder > 0) {
            _loc3_._dragonResourcesOpalOrder = param2._dragonResourcesOpalOrder;
        }
        if (param1._troopsOrder != null && param2._troopsOrder != null) {
            _loc3_._troopsOrder = new Object();
            for (_loc4_ in param2._troopsOrder) {
                if (param2._troopsOrder[_loc4_] > 0 && param1._troopsOrder[_loc4_] != undefined && param1._troopsOrder[_loc4_] > 0) {
                    _loc3_._troopsOrder[_loc4_] = param2._troopsOrder[_loc4_];
                }
            }
        }
        if (param1._blackMarketItemsOrder != null && param2._blackMarketItemsOrder != null) {
            _loc3_._blackMarketItemsOrder = new Object();
            for (_loc4_ in param2._blackMarketItemsOrder) {
                if (param2._blackMarketItemsOrder[_loc4_] > 0 && param1._blackMarketItemsOrder[_loc4_] != undefined && param1._blackMarketItemsOrder[_loc4_] > 0) {
                    _loc3_._blackMarketItemsOrder[_loc4_] = param2._blackMarketItemsOrder[_loc4_];
                }
            }
        }
        return _loc3_;
    }

    public function get resourcesGoldOrder():int {
        return this._resourcesGoldOrder;
    }

    public function get resourcesBlackCrystalOrder():int {
        return this._resourcesBlackCrystalsOrder;
    }

    public function get troopsOrder():Object {
        return this._troopsOrder;
    }

    public function get blackMarketItemsOrder():Object {
        return this._blackMarketItemsOrder;
    }

    public function get skillPointsOrder():int {
        return this._skillPointsOrder;
    }

    public function get vipPointsOrder():int {
        return this._vipPointsOrder;
    }

    public function get constructionWorkersOrder():int {
        return this._constructionWorkersOrder;
    }

    public function get dragonResourcesJadeOrder():int {
        return this._dragonResourcesJadeOrder;
    }

    public function get dragonResourcesRubyOrder():int {
        return this._dragonResourcesRubyOrder;
    }

    public function get dragonResourcesOpalOrder():int {
        return this._dragonResourcesOpalOrder;
    }

    public function clone():UserPrizeOrder {
        var _loc2_:* = undefined;
        var _loc1_:UserPrizeOrder = new UserPrizeOrder();
        _loc1_._resourcesGoldOrder = this._resourcesGoldOrder;
        _loc1_._resourcesBlackCrystalsOrder = this._resourcesBlackCrystalsOrder;
        _loc1_._skillPointsOrder = this._skillPointsOrder;
        _loc1_._vipPointsOrder = this._vipPointsOrder;
        _loc1_._constructionWorkersOrder = this._constructionWorkersOrder;
        _loc1_._dragonResourcesJadeOrder = this._dragonResourcesJadeOrder;
        _loc1_._dragonResourcesRubyOrder = this._dragonResourcesRubyOrder;
        _loc1_._dragonResourcesOpalOrder = this._dragonResourcesOpalOrder;
        if (this._troopsOrder != null) {
            _loc1_._troopsOrder = {};
            for (_loc2_ in this._troopsOrder) {
                _loc1_._troopsOrder[_loc2_] = this._troopsOrder[_loc2_];
            }
        }
        if (this._blackMarketItemsOrder != null) {
            _loc1_._blackMarketItemsOrder = {};
            for (_loc2_ in this._blackMarketItemsOrder) {
                _loc1_._blackMarketItemsOrder[_loc2_] = this._blackMarketItemsOrder[_loc2_];
            }
        }
        return _loc1_;
    }
}
}
