package model.logic.inventory {
public interface ITimerTickToRemoveItems {


    function startTimerToRemoveItems():void;

    function stopTimerToRemoveItems():void;

    function tickTimerToRemoveItems():void;

    function constructionFinishTimeToRemoveItems():Date;
}
}
