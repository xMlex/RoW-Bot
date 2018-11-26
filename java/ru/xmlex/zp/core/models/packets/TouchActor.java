package ru.xmlex.zp.core.models.packets;

import com.google.gson.annotations.Expose;
import ru.xmlex.zp.core.models.game.world.Actor;

/**
 * Created by mlex on 25.10.16.
 */
public class TouchActor extends CharacterMove {

    @Expose
    public int sid = 0;
    @Expose
    public int id = 0;

    public TouchActor(Actor actor) {
        super(actor.x, actor.y);
        sid = actor.sid;
        id = actor.id;
        name = "touch_actor";
    }
}
