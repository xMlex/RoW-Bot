package xmlex.test;

import ru.xmlex.common.crypt.RSA;
import xmlex.vk.VkClient;


public class HttpClientTest {

    public static void main(String[] args) throws Exception {

        RSA.getInstance().loadPrivate("java/config/private.pem");
        String decrypted = RSA.getInstance().decryptBase64("jVS2kYxc0dQ9xu86WnbEc6nt4452mnLgtgBVRTBKYPPyvAGhKG4T7AkFJGp+7nLn18RvC2iCDo7NFQ7modEMrU7DIpuDCkZCjDdGGnTe/+YrE6OAFmCnQRJrkPLoDFcCxNW6e6UBmp2dKkwcBPLD8SbehuDUY7KHUe3NxBpPWcp4Ts6mX+af/d9tWWmcmt/+PJEpO/Q9gPnd4UMpLv/xY1whZFMsqnCRbpuTd8fhP7VikYuN+ZYyxADIiQYIP5If3I3+o3rU4R3wA/s2G2LliyJSNdGTAtqse+lM3tybb3XvyAeCHUjX6wPybelZyX+Wq2EMRTrIPmVBdFeRax786Q==");
        System.out.println("decrypted: " + decrypted);
        if (true)
            return;
        VkClient client = new VkClient("", "");
        client.Login();
    }

}