package model.data.alliances.membership {
public class MemberMissionActivity {


    public var memberId:int;

    public var rankId:int;

    public var points:int;

    public function MemberMissionActivity(param1:int, param2:int, param3:int) {
        super();
        this.memberId = param1;
        this.rankId = param2;
        this.points = param3;
    }
}
}
