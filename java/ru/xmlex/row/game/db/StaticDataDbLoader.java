package ru.xmlex.row.game.db;

import com.j256.ormlite.table.TableUtils;
import ru.xmlex.common.ConfigSystem;
import ru.xmlex.common.dbcp.BaseDatabaseFactory;
import ru.xmlex.row.game.data.users.UserNote;
import ru.xmlex.row.game.db.models.*;
import ru.xmlex.row.game.logic.StaticDataManager;
import ru.xmlex.row.game.logic.skills.data.SkillType;
import xmlex.vk.row.model.data.scenes.types.GeoSceneObjectType;

import java.util.logging.Logger;

/**
 * Created by xMlex on 13.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class StaticDataDbLoader {
    static Logger log = Logger.getLogger(StaticDataDbLoader.class.getName());

    public static void main(String[] args) throws Exception {
        ConfigSystem.load();
        BaseDatabaseFactory.getInstance();
        StaticDataManager.initializeFromCache();

        TableUtils.createTableIfNotExists(BaseDatabaseFactory.getInstance().getConnectionSource(), UserNote.class);
        //loadAll();
    }

    public static void loadAll() throws Exception {
        TableUtils.createTableIfNotExists(BaseDatabaseFactory.getInstance().getConnectionSource(), Accounts.class);
        TableUtils.createTableIfNotExists(BaseDatabaseFactory.getInstance().getConnectionSource(), AccountLog.class);
        TableUtils.createTableIfNotExists(BaseDatabaseFactory.getInstance().getConnectionSource(), Skill.class);

        if (DbObjectType.getDao().isTableExists())
            TableUtils.dropTable(BaseDatabaseFactory.getInstance().getConnectionSource(), DbObjectType.class, true);
        //if(DbObjectSaleable.getDao().isTableExists())
        TableUtils.dropTable(BaseDatabaseFactory.getInstance().getConnectionSource(), DbObjectSaleable.class, true);


        TableUtils.createTableIfNotExists(BaseDatabaseFactory.getInstance().getConnectionSource(), DbObjectType.class);
        TableUtils.createTableIfNotExists(BaseDatabaseFactory.getInstance().getConnectionSource(), DbObjectSaleable.class);


        loadSceneObject();
        loadSkills();
    }

    public static void loadSceneObject() throws Exception {
        DbObjectType object = null;
        for (GeoSceneObjectType type : StaticDataManager.getInstance().geoSceneObjectTypeList) {
            object = new DbObjectType();
            object.setId(type.id);
            object.setName(type.name.toString());
            object.setDescr(type.description.toString());
            object.setUrl(type.getUrl());
            DbObjectType.getDao().create(object);
            if (type.saleableInfo != null) {
                DbObjectSaleable saleable = new DbObjectSaleable();
                saleable.setObjectType(object);
                saleable.setLimit(type.saleableInfo.limit);
                saleable.setRequiresAllExistingMaxLevel(type.saleableInfo.requiresAllExistingMaxLevel);
                DbObjectSaleable.getDao().create(saleable);
            }
        }

    }

    public static void loadSkills() throws Exception {
        // Skills
        Skill skill = new Skill();
        TableUtils.clearTable(BaseDatabaseFactory.getInstance().getConnectionSource(), Skill.class);
        for (SkillType skillType : StaticDataManager.getInstance().skillData.skillTypes) {
            skill.setId(skillType.id);
            skill.setName(skillType.name.toString());
            skill.setIconUrl(skillType.iconUrl);
            Skill.getDao().create(skill);
        }
    }
}
