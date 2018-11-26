package model.data.wisdomSkills {
public class LocalTexts {


    public var code:String;

    public var key:String;

    public function LocalTexts() {
        super();
    }

    public static function fromDto(param1:*):LocalTexts {
        var _loc2_:LocalTexts = new LocalTexts();
        _loc2_.code = param1.c;
        _loc2_.key = param1.k;
        return _loc2_;
    }
}
}
