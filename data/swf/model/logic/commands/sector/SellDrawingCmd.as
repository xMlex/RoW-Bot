package model.logic.commands.sector {
import common.ArrayCustom;

import model.data.Resources;
import model.data.User;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.users.drawings.DrawingPart;
import model.logic.StaticDataManager;
import model.logic.UserManager;
import model.logic.UserStatsManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;

public class SellDrawingCmd extends BaseCmd {

    private static var MinSellPrice:Resources = new Resources(0, 20, 20, 20);

    private static var MaxSellPrice:Resources = new Resources(0, Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE);


    private var requestDto;

    private var _drawingParts:ArrayCustom;

    private var _sellPriceAllDrawing:Resources;

    public function SellDrawingCmd(param1:ArrayCustom, param2:Resources) {
        super();
        this._drawingParts = param1;
        this._sellPriceAllDrawing = param2;
        this.requestDto = UserRefreshCmd.makeRequestDto(DrawingPart.toDtos(this._drawingParts));
    }

    public static function getDrawingPartSellPrice(param1:User, param2:DrawingPart):Resources {
        var _loc3_:GeoSceneObjectType = StaticDataManager.getObjectType(param2.typeId);
        var _loc4_:Number = _loc3_.drawingInfo.miningPerHourSellKoeff;
        var _loc5_:Resources = Resources.scale(param1.gameData.account.miningPerHour, _loc4_);
        _loc5_.threshold2(MinSellPrice, MaxSellPrice);
        _loc5_.money = Math.min(_loc5_.uranium, _loc5_.titanite);
        return _loc5_;
    }

    override public function execute():void {
        new JsonCallCmd("SellDrawing", this.requestDto, "POST").ifResult(function (param1:*):void {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            if (!UserRefreshCmd.updateUserByResultDto(param1, requestDto)) {
                _loc2_ = UserManager.user;
                if (_drawingParts.length == 1) {
                    _loc3_ = _loc2_.gameData.drawingArchive.getDrawing(_drawingParts[0].typeId);
                    if (_loc3_ == null || _loc3_.drawingInfo.drawingParts[param1.part] == 0) {
                        return;
                    }
                    _loc3_.drawingInfo.drawingParts[_drawingParts[0].part]--;
                }
                else {
                    for each(_loc4_ in UserManager.user.gameData.drawingArchive.drawings) {
                        if (!(_loc4_ && _loc4_.drawingInfo && _loc4_.drawingInfo.partsCollected > 0 && _loc4_.objectType.drawingInfo.isBlockedForeTrade)) {
                            _loc5_ = 0;
                            while (_loc5_ < _loc4_.drawingInfo.drawingParts.length) {
                                if (_loc4_.drawingInfo.drawingParts[_loc5_] > 0) {
                                    if (_loc4_ == null || _loc4_.drawingInfo.drawingParts[_loc5_] == 0) {
                                        return;
                                    }
                                    _loc4_.drawingInfo.drawingParts[_loc5_] = 0;
                                }
                                _loc5_++;
                            }
                        }
                    }
                }
                _loc2_.gameData.account.resources.add(_sellPriceAllDrawing);
                _loc2_.gameData.drawingArchive.raiseDrawingPartsChanged();
                UserStatsManager.minedResources(_loc2_, _sellPriceAllDrawing);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
