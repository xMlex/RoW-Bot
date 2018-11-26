package model.logic.commands {
public class QueueCommandsCaller {

    private static var _commands:Vector.<BaseCmd>;

    private static var _awaiting:Boolean = false;

    private static var _currentCmd:BaseCmd;


    public function QueueCommandsCaller() {
        super();
    }

    public static function addCommand(param1:BaseCmd):void {
        if (_commands == null) {
            _commands = new Vector.<BaseCmd>(0);
        }
        if (param1 != null) {
            _commands.push(param1);
        }
        executeCommand();
    }

    private static function executeCommand():void {
        if (!_awaiting && _commands.length > 0) {
            _currentCmd = _commands.shift();
            _awaiting = true;
            _currentCmd.doFinally(onCurrentCommandDoFinally).execute();
        }
    }

    private static function onCurrentCommandDoFinally():void {
        _awaiting = false;
        _currentCmd = null;
        executeCommand();
    }
}
}
