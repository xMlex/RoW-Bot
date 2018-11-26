package ru.xmlex.zp.core.models.amf;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import flex.messaging.io.amf.ASObject;
import ru.xmlex.common.dbcp.BaseDatabaseFactory;

import java.sql.SQLException;

/**
 * Created by mlex on 24.10.2016.
 */
@DatabaseTable(tableName = "zp_actors")
public class MFActor {

    @DatabaseField(columnName = "id", id = true)
    public int id;
    @DatabaseField(columnName = "ident")
    public String ident;
    @DatabaseField(columnName = "type")
    public String type;
    @DatabaseField(columnName = "name")
    public String name;

    public int zsize;
    public int width;
    public int height;

    public int canPack;

    private static Dao<MFActor, Integer> dao;

    public static Dao<MFActor, Integer> getDao() {
        if (dao == null) {
            try {
                dao = DaoManager.createDao(BaseDatabaseFactory.getInstance().getConnectionSource(), MFActor.class);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return dao;
    }

    public void deserialize(Object o) {
        if (o instanceof ASObject) {
            ASObject ob = (ASObject) o;
            ident = (String) ob.get("ident");
            if (ob.containsKey("zsize"))
                zsize = (Integer) ob.get("zsize");
            if (ob.containsKey("width"))
                width = (Integer) ob.get("width");
            id = (Integer) ob.get("id");
            type = (String) ob.get("type");
        }
    }

    @Override
    public String toString() {
        return super.toString();
    }
}
