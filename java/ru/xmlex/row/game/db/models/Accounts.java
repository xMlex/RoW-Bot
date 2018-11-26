package ru.xmlex.row.game.db.models;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.dao.ForeignCollection;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.field.ForeignCollectionField;
import com.j256.ormlite.table.DatabaseTable;
import ru.xmlex.common.crypt.RSA;
import ru.xmlex.common.dbcp.BaseDatabaseFactory;

import java.sql.SQLException;

/**
 * Created by xMlex on 26.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
@DatabaseTable(tableName = "row_accounts")
public class Accounts {
    @DatabaseField(generatedId = true)
    private int id;
    @DatabaseField(columnName = "type", canBeNull = true, defaultValue = "vk")
    private String type;
    @DatabaseField(columnName = "login", canBeNull = false)
    private String login;
    @DatabaseField(columnName = "password", canBeNull = false)
    private String password;
    @DatabaseField(columnName = "active", defaultValue = "0")
    private boolean active;
    @DatabaseField(columnName = "allow_building", defaultValue = "0")
    private boolean allow_building;
    @DatabaseField(columnName = "allow_tech", defaultValue = "0")
    private boolean allow_tech;
    @DatabaseField(columnName = "allow_troops", defaultValue = "0")
    private boolean allow_troops;
    @DatabaseField(columnName = "allow_quests", defaultValue = "0")
    private boolean allow_quests;

    //
    @ForeignCollectionField(eager = false)
    ForeignCollection<DbAutoTroops> autoTroops;

    private static Dao<Accounts, Integer> dao;

    public static Dao<Accounts, Integer> getDao() {
        if (dao == null) {
            try {
                dao = DaoManager.createDao(BaseDatabaseFactory.getInstance().getConnectionSource(), Accounts.class);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dao;
    }

    public int getId() {
        return id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        System.out.println("pass: " + password);
        return RSA.getInstance().decryptBase64(password);
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public boolean isAllow_building() {
        return allow_building;
    }

    public void setAllow_building(boolean allow_building) {
        this.allow_building = allow_building;
    }

    public boolean isAllow_tech() {
        return allow_tech;
    }

    public void setAllow_tech(boolean allow_tech) {
        this.allow_tech = allow_tech;
    }

    public boolean isAllow_troops() {
        return allow_troops;
    }

    public void setAllow_troops(boolean allow_troops) {
        this.allow_troops = allow_troops;
    }

    public boolean isAllow_quests() {
        return allow_quests;
    }

    public void setAllow_quests(boolean allow_quests) {
        this.allow_quests = allow_quests;
    }

    public void logMessage(String msg, int id) {
        AccountLog model = new AccountLog();
        model.setAccount(this);
        model.setMessage(msg);
        model.setObjectId(id);
        try {
            AccountLog.getDao().create(model);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ForeignCollection<DbAutoTroops> getAutoTroops() {
        return autoTroops;
    }
}
