package model.logic.sale {
import model.logic.sale.bonusItem.dynamicFilling.ICountFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IDescriptionFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IFullNameFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IImageFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IResourcesCountFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.ITempSkinFillingElement;
import model.logic.tournament.IActionInvoker;

public class PortalBonusItem implements IImageFillingElement, IDescriptionFillingElement, IFullNameFillingElement, ICountFillingElement, IResourcesCountFillingElement, ITempSkinFillingElement, IFillingElement {


    public var imageUrl:String;

    public var count:int;

    public var toolTipText:String;

    public var numCount:int = 1;

    public var description:String;

    public var typeId:int = 0;

    public var isCrystal:Boolean = false;

    public var actionBehaviour:IActionInvoker;

    public var points:Number;

    public var effectsCount:int;

    public function PortalBonusItem(param1:BonusItem) {
        super();
        param1.applyAll(this);
    }

    public function fillImage(param1:String):void {
        this.imageUrl = param1;
    }

    public function fillDescription(param1:String):void {
        this.description = param1;
    }

    public function fillFullName(param1:String):void {
        this.toolTipText = param1;
    }

    public function fillCount(param1:int):void {
        this.count = param1;
    }

    public function fillResourcesCount(param1:String):void {
        this.numCount = param1.indexOf("K") == -1 ? int(this.numCount = int(param1)) : int(int(param1.split("K")[0]) * 1000);
    }

    public function fillSkinPoints(param1:int):void {
        this.points = param1;
    }

    public function fillEffectsCount(param1:int):void {
        this.effectsCount = param1;
    }

    public function fillAllProperties():void {
    }
}
}
