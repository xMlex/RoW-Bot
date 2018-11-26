/*
 * Created on 26 apr 2010
 */

package jawnae.pyronet.events;

public interface PyroServerListener {
    /**
     * Note: invoked from the PyroSelector-thread that created this PyroClient
     */
    public void acceptedClient(jawnae.pyronet.PyroClient client);
}
