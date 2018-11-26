package ru.xmlex.zp.core.models.game.world;

import java.util.ArrayList;

/**
 * Created by mlex on 25.10.16.
 */
public class World {
    public ActiveCraft[] active_crafts;
    public int radius;// : 32
    public ArrayList<Actor> actors = new ArrayList<>();

    public void removeActor(Actor actor) {
        for (Actor actor1 : actors) {
            if (actor.id == actor1.id && actor.x == actor1.x && actor.y == actor1.y) {
                actors.remove(actor1);
                return;
            }
        }

    }
}
