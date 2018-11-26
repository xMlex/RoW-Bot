package model.logic.blackMarketModel.core {
import model.data.Resources;
import model.logic.blackMarketItems.AbTestData;
import model.logic.blackMarketItems.BlackMarketItemRaw;
import model.logic.blackMarketModel.interfaces.IApplyBehaviour;
import model.logic.blackMarketModel.interfaces.IBuyBehaviour;
import model.logic.blackMarketModel.interfaces.IDiscountContext;
import model.logic.blackMarketModel.services.ItemApplyService;
import model.logic.blackMarketModel.services.ItemBuyService;
import model.logic.blackMarketModel.services.interfaces.IApplyService;
import model.logic.blackMarketModel.services.interfaces.IBuyService;
import model.logic.filterSystem.dataProviders.IIDProvider;

public class BlackMarketItemBase implements IIDProvider {


    public var raw:BlackMarketItemRaw;

    public var itemType:int;

    public var name:String;

    public var fullName:String;

    public var description:String;

    public var descriptionWithoutDuration:String;

    public var helpText:String;

    public var iconUrl:String;

    public var price:Resources;

    public var newUntil:Date;

    public var discountContext:IDiscountContext;

    public var buyInBank:Boolean;

    public var saleProhibited:Boolean;

    public var isPromoPackMerchandise:Boolean;

    public var abTestData:AbTestData;

    public var groupId:int;

    protected var _id:int;

    protected var _buyService:IBuyService;

    protected var _applyService:IApplyService;

    public function BlackMarketItemBase() {
        super();
    }

    public function set id(param1:int):void {
        this._id = param1;
        this.commitId();
    }

    public function get id():int {
        return this._id;
    }

    protected function createBuyBehaviour():IBuyBehaviour {
        throw new Error("BlackMarketItemBase.createBuyBehaviour не был переопределён!");
    }

    protected function createApplyBehaviour():IApplyBehaviour {
        throw new Error("BlackMarketItemBase.createApplyBehaviour не был переопределён!");
    }

    public function getBuyService():IBuyService {
        return this._buyService;
    }

    public function getApplyService():IApplyService {
        return this._applyService;
    }

    protected function commitId():void {
        var _loc1_:IBuyBehaviour = this.createBuyBehaviour();
        var _loc2_:IApplyBehaviour = this.createApplyBehaviour();
        this._buyService = new ItemBuyService(this._id, _loc1_);
        this._applyService = new ItemApplyService(this._id, _loc2_);
    }
}
}
