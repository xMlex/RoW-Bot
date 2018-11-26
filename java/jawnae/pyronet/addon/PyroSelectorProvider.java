/*
 * Created on 26 apr 2010
 */

package jawnae.pyronet.addon;

import java.nio.channels.SocketChannel;

public interface PyroSelectorProvider {
    public jawnae.pyronet.PyroSelector provideFor(SocketChannel channel);
}