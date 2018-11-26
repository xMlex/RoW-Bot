package model.data.visualBattle {
public class HeroVO {


    public var heroName:String;

    public var heroUrl:String;

    public var playerName:String;

    public var playerUrl:String;

    public function HeroVO() {
        super();
    }

    public static function fromDto(param1:*):HeroVO {
        var _loc2_:HeroVO = new HeroVO();
        _loc2_.heroName = param1.n;
        _loc2_.heroUrl = param1.u;
        _loc2_.playerName = param1.pn;
        _loc2_.playerUrl = param1.pu;
        return _loc2_;
    }

    public function getDto():* {
        var _loc1_:* = undefined;
        _loc1_ = {
            "n": this.heroName,
            "u": this.heroUrl,
            "pn": this.playerName,
            "pu": this.playerUrl
        };
        return _loc1_;
    }
}
}
