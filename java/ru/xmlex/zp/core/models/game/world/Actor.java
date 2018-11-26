package ru.xmlex.zp.core.models.game.world;

import ru.xmlex.zp.ZpStaticManager;
import ru.xmlex.zp.core.models.amf.MFActor;

/**
 * Created by mlex on 25.10.16.
 */
public class Actor {
    public static int UNLOCK_TYPE_UNLOCKED = -1;
    public static int UNLOCK_TYPE_LEVEL = 1;
    public static int UNLOCK_TYPE_FRIENDS_COUNT = 2;
    public static int UNLOCK_TYPE_QUEST = 3;
    public static int UNLOCK_TYPE_OTHER = 4;
    public static int UNLOCK_TYPE_ACTIVE_QUEST = 5;
    public static int UNLOCK_TYPE_FRIEND_ONLY = 6;
    public static int UNLOCK_TYPE_LOCK_UPGRADE_BY_QUEST = 8;
    public static int UNLOCK_TYPE_MOVE_PERMANENT = 10;

    public long ltt = -1;// : 1476002270
    public int y;// : 37
    public int x;// : 33
    public int sid;// : 4801
    public int t;// : 42
    public int id;// : 328
    public int state = -1;// : 328

    @Override
    public String toString() {
        return "Actor[" + id + "]-" + sid + " " + x + "," + y + " State: " + state + ": " + t + " " + getName();
    }

    public MFActor getActor() {
        return ZpStaticManager.getInstance().actors.get(id);
    }

    public String getName() {
        return getActor().name;
    }

    public boolean isUnlocked() {
        return state == UNLOCK_TYPE_UNLOCKED;
    }

    public boolean isTTLExpire() {
        return ltt == -1;
    }

    /**
     * @return true если мусор
     */
    public boolean isTrash() {
        return getActor().type.equalsIgnoreCase("trash");
    }

    public boolean isDecor() {
        return getActor().type.equalsIgnoreCase("decor");
    }

    /**
     * @return true если дерево
     */
    public boolean isTree() {
        return getActor().type.equalsIgnoreCase("tree");
    }

    /**
     * @return true если фруктовое дерево
     */
    public boolean isFruitTree() {
        return getActor().type.equalsIgnoreCase("fruit_tree");
    }

    /**
     * @return true если животное
     */
    public boolean isPet() {
        return getActor().type.equalsIgnoreCase("pet");
    }

    /**
     * @return true если монстр на огороде
     */
    public boolean isMonster() {
        return getActor().type.equalsIgnoreCase("monster");
    }

    /**
     * @return true если здание
     */
    public boolean isBuilding() {
        return getActor().type.equalsIgnoreCase("building");
    }
}
