package xmlex.vk.row.model.staticdata;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import xmlex.vk.row.model.data.Resources;

import java.util.HashMap;

public class BaseRowObject {
    /**
     * d.c - описание
     */
    public String description = "";
    /**
     * i - id
     */
    public int id = -1;
    /**
     * n.c - название элемента
     */
    public String name = "";
    /**
     * si.l - Не понятно
     */
    public int l = -1;
    /**
     * si.m - Не понятно
     */
    public int model = -1;
    //public GuiInfo gui = new GuiInfo();
    /* di - если есть значит чертеж */
    /**
     * di - Чертеж
     */
    public Drawing drawing = null;
    /**
     * ti - Воин(пехота, авиация защита)
     */
    public Warior warior = null;
    /**
     * bi - Здание
     */
    public Build build = null;

    public RowObjectType type = RowObjectType.NONE;

    /**
     * si.lc[N] Список доступных уровней<Level,Info>
     */
    public HashMap<Integer, LvlInfo> lvlList = new HashMap<Integer, LvlInfo>();

    public class LvlInfo {
        /**
         * с - Время строительства этого уровня(в секундах)
         */
        public int buildtime = 0;
        /**
         * p - список требуемых ресурсов для покупки
         */
        public Resources res = null;
        /**
         * Доступен ли для строительства\создания
         */
        public boolean initialized = false;
    }

    static enum RowObjectType {
        NONE, BUILD, WARIOR, DRAWING, TECHNOLOGY, ARTIFACT
    }

    public class Build {
    }

    public class Drawing {
        public int p = -1, s = -1;
    }

    public class Warior {
        public int damage = -1;
        /**
         * Защита от пехоты, бронетехники, артилерии, авиации
         */
        public int def_infantry = -1, def_tank = -1, def_artillery = -1, def_air = -1;
        /**
         * Несет ресурсов при грабеже
         */
        public int res_for_rob = -1;
        /**
         * m - Время строительства этого уровня(в минутах)
         */
        public int buildtime = -1;
        /**
         * Потребление кредитов в час
         */
        public int credits = 0;
    }

    public class GuiInfo {
        int a, n, ox, oy, sx, sy, x, y;
        String u;
    }

    /**
     * Возвращает информацию о первом уровне или null
     */
    public LvlInfo getFirstLvl() {
        return lvlList.isEmpty() ? null : lvlList.get(0);
    }

    public void parseSelf(JsonObject dto) {

        id = dto.get("i").getAsInt();
        name = dto.get("n").getAsJsonObject().get("c").getAsString();
        description = dto.get("d").getAsJsonObject().get("c").getAsString();
        // System.out.println("Name: " + name + " ID: " + id);

        // Если четреж то есть этот элемент
        JsonElement di = dto.get("di");
        if (di != null) {
            type = RowObjectType.DRAWING;
            drawing = new Drawing();
            drawing.p = di.getAsJsonObject().get("p").getAsInt();
            drawing.s = di.getAsJsonObject().get("s").getAsInt();
        }
        // Если это член армии
        JsonElement ti = dto.get("ti");
        if (ti != null) {
            warior = new Warior();
            type = RowObjectType.WARIOR;
            warior.credits = ti.getAsJsonObject().get("k").getAsInt();
            JsonObject _t1 = ti.getAsJsonObject().get("lc").getAsJsonArray().get(0)
                    .getAsJsonObject();// .get("b").getAsJsonObject();

            warior.res_for_rob = _t1.get("a").getAsInt();
            warior.buildtime = _t1.get("s").getAsInt();
            JsonObject _t2 = _t1.get("b").getAsJsonObject();
            warior.damage = _t2.get("a").getAsInt();

            JsonArray _t3 = _t2.get("d").getAsJsonArray();
            warior.def_infantry = _t3.get(0).getAsJsonObject().get("d").getAsInt();
            warior.def_tank = _t3.get(1).getAsJsonObject().get("d").getAsInt();
            warior.def_artillery = _t3.get(2).getAsJsonObject().get("d").getAsInt();
            warior.def_air = _t3.get(3).getAsJsonObject().get("d").getAsInt();
        }
        // Если есть инфа о здании
        JsonElement bi = dto.get("bi");
        if (bi != null) {
            build = new Build();
            type = RowObjectType.BUILD;
        }
        // Если есть инфа о технологии
        JsonElement ci = dto.get("ci");
        if (ci != null) {
            type = RowObjectType.TECHNOLOGY;
        }
        // Если есть инфа о артифакте
        JsonElement ai = dto.get("ai");
        if (ai != null) {
            type = RowObjectType.ARTIFACT;
        }

        // Если есть инфа о уровнях
        JsonElement si = dto.get("si");
        if (si != null) {
            l = si.getAsJsonObject().get("l").getAsInt();
            if (si.getAsJsonObject().get("lc") != null) {
                JsonArray lvls = si.getAsJsonObject().get("lc").getAsJsonArray();
                for (int i = 0; i < lvls.size(); i++) {
                    LvlInfo _lvl = new LvlInfo();
                    JsonObject _item = lvls.get(i).getAsJsonObject();
                    _lvl.buildtime = _item.get("c").getAsInt();
                    _lvl.res = Resources.fromDto(_item.get("p"));
                    if (_lvl.res != null)
                        _lvl.initialized = true;
                    lvlList.put(i, _lvl);
                }
            }
        }

        //System.out.println("ID: " + id + "\tType: " + type+"\tLVL Count: "+lvlList.size()+"\tName: " + name);

    }

    /**
     * true если это чертеж
     */
    public boolean isDrawing() {
        return (drawing == null) ? false : true;
    }

    /**
     * true если это воин
     */
    public boolean isWarior() {
        return (warior == null) ? false : true;
    }

    /**
     * true если это здание
     */
    public boolean isBuild() {
        return (warior == null) ? false : true;
    }

}
