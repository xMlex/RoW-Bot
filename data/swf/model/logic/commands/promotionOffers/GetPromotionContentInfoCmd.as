package model.logic.commands.promotionOffers {
import common.localization.LocaleUtil;

import integration.SocialNetworkIdentifier;

import model.data.promotionOffers.PromotionContentManager;
import model.logic.ServerManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.getRequest.GetFormatRequest;
import model.logic.commands.server.getRequest.GetRequestCallCmd;

public class GetPromotionContentInfoCmd extends BaseCmd {

    private static const SERVER_PROD_URL:String = "https://cnt.x-plarium.com/public/storage";

    private static const SERVER_TEST_URL:String = "https://bmwi.x-plarium.com/content_service_public_api_staging/storage";


    private var _request:GetFormatRequest;

    public function GetPromotionContentInfoCmd(param1:Array, param2:Array) {
        super();
        this._request = new GetFormatRequest();
        this._request.addParameter("a", ServerManager.appId);
        this._request.addParameter("b", LocaleUtil.currentLocale.replace("_", "-"));
        this._request.addParameter("l", param1);
        this._request.addParameter("i", param2);
    }

    override public function execute():void {
        var serverUrl:String = !!SocialNetworkIdentifier.isTest ? SERVER_TEST_URL : SERVER_PROD_URL;
        new GetRequestCallCmd(this._request, serverUrl).ifResult(function (param1:*):void {
            PromotionContentManager.addContent(param1);
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
