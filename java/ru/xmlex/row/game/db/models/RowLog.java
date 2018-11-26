package ru.xmlex.row.game.db.models;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import ru.xmlex.common.dbcp.BaseDatabaseFactory;

import java.sql.SQLException;

/**
 * Created by mlex on 27.12.16.
 */
@DatabaseTable(tableName = "row_log")
public class RowLog {
    @DatabaseField(generatedId = true)
    public int id;
    //    @DatabaseField(foreign = true, foreignAutoRefresh = true, columnName = "user_id")
//    private Accounts account;
    @DatabaseField(columnName = "user_id")
    public int userId;
    @DatabaseField(foreign = true, foreignAutoRefresh = true, columnName = "fid_auth_key")
    public RowAuthKeys authKey;
    @DatabaseField(columnName = "fid_object")
    public int objectId;
    @DatabaseField(columnName = "message")
    public String message;

    private static Dao<RowLog, Integer> dao;

    public static Dao<RowLog, Integer> getDao() {
        if (dao == null) {
            try {
                dao = DaoManager.createDao(BaseDatabaseFactory.getInstance().getConnectionSource(), RowLog.class);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dao;
    }
}
