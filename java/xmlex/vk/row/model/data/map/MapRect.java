package xmlex.vk.row.model.data.map;

import com.google.gson.JsonElement;
import org.json.JSONObject;

public class MapRect {

    public int x1;
    public int y1;
    public int x2;
    public int y2;

    public static MapRect fromDto(JsonElement jl) {
        if (jl == null) {
            return null;
        }
        MapRect _loc2_ = new MapRect();
        _loc2_.x1 = jl.getAsJsonObject().get("x").getAsInt();
        _loc2_.y1 = jl.getAsJsonObject().get("y").getAsInt();// param1.y;
        _loc2_.x2 = jl.getAsJsonObject().get("v").getAsInt();// param1.v;
        _loc2_.y2 = jl.getAsJsonObject().get("u").getAsInt();// param1.u;
        return _loc2_;
    }

    public JSONObject toDto() {
        JSONObject _loc1_ = new JSONObject();
        _loc1_.put("x", this.x1);
        _loc1_.put("y", this.y1);
        _loc1_.put("v", this.x2);
        _loc1_.put("u", this.y2);
        return _loc1_;
    }

}
