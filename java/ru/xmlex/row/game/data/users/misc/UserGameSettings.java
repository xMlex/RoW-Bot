package ru.xmlex.row.game.data.users.misc;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by mlex on 28.12.16.
 */
public class UserGameSettings {
    @Expose
    @SerializedName("f")
    public boolean interactiveFullScreenMode;
    @Expose
    @SerializedName("a")
    public boolean animationEnabled;
    @Expose
    @SerializedName("l")
    public boolean slidingSectorEnabled;
    @Expose
    @SerializedName("g")
    public boolean mapGridEnabled;
    @Expose
    @SerializedName("c")
    public String locale;

    @SerializedName("z")
    public Number zoomValue;
    @Expose
    @SerializedName("s")
    public boolean soundsEnabled;
    @Expose
    @SerializedName("m")
    public boolean musicEnabled;
    @Expose
    @SerializedName("o")
    public int sortOrder;
    @Expose
    @SerializedName("p")
    public int pageNumber;

    public boolean soundNotificationEnabledForUserMessages = true;

    public boolean soundNotificationEnabledForMilitaryMessages = true;

    public boolean soundNotificationEnabledForTradeMessages = true;

    public boolean soundNotificationEnabledForDiplomaticMessages = true;

    public boolean soundNotificationEnabledForScientificMessages = true;
}
