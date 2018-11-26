package ru.xmlex.row.game.common;

/**
 * Created by xMlex on 08.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class GameType {
    public static GameType TOTAL_DOMINATION = new GameType("geotopia");

    public static GameType PIRATES = new GameType("pirates");

    public static GameType ELVES = new GameType("elves");

    public static GameType MILITARY = new GameType("military");

    public static GameType SPARTA = new GameType("sparta");

    public static GameType NORDS = new GameType("nords");

    public static GameType current;

    private String _name = "military";

    public GameType(String param1) {
        this._name = param1;
    }

    public static boolean isTotalDomination() {
        return current == TOTAL_DOMINATION;
    }

    public static boolean isPirates() {
        return current == PIRATES;
    }

    public static boolean isElves() {
        return current == ELVES;
    }

    public static boolean isMilitary() {
        return current == MILITARY;
    }

    public static boolean isSparta() {
        return current == SPARTA;
    }

    public static boolean isNords() {
        return current == NORDS;
    }

    public static String getGameAbbreviation() {
        if (isTotalDomination()) {
            return "TD";
        }
        if (isPirates()) {
            return "TOF";
        }
        if (isElves()) {
            return "SF";
        }
        if (isMilitary()) {
            return "SI";
        }
        if (isSparta()) {
            return "SP";
        }
        if (isNords()) {
            return "ND";
        }
        return "SF";
    }

    public String toString() {
        return "game_type_" + this._name;
    }

    public String name() {
        return this._name;
    }
}
