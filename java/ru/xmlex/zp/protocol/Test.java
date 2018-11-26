package ru.xmlex.zp.protocol;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Test {

    public static boolean checkRegExp(String rg, String s) {
        Pattern p = Pattern.compile(rg);
        Matcher m = p.matcher(s);
        return m.matches();
    }

    public static void main(String[] args) {
        String rg = "^\\d+>.+";
        String s = "2>{'now':1423582670}";

        System.out.println("Res: " + checkRegExp(rg, s));
        System.out.println("Str: " + s.matches(rg));
        System.out.println("Str: " + s);
    }

}
