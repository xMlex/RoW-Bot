package model.data.alliances {
public class AllianceMemberRankId {

    public static const LEADER:int = 10;

    public static const DEPUTY:int = 20;

    public static const PROCURATOR:int = 30;

    public static const ELITE:int = 40;

    public static const DIPLOMAT:int = 45;

    public static const ATTACKER:int = 50;

    public static const INTELLIGENCE:int = 55;

    public static const DEFENDER:int = 60;

    public static const STAFF:int = 70;

    public static const RECRUIT:int = 80;

    public static const TRAINEE:int = 90;

    public static const INVITED:int = 1000;


    public function AllianceMemberRankId() {
        super();
    }

    public static function toArray():Array {
        return [LEADER, DEPUTY, PROCURATOR, ELITE, DIPLOMAT, ATTACKER, INTELLIGENCE, DEFENDER, STAFF, RECRUIT, TRAINEE];
    }
}
}
