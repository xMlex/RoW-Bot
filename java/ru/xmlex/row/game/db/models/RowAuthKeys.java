package ru.xmlex.row.game.db.models;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import ru.xmlex.common.MessageNotifier;
import ru.xmlex.common.dbcp.BaseDatabaseFactory;

import java.sql.SQLException;

/**
 * Created by mlex on 20.12.16.
 */
@DatabaseTable(tableName = "row_auth_keys")
public class RowAuthKeys {
    @DatabaseField(generatedId = true)
    public int id;
    @DatabaseField(columnName = "social_type", canBeNull = true, defaultValue = "vk")
    public String socialType;
    @DatabaseField(columnName = "user_id")
    public int userId;
    @DatabaseField(columnName = "social_id")
    public String socialId;
    @DatabaseField(columnName = "server_id")
    public int serverId;
    @DatabaseField(columnName = "auth_key")
    public String authKey;
    @DatabaseField(columnName = "seed")
    public String seed;
    @DatabaseField(columnName = "photo")
    public String photo;
    @DatabaseField(columnName = "friends")
    public String friends;
    @DatabaseField(columnName = "first_name")
    public String first_name;
    @DatabaseField(columnName = "last_name")
    public String last_name;
    @DatabaseField(columnName = "is_active")
    public int isActive;

    public static Dao<RowAuthKeys, Integer> dao;

    public static Dao<RowAuthKeys, Integer> getDao() {
        if (dao == null) {
            try {
                dao = DaoManager.createDao(BaseDatabaseFactory.getInstance().getConnectionSource(), RowAuthKeys.class);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dao;
    }

    public String getSocialId() {
        return socialType + socialId;
    }

    public String getAuthKey() {
        return authKey;
    }

    public void log(String msg, int id) {
        RowLog model = new RowLog();
        model.userId = this.userId;
        model.authKey = this;
        model.objectId = id;
        model.message = msg;
        try {
            RowLog.getDao().create(model);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deactivateByServerError(String message, int code) {
        this.isActive = 0;
        try {
            getDao().update(this);
            log("Деактивация акканута: " + message, -1);
        } catch (Exception e) {
            e.printStackTrace();
            MessageNotifier.getInstance().log(e.toString());
        }
    }

    @Override
    public String toString() {
        return "RowAuthKeys{" +
                "id=" + id +
                ", socialType='" + socialType + '\'' +
                ", userId=" + userId +
                ", socialId=" + socialId +
                ", isActive=" + isActive +
                '}';
    }
}
