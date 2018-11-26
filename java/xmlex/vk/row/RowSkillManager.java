package xmlex.vk.row;

import xmlex.extensions.database.mysql;
import xmlex.vk.row.model.StaticData;
import xmlex.vk.row.model.commands.sector.ImproveSkill;
import xmlex.vk.row.model.staticdata.SkillManager.VisualSkill;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;
import java.util.logging.Logger;

public class RowSkillManager implements Runnable {
    private static final Logger _log = Logger.getLogger(RowSkillManager.class.getName());

    private RowClient _client = null;
    public HashMap<Integer, VisualSkill> skills = new HashMap<Integer, VisualSkill>();
    private ArrayList<Integer> map = null;
    private long q_end = 0;
    private boolean working = false;
    private ImproveSkill cmd = null;

    public RowSkillManager(RowClient client) {
        _client = client;
    }

    public void setEndQuery(long q) {
        q_end = q;
    }

    @Override
    public void run() {
        if (_client == null) {
            _log.warning("Client = null");
            return;
        }
        if (!working) {
            _log.warning("Not working");
            return;
        }
        if (_client.nanopods < 1) {
            //_log.warning("Nanopods not hasve");
            return;
        }
        if (System.currentTimeMillis() > q_end) {
            learnSkills();
        }
    }

    public void update() {
        working = true;
    }

    public void learnSkills() {
        for (Entry<Integer, VisualSkill> _el : skills.entrySet()) {
            if (_el.getValue().inProgress()) {
                q_end = _el.getValue().end;
                _log.info("IGNORE Learn skill: " + StaticData.getInstance().centerUpgrade.getNameById(_el.getValue().id) + " END: " +
                        (System.currentTimeMillis() - q_end));
                return;
            }
        }
        if (map == null)
            map = mysql.get_int_array("skill", "row_skill_map", "ORDER BY `id` DESC");


        for (int i = 0; i < map.size(); i++) {
            if (StaticData.getInstance().centerUpgrade.TryLearnSkill(map.get(i), skills)) {
                cmd = new ImproveSkill(map.get(i));
                cmd.setManager(this);
                try {
                    //_client.runCmd(cmd);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                skills.get(map.get(i)).lvl++;
                return;
            }
        }
        //_log.info("No skill to learn");
    }

}