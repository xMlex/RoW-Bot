package model.logic.commands.user {
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class GetPostGiftDataCmd extends BaseCmd {


    public function GetPostGiftDataCmd() {
        super();
    }

    override public function execute():void {
        new JsonCallCmd("CreatePostGiftData", null, "POST").ifResult(_onResult).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
