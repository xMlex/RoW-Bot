package ru.xmlex.row.game.data.commands;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import ru.xmlex.row.game.data.users.misc.FavouriteUser;

import java.util.ArrayList;
import java.util.List;

public class AutoRefreshCmd extends BaseCommand {

    public List<FavouriteUser> favouriteUsers = new ArrayList<FavouriteUser>(0);

    @Override
    public void onCommandInit() {
        setAction("AutoRefresh");

        UserRefreshCmd old = new UserRefreshCmd(null);
        old.setClient(getClient());
        old.onCommandInit();

        JsonObject obj = getGsonWithoutExpose().fromJson(old.getBody(), JsonObject.class);
        obj.remove("o");

//        obj.add("k", far);

        if (favouriteUsers.size() > 0) {
            JsonArray far = new JsonArray();
            for (FavouriteUser user : favouriteUsers) {
                far.add(getGsonWithoutExpose().toJsonTree(user));
            }
            obj.add("k", far);
        }

        setBody(getGsonWithoutExpose().toJson(obj));
    }

    @Override
    public void onCommandResult(String result) {

    }
}
