package ru.xmlex.zp.net.api;

import ru.xmlex.common.Rnd;

import java.util.Base64;

/**
 * Created by mlex on 21.10.16.
 */
public class ZpStartResponse {
    public Backend backend;

    public class Backend {
        public String host;
        public String id;
        public int[] port;

        public String getStaticKey() {
            return Base64.getEncoder().encodeToString(("{\"main\":1,\"subenv\":null,\"environment\":\"Canvas\",\"instance\":\"198767770442137" + Rnd.get(10, 99) + "\",\"env\":\"Canvas\"}").getBytes()).replace("\n", "").replace("\r", "");
        }
    }
}
