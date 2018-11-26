package ru.xmlex.row.game.logic.commands.sector;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.common.ConfigSystem;
import ru.xmlex.row.game.data.commands.BaseCommand;
import ru.xmlex.row.game.data.commands.UserRefreshCmd;
import ru.xmlex.row.game.data.scenes.SceneObject;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;

/**
 * Created by xMlex on 4/6/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class BuyCommand extends BaseCommand {
    @Expose
    @SerializedName("o")
    public GeoSceneObject object;

    private SceneObject objectToUpdate;
    @Expose
    @SerializedName("g")
    private boolean goldBuy = false;
    @Expose
    @SerializedName("n")
    private boolean buyInstantly = false;

    public BuyCommand(GeoSceneObject object) {
        this.object = object;
    }

    @Override
    public void onCommandInit() {
        setAction("Buy");
        if (ConfigSystem.DEBUG)
            log.info("beginBuyObject: " + getGsonWithoutExpose().toJsonTree(object).toString());

        UserRefreshCmd cmd = new UserRefreshCmd(this);
        cmd.setClient(getClient());
        cmd.onCommandInit();

        setBody(cmd.getBody());
        if (object.isTroops()) {
            getClient().logAction("Покупаем: " + object.getName() + " Count: " + object.troopsInfo.countForBuy, object.type);
        } else {
            getClient().logAction("Улучшаем: " + object.getName() + " Lvl: " + object.getLevel(), object.type);
        }
    }

    @Override
    public void onCommandResult(String result) {
        if (ConfigSystem.DEBUG)
            log.info("BuyAnswer: " + result);
    }
}
