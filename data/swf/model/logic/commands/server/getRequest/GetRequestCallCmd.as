package model.logic.commands.server.getRequest {
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;

import json.JSONOur;

import model.logic.commands.BaseCmd;

public class GetRequestCallCmd extends BaseCmd {


    private var _url:String;

    private var _methodData:GetFormatRequest;

    private var _loader:URLLoader;

    private var _request:URLRequest;

    public function GetRequestCallCmd(param1:GetFormatRequest, param2:String) {
        super();
        this._url = param2;
        this._methodData = param1;
        this._request = new URLRequest();
    }

    override public function execute():void {
        this._request.method = URLRequestMethod.GET;
        this._request.url = this._url;
        if (this._methodData != null && this._methodData.count > 0) {
            this._request.url = this._request.url + this._methodData.toString();
        }
        this._loader = new URLLoader();
        this._loader.addEventListener(Event.COMPLETE, this.onLoad);
        this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.faultFunction, false, 0, true);
        this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.faultFunction);
        try {
            this._loader.load(this._request);
            return;
        }
        catch (e:Error) {
            if (_onFault is Function) {
                _onFault();
            }
            return;
        }
    }

    private function onLoad(param1:Event):void {
        var _loc2_:* = JSONOur.decode(this._loader.data);
        _onResult(_loc2_);
        this.dispose();
    }

    private function faultFunction(param1:Event):void {
        if (_onFault is Function) {
            _onFault();
        }
    }

    private function dispose():void {
        if (this._loader != null) {
            this._loader.close();
            this._loader = null;
            if (_onFinally is Function) {
                _onFinally();
            }
        }
    }
}
}
