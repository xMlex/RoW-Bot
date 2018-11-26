package ru.xmlex.zp.model;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import ru.xmlex.common.Rnd;
import ru.xmlex.common.dbcp.BaseDatabaseFactory;
import ru.xmlex.zp.core.ZpClient;
import ru.xmlex.zp.net.api.ZpStartResponse;

import java.sql.SQLException;
import java.util.Base64;

/**
 * Created by mlex on 19.10.16.
 */
@DatabaseTable(tableName = "zp_auth_keys")
public class ZpAuthKey {
    @DatabaseField(generatedId = true)
    public int id;

    @DatabaseField(columnName = "user_id")
    public int userId;

    @DatabaseField(columnName = "active")
    public boolean active;

    @DatabaseField(columnName = "social_type")
    public String socialType;

    @DatabaseField(columnName = "social_id")
    public String socialId;

    @DatabaseField(columnName = "name")
    public String name;

    @DatabaseField(columnName = "auth_key")
    public String authKey;

    @DatabaseField(columnName = "is_cheesecakes")
    public boolean isCheesecakes;

    @DatabaseField(columnName = "item_id")
    public String itemId;

    @DatabaseField(columnName = "created_at")
    public String createdAt;

    @DatabaseField(columnName = "updated_at")
    public String updatedAt;

    public ZpStartResponse startResponse;
    private ZpClient client;

    private static Dao<ZpAuthKey, Integer> dao;

    public static Dao<ZpAuthKey, Integer> getDao() {
        if (dao == null) {
            try {
                dao = DaoManager.createDao(BaseDatabaseFactory.getInstance().getConnectionSource(), ZpAuthKey.class);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dao;
    }

    public String generateAuth() {
        return generateAuth(false);
    }

    public String generateAuth(boolean isBase64) {
        String k = "{\"access_token\":\"cff91c0b06d6b2ee0a09e73ccbd407560bd7d44a63c31c614f088801bfa79429c1f20410e0f2305" + Rnd.get(1000000, 999999) + "\",\"auth_key\":\"" + authKey + "\",\"viewer_id\":\"" + socialId + "\",\"api_url\":\"https://api.vk.com/api.php\"}";
        if (isBase64)
            return Base64.getEncoder().encodeToString(k.getBytes());
        return k;
    }

    public String getAppId() {
        if (socialType.equalsIgnoreCase("vk")) {
            return "2296756";
        } else {
            return "1541888";
        }
    }

    @Override
    public String toString() {
        return "ZpAuthKey[" + id + "] " + userId + " - " + authKey;
    }

    public ZpClient getClient() {
        if (client == null)
            client = new ZpClient();
        return client;
    }
}
