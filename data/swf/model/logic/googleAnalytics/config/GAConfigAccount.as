package model.logic.googleAnalytics.config {
public class GAConfigAccount {


    public function GAConfigAccount() {
        super();
    }

    public static function get none():String {
        return "";
    }

    public static function get nordsVk():String {
        return "UA-67886619-2";
    }

    public static function get nordsFb():String {
        return "UA-67886619-3";
    }

    public static function get rowFb():String {
        return "UA-67886619-4";
    }

    public static function get elvesFb():String {
        return "UA-67886619-5";
    }

    public static function get militaryFb():String {
        return "UA-67886619-6";
    }
}
}
