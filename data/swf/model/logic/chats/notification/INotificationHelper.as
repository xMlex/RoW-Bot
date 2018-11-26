package model.logic.chats.notification {
import model.logic.chats.ChatMessage;

public interface INotificationHelper {


    function findHandler(param1:ChatMessage):void;

    function execute():void;

    function executeCash():void;
}
}
