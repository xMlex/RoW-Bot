package ru.xmlex.zp.protocol;

/**
 * Created by Mlex on 14.09.2014.
 */
public interface PacketHandler {
    public abstract void onPacketFromServer();

    public abstract void onPacketFromClient();
}
