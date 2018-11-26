package xmlex.vk;

import ru.xmlex.common.ConfigSystem;
import ru.xmlex.common.Util;
import ru.xmlex.row.game.RowSignature;

import java.util.Calendar;
import java.util.TimeZone;
import java.util.logging.Logger;

public class TestRow {
    private static final Logger _log = Logger.getLogger(TestRow.class.getName());

    public static void main(String[] args) throws Exception {
        ConfigSystem.load();
        String sign = "2b5ac07d1ad955d39084d035884dd641";

        _log.info("Test signature: " + sign);
        RowSignature crypt = new RowSignature();
        //crypt.setUserHashedId("vk21686615");
        //crypt.setUserSocialId("21686615");
        //crypt.setUserSocialAuthKey("61b309eaa5d051b36adb178b617871ee");

        String gSign = crypt.generateRequestSignature("GetTouch", "[\"vk21686615\"]");
        if (gSign.equalsIgnoreCase(sign)) {
            String r = crypt.JsonCallCmd("GetTouch", "[\"vk21686615\"]");
            _log.info("Answer: " + r);
            Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("GMT"));
            //cal.setTimeInMillis(Long.valueOf(r));
            long time = cal.getTimeInMillis();
            _log.info("UTC: " + time);

            crypt.setUserHashedId("vk21686615");
            crypt.setUserSocialAuthSeed(Util.randomString(86));
            crypt.setUserSocialAuthKey("61b309eaa5d051b36adb178b617871ee");

            r = crypt.JsonCallCmd("SignIn", "{\"s\":{\"x\":\"NaN\",\"a\":true,\"p\":null,\"n\":\"Maxim Novikov\",\"np\":false,\"gr\":null,\"tg\":0,\"s\":null,\"i\":\"vk21686615\",\"t\":0,\"u\":\"http://cs620527.vk.me/v620527615/172e9/WMzE2cIqgls.jpg\",\"d\":\"Maxim;Novikov;NaN;ru_RU;0;;\",\"fl\":false,\"l\":\"ru-RU\"},\"i\":\"vk21686615\",\"t\":-180,\"f\":[\"vk8107314\",\"vk99061878\",\"vk135321214\",\"vk136379980\",\"vk209965803\",\"vk245418671\"],\"l\":\"menu\",\"mr\":\"\"}");
            _log.info("SignIn: " + r);
        } else
            _log.info("ERROR: " + gSign);

    }

}
