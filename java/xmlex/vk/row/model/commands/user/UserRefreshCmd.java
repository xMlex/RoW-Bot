package xmlex.vk.row.model.commands.user;

import org.json.JSONObject;
import xmlex.vk.row.model.commands.BaseCmd;

import java.util.ArrayList;

public class UserRefreshCmd extends BaseCmd {

    public ArrayList<Integer> questList = new ArrayList<Integer>();

    public void makeRequestDto(String o) {
        JSONObject ret = new JSONObject();
        ret.put("y", (Object) null);
        ret.put("t", (Object) null);
        ret.put("y", (Object) null);
        ret.put("y", (Object) null);
    }

    @Override
    public void onResponce(String data) {
        // TODO Auto-generated method stub

    }

    @Override
    public void onCreate() {
        // TODO Auto-generated method stub

    }
}
