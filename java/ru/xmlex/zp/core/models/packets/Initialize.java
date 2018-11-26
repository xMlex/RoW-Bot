package ru.xmlex.zp.core.models.packets;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by mlex on 21.10.16.
 */
public class Initialize extends BasePacket {
    @Expose
    @SerializedName("msie")
    public boolean msie = false;

    public Initialize() {
        setName("start_game");
    }
}
