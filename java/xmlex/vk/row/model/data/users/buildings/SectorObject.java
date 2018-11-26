package xmlex.vk.row.model.data.users.buildings;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.json.JSONObject;
import xmlex.vk.row.model.data.Resources;

public class SectorObject {

    public int level = 0, id = 0, h = 0, m = 0;
    public int x, y, i;
    public long endBuildTime = -1;

    public Resources getRes() {
        Resources res = new Resources();
        /*TODO выбор стоимости здания для улучшения на основе текущего уровня. */
        return res;
    }

    public static SectorObject fromDto(JsonElement param1) {
        if (param1 == null) {
            System.out.println("WARNING: SectorObject fromDto argument = null");
            return null;
        }
        JsonObject p = param1.getAsJsonObject();
        SectorObject _ret = new SectorObject();
        _ret.i = p.get("i").getAsInt();
        _ret.id = p.get("t").getAsInt();

        JsonObject t = p.get("c").getAsJsonObject();
        if (t.get("f") != null)
            _ret.endBuildTime = t.get("f").getAsLong();


        _ret.level = p.get("c").getAsJsonObject().get("l").getAsInt();

        _ret.h = p.get("gi").getAsJsonObject().get("h").getAsInt();
        _ret.m = p.get("gi").getAsJsonObject().get("m").getAsInt();
        _ret.x = p.get("gi").getAsJsonObject().get("x").getAsInt();
        _ret.y = p.get("gi").getAsJsonObject().get("y").getAsInt();

        return _ret;
    }

    public JSONObject toDto() {
        JSONObject dto = new JSONObject();

        dto.put("d", (Object) null);
        dto.put("tci", (Object) null);
        dto.put("ti", (Object) null);
        dto.put("t", id);
        dto.put("i", i);
        dto.put("bi", new JSONObject());

        JSONObject c = new JSONObject();
        c.put("f", (Object) null);
        c.put("s", (Object) null);
        c.put("l", level);

        dto.put("c", c);

        JSONObject gi = new JSONObject();
        gi.put("m", false);
        gi.put("x", x);
        gi.put("y", y);

        dto.put("gi", gi);

        //dto.put("", "");

        return dto;
    }

    public boolean isBuildProgress() {
        if (endBuildTime > 0)
            if (System.currentTimeMillis() >= endBuildTime)
                return false;
            else
                return true;
        else
            return false;
    }

}
