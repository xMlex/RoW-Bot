package ru.xmlex.common;

import xmlex.extensions.log.ConsoleLogFormatter;

import java.util.logging.ErrorManager;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.LogRecord;

/**
 * Created by mlex on 26.12.16.
 */
public class MessageNotifierHandler extends Handler {


    @Override
    public void publish(LogRecord record) {
        if (record.getLevel().intValue() <= Level.INFO.intValue())
            return;

        if (getFormatter() == null) {
            setFormatter(new ConsoleLogFormatter());
        }
        try {
            if (!ConfigSystem.DEBUG)
                MessageNotifier.getInstance().log(getFormatter().format(record));
        } catch (Exception exception) {
            reportError(null, exception, ErrorManager.FORMAT_FAILURE);
        }
    }

    @Override
    public void flush() {

    }

    @Override
    public void close() throws SecurityException {

    }
}
