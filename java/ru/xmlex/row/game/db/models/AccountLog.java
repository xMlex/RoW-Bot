package ru.xmlex.row.game.db.models;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.field.DataType;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import ru.xmlex.common.dbcp.BaseDatabaseFactory;

import java.sql.SQLException;
import java.sql.Timestamp;

/**
 * Created by xMlex on 26.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
@DatabaseTable(tableName = "row_accounts_log")
public class AccountLog {
    @DatabaseField(generatedId = true)
    private int id;
    @DatabaseField(foreign = true, foreignAutoRefresh = true)
    private Accounts account;
    @DatabaseField(columnName = "message", canBeNull = false, dataType = DataType.LONG_STRING)
    private String message;
    @DatabaseField(columnName = "object_id")
    private int object_id;
    @DatabaseField(columnName = "created_at", dataType = DataType.TIME_STAMP, version = true)
    private Timestamp created_at;

    public int getId() {
        return id;
    }

    public Accounts getAccount() {
        return account;
    }

    public void setAccount(Accounts account) {
        this.account = account;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getObjectId() {
        return object_id;
    }

    public void setObjectId(int object_id) {
        this.object_id = object_id;
    }

    private static Dao<AccountLog, Integer> dao;

    public static Dao<AccountLog, Integer> getDao() {
        if (dao == null) {
            try {
                dao = DaoManager.createDao(BaseDatabaseFactory.getInstance().getConnectionSource(), AccountLog.class);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dao;
    }
}
