package model.logic.commands.sector {
import model.data.SpecialOffer;
import model.data.User;
import model.data.scenes.objects.GeoSceneObject;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.users.drawings.DrawingPart;
import model.data.users.troops.Troops;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.UserStatsManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class BuySpecialOfferCmd extends BaseCmd {


    private var requestDto;

    private var _offerIndex:int;

    private var _building:GeoSceneObject;

    public function BuySpecialOfferCmd(param1:int, param2:int = -1, param3:int = -1, param4:GeoSceneObject = null) {
        super();
        this._offerIndex = param1;
        var _loc5_:Object = {"i": param1};
        if (param2 != -1 && param3 != -1) {
            _loc5_.x = param2;
            _loc5_.y = param3;
        }
        this._building = param4;
        this.requestDto = UserRefreshCmd.makeRequestDto(_loc5_);
    }

    private static function BuyBuildingOffer(param1:User, param2:GeoSceneObject, param3:Number):void {
        param2.id = param3;
        param2.constructionInfo.level = 1;
        param2.constructionInfo.constructionStartTime = null;
        param2.constructionInfo.constructionFinishTime = null;
    }

    private static function BuyTroopsOffer(param1:User, param2:SpecialOffer):void {
        var _loc3_:Troops = new Troops();
        _loc3_.countByType[param2.typeId] = param2.number;
        param1.gameData.troopsData.troops.addTroops(_loc3_);
        UserStatsManager.troopsBuilt(param1, _loc3_);
    }

    private static function BuyDrawingOffer(param1:User, param2:SpecialOffer, param3:GeoSceneObjectType):void {
        var _loc4_:DrawingPart = new DrawingPart();
        _loc4_.typeId = param2.typeId;
        _loc4_.part = param2.number;
        param1.gameData.drawingArchive.addDrawingPart(_loc4_);
    }

    override public function execute():void {
        new JsonCallCmd("BuySpecialOffer", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc4_:* = undefined;
            var _loc2_:* = UserManager.user;
            var _loc3_:* = _loc2_.gameData.commonData.specialOffers[_offerIndex];
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc4_ = StaticDataManager.getObjectType(_loc3_.typeId);
                if (_loc4_.buildingInfo != null) {
                    BuyBuildingOffer(_loc2_, _building, param1.o.i);
                }
                else if (_loc4_.troopsInfo != null) {
                    BuyTroopsOffer(_loc2_, _loc3_);
                }
                else if (_loc4_.drawingInfo != null) {
                    BuyDrawingOffer(_loc2_, _loc3_, _loc4_);
                }
                _loc2_.gameData.account.resources.substract(_loc3_.price);
                _loc3_.buyDate = new Date(param1.o.d);
                UserStatsManager.boughtSpecialOffer(_loc2_, _loc3_.copy());
                _loc2_.gameData.commonData.specialOffersDirty = true;
                UserManager.user.gameData.updateObjectsBuyStatus(true);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
