package ru.xmlex.common.socks.lisrtener;

import jawnae.pyronet.PyroClient;
import ru.xmlex.common.listener.Listener;
import ru.xmlex.common.socks.SocksAttachment;

import java.nio.ByteBuffer;

/**
 * Created by xMlex on 05.10.16.
 */
public interface OnSockerWriteListener extends Listener<SocksAttachment> {
    /**
     * Обработка столкновения двух объектов чашки Петри
     */
    public void onSocketWrite(PyroClient from, PyroClient to, ByteBuffer data);
}
