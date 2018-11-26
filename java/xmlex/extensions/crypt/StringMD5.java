package xmlex.extensions.crypt;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Logger;

public class StringMD5 implements TStringCrypt {

    protected static Logger _log = Logger.getLogger(StringMD5.class.getName());
    private static StringMD5 _instance = new StringMD5();

    public static StringMD5 getInstance() {
        return _instance;
    }

    @Override
    public boolean compare(String password, String expected) {
        try {
            return encrypt(password).equals(expected);
        } catch (NoSuchAlgorithmException nsee) {
            _log.warning("Could not check password, algorithm  MD5 not found!");
            return false;
        } catch (UnsupportedEncodingException uee) {
            _log.warning("Could not check password, UTF-8 is not supported!");
            return false;
        }
    }

    @Override
    public String encrypt(String password) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        return MD5String(password);

    }

    private static String ByteToHexString(byte hash[]) {
        StringBuffer buf = new StringBuffer(hash.length * 2);
        int i;
        for (i = 0; i < hash.length; i++) {
            if ((hash[i] & 0xff) < 0x10)
                buf.append("0");
            buf.append(Long.toString(hash[i] & 0xff, 16));
        }
        return buf.toString();
    }

    public static String MD5String(String text) {
        try {
            MessageDigest digest = MessageDigest.getInstance("MD5");
            return ByteToHexString(digest.digest(text.getBytes()));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}
