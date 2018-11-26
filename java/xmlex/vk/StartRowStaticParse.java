package xmlex.vk;

import ru.xmlex.common.ConfigSystem;
import xmlex.common.ThreadPoolManager;
import xmlex.extensions.database.L2DatabaseFactory;
import xmlex.extensions.database.mysql;
import xmlex.vk.row.model.StaticData;
import xmlex.vk.row.model.staticdata.BaseRowObject;
import xmlex.vk.row.model.staticdata.BaseRowObject.LvlInfo;
import xmlex.vk.row.model.staticdata.SkillManager.Skill;

import java.sql.SQLException;
import java.util.Map.Entry;
import java.util.logging.Logger;

public class StartRowStaticParse {
    static Logger _log = Logger.getLogger(StartRowStaticParse.class.getName());
    static String StaticStr = null;

    public static void main(String[] args) {
        ConfigSystem.load();
        try {
            L2DatabaseFactory.getInstance();
        } catch (SQLException e) {
            e.printStackTrace();
            _log.warning("SQL: " + e.getMessage());
            return;
        }
        ThreadPoolManager.getInstance();
        StaticData.getInstance();

        mysql.set("TRUNCATE `row_static`;");
        mysql.set("TRUNCATE `row_static_lvls`;");

        StringBuffer builds = new StringBuffer();
        StringBuffer build_lvls = new StringBuffer();

        for (Entry<Integer, BaseRowObject> _el : StaticData.getInstance().buildings
                .entrySet()) {
            // _log.info("Name: "+_el.getValue().name+" id: "+_el.getValue().id+" type: "+_el.getValue().type);

            if (builds.length() > 0)
                builds.append(",\n");
            builds.append("(" + _el.getValue().id + ", '" + _el.getValue().name
                    + "', '" + _el.getValue().description + "', '"
                    + _el.getValue().type + "')");

            for (Entry<Integer, LvlInfo> _lel : _el.getValue().lvlList
                    .entrySet()) {
                if (build_lvls.length() > 0)
                    build_lvls.append(",\n");
                build_lvls.append("(" + _el.getValue().id + ", "
                        + (_lel.getKey() + 1) + ", "
                        + _lel.getValue().buildtime + "," + _lel.getValue().res.SQLInsert() + ")");

            }
        }
        _log.info("Query: Builds list...");
        mysql.set("INSERT INTO `row_static` VALUES " + builds.toString() + ";");

        _log.info("Query: Builds lvl list...");
        mysql.set("INSERT INTO `row_static_lvls` VALUES "
                + build_lvls.toString() + ";");
        _log.info("ok");

        mysql.set("TRUNCATE `row_skills`;");
        mysql.set("TRUNCATE `row_skills_depend`;");
        for (Entry<Integer, Skill> _el : StaticData.getInstance().centerUpgrade.skills
                .entrySet()) {
            Skill skill = (Skill) _el.getValue();
            // _log.info("Name: "+skill.name+" id: "+skill.id);
            mysql.set("INSERT INTO `row_skills`  VALUES (" + skill.id + ", '"
                    + skill.name + "');");
            for (Entry<Integer, Integer> dep : skill.dependence.entrySet()) {
                // _log.info("\tid: "+dep.getKey()+" lvl: "+dep.getValue());
                mysql.set("INSERT INTO `row_skills_depend`  VALUES ("
                        + skill.id + ", " + dep.getKey() + "," + dep.getValue()
                        + ");");
            }
        }

        _log.info("** END ***");
    }

}
