package xmlex.vk.row.model.data;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.json.JSONObject;

public class Resources {

    public int goldMoney = 0;
    public int money = 0;
    public int uranium = 0;
    public int titanite = 0;
    public int biochips = 0;

    /**
     * Сравниваем себя и параметр, если у себя чего то меньше то false return
     */
    public Boolean greaterOrEquals(Resources param1) {
        return this.goldMoney >= param1.goldMoney && this.money >= param1.money
                && this.uranium >= param1.uranium && this.titanite >= param1.titanite
                && this.biochips >= param1.biochips;
    }

    public Boolean equals(Resources param1) {
        return param1.goldMoney == this.goldMoney && param1.money == this.money
                && param1.uranium == this.uranium && param1.titanite == this.titanite
                && param1.biochips == this.biochips;
    }

    public Boolean notEquals(Resources param1) {
        return !this.equals(param1);
    }

    @Override
    public String toString() {
        return "{g:" + this.goldMoney + ",m:" + this.money + ",u:" + this.uranium + ",t:"
                + this.titanite + ",c:" + this.biochips + "}";
    }

    public JSONObject toDto() {

        JSONObject ret = new JSONObject();
        ret.put("g", this.goldMoney);
        ret.put("m", this.money);
        ret.put("u", this.uranium);
        ret.put("t", this.titanite);
        ret.put("c", this.biochips);
        return ret;
    }

    public static Resources fromDto(JsonElement param1) {
        if (param1 == null) {
            System.out.println("ERROR Resource null !");
            return null;
        }
        JsonObject p = param1.getAsJsonObject();
        Resources _loc2_ = new Resources();
        _loc2_.goldMoney = p.get("g").getAsInt();
        _loc2_.money = p.get("m").getAsInt();
        _loc2_.uranium = p.get("u").getAsInt();
        _loc2_.titanite = p.get("t").getAsInt();
        _loc2_.biochips = p.get("c") != null ? p.get("c").getAsInt() : 0;
        return _loc2_;
    }

    /**
     * g,c,u,t,b
     */
    public String SQLInsert() {
        return this.goldMoney + "," + this.money + "," + this.uranium + ","
                + this.titanite + "," + this.biochips;
    }

    public String friendStr() {
        return " Cry:" + this.goldMoney + " Credit`s:" + this.money + " Uran:" + this.uranium + " Titanit:"
                + this.titanite + " BioChips:" + this.biochips + " ";
    }

}
