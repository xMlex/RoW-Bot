package ru.xmlex.zp.core.models.packets;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by mlex on 25.10.16.
 */
public class CharacterMove extends BasePacket {
    @Expose
    @SerializedName("who")
    public int who = 0;
    @Expose
    public int x = 0;
    @Expose
    public int y = 0;

    public CharacterMove(int x, int y, int who) {
        this.who = who;
        this.x = x;
        this.y = y;
        name = "character_move";
    }

    public CharacterMove(int x, int y) {
        this(x, y, 0);
    }
}
