package ru.xmlex.row.game.data.map.unitMoving;

/**
 * Created by mlex on 29.12.2016.
 */
public class MapPosBlockExtensions {

    public static final int MAX = 65535;
    public static final short BLOCK_SIZE = 20;

    public static int getBlockId(int x, int y) {
        return getBlockId(x, y, 1);
    }

    public static int getBlockId(int x1, int y1, int one) {
        int x = x1 - 1, y = y1 - 1;
        return one == 1 ? x << 16 | y & MAX : round(x, one) << 16 | round(y, one) & MAX;
    }

    private static int round(int x, int y) {
        return x >= 0 ? (x / y) : ((x - y + 1) / y);
    }

    public static int xToId(int x) {
        return x / BLOCK_SIZE * MAX;
    }

//    public static function getBlockId(param1:int, param2:int, param3:int = 1) : int
//    {
//        return param3 == 1?param1 << 16 | param2 & 65535:round(param1,param3) << 16 | round(param2,param3) & 65535;
//    }
//
//    private static function round(param1:int, param2:int) : int
//    {
//        return param1 >= 0?int(param1 / param2):int((param1 - param2 + 1) / param2);
//    }

    public static void debug(int x, int y) {

        int x2 = x - 1;
        int x3 = x + 1;
        int x4 = x + 1, y4 = y + 1;

        System.out.println("Debug map blocks");
        System.out.println("f: " + xToId(x));
        System.out.println("f: " + xToId(x + 1));
//        System.out.println(String.valueOf(getBlockId(x, x2)));
//        System.out.println(String.valueOf(getBlockId(x2, y)));
//        System.out.println(String.valueOf(getBlockId(y4, y)));
//        System.out.println(String.valueOf(getBlockId(x, x)));

    }

    public static void main(String[] args) {
        debug(1, 1);
        debug(265, -482);
    }
}
