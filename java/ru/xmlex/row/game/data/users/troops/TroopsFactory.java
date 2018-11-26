package ru.xmlex.row.game.data.users.troops;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.List;

/**
 * Created by xMlex on 29.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class TroopsFactory {
    @Expose
    @SerializedName("i")
    public int nextOrderId;
    @Expose
    @SerializedName("o")
    public List<TroopsOrder> orders;
//    @Expose
//    @SerializedName("s")
//    public Array extraTroopsSlots;

    public int getTotalCountByTypeId(int id) {
        if (orders == null)
            return 0;
        int count = 0;
        for (TroopsOrder order : orders) {
            if (order.typeId == id)
                count += order.totalCount;
        }
        return count;
    }
}
