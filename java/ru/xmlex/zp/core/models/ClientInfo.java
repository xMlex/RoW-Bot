package ru.xmlex.zp.core.models;

/**
 * Created by mlex on 21.10.16.
 */
public class ClientInfo {
    public String id;
    public String env;
    public User user;

    public class User {
        public int money;
        public String photo_medium;
        public long next_level_exp;
        public long regdate;
        public String photo;
        public int ab_group;
        public String referrer;
        public String name;
        public int sex; //2 male
        public int wood;
        public int birthday;
        public int balance;
        public long curr_level_exp;
        public int food;
        public int level;
        public long exp;
        public String photo_big;
        public String id;
        public String country;
        public String panda_flags;
        public int payment_count;
    }
}
