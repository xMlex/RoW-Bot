package xmlex.vk.row.model;

import com.google.gson.*;
import ru.xmlex.common.Util;
import xmlex.vk.row.model.data.Resources;
import xmlex.vk.row.model.data.users.buildings.SectorObject;
import xmlex.vk.row.model.staticdata.BaseRowObject;
import xmlex.vk.row.model.staticdata.BaseRowObject.LvlInfo;
import xmlex.vk.row.model.staticdata.SkillManager;

import java.util.HashMap;
import java.util.logging.Logger;

public class StaticData {
    private static final Logger _log = Logger.getLogger(StaticData.class.getName());
    public HashMap<Integer, BaseRowObject> buildings = new HashMap<Integer, BaseRowObject>();
    public SkillManager centerUpgrade = new SkillManager();
    private static StaticData _instance;
    private boolean loaded = false;

    public static StaticData getInstance() {
        if (_instance == null)
            _instance = new StaticData();
        return _instance;
    }

    public StaticData() {
        String StaticStr = Util.readFile("static.json");
        if (StaticStr == null) {
            _log.warning("File static.json not found? exit. ");
            return;
        }
        load(StaticStr);
    }

    /**
     * Проверяет можно ли построить здание, хватает ли ресурсов
     */
    public boolean isTryBuild(SectorObject build, Resources res) {

        int needlvl = build.level;

        if (buildings.containsKey(build.id)) {
            BaseRowObject _tpl = buildings.get(build.id);
            if (_tpl.lvlList.containsKey(needlvl)) {
                LvlInfo lvl = _tpl.lvlList.get(needlvl);
                if (!lvl.initialized) {
                    System.out.println("Byild not init " + build.level + " id: " + build.id);
                    return false;
                }
                if (res.greaterOrEquals(lvl.res)) {
                    return true;
                } else {
                    //System.out.println("Byild lvl "+needlvl+"("+build.level+") not, money not have: "+lvl.res.friendStr()+" Time: "+(lvl.c/60)+" sec.");
                    return false;
                }
            }//else System.out.println("Byild lvl "+build.level+"(max) not up to "+needlvl);
        }//else System.out.println("Byild not found in static");
        return false;
    }

    public void load(String jsonstr) {
        if (loaded) return;

        GsonBuilder gson_builder = new GsonBuilder();
        Gson gson = gson_builder.create();

        JsonElement element = gson.fromJson(jsonstr, JsonElement.class);
        JsonObject dto = element.getAsJsonObject();

        buildings.clear();
        // Object list: sot.[0].
        JsonArray _builds = dto.get("sot").getAsJsonArray();
        for (int i = 0; i < _builds.size(); i++) {
			/*BuildInfo _bi = new BuildInfo();
			_bi.parseSelf(_builds.get(i).getAsJsonObject());
			buildings.put(_bi.id, _bi);*/
            BaseRowObject _bi = new BaseRowObject();
            _bi.parseSelf(_builds.get(i).getAsJsonObject());
            buildings.put(_bi.id, _bi);
        }
        _log.info("Loaded " + buildings.size() + " buildings");

        JsonArray ja = dto.get("sa").getAsJsonObject().get("s").getAsJsonArray();
        centerUpgrade.parseSelf(ja);

        loaded = true;

    }

}
