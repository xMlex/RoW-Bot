package model.data.users.troops {
import common.ArrayCustom;

import gameObjects.observableObject.ObservableObject;

import model.data.normalization.INConstructible;
import model.data.scenes.objects.info.ConstructionObjInfo;
import model.data.scenes.types.GeoSceneObjectType;
import model.logic.StaticDataManager;

public class TroopsOrder extends ObservableObject implements INConstructible {

    public static const CLASS_NAME:String = "TroopsOrder";

    public static const STATUS_UPDATED:String = CLASS_NAME + "StatusUpdated";


    public var id:Number;

    public var typeId:int;

    public var totalCount:int;

    public var pendingCount:int;

    public var constructionInfo:ConstructionObjInfo;

    public var finishAll:Boolean;

    public var constructionBoost:int;

    public var boostNormalizationTime:Date;

    public var count:int = 1;

    public var dirtyNormalized:Boolean;

    public var countChange:Boolean = false;

    public function TroopsOrder(param1:Number = 0, param2:int = 0, param3:int = 0) {
        super();
        this.id = param1;
        this.typeId = param2;
        this.totalCount = param3;
        this.pendingCount = param3;
    }

    public static function fromDto(param1:*):TroopsOrder {
        var _loc2_:TroopsOrder = new TroopsOrder();
        _loc2_.id = param1.i;
        _loc2_.typeId = param1.k;
        _loc2_.totalCount = param1.t;
        _loc2_.pendingCount = param1.p;
        _loc2_.constructionInfo = param1.c == null ? null : ConstructionObjInfo.fromDto(param1.c);
        _loc2_.finishAll = param1.f;
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
        var _loc3_:TroopsOrder = null;
        var _loc2_:Array = new Array();
        for each(_loc3_ in param1) {
            _loc2_.push(_loc3_.toDto());
        }
        return _loc2_;
    }

    public function dispatchEvents():void {
        if (!this.dirtyNormalized) {
            return;
        }
        this.dirtyNormalized = false;
        dispatchEvent(STATUS_UPDATED);
    }

    public function get objectType():GeoSceneObjectType {
        return StaticDataManager.getObjectType(this.typeId);
    }

    public function get constructionObjInfo():ConstructionObjInfo {
        return this.constructionInfo;
    }

    public function set constructionObjInfo(param1:ConstructionObjInfo):void {
        this.constructionInfo = param1;
    }

    public function toDto():* {
        var _loc1_:* = {
            "i": this.id,
            "k": this.typeId,
            "t": this.totalCount,
            "p": this.pendingCount,
            "c": (this.constructionInfo == null ? null : this.constructionInfo.toDto()),
            "f": this.finishAll
        };
        return _loc1_;
    }
}
}
