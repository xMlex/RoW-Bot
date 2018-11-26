package model.logic.jscommands.callCommands {
import model.logic.jscommands.JSCallCmd;

public class UserSignInError extends JSCallCmd {


    public function UserSignInError(...rest) {
        super("userSignInError", rest);
    }
}
}
