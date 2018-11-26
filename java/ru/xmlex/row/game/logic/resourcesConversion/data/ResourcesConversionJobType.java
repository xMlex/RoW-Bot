package ru.xmlex.row.game.logic.resourcesConversion.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;
import ru.xmlex.row.game.data.User;

/**
 * Created by xMlex on 09.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class ResourcesConversionJobType {
    @Expose
    @SerializedName("i")
    public int id;
    @Expose
    @SerializedName("c")
    public Resources inResources;
    @Expose
    @SerializedName("o")
    public Resources outResources;
    @Expose
    @SerializedName("d")
    public Long durationHours = null;
    @Expose
    @SerializedName("t")
    public int outResourceTypeId;

    public ResourcesConversionError canBeStarted(User user) {
        Resources _loc5_ = null;
        int _loc1_ = (int) this.outResources.biochips;
        int _loc2_ = (int) user.gameData.account.resources.biochips;
        int _loc3_ = (int) user.gameData.account.resourcesLimit.biochips;
        if (_loc2_ + _loc1_ > _loc3_) {
            return new ResourcesConversionError(ResourcesConversionErrorEnum.MAX_LIMIT);
        }
        Resources _loc4_ = user.gameData.account.resources;
        if (this.inResources.uranium > _loc4_.uranium || this.inResources.titanite > _loc4_.titanite || this.inResources.money > _loc4_.money) {
            _loc5_ = new Resources();
            if (this.inResources.uranium > _loc4_.uranium) {
                _loc5_.uranium = this.inResources.uranium - _loc4_.uranium;
            }
            if (this.inResources.titanite > _loc4_.titanite) {
                _loc5_.titanite = this.inResources.titanite - _loc4_.titanite;
            }
            if (this.inResources.money > _loc4_.money) {
                _loc5_.money = this.inResources.money - _loc4_.money;
            }
            return new ResourcesConversionError(ResourcesConversionErrorEnum.NOT_ENOUGH_RESOURCES, _loc5_);
        }
        return new ResourcesConversionError(ResourcesConversionErrorEnum.OK);
    }
}
