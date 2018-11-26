package ru.xmlex.row.game.logic.commands.world.unitMoving;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.data.commands.BaseCommand;
import ru.xmlex.row.game.data.map.unitMoving.MapRefreshInput;
import ru.xmlex.row.game.data.users.UserNote;

public class GetMapBlocksCmd extends BaseCommand {

    public int x;
    public boolean isDop = false;

    public GetMapBlocksCmd(int x, boolean isDop) {
        this.x = x;
        this.isDop = isDop;
    }

    @Override
    public void onCommandInit() {
        setAction("GetMapBlocks");
        setBody(getGsonWithoutExpose().toJson(MapRefreshInput.fromX(x, isDop)));
    }

    @Override
    public void onCommandResult(String result) {
        MapGetResult r = getGsonWithoutExpose().fromJson(result, MapGetResult.class);
        for (UserNote el : r.userNotes) {
            if (!el.isInactive())
                continue;

//            System.out.println("User: " + el.userName + ": " + " lvl: " + el.level + " InActive: " + el.inactiveDays() + " d." + " Pos: " + el.mapPos.x + ":" + el.mapPos.y);

            if (el.inactiveDays() > 40 && el.level > 40) {
//                FavouriteUser user = new FavouriteUser();
//                user.addDate = System.currentTimeMillis();
//                user.typeId = 1;
//                user.userId = el.id;
//                user.comment = el.level + ": " + el.inactiveDays() + " Robbery";
//                forAdd.add(user);
                System.out.println("User: " + el.userName + ": " + " lvl: " + el.level + " InActive: " + el.inactiveDays() + " d." + " Pos: " + el.mapPos.x + ":" + el.mapPos.y);
            }
        }

    }

    public class MapGetResult {
        @Expose
        @SerializedName("n")
        public UserNote[] userNotes = new UserNote[]{};
    }
}
