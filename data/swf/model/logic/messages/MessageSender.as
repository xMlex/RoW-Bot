package model.logic.messages {
import common.GameType;

import configs.Global;

import model.data.User;
import model.data.tournaments.TournamentStatistics;
import model.data.units.Unit;
import model.data.users.messages.Message;
import model.data.users.messages.MessageTypeId;
import model.logic.MessageManager;
import model.logic.UserManager;

public class MessageSender {


    public function MessageSender() {
        super();
    }

    public static function TradingPayloadArrived(param1:User, param2:Unit):void {
        var _loc3_:Message = null;
        var _loc4_:Message = null;
        if (param2.tradingPayload.resources != null) {
            _loc3_ = NewMessage2(MessageTypeId.ResourcesArrived, param2.StateMovingForward.arrivalTime, param2.OwnerUserId, param2.TargetUserId);
            _loc3_.resources = param2.tradingPayload.resources;
            _loc3_.unitId = param2.UnitId;
            MessageManager.add(param1, _loc3_);
        }
        if (param2.tradingPayload.drawingPart != null) {
            _loc4_ = NewMessage2(MessageTypeId.DrawingPartArrived, param2.StateMovingForward.arrivalTime, param2.OwnerUserId, param2.TargetUserId);
            _loc4_.drawingPart = param2.tradingPayload.drawingPart;
            MessageManager.add(param1, _loc4_);
        }
    }

    public static function DynamicMineResourcesArrived(param1:User, param2:Unit, param3:TournamentStatistics):void {
        var _loc7_:Array = null;
        var _loc8_:Message = null;
        var _loc9_:Message = null;
        var _loc4_:int = param2.troopsPayload.troops != null ? int(MessageTypeId.DynamicMineResourcesArrived) : int(MessageTypeId.ResourcesArrived);
        var _loc5_:Boolean = false;
        var _loc6_:Number = _loc4_ == MessageTypeId.DynamicMineResourcesArrived ? Number(-param2.TargetLocationId) : Number(param2.TargetLocationId);
        if (param2.troopsPayload.troops) {
            if (Global.EXTERNAL_MASSAGES_ENABLED) {
                _loc7_ = !!GameType.isNords ? UserManager.user.gameData.messageData.knownDiplomaticMessages : UserManager.user.gameData.messageData.knownTradeMessages;
            }
            else {
                _loc7_ = UserManager.user.gameData.messageData.messages;
            }
            for each(_loc8_ in _loc7_) {
                if (_loc8_.unitId == param2.UnitId && _loc8_.userIdTo == param2.OwnerUserId && _loc8_.userIdFrom == _loc6_) {
                    _loc5_ = true;
                    break;
                }
            }
        }
        if (!_loc5_) {
            _loc9_ = NewMessage2(_loc4_, param2.StateMovingBack.arrivalTime, _loc6_, param2.OwnerUserId);
            _loc9_.resources = param2.troopsPayload.resources;
            _loc9_.unitId = param2.UnitId;
            if (param2.troopsPayload.troops != null) {
                _loc9_.troops = param2.troopsPayload.troops;
            }
            if (param3 != null) {
                _loc9_.statisticsByTournament = [];
                _loc9_.statisticsByTournament[0] = param3;
            }
            MessageManager.add(param1, _loc9_);
        }
    }

    public static function TechnologyResearched(param1:User, param2:Date, param3:int, param4:int):void {
        var _loc5_:Message = NewMessage(MessageTypeId.TechnologyResearched, param2);
        _loc5_.technologyId = param3;
        _loc5_.technologyLevel = param4;
        MessageManager.add(param1, _loc5_);
    }

    private static function NewMessage(param1:int, param2:Date):Message {
        var _loc3_:Message = new Message();
        _loc3_.typeId = param1;
        _loc3_.time = param2;
        _loc3_.addedByClient = true;
        return _loc3_;
    }

    private static function NewMessage2(param1:int, param2:Date, param3:Number, param4:Number):Message {
        var _loc5_:Message = new Message();
        _loc5_.typeId = param1;
        _loc5_.time = param2;
        _loc5_.addedByClient = true;
        _loc5_.userIdFrom = param3;
        _loc5_.userIdTo = param4;
        return _loc5_;
    }
}
}
