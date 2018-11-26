package ru.xmlex.row.game.logic.units;

import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.data.units.MapObjectTypeId;
import ru.xmlex.row.game.data.units.Unit;
import ru.xmlex.row.game.data.users.troops.TroopsOrderId;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 05.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UnitUtility {
    public UnitSettings settings;

    //
//    public static void init(String[] param1) {
//        String _loc3_ = null;
//        for (String _loc2_ : param1) {
//            if (_loc2_.indexOf("us:") >= 0) {
//                _loc3_ = _loc2_.substr(_loc2_.indexOf(":") + 1);
//                settings = model.logic.units.UnitSettings.fromDto(JSONOur.decode(_loc3_));
//                return;
//            }
//        }
//        settings = new UnitSettings();
//    }
//
    public static void AddUnit(User param1, Unit param2) {
        param1.gameData.worldData.units.add(param2);
        param1.gameData.worldData.dirtyUnitListChanged = true;
    }

    //
    public static void RemoveUnit(User param1, Unit param2) {
        param1.gameData.worldData.units.remove(param2);
        param1.gameData.worldData.dirtyUnitListChanged = true;
    }

    //
    public static Unit FindInSectorUnit(User param1, int ownerId, int targetId) {
        for (Unit _loc4_ : param1.gameData.worldData.units) {
            if (_loc4_.StateInTargetSector != null && _loc4_.OwnerUserId == ownerId && _loc4_.TargetUserId == targetId) {
                return _loc4_;
            }
        }
        return null;
    }

    //
//    public static Unit FindInMissileStorageUnit(User param1) {
//        Troops _loc2_ = new Troops();
//        _loc2_.countByType = param1.gameData.troopsData.missileStorage.countByType;
//        TroopsPayload _loc3_ = new TroopsPayload();
//        _loc3_.troops = _loc2_;
//        Unit _loc4_ = new Unit();
//        _loc4_.troopsPayload = _loc3_;
//        _loc4_.OwnerUserId = param1.id;
//        _loc4_.TargetUserId = param1.id;
//        _loc4_.TargetTypeId = MapObjectTypeId.USER_OR_LOCATION;
//        _loc4_.StateInTargetSector = new UnitStateInSector();
//        return _loc4_;
//    }
//
    public static Unit FindInBunkerUnit(User user) {
        for (Unit unit : user.gameData.worldData.units) {
            if (unit.StateInTargetSector != null && unit.troopsPayload != null && unit.troopsPayload.order == TroopsOrderId.Bunker && unit.OwnerUserId == user.id && unit.TargetUserId == user.id && unit.TargetTypeId == MapObjectTypeId.USER_OR_LOCATION) {
                return unit;
            }
        }
        return null;
    }

    //
//    public static Unit FindOrCreateInBunkerUnit(User param1) {
//        Unit _loc2_ = FindInBunkerUnit(param1);
//        if (_loc2_ == null) {
//            _loc2_ = new Unit();
//            _loc2_.OwnerUserId = param1.id;
//            _loc2_.TargetUserId = param1.id;
//            _loc2_.TargetTypeId = MapObjectTypeId.USER_OR_LOCATION;
//            _loc2_.troopsPayload = new TroopsPayload();
//            _loc2_.troopsPayload.order = TroopsOrderId.Bunker;
//            _loc2_.troopsPayload.troops = new Troops();
//            _loc2_.StayInSector();
//            AddUnit(param1, _loc2_);
//        }
//        return _loc2_;
//    }
//
//    public static Unit FindInSectorUnit2(Location param1, int param2, int param3) {
//        Unit _loc4_ = null;
//        for (Object _loc4_ : param1.gameData.worldData.units) {
//            if (_loc4_.StateInTargetSector != null && _loc4_.OwnerUserId == param2 && _loc4_.TargetUserId == param3) {
//                return _loc4_;
//            }
//        }
//        return null;
//    }
//
//    public static List<Object> GetOccupiedLocationIds(User param1) {
//        LocationNote _loc3_ = null;
//        Unit _loc4_ = null;
//        List<Object> _loc2_ = new ArrayList<Object>();
//        for (Object _loc4_ : param1.gameData.worldData.units) {
//            if (boolean
//            (_loc4_.TargetIsLocation) && _loc4_.StateInTargetSector != null && _loc4_.troopsPayload.order == TroopsOrderId.Occupation)
//            {
//                _loc3_ = LocationNoteManager.getById(_loc4_.TargetLocationId);
//                if (_loc3_.mineInfo != null && _loc3_.isStorage == false) {
//                    _loc2_.add(_loc4_.TargetLocationId);
//                }
//            }
//        }
//        return _loc2_;
//    }
//
//    public static List<Object> GetOccupiedStorageIds(User param1) {
//        LocationNote _loc3_ = null;
//        Unit _loc4_ = null;
//        List<Object> _loc2_ = new ArrayList<Object>();
//        for (Object _loc4_ : param1.gameData.worldData.units) {
//            if (boolean
//            (_loc4_.TargetIsLocation) && _loc4_.StateInTargetSector != null && _loc4_.troopsPayload.order == TroopsOrderId.Occupation)
//            {
//                _loc3_ = LocationNoteManager.getById(_loc4_.TargetLocationId);
//                if (_loc3_.mineInfo != null && _loc3_.isStorage == true) {
//                    _loc2_.add(_loc4_.TargetLocationId);
//                }
//            }
//        }
//        return _loc2_;
//    }
//
//    public static List<Object> GetOccupiedMinesIds(User param1) {
//        Unit _loc3_ = null;
//        List<Object> _loc2_ = new ArrayList<Object>();
//        for (Object _loc3_ : param1.gameData.worldData.units) {
//            if (boolean
//            (_loc3_.TargetIsLocation) && _loc3_.StateInTargetSector != null && _loc3_.troopsPayload.order == TroopsOrderId.Occupation)
//            {
//                _loc2_.add(_loc3_.TargetLocationId);
//            }
//        }
//        return _loc2_;
//    }
//
//    public static boolean checkLocationInOccupationProgressAlreadyLimit(User param1, int param2, int param3=0) {
//        LocationNote _loc5_ = null;
//        Unit _loc6_ = null;
//        List<Object> _loc4_ = new ArrayList<Object>();
//        for (Object _loc6_ : param1.gameData.worldData.units) {
//            if (!(!_loc6_.TargetIsLocation || _loc6_.TargetLocationId == param3)) {
//                _loc5_ = LocationNoteManager.getById(_loc6_.TargetLocationId);
//                if (!_loc5_.isStorage) {
//                    if (boolean(_loc5_ && _loc5_.mineInfo && _loc6_.StateMovingBack == null) &&boolean
//                    (_loc6_.troopsPayload.order == TroopsOrderId.Occupation) && _loc4_.indexOf(_loc6_.TargetLocationId) == -1)
//                    {
//                        _loc4_.add(_loc6_.TargetLocationId);
//                    }
//                }
//            }
//        }
//        return _loc4_.length >= param2;
//    }
//
//    public static boolean checkLocationInOccupationProgress(User param1, int param2) {
//        Unit _loc3_ = null;
//        for (Object _loc3_ : param1.gameData.worldData.units) {
//            if (boolean
//            (_loc3_.TargetIsLocation) && _loc3_.TargetLocationId == param2 && _loc3_.StateMovingBack == null && _loc3_.troopsPayload.order == TroopsOrderId.Occupation)
//            {
//                return true;
//            }
//        }
//        return false;
//    }
//
//    public static void LoadUnit(User param1, Unit param2, Troops param3=null) {
//        if (param1.id != param2.OwnerUserId && param1.id != param2.TargetUserId) {
//            Tracer.Trace("throw new InvalidOperationException(\'Unable to load unit\');");
//            return;
//        }
//        if (param2.troopsPayload != null) {
//            TroopsManager.LoadInfo(param1, param2.troopsPayload, param3);
//        }
//        if (param2.tradingPayload != null) {
//            TradingManager.LoadInfo(param1, param2.tradingPayload);
//        }
//    }
//
//    public static void UnloadUnit(User param1, Unit param2) {
//        if (param1.id != param2.OwnerUserId && param1.id != param2.TargetUserId) {
//            Tracer.Trace("throw new InvalidOperationException(\'Unable to unload unit\');");
//            return;
//        }
//        if (param2.troopsPayload != null) {
//            TroopsManager.UnloadInfo(param1, param2.troopsPayload);
//            if (param2.troopsPayload.resources != null) {
//                TradingManager.UnloadResources(param1, param2.troopsPayload.resources);
//            }
//        }
//        if (param2.tradingPayload != null) {
//            TradingManager.UnloadInfo(param1, param2.tradingPayload);
//        }
//        param2.ResetPayloads();
//    }
//
    public static void UnitSent(User param1, Unit param2) {
        if (param2.OwnerUserId != param1.id || param2.StatePendingDepartureBack == null || param2.troopsPayload == null || param2.troopsPayload.order != TroopsOrderId.Return) {
            return;
        }
        List<Unit> _loc3_ = GetInSectorUnits(param1);
        for (Unit _loc4_ : _loc3_) {
            if (_loc4_.TargetUserId == param2.TargetUserId && _loc4_.OwnerUserId == param2.OwnerUserId) {
                if (!_loc4_.troopsPayload.troops.isEmpty()) {
                    _loc4_.troopsPayload.troops.removeTroops(param2.troopsPayload.troops);
                    if (_loc4_.troopsPayload.troops.isEmpty()) {
                        param1.gameData.worldData.units.remove(_loc4_);
                        param1.gameData.worldData.dirtyUnitListChanged = true;
                    }
                }
                break;
            }
        }
    }

    //
//    public static void UpdateReturningInSectorUnits(User param1) {
//        Unit _loc3_ = null;
//        List<Object> _loc4_ = null;
//        Unit _loc5_ = null;
//        List<Object> _loc2_ = GetInSectorUnits(param1);
//        for (Object _loc3_ : _loc2_) {
//            _loc4_ = GetPendingDepartureBackUnits(param1, _loc3_);
//            for (Object _loc5_ : _loc4_) {
//                if (!_loc3_.troopsPayload.troops.Empty) {
//                    _loc3_.troopsPayload.troops.removeTroops(_loc5_.troopsPayload.troops);
//                    param1.gameData.worldData.dirtyUnitListChanged = true;
//                }
//            }
//            if (_loc3_.troopsPayload.troops.Empty) {
//                param1.gameData.worldData.units.removeItemAt(param1.gameData.worldData.units.getItemIndex(_loc3_));
//                param1.gameData.worldData.dirtyUnitListChanged = true;
//            }
//        }
//    }
//
//    public static void UpdateReturningInSectorUnits2(User param1, Location param2) {
//        Unit _loc4_ = null;
//        List<Object> _loc5_ = null;
//        Unit _loc6_ = null;
//        List<Object> _loc3_ = GetInSectorUnits3(param1, param2.id);
//        for (Object _loc4_ : _loc3_) {
//            _loc5_ = GetPendingDepartureBackUnits(param1, _loc4_);
//            for (Object _loc6_ : _loc5_) {
//                if (!_loc4_.troopsPayload.troops.Empty) {
//                    _loc4_.troopsPayload.troops.removeTroops(_loc6_.troopsPayload.troops);
//                }
//            }
//            if (_loc4_.troopsPayload.troops.Empty) {
//                param1.gameData.worldData.units.removeItemAt(param1.gameData.worldData.units.getItemIndex(_loc4_));
//            }
//        }
//    }
//
    public static List<Unit> GetInSectorUnits(User param1) {
        List<Unit> _loc2_ = new ArrayList<Unit>();
        for (Unit _loc3_ : param1.gameData.worldData.units) {
            if (_loc3_.OwnerUserId == param1.id && _loc3_.StateInTargetSector != null) {
                _loc2_.add(_loc3_);
            }
        }
        return _loc2_;
    }
//
//    public static List<Object> GetInSectorUnits2(Location param1, int param2) {
//        Unit _loc4_ = null;
//        List<Object> _loc3_ = new ArrayList<Object>();
//        for (Object _loc4_ : param1.gameData.worldData.units) {
//            if (_loc4_.OwnerUserId == param2 && _loc4_.StateInTargetSector != null) {
//                _loc3_.add(_loc4_);
//            }
//        }
//        return _loc3_;
//    }
//
//    public static List<Object> GetInSectorUnits3(User param1, int param2) {
//        Unit _loc4_ = null;
//        List<Object> _loc3_ = new ArrayList<Object>();
//        for (Object _loc4_ : param1.gameData.worldData.units) {
//            if (_loc4_.TargetUserId == param2 && _loc4_.StateInTargetSector != null) {
//                _loc3_.add(_loc4_);
//            }
//        }
//        return _loc3_;
//    }
//
//    public static List<Object> GetPendingDepartureBackUnits(User param1, Unit param2) {
//        Unit _loc4_ = null;
//        List<Object> _loc3_ = new ArrayList<Object>();
//        for (Object _loc4_ : param1.gameData.worldData.units) {
//            if (_loc4_.OwnerUserId == param2.OwnerUserId && _loc4_.TargetUserId == param2.TargetUserId && _loc4_.troopsPayload != null && _loc4_.troopsPayload.order == TroopsOrderId.Return && _loc4_.StatePendingDepartureBack != null) {
//                _loc3_.add(_loc4_);
//            }
//        }
//        return _loc3_;
//    }
//
//    public static void UnloadUnitToBunker(User param1, Unit param2) {
//        Unit _loc3_ = FindOrCreateInBunkerUnit(param1);
//        _loc3_.UnitId = param2.UnitId;
//        if (param2.troopsPayload.resources != null) {
//            TradingManager.UnloadResources(param1, param2.troopsPayload.resources);
//        }
//        if (param2.troopsPayload != null) {
//            _loc3_.MergeTroopsPayload(param2.troopsPayload);
//        }
//        param2.ResetPayloads();
//    }
//
//    public static void AddTroopsToBunker(User param1, Troops param2) {
//        Unit _loc3_ = UnitUtility.FindInBunkerUnit(param1);
//        if (_loc3_ == null) {
//            _loc3_ = new Unit();
//            _loc3_.OwnerUserId = param1.id;
//            _loc3_.TargetUserId = param1.id;
//            _loc3_.TargetTypeId = MapObjectTypeId.USER_OR_LOCATION;
//            _loc3_.troopsPayload = new TroopsPayload();
//            _loc3_.troopsPayload.order = TroopsOrderId.Bunker;
//            _loc3_.troopsPayload.troops = new Troops();
//            _loc3_.StayInSector();
//            UnitUtility.AddUnit(param1, _loc3_);
//        }
//        _loc3_.troopsPayload.troops.addTroops(param2);
//        param1.gameData.worldData.dirtyUnitListChanged = true;
//    }
}
