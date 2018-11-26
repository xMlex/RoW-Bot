package ru.xmlex.row.game.common;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by xMlex on 13.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class RowName {
    @Expose
    @SerializedName("c")
    public String value;

    public RowName(String val) {
        value = val;
    }

    public RowName() {
        value = "";
    }

    @Override
    public String toString() {
        return value;
    }
}
