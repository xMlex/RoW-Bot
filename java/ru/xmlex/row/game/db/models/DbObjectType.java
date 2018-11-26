package ru.xmlex.row.game.db.models;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.field.DataType;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import ru.xmlex.common.dbcp.BaseDatabaseFactory;

import java.sql.SQLException;

/**
 * Created by xMlex on 03.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
@DatabaseTable(tableName = "row_scene_objects")
public class DbObjectType {
    @DatabaseField(generatedId = false, index = true, id = true)
    private int id;
    //    @DatabaseField(columnName = "type", canBeNull = false, index = true)
//    private int type;
    @DatabaseField(columnName = "name")
    private String name;
    @DatabaseField(columnName = "description", dataType = DataType.LONG_STRING)
    private String descr;
    @DatabaseField(columnName = "url", dataType = DataType.STRING)
    private String url;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    private static Dao<DbObjectType, Integer> dao;

    public static Dao<DbObjectType, Integer> getDao() {
        if (dao == null) {
            try {
                dao = DaoManager.createDao(BaseDatabaseFactory.getInstance().getConnectionSource(), DbObjectType.class);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dao;
    }
}
