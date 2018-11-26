package model.data {
import model.data.visualBattle.HeroVO;
import model.data.visualBattle.UnitVO;

public class VisualBattleData {


    public var myUnitsVO:Vector.<UnitVO>;

    public var enemyUnitsVO:Vector.<UnitVO>;

    public var messageId:int;

    public var isMyUserAttackedFirst:Boolean;

    public var isEnemyWon:Boolean;

    public var myHero:HeroVO;

    public var enemyHero:HeroVO;

    public var localeGame:String;

    public function VisualBattleData() {
        this.myHero = new HeroVO();
        this.enemyHero = new HeroVO();
        super();
    }

    public static function fromDto(param1:*):VisualBattleData {
        var _loc2_:VisualBattleData = new VisualBattleData();
        _loc2_.myUnitsVO = param1.mu == null ? new Vector.<UnitVO>() : UnitVO.fromDtos(param1.mu);
        _loc2_.enemyUnitsVO = param1.eu == null ? new Vector.<UnitVO>() : UnitVO.fromDtos(param1.eu);
        _loc2_.messageId = param1.id;
        _loc2_.isMyUserAttackedFirst = param1.a;
        _loc2_.isEnemyWon = param1.ew;
        _loc2_.myHero = HeroVO.fromDto(param1.mh);
        _loc2_.enemyHero = HeroVO.fromDto(param1.eh);
        _loc2_.localeGame = param1.l;
        return _loc2_;
    }

    public function getDto():* {
        var _loc1_:* = undefined;
        _loc1_ = {
            "mu": this.dtoFromVector(this.myUnitsVO),
            "eu": this.dtoFromVector(this.enemyUnitsVO),
            "id": this.messageId,
            "a": this.isMyUserAttackedFirst,
            "ew": this.isEnemyWon,
            "mh": this.myHero.getDto(),
            "eh": this.enemyHero.getDto(),
            "l": this.localeGame
        };
        return _loc1_;
    }

    private function dtoFromVector(param1:Vector.<UnitVO>):* {
        var _loc2_:* = undefined;
        var _loc3_:Array = new Array();
        var _loc4_:int = 0;
        while (_loc4_ < param1.length) {
            _loc3_.push(param1[_loc4_].getDto());
            _loc4_++;
        }
        return _loc3_;
    }
}
}
