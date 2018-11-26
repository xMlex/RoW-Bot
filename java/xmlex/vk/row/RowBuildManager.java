package xmlex.vk.row;

import xmlex.vk.row.model.StaticData;
import xmlex.vk.row.model.commands.sector.BuyCommand;
import xmlex.vk.row.model.data.users.buildings.SectorObject;

import java.util.HashMap;
import java.util.Map.Entry;
import java.util.logging.Logger;

public class RowBuildManager implements Runnable {
    private static final Logger _log = Logger.getLogger(RowBuildManager.class.getName());
    private RowClient _client = null;

    public HashMap<Integer, SectorObject> sectorObjects = new HashMap<Integer, SectorObject>();

    private long build_end_time = 0;
    private boolean working = false;

    public RowBuildManager(RowClient client) {
        _client = client;
    }

    public void setEndQuery(long q) {
        build_end_time = q;
    }

    @Override
    public void run() {
        if (_client == null)
            return;
        if (!working) return;
        if ((System.currentTimeMillis() - build_end_time) > 0)
            chekToBuy();
    }

    public void update() {
        working = true;
    }

    private void chekToBuy() {

        //Integer[][] dbmap =  mysql.(ides, "row_static_map", "");

        SectorObject it = null;
        boolean isCurBuild = false;
        for (Entry<Integer, SectorObject> _el : sectorObjects.entrySet()) {

            SectorObject el = _el.getValue();
            if (el.isBuildProgress() && el.id != 800) {
                //_log.info("** Item " + StaticData.getInstance().buildings.get(el.id).name + "("+ el.id + ") in progress");
                isCurBuild = true;
            }

            if (RowUtils.inStaticMap(el.id)) {
                if (StaticData.getInstance().isTryBuild(el, _client.money) && !el.isBuildProgress()) {
                    if (it == null)
                        it = el;
                    if (el.level < it.level)
                        it = el;
                }
            }

        }
        if (it == null) {
            build_end_time = System.currentTimeMillis() + (30 * 60 * 1000);
            return;
        }


        if (isCurBuild) {
            _log.fine("IGNORE Buy " + StaticData.getInstance().buildings.get(it.id).name + "("
                    + it.id + ") Level: " + it.level);
            return;
        }


        if (StaticData.getInstance().buildings.containsKey(it.id)) {
            _log.fine("Try Buy " + StaticData.getInstance().buildings.get(it.id).name + "(" + it.id
                    + ") Level: " + it.level);
            BuyCommand bc = new BuyCommand(it);
            bc.setBuildm(this);
            _client.runCmd(bc);
            working = false;
            build_end_time = System.currentTimeMillis()
                    + (StaticData.getInstance().buildings.get(it.id).lvlList.get(it.level).buildtime / 60 * 1000);
        } else
            _log.fine("Not Try Buy " + it.id + " Level: " + it.level);
    }
}
