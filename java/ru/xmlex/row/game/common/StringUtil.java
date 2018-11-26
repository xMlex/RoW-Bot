package ru.xmlex.row.game.common;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class StringUtil {

    public static final Map<String, String> REPLACE_NAME_SYMBOLS = new HashMap<>();

    static {
        REPLACE_NAME_SYMBOLS.put("\u0027", "\\'");
        REPLACE_NAME_SYMBOLS.put("&quot;", "\"");
        REPLACE_NAME_SYMBOLS.put("\u0463", "е");
        REPLACE_NAME_SYMBOLS.put("\ue38d", "");
        REPLACE_NAME_SYMBOLS.put("\ue9c3", "");
        REPLACE_NAME_SYMBOLS.put("\ue306", "");
        REPLACE_NAME_SYMBOLS.put("\ufb2b", "");
        REPLACE_NAME_SYMBOLS.put("\u02dc", "");
        REPLACE_NAME_SYMBOLS.put("\u06e9", "");
        REPLACE_NAME_SYMBOLS.put("\u06de", "");
        REPLACE_NAME_SYMBOLS.put("\u2550", "");
        REPLACE_NAME_SYMBOLS.put("\u02d9", "");
        REPLACE_NAME_SYMBOLS.put("\u0387", "");
        REPLACE_NAME_SYMBOLS.put("\u0660", "");
        REPLACE_NAME_SYMBOLS.put("\u25cf", "");
        REPLACE_NAME_SYMBOLS.put("\u2665", "");
        REPLACE_NAME_SYMBOLS.put("\u0b90", "");
        REPLACE_NAME_SYMBOLS.put("\u10e6", "");
    }


    public static String replaceSpecExpressions(String param1) {
        String result = param1;
        for (Map.Entry<String, String> r : REPLACE_NAME_SYMBOLS.entrySet())
            result = result.replace(r.getKey(), r.getValue());
        return result;
    }
}
