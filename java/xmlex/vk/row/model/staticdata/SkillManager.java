package xmlex.vk.row.model.staticdata;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import java.util.HashMap;
import java.util.Map.Entry;
import java.util.logging.Logger;

public class SkillManager {
    private static final Logger _log = Logger.getLogger(SkillManager.class.getName());
    public HashMap<Integer, Skill> skills = new HashMap<Integer, Skill>();

    public class Skill {
        /**
         * pos=e номер скила
         */
        public int id = 0, x, y, e, pos;
        public String name = "";
        /**
         * Зависимость id скила и уровень(lvl)
         */
        public HashMap<Integer, Integer> dependence = new HashMap<Integer, Integer>();
        /**
         * Уровень, время
         */
        public HashMap<Integer, Integer> lvls = new HashMap<Integer, Integer>();
    }

    public class VisualSkill {
        public int id = 0, lvl = 0;
        public long start = 0, end = 0;

        public boolean inProgress() {
            if (end > 0)
                return (System.currentTimeMillis() - end) <= 0;
            return false;
        }
    }

    public synchronized boolean TryLearnSkill(int id, HashMap<Integer, VisualSkill> skilllist) {

        HashMap<Integer, Integer> dep = getDependence(id);
        if (dep == null)
            return false;
        for (Entry<Integer, Integer> msk : dep.entrySet()) {
            if (!skilllist.containsKey(msk.getKey()))
                return false;
            if (skilllist.get(msk.getKey()).lvl < msk.getValue())
                return false;
            if (skilllist.get(msk.getKey()).lvl >= 40)
                return false;
            if (skilllist.get(id) == null)
                return false;
            if (skilllist.get(id).inProgress())
                return false;
            if (skills.get(id) != null) {
                if (skills.get(id).lvls.size() <= skilllist.get(id).lvl) {
                    //_log.info("LVL MAX: "+skills.get(id).lvls.size()+" cur: "+skilllist.get(id).lvl);
                    return false;
                }
            }
        }
        return true;
    }

    public VisualSkill VisualSkillfromDto(JsonObject obj) {
        VisualSkill ret = new VisualSkill();
        ret.lvl = obj.get("c").getAsJsonObject().get("l").getAsInt();
        ret.id = obj.get("t").getAsInt();
        if (obj.get("c").getAsJsonObject().get("f") != null) {
            ret.end = obj.get("c").getAsJsonObject().get("f").getAsLong();
            //_log.info("End skill time: "+ret.end);
        }
        if (obj.get("c").getAsJsonObject().get("s") != null)
            ret.start = obj.get("c").getAsJsonObject().get("s").getAsLong();
        //_log.info(obj.toString());
        return ret;
    }

    /**
     * Возвращает зависимости скила, если нету скила или зависимостей то null
     */
    public synchronized HashMap<Integer, Integer> getDependence(int id) {

        if (!skills.containsKey(id))
            return null;

        if (skills.get(id).dependence.size() > 0)
            return skills.get(id).dependence;
        else
            return null;

    }

    public synchronized String getNameById(int id) {
        if (skills.containsKey(id))
            return skills.get(id).name;
        return "Skill no name!";
    }


    public synchronized void parseSelf(JsonArray ja) {

        for (int i = 0; i < ja.size(); i++) {
            JsonObject _item = ja.get(i).getAsJsonObject();
            Skill _cui = new Skill();
            _cui.id = _item.get("i").getAsInt();
            _cui.name = _item.get("n").getAsJsonObject().get("c").getAsString();
            _cui.x = _item.get("x").getAsInt();
            _cui.y = _item.get("y").getAsInt();
            _cui.pos = _item.get("e").getAsInt();

            if (_item.get("r") != null) {
                JsonArray _dep = _item.get("r").getAsJsonArray();
                for (int j = 0; j < _dep.size(); j++) {
                    JsonObject _d = _dep.get(j).getAsJsonObject();
                    _cui.dependence.put(_d.get("i").getAsInt(), _d.get("l").getAsInt());
                }
            }

            JsonArray _lvl = _item.get("l").getAsJsonArray();
            for (int j = 0; j < _lvl.size(); j++) {
                JsonObject _l = _lvl.get(j).getAsJsonObject();
                _cui.lvls.put(j + 1, _l.get("t").getAsInt());
            }
            skills.put(_cui.id, _cui);
        }
        _log.info("Loaded " + skills.size() + " skills.");
    }
}
