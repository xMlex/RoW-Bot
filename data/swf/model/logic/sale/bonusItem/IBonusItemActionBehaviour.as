package model.logic.sale.bonusItem {
import model.data.temporarySkins.TemporarySkin;
import model.logic.tournament.IActionInvoker;

public interface IBonusItemActionBehaviour {


    function tempSkinActionBehaviour(param1:TemporarySkin):IActionInvoker;

    function unitActionBehaviour(param1:int):IActionInvoker;
}
}
