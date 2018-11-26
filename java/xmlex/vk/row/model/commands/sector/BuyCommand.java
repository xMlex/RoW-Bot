package xmlex.vk.row.model.commands.sector;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import org.json.JSONObject;
import xmlex.vk.row.RowBuildManager;
import xmlex.vk.row.model.commands.BaseCmd;
import xmlex.vk.row.model.data.users.buildings.SectorObject;

public class BuyCommand extends BaseCmd {

    private JSONObject _requestDto = null;

    private RowBuildManager buildm = null;
    private SectorObject sobj = null;

    public BuyCommand(SectorObject _obj) {
        sobj = _obj;
        _requestDto = new JSONObject();
        _requestDto.put("g", false);
        _requestDto.put("o", _obj.toDto());
    }

    @Override
    public void onResponce(String data) {

        if (buildm == null)
            return;

        //_client.money.minusRes(sobj.)

        GsonBuilder gson_builder = new GsonBuilder();
        Gson gson = gson_builder.create();
        try {
            JsonElement element = gson.fromJson(data, JsonElement.class);
            JsonObject dto = element.getAsJsonObject().get("o")
                    .getAsJsonObject();
            buildm.setEndQuery(dto.get("f").getAsLong());
        } catch (Exception e) {
            _log.warning("Not parse! onResponce BuyCommand: " + e.getMessage());
            //buildm.setEndQuery(System.currentTimeMillis()+(60*60*1000));
        }
    }

    @Override
    public void onCreate() {
        _method = "Buy";
        _request = _client.makeRequestDto(_requestDto);
    }

    public void setBuildm(RowBuildManager buildm) {
        this.buildm = buildm;
    }
}
