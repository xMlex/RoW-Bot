package xmlex.vk.row.model.data.users;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.util.Date;

public class UserCommonData {

    public Date registrationTime;

    public Date lastVisitTime;

    public int loyaltyProgramDaysLeft;

    // public var boughtTroopKitIds:ArrayCollection;

    // public var boughtResourceKitIds:ArrayCollection;

    // public var specialOffers:ArrayCollection;

    public boolean kitsDirty = false;

    public boolean specialOffersDirty = false;

    public int playedDays;

    public int wallpostsCount;

    public Date wallpostsLastTime;

    public static UserCommonData fromDto(JsonElement param1) {
        UserCommonData _loc2_ = new UserCommonData();
        JsonObject p1 = param1.getAsJsonObject();
        _loc2_.registrationTime = new Date(p1.get("r").getAsLong());
        _loc2_.lastVisitTime = new Date(p1.get("v").getAsLong());
        _loc2_.loyaltyProgramDaysLeft = p1.get("l").getAsInt();
        //_loc2_.boughtTroopKitIds = param1.t == null?new ArrayCollection():new ArrayCollection(param1.t);
        //_loc2_.boughtResourceKitIds = param1.y == null?new ArrayCollection():new ArrayCollection(param1.y);
        //_loc2_.specialOffers = param1.o == null?new ArrayCollection():SpecialOffer.fromDtos(param1.o);
        _loc2_.playedDays = p1.get("d").getAsInt();
        _loc2_.wallpostsCount = p1.get("w") == null ? 0 : p1.get("w").getAsInt();
        _loc2_.wallpostsLastTime = p1.get("x") == null ? null : new Date(p1.get("x").getAsLong());
        return _loc2_;
    }
}
