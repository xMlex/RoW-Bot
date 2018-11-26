package model.data.alliances {
import common.localization.LocaleUtil;

public class AllianceRelationshipType {

    public static const None:int = 0;

    public static const War:int = 1;

    public static const Enemy:int = 2;

    public static const Friend:int = 3;

    public static const Peace:int = 4;

    public static const Challenge:int = 5;


    public function AllianceRelationshipType() {
        super();
    }

    public static function getName(param1:int):String {
        switch (param1) {
            case 1:
                return LocaleUtil.getText("tools-MessagesUIManager_allianceRelationType_War");
            case 2:
                return LocaleUtil.getText("tools-MessagesUIManager_allianceRelationType_Enemy");
            case 3:
                return LocaleUtil.getText("tools-MessagesUIManager_allianceRelationType_Friend");
            case 4:
                return LocaleUtil.getText("tools-MessagesUIManager_allianceRelationType_Peace");
            case 5:
                return LocaleUtil.getText("tools-MessagesUIManager_allianceRelationType_Challenge");
            default:
                return LocaleUtil.getText("tools-MessagesUIManager_allianceRelationType_None");
        }
    }

    public static function isGood(param1:int):Boolean {
        return param1 == Friend || param1 == Peace;
    }
}
}
