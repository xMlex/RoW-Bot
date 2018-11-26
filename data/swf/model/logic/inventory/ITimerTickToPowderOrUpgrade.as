package model.logic.inventory {
public interface ITimerTickToPowderOrUpgrade {


    function startTimerToPowderAndUpgrade():void;

    function stopTimerToPowderOrUpgrade():void;

    function tickTimerToPowderOrUpgrade():void;

    function constructionFinishTimeToPowderOrUpgrade():Date;
}
}
