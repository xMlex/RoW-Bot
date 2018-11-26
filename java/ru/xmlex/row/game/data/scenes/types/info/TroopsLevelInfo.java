package ru.xmlex.row.game.data.scenes.types.info;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.Resources;
import ru.xmlex.row.game.data.scenes.types.info.troops.BattleBehaviour;
import ru.xmlex.row.game.data.scenes.types.info.troops.BattleParameters;

/**
 * Created by xMlex on 19.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class TroopsLevelInfo {
    @Expose
    @SerializedName("r")
    public Resources resources;
    @Expose
    @SerializedName("b")
    public BattleParameters battleParameters;
    @Expose
    @SerializedName("h")
    public BattleBehaviour battleBehaviour;
    @Expose
    @SerializedName("s")
    public int speed;
    @Expose
    @SerializedName("c")
    public int resourcesCapacity;
    @Expose
    @SerializedName("a")
    public float antigen;
    @Expose
    @SerializedName("z")
    public float defensePoints;
    @Expose
    @SerializedName("n")
    public double attackPoints;
}
