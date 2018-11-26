package xmlex.vk.row.model.commands.sector;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.json.JSONObject;
import xmlex.vk.row.RowSkillManager;
import xmlex.vk.row.model.commands.BaseCmd;

public class ImproveSkill extends BaseCmd {

    private JSONObject _requestDto = new JSONObject();
    private RowSkillManager skillm = null;

    public ImproveSkill(int id) {
        _requestDto.put("i", id);
    }


    public void setManager(RowSkillManager sm) {
        skillm = sm;
    }

    @Override
    public void onResponce(String data) {
        _client.nanopods--;
        if (skillm == null)
            return;
        GsonBuilder gson_builder = new GsonBuilder();
        Gson gson = gson_builder.create();

        try {
            JsonElement element = gson.fromJson(data, JsonElement.class);
            JsonObject dto = element.getAsJsonObject().get("o")
                    .getAsJsonObject().get("s").getAsJsonObject().get("c")
                    .getAsJsonObject();
            skillm.setEndQuery(dto.get("f").getAsLong());
        } catch (Exception e) {
            _log.warning("Not parse! onResponce ImproveSkill: "
                    + e.getMessage());
        }

    }

    @Override
    public void onCreate() {
        _method = "ImproveSkill";
        _request = _client.makeRequestDto(_requestDto);
    }

}
