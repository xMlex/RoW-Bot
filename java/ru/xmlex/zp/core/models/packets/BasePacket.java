package ru.xmlex.zp.core.models.packets;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by mlex on 21.10.16.
 */
public class BasePacket {
    @Expose
    @SerializedName("cmd_id")
    public String cmdId;
    @Expose
    @SerializedName("name")
    public String name;

    public BasePacket setCmdId(String cmdId) {
        this.cmdId = cmdId;
        return this;
    }

    public BasePacket setName(String name) {
        this.name = name;
        return this;
    }
}
