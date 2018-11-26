package model.logic.journal {
public class JEventUser implements IJEventUser {


    public var time:Date;

    public function JEventUser() {
        super();
    }

    public function apply():void {
        throw new Error();
    }
}
}
