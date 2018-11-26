package ru.xmlex.row.game.data.users.troops;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by xMlex on 29.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class Troops {
    @Expose
    @SerializedName("t")
    public ConcurrentHashMap<Integer, Integer> countByType = new ConcurrentHashMap<>();

    public boolean isEmpty() {
        return countByType == null || countByType.isEmpty();
    }

    public void removeTroops(Troops param1) {
        if (param1 == null)
            return;
        for (Map.Entry<Integer, Integer> el : param1.countByType.entrySet()) {
            this.removeTroops2(el.getKey(), param1.countByType.get(el.getKey()));
        }
    }

    /**
     * @param id
     * @param count
     */
    public void removeTroops2(int id, int count) {
        if (countByType.containsKey(id)) {
            int total = this.countByType.get(id);
            if (total < count || total == count) {
                countByType.remove(id);
            } else {
                countByType.put(id, (total - count));
            }
        }
    }
}
