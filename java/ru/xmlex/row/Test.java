package ru.xmlex.row;

import com.google.gson.GsonBuilder;
import ru.xmlex.common.ConfigSystem;
import ru.xmlex.common.Util;
import ru.xmlex.row.game.common.gson.AdapterBooleanRow;
import ru.xmlex.row.game.data.commands.UserSignInCmd;
import ru.xmlex.row.game.data.scenes.objects.GeoSceneObject;
import ru.xmlex.row.game.data.scenes.types.info.TechnologyLevelInfo;
import ru.xmlex.row.game.logic.StaticDataManager;
import xmlex.vk.row.model.data.scenes.types.GeoSceneObjectType;

import java.util.logging.Logger;

/**
 * Created by xMlex on 29.03.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class Test {
    private static Logger log = Logger.getLogger(Test.class.getName());

    public static void main(String[] agrs) throws Exception {
        ConfigSystem.load();

//        final GsonBuilder builder = new GsonBuilder();
//        //builder.excludeFieldsWithoutExposeAnnotation();
//        final Gson gson = builder.serializeNulls().excludeFieldsWithoutExposeAnnotation().create();

//        GameClient client = new GameClient();
//
//        SocialUser su = new SocialUser();
//        su.first_name = "Максим";
//        su.last_name = "Новиков";
//        su.first_name = "Maxim";
//        su.last_name = "Novikov";
//        su.uid = "vk21686615";
//        client.setUserSocialData(su);
//        client.getUserSocialData().photoUrl = "http://cs630020.vk.me/v630020615/4d86/-vPzKtTxgL8.jpg";
//        client.getCrypt().setUserSocialAuthKey("abae5a37c2d0245dc53d7f7129fe00f4");
//
//
//        System.out.println("JSON: "+gson.toJson(client.getUserSocialData()));
//
//        String gSign =  client.getCrypt().generateRequestSignature("GetTouch","[\"vk21686615\"]");
//
//        System.out.println("sing: "+gSign);
//        System.out.println("sing: 2b5ac07d1ad955d39084d035884dd641");

        //client.initialize();

        StaticDataManager.initializeFromCache();
        log.info("LD size: " + StaticDataManager.getInstance().levelData.prizesForLevel.size());

        for (GeoSceneObjectType obj : StaticDataManager.getInstance().geoSceneObjectTypeList) {
            if (obj.isTechnology()) {
                log.info("Technology: " + obj.name + " id: " + obj.id + " b: " + obj.technologyInfo.isBlockedForeTrade);
                for (TechnologyLevelInfo li : obj.technologyInfo.levelInfos) {
                    log.info(" L: " + li.caravanSpeed + " id: " + li.caravanQuantity);
                }
            }
        }
        log.info("Total scene objects: " + StaticDataManager.getInstance().geoSceneObjectTypeList.size());


        if (true)
            return;

        UserSignInCmd.UserSignInCmdResult test = new GsonBuilder()
                .registerTypeAdapter(boolean.class, new AdapterBooleanRow())
                .registerTypeAdapter(Boolean.class, new AdapterBooleanRow())
                //.excludeFieldsWithoutExposeAnnotation()
                .create()
                .fromJson(Util.readFile("data-v.sigin.json"), UserSignInCmd.UserSignInCmdResult.class);


        for (GeoSceneObject obj : test.user.gameData.sector.scene.objects) {
            System.out.println("B: " + obj.getName() +
                            " Lvl: " + obj.constructionInfo.level
//                    + " canUpgrade: " + obj.canUpgrade(test.user)
                            + " inProgress: " + obj.constructionInfo.isInProgress()
            );

        }
        System.out.println("Count in progress: " + test.user.getCountBuildingInProgress());
        System.out.println(System.currentTimeMillis());
        //String json = "{\"s\":{\"x\":\"NaN\",\"l\":\"ru-RU\",\"tg\":0,\"gr\":null,\"s\":null,\"tpi\":null,\"np\":false,\"t\":0,\"a\":true,\"n\":\"Максим Новиков\",\"fl\":false,\"u\":\"http://cs630020.vk.me/v630020615/4d86/-vPzKtTxgL8.jpg\",\"ar\":null,\"i\":\"vk21686615\",\"de\":null,\"p\":null,\"im\":false,\"vk\":{\"b\":false},\"d\":\"Максим;Новиков;NaN;ru_RU;0;;\"},\"l\":\"user_apps\",\"i\":\"vk21686615\",\"f\":[\"vk8087287\",\"vk135321214\",\"vk144157510\",\"vk154911613\"],\"c\":{\"i\":1,\"v\":\"1.0\"},\"rr\":null,\"mr\":\"\",\"t\":-180}";

        //System.out.println(RowSignature.MD5String("The Matrix has you..."+json+"SignInvk21686615abae5a37c2d0245dc53d7f7129fe00f4"));
    }
}
