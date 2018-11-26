package xmlex.vk.row.model.data.map;

import com.google.gson.JsonElement;
import org.json.JSONObject;

public class MapPos {

    public int x, y;

    public MapPos() {
        x = 0;
        y = 0;
    }

    public MapPos(int _x, int _y) {
        x = _x;
        _y = y;
    }

    public static MapPos fromDto(JsonElement param1) {
        if (param1 == null) {
            return null;
        }
        MapPos _loc2_ = new MapPos();
        _loc2_.x = param1.getAsJsonObject().get("x").getAsInt();
        _loc2_.y = param1.getAsJsonObject().get("y").getAsInt();
        return _loc2_;
    }

    public JSONObject toDto() {
        JSONObject _loc1_ = new JSONObject();
        _loc1_.put("x", this.x);
        _loc1_.put("y", this.y);
        return _loc1_;
    }

    @Override
    public String toString() {
        return "MapPos[" + this.x + ", " + this.y + "]";
    }
}
