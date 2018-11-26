/*
 * Created on 26 apr 2010
 */

package jawnae.pyronet.addon;

import jawnae.pyronet.PyroSelector;

import java.nio.channels.SocketChannel;

public class PyroSingletonSelectorProvider implements PyroSelectorProvider {
    private final PyroSelector selector;

    public PyroSingletonSelectorProvider(PyroSelector selector) {
        this.selector = selector;
    }

    @Override
    public PyroSelector provideFor(SocketChannel channel) {
        return this.selector;
    }
}
