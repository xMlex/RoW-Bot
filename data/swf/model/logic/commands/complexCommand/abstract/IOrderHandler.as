package model.logic.commands.complexCommand.abstract {
public interface IOrderHandler {


    function handlerRequest():void;

    function set nextWrapper(param1:IOrderHandler):void;

    function get nextWrapper():IOrderHandler;

    function set finallyCallback(param1:Function):void;

    function get finallyCallback():Function;
}
}
