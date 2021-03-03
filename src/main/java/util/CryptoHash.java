package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.nio.charset.StandardCharsets;
import java.math.BigInteger;

public class CryptoHash {
    public static String getHash(String pass) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");

        md.update(pass.getBytes(StandardCharsets.UTF_8));
        byte[] digest = md.digest();

        return String.format("%064x", new BigInteger(1, digest));
    }

    public static boolean compare(String pass, String hash) {
        try {
            String crypto = getHash(pass);
            return crypto.equals(hash);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}