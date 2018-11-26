package ru.xmlex.row.game.logic.commands.inventory;

import com.google.gson.JsonObject;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.commands.BaseCommand;
import ru.xmlex.row.game.data.commands.UserRefreshCmd;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;

/**
 * Created by mlex on 23.12.16.
 */
public class PowderInventoryItemCmd extends BaseCommand {

    @Expose
    @SerializedName("o")
    private JsonObject object = new JsonObject();

    public PowderInventoryItemCmd(GeoSceneObject item) {
        object.addProperty("i", item.id);
    }

    @Override
    public void onCommandInit() {
        setAction("PowderInventoryItem");

        UserRefreshCmd cmd = new UserRefreshCmd(object);
        cmd.setClient(getClient());
        cmd.onCommandInit();

        setBody(cmd.getBody());
    }

    @Override
    public void onCommandResult(String result) {

    }
}
