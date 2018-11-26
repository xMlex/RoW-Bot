package xmlex.extensions.crypt;

import xmlex.extensions.util.Rnd;

import java.security.InvalidAlgorithmParameterException;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.spec.RSAKeyGenParameterSpec;
import java.util.logging.Logger;

/**
 * RSA keygen
 */
public class KeygenRSA {
    private static final Logger _log = Logger.getLogger(KeygenRSA.class.getName());
    private static final int CRYPT_KEYS_SIZE = 2;
    private static final KeyPair[] CRYPT_KEYS = new KeyPair[CRYPT_KEYS_SIZE];

    public static void generate() throws NoSuchAlgorithmException, InvalidAlgorithmParameterException {

        KeyPairGenerator keygen;

        keygen = KeyPairGenerator.getInstance("RSA");
        RSAKeyGenParameterSpec spec = new RSAKeyGenParameterSpec(1024, RSAKeyGenParameterSpec.F4);
        keygen.initialize(spec);
        for (int i = 0; i < CRYPT_KEYS.length; i++)
            CRYPT_KEYS[i] = keygen.generateKeyPair();
        _log.info("Cached " + CRYPT_KEYS.length + " Keys for RSA communication");
    }

    /**
     * Returns a key from this keygen pool, the logical ownership is retained by
     * this keygen.<BR>
     * Thus when getting a key with interests other then read-only a copy must
     * be performed.<BR>
     *
     * @return A key from this keygen pool.
     */
    public static KeyPair getRandomKey() {
        return CRYPT_KEYS[Rnd.get(CRYPT_KEYS_SIZE)];
    }

}
