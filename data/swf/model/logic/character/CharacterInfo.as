package model.logic.character {
import model.data.Resources;

public class CharacterInfo {


    public var id:int;

    public var characterRace:int;

    public var characterGender:int;

    public var price:Resources;

    public var isExtra:Boolean;

    public var name:String;

    public var description:String;

    public function CharacterInfo() {
        super();
    }

    public static function fromDto(param1:*):CharacterInfo {
        var _loc2_:CharacterInfo = new CharacterInfo();
        _loc2_.id = param1.i;
        _loc2_.characterRace = param1.r;
        _loc2_.characterGender = param1.g;
        _loc2_.price = param1.p;
        _loc2_.name = param1.n.c;
        _loc2_.description = param1.d.c;
        _loc2_.isExtra = param1.s;
        return _loc2_;
    }
}
}
