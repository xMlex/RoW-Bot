package ru.xmlex.zp.core.xclient;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.apache.commons.codec.binary.Base64;
import ru.xmlex.common.HexDump;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by theml on 08.10.2016.
 */
public class XPacket {
    private static final Gson gson = new Gson();

    public String raw;
    public JsonObject asJson;

    public int number;

    public boolean isGroup;

    public String name;

    public boolean error;

    public String descr;

    public boolean fatal;
    public boolean isJson;

    @Override
    public String toString() {
        return number + ">" + name + " Raw: " + raw;
    }

    public static XPacket parsePacket(String buf) {
        XPacket result = new XPacket();

        int pos = 0;
        if (checkRegExp("^\\d+>.*?", buf)) {
            int _loc5_ = buf.indexOf(">");
            result.number = Integer.valueOf(buf.substring(0, _loc5_));
            pos = _loc5_ + 1;
        }
        if (buf.charAt(pos) == 'G' && buf.charAt(pos) == 'R') {
            result.isGroup = true;
            pos = pos + 4;
        }
        if (buf.charAt(pos) == 'D') {
            byte[] b64;
            b64 = Base64.encodeBase64(buf.substring(pos + 1).getBytes());
            b64 = HexDump.decompressByteArray(b64);
            result.raw = new String(b64);
        } else {
            result.raw = pos > 0 ? buf.substring(pos) : buf;
        }
        if (result.raw.charAt(0) == '{') {
            result.isJson = true;
            result.asJson = gson.fromJson(result.raw, JsonObject.class);
        }
        return result;
    }

    public static boolean checkRegExp(String rg, String s) {
        Pattern p = Pattern.compile(rg);
        Matcher m = p.matcher(s);
        return m.matches();
    }
}
