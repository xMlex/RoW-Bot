package ru.xmlex.row.game.logic.commands.sector;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.commands.BaseCommand;
import ru.xmlex.row.game.data.commands.UserRefreshCmd;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;

/**
 * Created by mlex on 27.12.16.
 */
public class RepairBuildingCmd extends BaseCommand {

    @Expose
    @SerializedName("i")
    public int id;

    public RepairBuildingCmd(GeoSceneObject object) {
        id = object.id;
        if (!object.objectType().buildingInfo.canBeBroken || !object.buildingInfo.isBroken())
            throw new RuntimeException("Как так? пытаемся отремонтировать: " + object.toString());

        setAction("RepairBuilding");
    }

    @Override
    public void onCommandInit() {
        UserRefreshCmd cmd = new UserRefreshCmd(this);
        cmd.setClient(getClient());
        cmd.onCommandInit();

        setBody(cmd.getBody());
    }

    @Override
    public void onCommandResult(String result) {

    }
}
