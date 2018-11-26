package ru.xmlex.row.game.data.users;

import ru.xmlex.row.game.data.Resources;
import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.data.UserGameData;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;
import ru.xmlex.row.game.data.scenes.types.info.BuildingTypeId;
import ru.xmlex.row.game.data.scenes.types.info.RequiredObject;
import ru.xmlex.row.game.data.scenes.types.info.SaleableLevelInfo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 07.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserBuyingData {

    public static void updateObjectStatus(GeoSceneObject param1, User user) {
        updateObjectStatus(param1, user, false, false);
    }

    public static void updateObjectStatus(GeoSceneObject object, User user, boolean param3, boolean param4) {
        int _loc6_ = BuyStatus.OBJECT_CAN_BE_BOUGHT;
        Resources price = null;
        boolean _loc8_ = false;
        if (object.buyStatus == BuyStatus.OBJECT_CANNOT_BE_BOUGHT && !param4) {
            return;
        }
        SaleableLevelInfo _loc5_ = object.getSaleableLevelInfo();
        if (_loc5_ == null) {
            object.setMissingResources(null);
        } else {
            price = user.gameData.getPrice(user, object.objectType(), object.getNextLevel());
            object.setMissingResources(getMissingResources(user.gameData, price));
        }
        if (param3) {
            if (object.getLevel() > 0) {
                object.setMissingResources(null);
            } else {
                object.setMissingObjects(getMissingObjects(user.gameData, object.getRequiredObjects()));
            }
        }
        if (object.buildingInProgress() || user.gameData.objectFromSameGroupIsInProgress(object.objectType())) {
            _loc6_ = BuyStatus.OBJECT_OF_SAME_GROUP_IN_PROGRESS;
        } else if (object.getMissingObjects() != null) {
            _loc6_ = BuyStatus.REQUIRED_OBJECT_MISSING;
        } else {
            _loc8_ = object.type != BuildingTypeId.BuildingIdLogisticsCenter || object.getSaleableLevelInfo() != null
                    && user.gameData.invitationData.constructionBlockCount >= object.getSaleableLevelInfo().constructionBlockPrize;
            if (object.getMissingResources() != null || !_loc8_) {
                _loc6_ = BuyStatus.NOT_ENOUGH_RESOURCES;
            } else {
                _loc6_ = user.gameData.getBuyStatus(object.objectType(), object.getLevel() + 1);
            }
        }
        if (user.gameData.objectFromSameGroupIsInProgress(object.objectType())) {
            _loc6_ = BuyStatus.OBJECT_OF_SAME_GROUP_IN_PROGRESS;
        }
        if (_loc6_ != object.buyStatus) {
            object.buyStatus = _loc6_;
        }
    }

    private static List<RequiredObject> getMissingObjects(UserGameData param1, List<RequiredObject> param2) {
        if (param2 == null) {
            return null;
        }
        List<RequiredObject> _loc3_ = new ArrayList<RequiredObject>();
        for (RequiredObject _loc4_ : param2) {
            if (!param1.hasRequiredObject(_loc4_)) {
                _loc3_.add(_loc4_);
            }
        }
        return _loc3_.size() == 0 ? null : _loc3_;
    }

    private static Resources getMissingResources(UserGameData param1, Resources param2) {
        if (param2 == null) {
            return null;
        }
        Resources _loc3_ = param1.account.resources.clone();
        if (param2.goldMoney == 0) {
            _loc3_.goldMoney = 0;
        }
        if (param2.uranium == 0) {
            _loc3_.uranium = 0;
        }
        if (param2.titanite == 0) {
            _loc3_.titanite = 0;
        }
        if (param2.money == 0) {
            _loc3_.money = 0;
        }
        if (_loc3_.greaterOrEquals(param2)) {
            return null;
        }
        Resources _loc4_ = param2.clone();
        _loc4_.substract(param1.account.resources);
        return _loc4_;
    }
}
