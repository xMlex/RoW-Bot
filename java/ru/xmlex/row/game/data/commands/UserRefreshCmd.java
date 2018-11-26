package ru.xmlex.row.game.data.commands;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.common.ConfigSystem;
import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.data.UserRefresh;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;
import ru.xmlex.row.game.logic.commands.sector.BuyCommand;
import ru.xmlex.row.game.logic.quests.data.QuestState;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 4/6/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserRefreshCmd extends BaseCommand {
    public static final int RefreshUserNoteTimeoutMs = 60000;

    @Expose
    @SerializedName("r")
    public int revision;
    @Expose
    @SerializedName("t")
    public long serverTimeNow;
    @Expose
    @SerializedName("u")
    public long sessionStartTimeMs;
    @Expose
    @SerializedName("g")
    public long sessionInGameTimeMs;
    @Expose
    @SerializedName("o")
    private Object object;
    @Expose
    @SerializedName("q")
    private List<Integer> questList = new ArrayList<>();
    @Expose
    @SerializedName("y")
    private Object unknown = null;
    @Expose
    @SerializedName("km")
    private int countMessage = 17;

    public UserRefreshCmd(Object object) {
        this.object = object;
    }

    @Override
    public void onCommandInit() {
        setAction("AutoRefresh");
        revision = getClient().getUser().gameData.revision;
        serverTimeNow = getClient().serverTimeManager.getServerTimeNow().getTime();
        sessionStartTimeMs = getClient().serverTimeManager.getSessionStartTimeMs();
        sessionInGameTimeMs = getClient().serverTimeManager.getSessionInGameTimeMs();
        if (getClient().getUser().gameData.questData != null) {
            List<QuestState> questStateList = getClient().getUser().gameData.questData.openedStates;
            if (questStateList != null && !questStateList.isEmpty()) {
                for (QuestState qs : questStateList) {
                    //log.info("q: "+qs.questId+" stateId: "+qs.stateId);
                    questList.add(qs.questId);
                }
            }
        }
        JsonObject jsonObject = (JsonObject) getGsonWithoutExpose().toJsonTree(this);
        JsonObject t = new JsonObject();

        if (this.object != null && this.object instanceof BuyCommand && ((BuyCommand) object).object != null) {
            GeoSceneObject obj = ((BuyCommand) object).object;
            if (obj.objectType().isBuilding() && obj.objectType().buildingInfo.canBeBroken) {
                jsonObject.getAsJsonObject("o").getAsJsonObject("o").getAsJsonObject("bi").add("b", new JsonPrimitive(false));
            }
        }

//        if (System.currentTimeMillis() - getClient().getUser().refreshData.lastRefreshKnownUserNotesAtTimerMs > RefreshUserNoteTimeoutMs) {
//            t.add("n", new JsonPrimitive(1));
//            jsonObject.add("n", t);
//        }
        int lastMsgId = getClient().getUser().gameData.messageData.nextMessageId - 1;
        if (ConfigSystem.DEBUG)
            log.info("nextMessageId: " + lastMsgId);
        jsonObject.add("km", new JsonPrimitive(lastMsgId));


        setBody(getGsonWithoutExpose().toJson(jsonObject));
        setUserRefresh(false);
    }

    @Override
    public void onCommandResult(String result) {

    }


    public static JsonObject makeRequestDto(User user, JsonObject object) {
        int lastMsgId = user.gameData.messageData.nextMessageId - 1;

        JsonObject t = null;
        JsonObject r = new JsonObject();
        r.addProperty("km", lastMsgId);
//        if (System.currentTimeMillis() - user.refreshData.lastRefreshKnownUserNotesAtTimerMs > RefreshUserNoteTimeoutMs) {
//            t = new JsonObject();
//            t.addProperty("n", 1);
//            r.add("n", t);
//        }
        r.addProperty("r", user.gameData.revision);
        r.addProperty("t", user.getClient().serverTimeManager.getServerTimeNow().getTime());
        r.addProperty("u", user.getClient().serverTimeManager.getSessionStartTimeMs());
        r.addProperty("g", user.getClient().serverTimeManager.getSessionInGameTimeMs());
        r.add("y", null);

        if (user.gameData.userGameSettings != null) {
            r.add("s", getGsonWithoutExpose().toJsonTree(user.gameData.userGameSettings));
        }

        JsonArray questList = null;
        if (user.gameData.questData != null) {
            questList = new JsonArray();
            List<QuestState> questStateList = user.gameData.questData.openedStates;
            if (questStateList != null && !questStateList.isEmpty()) {
                for (QuestState qs : questStateList) {
                    //log.info("q: "+qs.questId+" stateId: "+qs.stateId);
                    questList.add(new JsonPrimitive(qs.questId));
                }
            }
        }
        r.add("q", questList);

        if (object != null)
            r.add("o", object);

        return r;
    }

    public static boolean updateUserByResultDto(String result, User user) {
        UserRefresh u = getGsonWithoutExpose().fromJson(result, UserRefresh.class);
        user.getClient().serverTimeManager.update(u.serverTime);
        if (u.questData != null) {
            user.userQuestManager.setQuest(u.questData);
        }
        if (u.revision == -1 || u.revision == 0 || user.gameData.revision >= u.revision) {
            return true;
        }
        if (u.gameData == null) {
            user.gameData.revision = Math.max(user.gameData.revision, u.revision);
            return false;
        }
        user.gameData.update(u.gameData);
        return true;
    }
}
