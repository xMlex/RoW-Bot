package ru.xmlex.zp.core.models.game;

import com.google.gson.annotations.SerializedName;
import ru.xmlex.zp.core.models.game.world.World;

/**
 * Created by mlex on 25.10.16.
 */
public class Worlds {
    @SerializedName("default")
    public World main;
}
