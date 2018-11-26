package xmlex.vk.row.model.staticdata;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import xmlex.vk.row.model.data.Resources;

import java.util.HashMap;

public class BuildInfo {

    public int id = -1;
    public String name = "";
    public GuiInfo gui = new GuiInfo();
    public boolean isWarrior = false;
    public HashMap<Integer, LvlInfo> lvlList = new HashMap<Integer, LvlInfo>();

    public class GuiInfo {
        int a, n, ox, oy, sx, sy, x, y;
        String u;
    }

    public class LvlInfo {
        public int c = 0;
        /**
         * список требуемых ресурсов для покупки
         */
        public Resources res = null;
        public boolean initialized = false;
    }

    public void parseSelf(JsonObject dto) {

        id = dto.get("i").getAsInt();
        name = dto.get("n").getAsJsonObject().get("c").getAsString();
        //System.out.println("Name: " + name + " ID: " + id);


        JsonElement lvl1 = dto.get("si");
        if (lvl1 == null) {
            LvlInfo _lvl = new LvlInfo();
            lvlList.put(1, _lvl);
            isWarrior = true;
        } else {
            JsonArray _lvls = lvl1.getAsJsonObject().get("lc").getAsJsonArray();
            for (int i = 0; i < _lvls.size(); i++) {
                JsonObject _item = _lvls.get(i).getAsJsonObject();
                LvlInfo _lvl = new LvlInfo();
                _lvl.c = _item.get("c").getAsInt();
                //_item = _item.get("p").getAsJsonObject();
                _lvl.res = Resources.fromDto(_item.get("p"));

                //System.out.println("\t LVL: " + i + " c: " + _lvl.res.money+" u: "+_lvl.res.uranium+" t: "+_lvl.res.titanite);
                if (_lvl.res != null)
                    _lvl.initialized = true;
                lvlList.put(i, _lvl);
            }
        }

        //System.out.println("Name: " + name + " ID: " + id + " LVL Count: " + lvlList.size());

    }

}
