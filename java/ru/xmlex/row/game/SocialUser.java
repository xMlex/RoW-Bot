package ru.xmlex.row.game;

import ru.xmlex.common.Translit;

/**
 * Created by xMlex on 29.03.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class SocialUser {
    public String uid;
    public String name = "";
    public String first_name = "";
    public String last_name = "";
    public String sex = "NaN";
    public String birthday = "";
    public int timezone = -180;
    public String location = "";
    public String locale = "ru_RU";


    public SocialUser() {

    }

    public String getSocialNetworkData() {
        return this.first_name + ";" + this.last_name + ";" + this.sex + ";" + this.locale + ";" + this.timezone + ";" + this.birthday + ";" + this.location;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public void setFirstName(String first_name) {
        this.first_name = Translit.cyr2lat(first_name);
    }

    public void setLastName(String last_name) {
        this.last_name = Translit.cyr2lat(last_name);
    }
}
