package ru.xmlex.row.game.db.models;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import ru.xmlex.common.dbcp.BaseDatabaseFactory;

import java.sql.SQLException;

/**
 * Created by xMlex on 03.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
@DatabaseTable(tableName = "row_scene_saleable")
public class DbObjectSaleable {
    @DatabaseField(generatedId = true)
    private int id;
    @DatabaseField(columnName = "object_type_id", foreign = true, index = true)
    private DbObjectType object_type;
    @DatabaseField(columnName = "limits")
    private int limit;
    @DatabaseField(columnName = "requiresAllExistingMaxLevel")
    private boolean requiresAllExistingMaxLevel;

    public DbObjectType getObjectType() {
        return object_type;
    }

    public void setObjectType(DbObjectType object_type) {
        this.object_type = object_type;
    }

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public boolean getRequiresAllExistingMaxLevel() {
        return requiresAllExistingMaxLevel;
    }

    public void setRequiresAllExistingMaxLevel(boolean requiresAllExistingMaxLevel) {
        this.requiresAllExistingMaxLevel = requiresAllExistingMaxLevel;
    }

    private static Dao<DbObjectSaleable, Integer> dao;

    public static Dao<DbObjectSaleable, Integer> getDao() {
        if (dao == null) {
            try {
                dao = DaoManager.createDao(BaseDatabaseFactory.getInstance().getConnectionSource(), DbObjectSaleable.class);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dao;
    }
}
