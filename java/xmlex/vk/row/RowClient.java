package xmlex.vk.row;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.json.JSONArray;
import org.json.JSONObject;
import xmlex.common.ThreadPoolManager;
import xmlex.ext.Rnd;
import xmlex.vk.VkUserInfo;
import xmlex.vk.row.model.ServerTimeManager;
import xmlex.vk.row.model.StaticData;
import xmlex.vk.row.model.commands.BaseCmd;
import xmlex.vk.row.model.data.Resources;
import xmlex.vk.row.model.data.UserGameData;
import xmlex.vk.row.model.data.users.UserSocialData;
import xmlex.vk.row.model.data.users.buildings.SectorObject;
import xmlex.vk.row.model.staticdata.SkillManager.VisualSkill;

import java.util.ArrayList;
import java.util.logging.Logger;

public class RowClient implements Runnable {

    private static final Logger _log = Logger.getLogger(RowClient.class.getName());

    public ServerTimeManager serverTimeManager = new ServerTimeManager();
    public NetworkAdapter connection = null;

    public int id;
    public UserSocialData socialData;
    public UserGameData gameData;
    public Resources money = new Resources();
    public int nanopods = 0;
    private VkUserInfo vk;

    public ArrayList<Integer> questIdList = new ArrayList<Integer>();

    private RowSkillManager skillManager = null;
    private RowBuildManager buildManager = null;

    public RowClient() {
        vk = new VkUserInfo();
        connection = new NetworkAdapter(this);

        skillManager = new RowSkillManager(this);
        ThreadPoolManager.getInstance().scheduleGeneralAtFixedRate(skillManager, 5000, 5000);
        buildManager = new RowBuildManager(this);
        ThreadPoolManager.getInstance().scheduleGeneralAtFixedRate(buildManager, 10000, 10000);

        ThreadPoolManager.getInstance().scheduleGeneralAtFixedRate(this, 600000 + Rnd.get(2000, 20000), 1800 * 1000 + Rnd.get(20000, 120000));

    }

    public VkUserInfo getVkInfo() {
        return vk;
    }

    public void go() {
        connection.setVkUser(vk);
        //
    }

    public void setConnection(NetworkAdapter _c) {
        connection = _c;
    }

    public void parseSelf(JsonObject dto) {

        JsonArray _secObj = dto.get("u").getAsJsonObject().get("g").getAsJsonObject().get("sd")
                .getAsJsonObject().get("s").getAsJsonObject().get("o").getAsJsonArray();
        buildManager.sectorObjects.clear();
        for (int i = 0; i < _secObj.size(); i++) {
            SectorObject it = SectorObject.fromDto(_secObj.get(i));
            if (it != null) {
                // System.out.println(" bid: " + it.id + " i: "+it.i);
                buildManager.sectorObjects.put(it.i, it);
            }
        }
        if (NetworkAdapter.debug)
            _log.info("Loaded " + buildManager.sectorObjects.size() + " sectorObjects.");
        // Skills
        skillManager.skills.clear();
        _secObj = dto.get("u").getAsJsonObject().get("g").getAsJsonObject().get("sa")
                .getAsJsonObject().get("s").getAsJsonArray();
        for (int i = 0; i < _secObj.size(); i++) {
            VisualSkill _new = StaticData.getInstance().centerUpgrade.VisualSkillfromDto(_secObj.get(i).getAsJsonObject());
            skillManager.skills.put(_new.id, _new);
            if (NetworkAdapter.debug)
                _log.info("Skill: " + StaticData.getInstance().centerUpgrade.getNameById(_new.id) +
                        " LVL: " + _new.lvl);
        }
        nanopods = dto.get("u").getAsJsonObject().get("g").getAsJsonObject().get("sa")
                .getAsJsonObject().get("p").getAsInt();

        // Quest list
        questIdList.clear();
        _secObj = dto.get("u").getAsJsonObject().get("g").getAsJsonObject().get("qd")
                .getAsJsonObject().get("q").getAsJsonArray();
        for (int i = 0; i < _secObj.size(); i++)
            questIdList.add(_secObj.get(i).getAsJsonObject().get("l").getAsInt());


        money = Resources.fromDto(dto.get("u").getAsJsonObject().get("g").getAsJsonObject()
                .get("a").getAsJsonObject().get("r"));

        connection.revison = dto.get("u").getAsJsonObject().get("g").getAsJsonObject().get("r")
                .getAsInt();
        // _log.info("Credits: "+money.toString());

        // _log.info("Try build: "+StaticData.getInstance().isTryBuild(,
        // money));
        update();
		
		/*chekToBuy();
		if(nanopods > 0)
			chekSkills();*/
    }

    private void update() {
        skillManager.update();
        buildManager.update();
    }


    public synchronized JSONObject makeRequestDto(JSONObject o) {
        JSONObject ret = new JSONObject();
        ret.put("y", (Object) null);
        ret.put("t", serverTimeManager.getServerTimeNow().getTime());
        ret.put("u", serverTimeManager.getSessionStartTimeMs());
        ret.put("g", serverTimeManager.getSessionInGameTimeMs());
        ret.put("o", o);
        JSONArray qList = new JSONArray();
        for (int i = 0; i < questIdList.size(); i++)
            qList.put(questIdList.get(i));

        ret.put("q", qList);
        ret.put("r", connection.revison);

        return ret;
    }


    @Override
    public void run() {
        go();
    }

    public void runCmd(BaseCmd cmd) {
        if (cmd == null) {
            _log.warning("Not run cmd == null!");
            return;
        }
        cmd.setClient(this);
        _log.info("Run cmd: " + cmd.getClass().getName());
        ThreadPoolManager.getInstance().executeGeneral(cmd);
        //cmd.run();
    }

}
