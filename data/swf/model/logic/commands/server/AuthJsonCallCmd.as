package model.logic.commands.server {
import com.adobe.crypto.MD5;
import com.probertson.utils.GZIPBytesEncoder;

import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.events.TextEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestHeader;
import flash.utils.ByteArray;
import flash.utils.getTimer;

import json.JSONOur;

import model.data.GeotopiaLogicExceptionCode;
import model.data.network.HTTPStatus;
import model.logic.ServerManager;
import model.logic.commands.BaseCmd;

public class AuthJsonCallCmd extends BaseCmd {

    private static const CLASS_NAME:String = "AuthJsonCallCmd";

    public static var lastCommandResultAtTimerMs:Number = getTimer();

    public static var lastSuccessCommandResultAtTimerMs:Number = getTimer();

    private static var _countActiveCommands:int = 0;

    public static var countWaitingServerCommands:int = 0;

    private static var _defaultAddress:String;

    private static var _defaultUrl:String;

    private static var _userSocialId:String;

    private static var _userHashedId:String;

    private static var _userSocialAuthKey:String;

    private static var _userSocialAuthSeed:String;

    private static var _sessionId:String;

    private static var _localeName:String;

    private static var _defaultFaultHandler:Function;

    private static var _cLogger:Function;


    private var _url:String;

    private var _methodName:String;

    private var _methodData;

    private var _httpMethod:String;

    private var _responseSignature:Boolean;

    private var _loader:URLLoader;

    public function AuthJsonCallCmd(param1:String, param2:*, param3:String = "POST", param4:String = "") {
        super();
        if (param4 == "" || param4 == null) {
            this._url = _defaultUrl;
        }
        else {
            this._url = param4;
        }
        this._methodName = param1;
        this._methodData = param2;
        this._httpMethod = param3;
        this._responseSignature = true;
    }

    public static function get countActiveCommands():int {
        return _countActiveCommands;
    }

    public static function set countActiveCommands(param1:int):void {
        _countActiveCommands = param1;
        if (typeof _cLogger == "function") {
            _cLogger.call();
        }
    }

    public static function getDefaultAddress():String {
        return _defaultAddress;
    }

    public static function setDefaultAddress(param1:String):void {
        _defaultAddress = param1;
        _defaultUrl = makeUrl(param1);
    }

    private static function makeUrl(param1:String):String {
        return "http://" + param1 + "/segment.ashx";
    }

    public static function setUserCredentials(param1:String, param2:String = "", param3:String = "", param4:String = ""):void {
        _userSocialId = param1;
        _userHashedId = param4;
        _userSocialAuthKey = param2;
        _userSocialAuthSeed = param3;
    }

    public static function updateUserSocialAuthData(param1:String, param2:String):void {
        _userSocialAuthSeed = param1;
        _userSocialId = param2;
    }

    public static function updateAuthKey(param1:String):void {
        _userSocialAuthKey = param1;
    }

    public static function setSessionId(param1:String):void {
        _sessionId = param1;
    }

    public static function setCommandsLogger(param1:Function):void {
        _cLogger = param1;
    }

    public static function setLocaleName(param1:String):void {
        _localeName = param1;
    }

    public static function setDefaultFaultHandler(param1:Function):void {
        _defaultFaultHandler = param1;
    }

    public static function getDefaultFaultHandler():Function {
        return _defaultFaultHandler;
    }

    public static function handleOnFault(param1:FaultDto, param2:Function):void {
        if (param2 != null) {
            param2(param1);
        }
        else if (_defaultFaultHandler != null) {
            _defaultFaultHandler(param1);
        }
    }

    public static function handleOnIoFault(param1:Event, param2:Function, param3:Function, param4:FaultDto = null):void {
        var _loc7_:HTTPStatusEvent = null;
        var _loc8_:FaultDto = null;
        var _loc5_:String = "Unknown error";
        var _loc6_:TextEvent = param1 as TextEvent;
        if (_loc6_ != null) {
            _loc5_ = _loc6_.text;
        }
        else {
            _loc7_ = param1 as HTTPStatusEvent;
            if (_loc7_ != null) {
                _loc5_ = "HTTP Status " + _loc7_.status;
            }
        }
        if (param2 != null) {
            param2(param1);
        }
        else if (param3 != null || _defaultFaultHandler != null) {
            if (param4 != null) {
                _loc8_ = param4;
                _loc8_.code = GeotopiaLogicExceptionCode.SERVER_UNAVAILABLE;
                _loc8_.message = _loc5_;
            }
            else {
                _loc8_ = new FaultDto(GeotopiaLogicExceptionCode.SERVER_UNAVAILABLE, _loc5_);
                _loc8_.setAdditionalProperty("Unknown", _defaultUrl, "Unknown", _userSocialId, new Date(), HTTPStatus.SERVICE_UNAVAILABLE);
            }
            handleOnFault(_loc8_, param3);
        }
    }

    private static function generateRequestSignature(param1:String, param2:String):String {
        var _loc3_:String = "The Matrix has you..." + param1 + param2;
        var _loc4_:String = MD5.hash(_loc3_);
        return _loc4_;
    }

    public function setSegment(param1:int):AuthJsonCallCmd {
        return this.setAddress(ServerManager.SegmentServerAddresses[param1]);
    }

    public function setAddress(param1:String):AuthJsonCallCmd {
        this._url = makeUrl(param1);
        return this;
    }

    public function noResponseSignature():AuthJsonCallCmd {
        this._responseSignature = false;
        return this;
    }

    public function cancel():void {
        if (this._loader != null) {
            this._loader.close();
            this._loader = null;
            if (_onFinally != null) {
                _onFinally();
            }
        }
    }

    override public function execute():void {
        this.callJson(this._httpMethod == "POST", this._methodName, this._methodData, _onResult, _onFault, _onIoFault);
    }

    private function callJson(param1:Boolean, param2:String, param3:*, param4:Function = null, param5:Function = null, param6:Function = null):void {
        var ioFaultCalled:Boolean = false;
        var httpPost:Boolean = param1;
        var method:String = param2;
        var data:* = param3;
        var onResult:Function = param4;
        var onFault:Function = param5;
        var onIoFault:Function = param6;
        ioFaultCalled = false;
        this.call(httpPost, method, JSONOur.encode(data), function (param1:String):void {
            var _loc2_:FaultDto = null;
            if (ioFaultCalled) {
                return;
            }
            if (param1.length == 0 || param1.charAt(0) != "e") {
                if (onResult != null) {
                    onResult(param1.length == 0 ? null : JSONOur.decode(param1));
                }
            }
            else {
                param1 = param1.substr(1);
                _loc2_ = FaultDto.fromJson(JSONOur.decode(param1));
                _loc2_.setAdditionalProperty(_methodName, _url, JSONOur.encode(_methodData), _userSocialId, new Date(), HTTPStatus.OK, param1);
                handleOnFault(_loc2_, onFault);
            }
            if (_onFinally != null) {
                _onFinally();
            }
        }, function (param1:Event):void {
            ioFaultCalled = true;
            var _loc2_:int = 0;
            if (param1 is HTTPStatusEvent) {
                _loc2_ = (param1 as HTTPStatusEvent).status;
            }
            var _loc3_:FaultDto = new FaultDto();
            _loc3_.setAdditionalProperty(_methodName, _url, JSONOur.encode(_methodData), _userSocialId, new Date(), _loc2_);
            handleOnIoFault(param1, onIoFault, onFault, _loc3_);
            if (_onFinally != null) {
                _onFinally();
            }
        });
    }

    private function call(param1:Boolean, param2:String, param3:String, param4:Function = null, param5:Function = null):void {
        var paramTextForSignatureCalculation:String = null;
        var request:URLRequest = null;
        var headers:Array = null;
        var urlParams:String = null;
        var event:ErrorEvent = null;
        var httpPost:Boolean = param1;
        var method:String = param2;
        var data:String = param3;
        var result:Function = param4;
        var fault:Function = param5;
        var thisCmd:AuthJsonCallCmd = this;
        countActiveCommands++;
        countWaitingServerCommands++;
        paramTextForSignatureCalculation = null;
        var resultFunction:Function = function (param1:Event):void {
            var encoder:GZIPBytesEncoder = null;
            var iSignature:int = 0;
            var signature:String = null;
            var event:Event = param1;
            var responseBytes:ByteArray = _loader.data;
            _loader = null;
            if (responseBytes.length >= 3 && responseBytes[0] == 31 && responseBytes[1] == 139 && responseBytes[2] == 8) {
                encoder = new GZIPBytesEncoder();
                responseBytes = encoder.uncompressToByteArray(responseBytes);
            }
            var response:String = responseBytes.readUTFBytes(responseBytes.length);
            if (_responseSignature && !(response.length > 0 && response.charAt(0) == "e")) {
                iSignature = response.lastIndexOf("!");
                if (iSignature == -1 || iSignature >= response.length - 1) {
                    faultFunction(null);
                    return;
                }
                signature = response.substr(iSignature + 1);
                response = response.substr(0, iSignature);
                if (!validateResponseSignature(response, paramTextForSignatureCalculation, signature)) {
                    faultFunction(null);
                    return;
                }
            }
            lastSuccessCommandResultAtTimerMs = lastCommandResultAtTimerMs = getTimer();
            countWaitingServerCommands--;
            try {
                if (result != null) {
                    result(response);
                }
                return;
            }
            finally {
                countActiveCommands--;
            }
        };
        var faultFunction:Function = function (param1:Event):void {
            var event:Event = param1;
            _loader = null;
            lastCommandResultAtTimerMs = getTimer();
            countWaitingServerCommands--;
            try {
                if (fault != null) {
                    fault(event);
                }
                return;
            }
            finally {
                countActiveCommands--;
            }
        };
        var statusFunction:Function = function (param1:HTTPStatusEvent):void {
            if (param1.status >= HTTPStatus.BAD_REQUEST && param1.status <= HTTPStatus.NETWORK_CONNECT_TIMEOUT || param1.status == 0) {
                faultFunction(param1);
            }
        };
        var ioFunction:Function = function (param1:Event):void {
            _loader = null;
        };
        try {
            this._loader = new URLLoader();
            this._loader.dataFormat = URLLoaderDataFormat.BINARY;
            this._loader.addEventListener(Event.COMPLETE, resultFunction);
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, resultFunction);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, ioFunction);
            this._loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, statusFunction);
            request = new URLRequest(this._url);
            if (httpPost) {
                request.method = "POST";
                request.contentType = "text/html";
                headers = new Array();
                headers.push(new URLRequestHeader("client-ver", ServerManager.clientVersion));
                headers.push(new URLRequestHeader("server-method", method));
                if (_userSocialId != null && _userSocialId != "") {
                    headers.push(new URLRequestHeader("signin-userId", _userSocialId));
                }
                else if (_userHashedId != null && _userHashedId != "") {
                    headers.push(new URLRequestHeader("signin-userId", _userHashedId));
                }
                if (_userSocialAuthKey != null && _userSocialAuthKey != "") {
                    headers.push(new URLRequestHeader("signin-authKey", _userSocialAuthKey));
                }
                if (_userSocialAuthSeed != null && _userSocialAuthSeed != "") {
                    headers.push(new URLRequestHeader("signin-authSeed", _userSocialAuthSeed));
                }
                if (_sessionId != null) {
                    headers.push(new URLRequestHeader("signin-session", _sessionId));
                }
                if (_localeName != null && _localeName != "") {
                    headers.push(new URLRequestHeader("locale-name", _localeName));
                }
                if (_userSocialId != null && _userSocialId != "") {
                    paramTextForSignatureCalculation = method + (_userSocialId == null ? "" : _userSocialId) + (_userSocialAuthKey == null ? "" : _userSocialAuthKey);
                }
                else {
                    paramTextForSignatureCalculation = method + (_userHashedId == null ? "" : _userHashedId) + (_userSocialAuthKey == null ? "" : _userSocialAuthKey);
                }
                headers.push(new URLRequestHeader("sign-code", generateRequestSignature(data, paramTextForSignatureCalculation)));
                request.data = data;
                request.requestHeaders = headers;
            }
            else {
                request.method = "GET";
                urlParams = "ver=" + encodeURIComponent(ServerManager.clientVersion);
                urlParams = urlParams + ("&method=" + encodeURIComponent(method));
                if (_localeName != null && _localeName != "") {
                    urlParams = urlParams + ("&locale=" + _localeName);
                }
                paramTextForSignatureCalculation = method;
                urlParams = urlParams + ("&sign=" + encodeURIComponent(generateRequestSignature(data, paramTextForSignatureCalculation)));
                urlParams = urlParams + ("&data=" + encodeURIComponent(data));
                request.data = urlParams;
            }
            this._loader.load(request);
            return;
        }
        catch (e:Error) {
            event = new ErrorEvent(ErrorEvent.ERROR);
            event.text = String(e.message);
            faultFunction(event);
            return;
        }
    }

    private function validateResponseSignature(param1:String, param2:String, param3:String):Boolean {
        var _loc4_:String = "Follow the white rabbit." + param1 + param2;
        var _loc5_:String = MD5.hash(_loc4_);
        return _loc5_ == param3;
    }
}
}
