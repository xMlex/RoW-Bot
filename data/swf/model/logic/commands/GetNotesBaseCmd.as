package model.logic.commands {
public class GetNotesBaseCmd extends BaseCmd {


    protected var onLoadedCallback:Function;

    protected var needDispatchUpdateEvent:Boolean;

    public function GetNotesBaseCmd() {
        super();
    }

    public function onNotesLoaded(param1:Function):GetNotesBaseCmd {
        this.onLoadedCallback = param1;
        return this;
    }
}
}
