package ru.xmlex.row.game.data.commands;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.scenes.SectorScene;

import java.util.ArrayList;

/**
 * Created by mlex on 22.12.16.
 */
public class SaveSceneCmd extends BaseCommand {

    @Expose
    @SerializedName("s")
    public final SectorScene scene;
    @Expose
    @SerializedName("d")
    public ArrayList<Integer> deletedObjectIds = new ArrayList<>();
    @Expose
    @SerializedName("w")
    public boolean isWarcamp = false;

    public SaveSceneCmd(SectorScene scene) {
        this.scene = scene;
    }

    @Override
    public void onCommandInit() {
        setAction("SaveScene");

        UserRefreshCmd cmd = new UserRefreshCmd(this);
        cmd.setClient(getClient());
        cmd.onCommandInit();

        setBody(cmd.getBody());
    }

    @Override
    public void onCommandResult(String result) {
        log.info("Scene saved: " + result);
    }
}
