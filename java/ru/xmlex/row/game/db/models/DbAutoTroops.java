package ru.xmlex.row.game.db.models;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import ru.xmlex.common.dbcp.BaseDatabaseFactory;

import java.sql.SQLException;

/**
 * Created by xMlex on 15.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
@DatabaseTable(tableName = "row_auto_troops")
public class DbAutoTroops {
    @DatabaseField(id = true)
    private int id;
    @DatabaseField(columnName = "fid_account", foreign = true, foreignAutoRefresh = true)
    private Accounts account;
    @DatabaseField(columnName = "fid_object")
    private int troopId;
    @DatabaseField(columnName = "total_count")
    private int targetCount;
    @DatabaseField(columnName = "current_count")
    private int currentCount;

    public int getId() {
        return id;
    }

    public Accounts getAccount() {
        return account;
    }

    public void setAccount(Accounts account) {
        this.account = account;
    }

    public int getTroopId() {
        return troopId;
    }

    public void setTroopId(int troopId) {
        this.troopId = troopId;
    }

    public int getTargetCount() {
        return targetCount;
    }

    public void setTargetCount(int targetCount) {
        this.targetCount = targetCount;
    }

    public int getCurrentCount() {
        return currentCount;
    }

    public void setCurrentCount(int currentCount) {
        this.currentCount = currentCount;
    }

    private static Dao<DbAutoTroops, Integer> dao;

    public static Dao<DbAutoTroops, Integer> getDao() {
        if (dao == null) {
            try {
                dao = DaoManager.createDao(BaseDatabaseFactory.getInstance().getConnectionSource(), DbAutoTroops.class);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dao;
    }
}
