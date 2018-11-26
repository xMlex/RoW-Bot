package ru.xmlex.zp.core.xclient;

import com.google.gson.annotations.SerializedName;

/**
 * Created by theml on 08.10.2016.
 */
public class ServerMessage {
    @SerializedName("cmd_id")
    public String id;
    @SerializedName("global")
    public Object global;
    @SerializedName("name")
    public String cmdName;
    @SerializedName("fatal")
    public Boolean fatal;
    @SerializedName("msg")
    public String failMessage;
    @SerializedName("type")
    public String type;
//    @SerializedName("cmd_id")
//    public Object metaData;
//    @SerializedName("cmd_id")
//    public String rawData;
}
