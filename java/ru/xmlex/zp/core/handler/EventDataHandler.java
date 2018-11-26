package ru.xmlex.zp.core.handler;

import ru.xmlex.zp.core.ZpClient;
import ru.xmlex.zp.core.controller.ServerEventData;
import ru.xmlex.zp.core.models.User;
import ru.xmlex.zp.core.models.game.world.Actor;
import ru.xmlex.zp.core.models.packets.CharacterMove;
import ru.xmlex.zp.core.models.packets.TouchActor;
import ru.xmlex.zp.core.tasks.PacketSendTask;
import ru.xmlex.zp.listeners.OnServerEventData;

/**
 * Created by mlex on 25.10.16.
 */
public class EventDataHandler implements OnServerEventData {
    @Override
    public void onServerEventData(ZpClient client, ServerEventData data) {
        if (data.users != null && data.getMineData().has("id")) {
            User user = ZpClient.gson.fromJson(data.getMineData(), User.class);
            if (user.id.equalsIgnoreCase(client.info.user.id)) {
                client.user = user;
                for (Actor actor : user.worlds.main.actors) {
                    if (actor.isMonster() || (actor.isUnlocked() && actor.isTTLExpire() && !actor.isDecor())) {
                        System.out.println("Actor touch " + actor.toString());
                        client.tasks.add(new PacketSendTask(new CharacterMove(actor.x, actor.y)));
                        if (actor.isMonster()) {
                            for (int i = 1; i < actor.t; i++) {
                                if (client.user.getEnergy() > 1) {
                                    client.tasks.add(new PacketSendTask(new TouchActor(actor)));
                                    client.user.incEnergyRecoveryTime();
                                }
                            }
                        } else {
                            if (client.user.getEnergy() > 1) {
                                client.tasks.add(new PacketSendTask(new TouchActor(actor)));
                                client.user.incEnergyRecoveryTime();
                            }
                        }
                        return;
                    }
                    if (!actor.isUnlocked()) {
                        int time = (int) (System.currentTimeMillis() / 1000);
                        //System.out.println("FruitTree: " + actor.toString() + " ttl: " + actor.ltt + " now: " + time + " is: " + (actor.ltt > time));
                    }
                }

            } else {
                System.out.println("UserFail: " + user.id + " to " + client.user);
            }
        } else {
//            JsonObject user = data.getMineData();
//            if (user.has("worlds")) {
//                JsonObject object = user.getAsJsonObject("worlds").getAsJsonObject("default");
//                if (object.has("-actors")) {
//                    Actor actor;
//                    for (JsonElement element : object.get("-actors").getAsJsonArray()) {
//                        actor = ZpClient.gson.fromJson(element, Actor.class);
//                        client.user.worlds.main.removeActor(actor);
//                    }
//                }
//                if (object.has("=actors")) {
//                    Actor actor;
//                    for (JsonElement element : object.get("=actors").getAsJsonArray()) {
//                        actor = ZpClient.gson.fromJson(element, Actor.class);
//                        client.user.worlds.main.removeActor(actor);
//                        client.user.worlds.main.actors.add(actor);
//                    }
//                }
//            }
//            if (user.has("energy_max")) {
//                client.user.energy_max = user.get("energy_max").getAsInt();
//            }
        }
    }
}
