package xmlex.extensions.log;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Formatter;
import java.util.logging.LogRecord;

/**
 * This class ...
 *
 * @version $Revision: 1.1.4.1 $ $Date: 2005/03/27 15:30:08 $
 */

public class FileLogFormatter extends Formatter {

    /*
     * (non-Javadoc)
     *
     * @see java.util.logging.Formatter#format(java.util.logging.LogRecord)
     */
    private static final String CRLF = "\r\n";
    private static final String T = "\t";
    private static final SimpleDateFormat tsformat = new SimpleDateFormat("d-m-Y HH:mm:ss.SSS");
    private Date ts = new Date();

    @Override
    public String format(LogRecord record) {
        StringBuilder output = new StringBuilder();
        ts.setTime(record.getMillis());
        output.append(tsformat.format(ts));
        output.append(T);
        output.append(record.getLevel().getName());
        output.append(T);
        output.append(record.getThreadID());
        output.append(T);
        output.append(record.getLoggerName());
        output.append(T);
        output.append(record.getMessage());
        output.append(CRLF);
        return output.toString();
    }
}
