/*
 * Created on 26 apr 2010
 */

package jawnae.pyronet.events;

import java.io.IOException;
import java.nio.ByteBuffer;

public class PyroClientAdapter implements PyroClientListener {
    public void connectedClient(jawnae.pyronet.PyroClient client) {
        //
    }

    public void unconnectableClient(jawnae.pyronet.PyroClient client) {
        System.out.println("unconnectable");
    }

    public void droppedClient(jawnae.pyronet.PyroClient client, IOException cause) {
        if (cause != null) {
            System.out.println(this.getClass().getSimpleName() + ".droppedClient() caught exception: " + cause);
        }
    }

    public void disconnectedClient(jawnae.pyronet.PyroClient client) {
        //
    }

    //

    public void receivedData(jawnae.pyronet.PyroClient client, ByteBuffer data) {
        //
    }

    public void sentData(jawnae.pyronet.PyroClient client, int bytes) {
        //
    }
}