package model.logic.globalEvents {
import model.data.globalEvent.GlobalEventDateFilter;

public class GlobalEventItem {


    public var id:Number;

    public var typeIds:Array;

    public var isUpcoming:Boolean;

    public var iconUrl:String;

    public var value:Number;

    public var pictureUrl:String;

    public var pictureUrlActiveState:String;

    public var text:String;

    public var dateFilter:GlobalEventDateFilter;

    public function GlobalEventItem() {
        super();
    }
}
}
