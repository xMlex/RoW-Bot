package model.logic.inviteFriend {
import integration.SocialNetworkIdentifier;

import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;

public class CreateInvitationLinkCmd extends BaseCmd {


    public function CreateInvitationLinkCmd() {
        super();
    }

    override public function execute():void {
        new JsonCallCmd("CreateIafv2Link", SocialNetworkIdentifier.socialNetworkConfig.cluster, "POST").ifResult(function (param1:String):void {
            if (_onResult != null) {
                _onResult(param1);
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
