package ru.xmlex.row.game.data.users.raids;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.data.users.troops.Troops;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 07.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserRaidData {
    @Expose
    @SerializedName("i")
    public int nextLocationId;
    @Expose
    @SerializedName("l")
    public List<RaidLocation> locations = new ArrayList<>(0);
    @Expose
    @SerializedName("m")
    public int maxWonLevel;
    @Expose
    @SerializedName("s")
    public UserRaidStoryData storyData;
    @Expose
    @SerializedName("b")
    public int todayBonusRefreshesCount;

    public void processUser(User user) {

        RaidLocation def = null;
        RaidLocation attack = null;


        Troops toRaidDef = new Troops();
        toRaidDef.countByType.put(2, 50);
        Troops toRaidAttack = new Troops();
        toRaidAttack.countByType.put(1, 50);

        for (RaidLocation loc : locations) {
            if (loc.closed || loc.getType() == null)
                continue;

            if (loc.level <= 25) {
                if (loc.isAttacking()) {
                    if (attack == null) {
                        attack = loc;
                    } else {
                        if (loc.level < attack.level)
                            attack = loc;
                    }
                } else {
                    if (def == null) {
                        def = loc;
                    } else {
                        if (loc.level < def.level)
                            def = loc;
                    }
                }
            }
        }
        // Отсылаем в локи
        if (attack != null) {
            user.getClient().logAction("Атака локации " + attack.getType().name + " Lvl: " + attack.level);
            user.gameData.troopsData.sendRobberyTroops(user, attack.id, toRaidAttack);
        }
        if (def != null) {
            user.getClient().logAction("Защита локации " + def.getType().name + " Lvl: " + def.level);
            user.gameData.troopsData.sendReinforcementTroops(user, def.id, toRaidDef);
        }
    }
    //System.out.println("Count troops: " + user.gameData.troopsData.getTroopCountById(1, user));

}
