package ru.xmlex.common.crypt;

import org.apache.commons.codec.binary.Base64;

import javax.crypto.Cipher;
import java.io.File;
import java.nio.file.Files;
import java.security.Key;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.EncodedKeySpec;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

/**
 * Created by mlex on 17.10.16.
 */
public class RSA {

    private static RSA instance;
    private PrivateKey privateKey;


    public void loadPrivate(String file) throws Exception {
        privateKey = readPrivateKey(file);
    }

    public String decrypt(String str) {
        return decrypt(str.getBytes());
    }

    public String decrypt(byte[] str) {
        byte[] bytes = crypt(privateKey, str, Cipher.DECRYPT_MODE);
        assert bytes != null;
        return new String(bytes);
    }

    public String decryptBase64(String str) {
        byte[] bytes = crypt(privateKey, Base64.decodeBase64(str), Cipher.DECRYPT_MODE);
        assert bytes != null;
        return new String(bytes);
    }

    public static RSA getInstance() {
        if (instance == null)
            instance = new RSA();
        return instance;
    }

    static {
        java.security.Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
    }

    public static byte[] crypt(Key key, byte[] buffer, int mode) {
        try {
            Cipher rsa;
            rsa = Cipher.getInstance("RSA");
            rsa.init(Cipher.DECRYPT_MODE, key);
            return rsa.doFinal(buffer);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static byte[] encrypt(Key key, byte[] buffer) {
        return crypt(key, buffer, Cipher.ENCRYPT_MODE);
    }

    public static byte[] decrypt(Key key, byte[] buffer) {
        return crypt(key, buffer, Cipher.DECRYPT_MODE);
    }

    public static PublicKey readPublicKey(String fileName) throws Exception {
        byte[] keyBytes = Files.readAllBytes(new File(fileName).toPath());
        X509EncodedKeySpec spec = new X509EncodedKeySpec(keyBytes);
        KeyFactory kf = KeyFactory.getInstance("RSA");
        return kf.generatePublic(spec);
    }

    public static PrivateKey readPrivateKey(String fileName) throws Exception {
        String temp = new String(Files.readAllBytes(new File(fileName).toPath()));

        String privKeyPEM = temp.replace("-----BEGIN RSA PRIVATE KEY-----\n", "");
        privKeyPEM = privKeyPEM.replace("-----END RSA PRIVATE KEY-----", "");
        privKeyPEM = privKeyPEM.trim();

        Base64 b64 = new Base64();
        byte[] decoded = b64.decode(privKeyPEM);

        EncodedKeySpec spec = new PKCS8EncodedKeySpec(decoded);
        KeyFactory kf = KeyFactory.getInstance("RSA");
        return kf.generatePrivate(spec);
    }
}
