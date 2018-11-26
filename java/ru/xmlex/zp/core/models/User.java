package ru.xmlex.zp.core.models;

import ru.xmlex.zp.core.models.game.Char;
import ru.xmlex.zp.core.models.game.Worlds;

/**
 * Created by mlex on 25.10.16.
 */
public class User {
    public static final int ENERGY_RECOVERY_SPEED = 300;

    //actual_actions
    //        craft_workers
    public String name;
    public int energy_recovery_period;
    public int crafts_sold;
    public long exp;
    public String photo_big;
    public long regdate;
    public int birthday;
    public String id;
    public String map;
    //pets
    public int energy_max;
    public int energy_recovery_time;
    public int level;
    public int balance;
    public int wood;
    public int food;
    public long next_level_exp;
    public String country;
    //inventory
    public int achievement_points;
    public String partner;
    public Worlds worlds;
    //        link_actors
    //roulette
    //        completed_quests
    //achievements
    //        purchase_order
    public Char[] chars;
    //        collections
    //referrer : "100978226"
    public String photo;// : "http://cs631618.vk.me/v631618615/39af7/I50Y0VCBwC8.jpg"
    public String photo_medium;// : "http://cs631618.vk.me/v631618615/39af6/Ils_t2C7Yl8.jpg"
    public long last_visit_date;// : 1477282670
    public String skin;// : "365"
    //mystery_boxes_counters
    //        wallpost_landmarks
    public int sex;// : 2
    public int money;// : 258259
    public String panda_flags;// : "283163826574595560"
    public int ab_group;// : 6
    public long curr_level_exp;// : 222750
    public long server_time;// : 222750

    public int getEnergy() {
        return energy_max - (int) Math.floor(energy_recovery_time / ENERGY_RECOVERY_SPEED);
    }

    public void incEnergyRecoveryTime() {
        energy_recovery_time += ENERGY_RECOVERY_SPEED;
    }
}
