package ru.xmlex.row.game.logic.commands.world;

import com.google.gson.JsonObject;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.common.ConfigSystem;
import ru.xmlex.common.Util;
import ru.xmlex.row.game.data.commands.AutoRefreshCmd;
import ru.xmlex.row.game.data.commands.BaseCommand;
import ru.xmlex.row.game.data.map.MapPos;
import ru.xmlex.row.game.data.map.MapRect;
import ru.xmlex.row.game.data.users.UserNote;
import ru.xmlex.row.game.data.users.misc.FavouriteUser;
import ru.xmlex.row.game.logic.StaticDataManager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by xMlex on 4/10/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class MapGetCmd extends BaseCommand {
    public static final int BLOCK_SIZE = 20;

    private final MapRect rect;
    private final MapGetCmdRequest request = new MapGetCmdRequest();

    public MapGetCmd(MapRect rect) {
        this.rect = rect;
        request.block = getUnknownBlocks(rect);
        if (request.block.size() == 1) {
            request.block.add(new MapPos(request.block.get(0).x, request.block.get(0).y + 1));
        }
    }

    @Override
    public void onCommandInit() {
        setAction("GetMap");
        setBody(getGsonWithoutExpose().toJson(request));
    }

    public static final HashMap<Integer, JsonObject> users = new HashMap<>(200);

    @Override
    public void onCommandResult(String result) {
        //log.info("MapInfo: " + result);
        MapGetResult r = getGsonWithoutExpose().fromJson(result, MapGetResult.class);

        List<FavouriteUser> forAdd = new ArrayList<>();

        System.out.println("Count: " + r.userNotes.length);
        for (UserNote el : r.userNotes) {
            if (!el.isInactive())
                continue;

            if (el.inactiveDays() > 40 && el.level > 60) {
                FavouriteUser user = new FavouriteUser();
                user.addDate = System.currentTimeMillis();
                user.typeId = 1;
                user.userId = el.id;
                user.comment = el.level + ": " + el.inactiveDays() + " Robbery";
                forAdd.add(user);
                System.out.println("User: " + el.userName + ": " + " lvl: " + el.level + " InActive: " + el.inactiveDays() + " d." + " Pos: " + el.mapPos.x + ":" + el.mapPos.y);
            }


            // Сохраняем в бд
//            try {
//                UserNote.getDao().createOrUpdate(el);
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }

//            JsonObject obj = new JsonObject();
//            int id = Integer.valueOf(el.socialId.replace("vk", ""));
//            obj.addProperty("uid", id);
//            obj.addProperty("user_id", id);
//            String[] names = el.getName().split(" ");
//            if (names.length >= 2) {
//                obj.addProperty("first_name", names[0]);
//                obj.addProperty("last_name", names[1]);
//            } else {
//                obj.addProperty("first_name", el.getName());
//                obj.addProperty("last_name", "");
//            }
//            obj.addProperty("online", 0);
//            obj.addProperty("photo_big", el.photoUrl);
//            obj.add("lists", new JsonArray());
//            //log.info(obj.toString());
//            users.put(id, obj);
        }

        if (forAdd.size() > 0) {
            AutoRefreshCmd cmd = new AutoRefreshCmd();
            cmd.favouriteUsers.addAll(forAdd);
//            getClient().executeCmd(cmd);
        }

    }

    private static List<MapPos> getBlocks(MapRect mapRect) {
        List<MapPos> result = new ArrayList<>();

        int y1 = 0;
        MapRect converted = convertRectToBlockRect(mapRect);
        int x1 = converted.x1;
        while (x1 <= converted.x2) {
            y1 = converted.y1;
            while (y1 <= converted.y2) {
                result.add(new MapPos(x1, y1));
                y1++;
            }
            x1++;
        }
        return result;
    }

    public static void main(String[] args) {
        ConfigSystem.load();
        StaticDataManager.initializeFromCache();

        MapGetResult r = getGsonWithoutExpose().fromJson(Util.readFile("./log/map.json"), MapGetResult.class);
        for (UserNote el : r.userNotes) {
            if (el.level > 45 && el.lastReturnDate != -1)
                log.info("N: " + el.userName + " l: " + el.level + " last: " + Util.formatTime((System.currentTimeMillis() - el.lastReturnDate) / 1000) + " pos: " + el.mapPos.toString()
                );
        }
    }

    private static List<MapPos> getUnknownBlocks(MapRect param1) {
        boolean _loc5_ = false;
        MapPos _loc7_ = null;
        List<MapPos> _loc2_ = getBlocks(param1);
        List<MapPos> _loc3_ = new ArrayList<>();
        for (MapPos _loc4_ : _loc2_) {
            _loc3_.add(_loc4_);
        }
        return _loc3_;
    }

    private static MapRect convertRectToBlockRect(MapRect param1) {
        return new MapRect(convertPosToBlockPos(param1.x1), convertPosToBlockPos(param1.y1), convertPosToBlockPos(param1.x2), convertPosToBlockPos(param1.y2));
    }

    private static int convertPosToBlockPos(int param1) {
        return param1 >= 0 ? Integer.valueOf(param1 / BLOCK_SIZE) : Integer.valueOf((param1 - BLOCK_SIZE + 1) / BLOCK_SIZE);
    }

    public static class MapGetCmdRequest {
        @Expose
        @SerializedName("b")
        public List<MapPos> block = new ArrayList<>();
    }

    public class MapGetResult {
        @Expose
        @SerializedName("n")
        public UserNote[] userNotes = new UserNote[]{};
    }
}
