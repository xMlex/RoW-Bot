package model.logic.quests.data {
public class QuestGiftBoxPictureData {


    public var pictureUrl:String;

    public var width:Number;

    public var height:Number;

    public var animation:Number;

    public function QuestGiftBoxPictureData() {
        super();
    }

    public static function fromDto(param1:*):QuestGiftBoxPictureData {
        var _loc2_:QuestGiftBoxPictureData = new QuestGiftBoxPictureData();
        _loc2_.pictureUrl = param1.p;
        _loc2_.width = param1.w;
        _loc2_.height = param1.h;
        _loc2_.animation = param1.a;
        return _loc2_;
    }
}
}
