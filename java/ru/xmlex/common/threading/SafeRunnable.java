package ru.xmlex.common.threading;

import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Created by xMlex on 12.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public abstract class SafeRunnable implements Runnable {
    protected static final Logger log = Logger.getLogger(SafeRunnable.class.getName());

    public abstract void runImpl() throws Exception;

    @Override
    public void run() {
        try {
            runImpl();
        } catch (Throwable e) {
            log.log(Level.SEVERE, "SafeRunnable: " + e.getMessage(), e);
        }
    }
}
