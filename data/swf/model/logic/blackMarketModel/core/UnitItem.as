package model.logic.blackMarketModel.core {
import model.logic.blackMarketModel.applyBehaviours.StubApplyBehaviour;
import model.logic.blackMarketModel.buyBehaviours.UnitBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.interfaces.dynamicValues.IDynamicDate;
import model.logic.blackMarketModel.interfaces.temporary.ILimitedItem;
import model.logic.blackMarketModel.refreshableBehaviours.dates.ExpirableDate;
import model.logic.blackMarketModel.refreshableBehaviours.discounts.UnitDiscountContext;
import model.logic.filterSystem.dataProviders.ILevelProvider;
import model.logic.filterSystem.dataProviders.IUnitDataProvider;

public class UnitItem extends BlackMarketItemBase implements IUnitDataProvider, ILimitedItem, ILevelProvider {


    protected var _isStrategy:Boolean;

    protected var _isMutant:Boolean;

    protected var _defenceBonus:Number;

    protected var _attackBonus:int;

    protected var _intelligenceBonus:Number;

    public var requiredLevel:int;

    public var maxCount:int;

    public var minCount:int;

    public var date:IDynamicDate;

    public var startDate:IDynamicDate;

    public function UnitItem() {
        super();
        this.date = new ExpirableDate();
        this.startDate = new ExpirableDate();
    }

    public function set isStrategy(param1:Boolean):void {
        this._isStrategy = param1;
    }

    public function get isStrategy():Boolean {
        return this._isStrategy;
    }

    public function set isMutant(param1:Boolean):void {
        this._isMutant = param1;
    }

    public function get isMutant():Boolean {
        return this._isMutant;
    }

    public function set attackBonus(param1:int):void {
        this._attackBonus = param1;
    }

    public function get attackBonus():int {
        return this._attackBonus;
    }

    public function set defenceBonus(param1:Number):void {
        this._defenceBonus = param1;
    }

    public function get defenceBonus():Number {
        return this._defenceBonus;
    }

    public function set intelligenceBonus(param1:Number):void {
        this._intelligenceBonus = param1;
    }

    public function get intelligenceBonus():Number {
        return this._intelligenceBonus;
    }

    public function get saleEndDate():IDynamicDate {
        return this.date;
    }

    public function set saleEndDate(param1:IDynamicDate):void {
        this.date = param1;
    }

    public function get saleStartDate():IDynamicDate {
        return this.startDate;
    }

    public function set saleStartDate(param1:IDynamicDate):void {
        this.startDate = param1;
    }

    public function get level():int {
        return this.requiredLevel;
    }

    override protected function createBuyBehaviour():IBuyBehaviour {
        return new UnitBuyBehaviour();
    }

    override protected function createApplyBehaviour():IApplyBehaviour {
        return new StubApplyBehaviour();
    }

    override protected function commitId():void {
        super.commitId();
        discountContext = new UnitDiscountContext(_id);
    }
}
}
