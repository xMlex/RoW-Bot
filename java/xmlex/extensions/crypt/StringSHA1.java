package xmlex.extensions.crypt;

//import jonelo.jacksum.JacksumAPI;
//import jonelo.jacksum.algorithm.AbstractChecksum;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Logger;

public class StringSHA1 implements TStringCrypt {
    protected static Logger _log = Logger.getLogger(StringSHA1.class.getName());
    private static StringSHA1 _instance = new StringSHA1();

    public static StringSHA1 getInstance() {
        return _instance;
    }

    @Override
    public boolean compare(String password, String expected) {
        try {
            return encrypt(password).equals(expected);
        } catch (NoSuchAlgorithmException nsee) {
            _log.warning("Could not check password, algorithm SHA1 not found! Check jacksum library!");
            return false;
        } catch (UnsupportedEncodingException uee) {
            _log.warning("Could not check password, UTF-8 is not supported!");
            return false;
        }
    }

    @Override
    public String encrypt(String password) throws NoSuchAlgorithmException, UnsupportedEncodingException {
//		AbstractChecksum sha1 = JacksumAPI.getChecksumInstance("sha1");
//		sha1.setEncoding("BASE64");
//		sha1.update(password.getBytes("UTF-8"));
//		return sha1.format("#CHECKSUM");
        return null;
    }
}