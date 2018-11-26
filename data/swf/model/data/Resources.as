package model.data {
import common.ArrayCustom;
import common.localization.LocaleUtil;

public class Resources {

    public static const Zero:Resources = new Resources();

    public static const MaxValue:Resources = new Resources(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE);

    public static const GOLD_MONEY:String = "Resources_Gold_Money";

    public static const MONEY:String = "Resources_Money";

    public static const URANIUM:String = "Resources_Uranium";

    public static const TITANITE:String = "Resources_Titanite";

    public static const BIOCHIPS:String = "Resources_Biochips";

    public static const BLACKCRYSTALS:String = "Resources_BlackCrystals";

    public static const AVPMONEY:String = "Resources_AvpMoney";

    public static const CONSTRICTIONITEMS:String = "Resources_ConstructionItems";


    public var goldMoney:Number;

    public var money:Number;

    public var uranium:Number;

    public var titanite:Number;

    public var biochips:Number;

    public var blackCrystals:Number;

    public var avpMoney:Number;

    public var constructionItems:Number;

    public var upgradeItems:UpgradeItems;

    public var idols:Number;

    public function Resources(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:Number = 0, param8:Number = 0, param9:Number = 0) {
        super();
        this.goldMoney = param1;
        this.money = param2;
        this.uranium = param3;
        this.titanite = param4;
        this.biochips = param5;
        this.blackCrystals = param6;
        this.avpMoney = param8;
        this.constructionItems = param9;
        this.idols = param7;
    }

    public static function fromDtosArray(param1:*):Array {
        var _loc3_:* = undefined;
        var _loc2_:Array = [];
        for each(_loc3_ in param1) {
            _loc2_.push(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function fromGoldMoney(param1:Number):Resources {
        return new Resources(param1, 0, 0, 0);
    }

    public static function fromMoney(param1:Number):Resources {
        return new Resources(0, param1, 0, 0);
    }

    public static function fromUranium(param1:Number):Resources {
        return new Resources(0, 0, param1, 0);
    }

    public static function fromTitanite(param1:Number):Resources {
        return new Resources(0, 0, 0, param1);
    }

    public static function fromBiochips(param1:Number):Resources {
        return new Resources(0, 0, 0, 0, param1);
    }

    public static function fromBlackCrystals(param1:Number):Resources {
        return new Resources(0, 0, 0, 0, 0, param1);
    }

    public static function fromAvpMoney(param1:Number):Resources {
        return new Resources(0, 0, 0, 0, 0, 0, 0, param1);
    }

    public static function fromConstructionItems(param1:Number):Resources {
        return new Resources(0, 0, 0, 0, 0, 0, 0, 0, param1);
    }

    public static function fromType(param1:int, param2:Number):Resources {
        switch (param1) {
            case ResourceTypeId.GOLD_MONEY:
                return fromGoldMoney(param2);
            case ResourceTypeId.MONEY:
                return fromMoney(param2);
            case ResourceTypeId.URANIUM:
                return fromUranium(param2);
            case ResourceTypeId.TITANITE:
                return fromTitanite(param2);
            case ResourceTypeId.BIOCHIPS:
                return fromBiochips(param2);
            case ResourceTypeId.BLACK_CRYSTALS:
                return fromBlackCrystals(param2);
            case ResourceTypeId.AVP_MONEY:
                return fromAvpMoney(param2);
            case ResourceTypeId.CONSTRUCTION_ITEMS:
                return fromConstructionItems(param2);
            default:
                throw new Error("typeId");
        }
    }

    public static function FromTUM(param1:Number, param2:Number, param3:Number):Resources {
        return new Resources(0, param3, param2, param1);
    }

    public static function accelerate(param1:Resources, param2:Resources):Resources {
        param1 = param1.clone();
        param1.accelerate(param2);
        return param1;
    }

    public static function scale(param1:Resources, param2:Number):Resources {
        param1 = param1.clone();
        param1.scale(param2);
        return param1;
    }

    public static function fromDto(param1:*):Resources {
        if (param1 == null) {
            return null;
        }
        var _loc2_:Resources = new Resources();
        _loc2_.goldMoney = param1.g;
        _loc2_.money = param1.m;
        _loc2_.uranium = param1.u;
        _loc2_.titanite = param1.t;
        _loc2_.biochips = param1.c != null ? Number(param1.c) : Number(0);
        _loc2_.blackCrystals = param1.b != null ? Number(param1.b) : Number(0);
        _loc2_.avpMoney = param1.a != null ? Number(param1.a) : Number(0);
        _loc2_.constructionItems = param1.i != null ? Number(param1.i) : Number(0);
        return _loc2_;
    }

    public static function fromDtos(param1:*):ArrayCustom {
        var _loc3_:* = undefined;
        var _loc2_:ArrayCustom = new ArrayCustom();
        for each(_loc3_ in param1) {
            _loc2_.addItem(fromDto(_loc3_));
        }
        return _loc2_;
    }

    public static function toDtos(param1:ArrayCustom):Array {
        var _loc3_:Resources = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public static function getIntersection(param1:Resources, param2:Resources):Resources {
        if (param1 == null || param2 == null) {
            return null;
        }
        var _loc3_:Resources = new Resources();
        if (param1.goldMoney > 0 && param2.goldMoney > 0) {
            _loc3_.goldMoney = param2.goldMoney;
        }
        if (param1.money > 0 && param2.money > 0) {
            _loc3_.money = param2.money;
        }
        if (param1.uranium > 0 && param2.uranium > 0) {
            _loc3_.uranium = param2.uranium;
        }
        if (param1.titanite > 0 && param2.titanite > 0) {
            _loc3_.titanite = param2.titanite;
        }
        if (param1.biochips > 0 && param2.biochips > 0) {
            _loc3_.biochips = param2.biochips;
        }
        if (param1.blackCrystals > 0 && param2.blackCrystals > 0) {
            _loc3_.blackCrystals = param2.blackCrystals;
        }
        if (param1.idols > 0 && param2.idols > 0) {
            _loc3_.idols = param2.idols;
        }
        if (param1.avpMoney > 0 && param2.avpMoney > 0) {
            _loc3_.avpMoney = param2.avpMoney;
        }
        if (param1.constructionItems > 0 && param2.constructionItems > 0) {
            _loc3_.constructionItems = param2.constructionItems;
        }
        return _loc3_;
    }

    public function get isEmpty():Boolean {
        return this.equals(Zero);
    }

    public function get isOnlyGold():Boolean {
        return this.money == 0 && this.uranium == 0 && this.titanite == 0 && this.biochips == 0 && this.goldMoney != 0 && this.blackCrystals == 0 && this.avpMoney == 0;
    }

    public function get isOnlyCredits():Boolean {
        return this.money != 0 && this.uranium == 0 && this.titanite == 0 && this.biochips == 0 && this.goldMoney == 0 && this.blackCrystals == 0 && this.avpMoney == 0;
    }

    public function get isOnlyTitanium():Boolean {
        return this.money == 0 && this.uranium == 0 && this.titanite != 0 && this.biochips == 0 && this.goldMoney == 0 && this.blackCrystals == 0 && this.avpMoney == 0;
    }

    public function get isOnlyUranium():Boolean {
        return this.money == 0 && this.uranium != 0 && this.titanite == 0 && this.biochips == 0 && this.goldMoney == 0 && this.blackCrystals == 0 && this.avpMoney == 0;
    }

    public function get isOnlyBlackCrystals():Boolean {
        return this.money == 0 && this.uranium == 0 && this.titanite == 0 && this.biochips == 0 && this.goldMoney == 0 && this.blackCrystals != 0 && this.avpMoney == 0;
    }

    public function get isOnlyAvpMoney():Boolean {
        return this.money == 0 && this.uranium == 0 && this.titanite == 0 && this.biochips == 0 && this.goldMoney == 0 && this.blackCrystals == 0 && this.avpMoney != 0;
    }

    public function get isMUT():Boolean {
        return this.money != 0 && this.uranium != 0 && this.titanite != 0 && this.biochips == 0 && this.goldMoney == 0 && this.blackCrystals == 0;
    }

    public function clone():Resources {
        return new Resources(this.goldMoney, this.money, this.uranium, this.titanite, this.biochips, this.blackCrystals, this.idols, this.avpMoney, this.constructionItems);
    }

    public function getByType(param1:int):Number {
        switch (param1) {
            case ResourceTypeId.MONEY:
                return this.money;
            case ResourceTypeId.URANIUM:
                return this.uranium;
            case ResourceTypeId.TITANITE:
                return this.titanite;
            case ResourceTypeId.GOLD_MONEY:
                return this.goldMoney;
            case ResourceTypeId.BIOCHIPS:
                return this.biochips;
            case ResourceTypeId.BLACK_CRYSTALS:
                return this.blackCrystals;
            case ResourceTypeId.AVP_MONEY:
                return this.avpMoney;
            case ResourceTypeId.CONSTRUCTION_ITEMS:
                return this.constructionItems;
            default:
                throw new Error("Resources - Invalid ResourceTypeId");
        }
    }

    public function getAny():Number {
        if (this.money > 0) {
            return this.money;
        }
        if (this.uranium > 0) {
            return this.uranium;
        }
        if (this.titanite > 0) {
            return this.titanite;
        }
        if (this.goldMoney > 0) {
            return this.goldMoney;
        }
        if (this.biochips > 0) {
            return this.biochips;
        }
        if (this.blackCrystals > 0) {
            return this.blackCrystals;
        }
        if (this.avpMoney > 0) {
            return this.avpMoney;
        }
        if (this.constructionItems > 0) {
            return this.constructionItems;
        }
        return 0;
    }

    public function toString():String {
        return "{g:" + this.goldMoney + ",m:" + this.money + ",u:" + this.uranium + ",t:" + this.titanite + ",c:" + this.biochips + ",b:" + this.blackCrystals + ",a:" + this.avpMoney + ",i:" + this.constructionItems + "}";
    }

    public function toUserFriendlyString(param1:Boolean):String {
        var _loc2_:* = "";
        if (param1 && this.goldMoney > 0 || !param1) {
            _loc2_ = _loc2_ + this.goldMoney.toFixed(0) + " " + LocaleUtil.getText("model-data-resources-goldMoney");
        }
        if (param1 && this.money > 0 || !param1) {
            if (_loc2_ != "") {
                _loc2_ = _loc2_ + ",  ";
            }
            _loc2_ = _loc2_ + this.money.toFixed(0) + " " + LocaleUtil.getText("model-data-resources-money");
        }
        if (param1 && this.uranium > 0 || !param1) {
            if (_loc2_ != "") {
                _loc2_ = _loc2_ + ", ";
            }
            _loc2_ = _loc2_ + this.uranium.toFixed(0) + " " + LocaleUtil.getText("model-data-resources-uranium");
        }
        if (param1 && this.titanite > 0 || !param1) {
            if (_loc2_ != "") {
                _loc2_ = _loc2_ + ",  ";
            }
            _loc2_ = _loc2_ + this.titanite.toFixed(0) + " " + LocaleUtil.getText("model-data-resources-titanium");
        }
        if (param1 && this.biochips > 0 || !param1) {
            if (_loc2_ != "") {
                _loc2_ = _loc2_ + ",  ";
            }
            _loc2_ = _loc2_ + this.biochips.toFixed(0) + " " + LocaleUtil.getText("model-data-resources-biochips");
        }
        if (param1 && this.blackCrystals > 0 || !param1) {
            if (_loc2_ != "") {
                _loc2_ = _loc2_ + ",  ";
            }
            _loc2_ = _loc2_ + this.blackCrystals.toFixed(0) + " " + LocaleUtil.getText("model-data-resources-blackcrystals");
        }
        if (param1 && this.avpMoney > 0 || !param1) {
            if (_loc2_ != "") {
                _loc2_ = _loc2_ + ",  ";
            }
            _loc2_ = _loc2_ + this.avpMoney.toFixed(0) + " " + LocaleUtil.getText("model-data-resources-avpmoney");
        }
        if (param1 && this.constructionItems > 0 || !param1) {
            if (_loc2_ != "") {
                _loc2_ = _loc2_ + ",  ";
            }
            _loc2_ = _loc2_ + this.constructionItems.toFixed(0) + " " + LocaleUtil.getText("model-data-resources-constructionitems");
        }
        return _loc2_;
    }

    public function getVal(param1:String):Number {
        var _loc2_:Number = NaN;
        switch (param1) {
            case GOLD_MONEY:
                _loc2_ = this.goldMoney;
                break;
            case MONEY:
                _loc2_ = this.money;
                break;
            case URANIUM:
                _loc2_ = this.uranium;
                break;
            case TITANITE:
                _loc2_ = this.titanite;
                break;
            case BIOCHIPS:
                _loc2_ = this.biochips;
                break;
            case BLACKCRYSTALS:
                _loc2_ = this.blackCrystals;
                break;
            case AVPMONEY:
                _loc2_ = this.avpMoney;
                break;
            case CONSTRICTIONITEMS:
                _loc2_ = this.constructionItems;
                break;
            default:
                _loc2_ = 0;
        }
        return _loc2_;
    }

    public function equals(param1:Resources):Boolean {
        return param1.goldMoney == this.goldMoney && param1.money == this.money && param1.uranium == this.uranium && param1.titanite == this.titanite && param1.biochips == this.biochips && param1.blackCrystals == this.blackCrystals && param1.idols == this.idols && param1.avpMoney == this.avpMoney && param1.constructionItems == this.constructionItems;
    }

    public function greaterOrEquals(param1:Resources):Boolean {
        return this.goldMoney >= param1.goldMoney && this.money >= param1.money && this.uranium >= param1.uranium && this.titanite >= param1.titanite && this.biochips >= param1.biochips && this.blackCrystals >= param1.blackCrystals && this.avpMoney >= param1.avpMoney && this.constructionItems >= param1.constructionItems;
    }

    public function canSubstract(param1:Resources):Boolean {
        return (param1.goldMoney == 0 || this.goldMoney >= param1.goldMoney) && (param1.uranium == 0 || this.uranium >= param1.uranium) && (param1.titanite == 0 || this.titanite >= param1.titanite) && (param1.money == 0 || this.money >= param1.money) && (param1.biochips == 0 || this.biochips > param1.biochips) && (param1.blackCrystals == 0 || this.blackCrystals > param1.blackCrystals) && (param1.avpMoney == 0 || this.avpMoney >= param1.avpMoney) && (param1.constructionItems == 0 || this.constructionItems >= param1.constructionItems);
    }

    public function add(param1:Resources):void {
        this.change(param1, 1);
    }

    public function substract(param1:Resources):void {
        this.change(param1, -1);
    }

    private function change(param1:Resources, param2:int):void {
        this.goldMoney = this.goldMoney + param2 * param1.goldMoney;
        this.money = this.money + param2 * param1.money;
        this.uranium = this.uranium + param2 * param1.uranium;
        this.titanite = this.titanite + param2 * param1.titanite;
        this.biochips = this.biochips + param2 * param1.biochips;
        this.blackCrystals = this.blackCrystals + param2 * param1.blackCrystals;
        this.avpMoney = this.avpMoney + param2 * param1.avpMoney;
        this.constructionItems = this.constructionItems + param2 * param1.constructionItems;
    }

    public function sumResources(param1:Resources):Resources {
        var _loc2_:Resources = this.clone();
        _loc2_.goldMoney = _loc2_.goldMoney + param1.goldMoney;
        _loc2_.money = _loc2_.money + param1.money;
        _loc2_.uranium = _loc2_.uranium + param1.uranium;
        _loc2_.titanite = _loc2_.titanite + param1.titanite;
        _loc2_.biochips = _loc2_.biochips + param1.biochips;
        _loc2_.blackCrystals = _loc2_.blackCrystals + param1.blackCrystals;
        _loc2_.avpMoney = _loc2_.avpMoney + param1.avpMoney;
        _loc2_.constructionItems = _loc2_.constructionItems + param1.constructionItems;
        return _loc2_;
    }

    public function accelerate(param1:Resources):void {
        if (param1) {
            if (this.goldMoney > 0) {
                this.goldMoney = this.goldMoney * param1.goldMoney;
            }
            if (this.money > 0) {
                this.money = this.money * param1.money;
            }
            if (this.uranium > 0) {
                this.uranium = this.uranium * param1.uranium;
            }
            if (this.titanite > 0) {
                this.titanite = this.titanite * param1.titanite;
            }
            if (this.biochips > 0) {
                this.biochips = this.biochips * param1.biochips;
            }
            if (this.blackCrystals > 0) {
                this.blackCrystals = this.blackCrystals * param1.blackCrystals;
            }
            if (this.avpMoney > 0) {
                this.avpMoney = this.avpMoney * param1.avpMoney;
            }
            if (this.constructionItems > 0) {
                this.constructionItems = this.constructionItems * param1.constructionItems;
            }
        }
    }

    public function scale(param1:Number):void {
        this.goldMoney = this.goldMoney * param1;
        this.money = this.money * param1;
        this.uranium = this.uranium * param1;
        this.titanite = this.titanite * param1;
        this.biochips = this.biochips * param1;
        this.blackCrystals = this.blackCrystals * param1;
        this.avpMoney = this.avpMoney * param1;
        this.constructionItems = this.constructionItems * param1;
    }

    public function threshold(param1:Resources):void {
        this.goldMoney = Math.min(this.goldMoney, param1.goldMoney);
        this.money = Math.min(this.money, param1.money);
        this.uranium = Math.min(this.uranium, param1.uranium);
        this.titanite = Math.min(this.titanite, param1.titanite);
        this.biochips = Math.min(this.biochips, param1.biochips);
        this.blackCrystals = Math.min(this.blackCrystals, param1.blackCrystals);
        this.avpMoney = Math.min(this.avpMoney, param1.avpMoney);
        this.constructionItems = Math.min(this.constructionItems, param1.constructionItems);
    }

    public function threshold2(param1:Resources, param2:Resources):void {
        this.goldMoney = Math.max(param1.goldMoney, Math.min(this.goldMoney, param2.goldMoney));
        this.money = Math.max(param1.money, Math.min(this.money, param2.money));
        this.uranium = Math.max(param1.uranium, Math.min(this.uranium, param2.uranium));
        this.titanite = Math.max(param1.titanite, Math.min(this.titanite, param2.titanite));
        this.biochips = Math.max(param1.biochips, Math.min(this.biochips, param2.biochips));
        this.blackCrystals = Math.max(param1.blackCrystals, Math.min(this.blackCrystals, param2.blackCrystals));
    }

    public function leadToPositive():void {
        this.goldMoney = Math.max(this.goldMoney, 0);
        this.money = Math.max(this.money, 0);
        this.uranium = Math.max(this.uranium, 0);
        this.titanite = Math.max(this.titanite, 0);
        this.biochips = Math.max(this.biochips, 0);
        this.blackCrystals = Math.max(this.blackCrystals, 0);
    }

    public function roundAll():Resources {
        this.goldMoney = Math.round(this.goldMoney);
        this.money = Math.round(this.money);
        this.uranium = Math.round(this.uranium);
        this.titanite = Math.round(this.titanite);
        this.biochips = Math.round(this.biochips);
        this.blackCrystals = Math.round(this.blackCrystals);
        this.avpMoney = Math.round(this.avpMoney);
        this.constructionItems = Math.round(this.constructionItems);
        return this;
    }

    public function capacity():Number {
        return this.goldMoney + this.money + this.uranium + this.titanite + this.biochips + this.blackCrystals + this.avpMoney + this.constructionItems;
    }

    public function isNegative():Boolean {
        return this.goldMoney < 0 || this.money < 0 || this.uranium < 0 || this.titanite < 0 || this.biochips < 0 || this.blackCrystals < 0 || this.avpMoney < 0 || this.constructionItems < 0;
    }

    public function clear():void {
        this.goldMoney = 0;
        this.money = 0;
        this.uranium = 0;
        this.titanite = 0;
        this.biochips = 0;
        this.blackCrystals = 0;
        this.idols = 0;
        this.avpMoney = 0;
        this.constructionItems = 0;
    }

    public function toDto():* {
        if (this == null) {
            return null;
        }
        var _loc1_:* = {
            "g": this.goldMoney,
            "m": this.money,
            "u": this.uranium,
            "t": this.titanite,
            "c": this.biochips,
            "b": this.blackCrystals,
            "a": this.avpMoney,
            "i": this.constructionItems
        };
        return _loc1_;
    }
}
}
