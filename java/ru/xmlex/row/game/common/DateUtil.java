package ru.xmlex.row.game.common;

/**
 * Created by xMlex on 06.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class DateUtil {
    public static int SECONDS_1_MINUTE = 60;

    public static int SECONDS_3_MINUTES = SECONDS_1_MINUTE * 3;

    public static int SECONDS_5_MINUTES = SECONDS_1_MINUTE * 5;

    public static int SECONDS_10_MINUTES = SECONDS_1_MINUTE * 10;

    public static int SECONDS_15_MINUTES = SECONDS_1_MINUTE * 15;

    public static int SECONDS_30_MINUTES = SECONDS_1_MINUTE * 30;

    public static int SECONDS_60_MINUTES = SECONDS_1_MINUTE * 60;

    public static int SECONDS_4_HOURS = SECONDS_60_MINUTES * 4;

    public static int SECONDS_8_HOURS = SECONDS_60_MINUTES * 8;

    public static int SECONDS_12_HOURS = SECONDS_60_MINUTES * 12;

    public static int SECONDS_1_DAY = SECONDS_60_MINUTES * 24;

    public static int SECONDS_2_DAYS = SECONDS_60_MINUTES * 24 * 2;

    public static int SECONDS_3_DAYS = SECONDS_60_MINUTES * 24 * 3;

    public static int SECONDS_7_DAYS = SECONDS_60_MINUTES * 24 * 7;

    public static int SECONDS_9_DAYS = SECONDS_2_DAYS + SECONDS_7_DAYS;

    public static int SECONDS_30_DAYS = SECONDS_60_MINUTES * 24 * 30;

    public static int MILLISECONDS_PER_MINUTE = 1000 * 60;

    public static int MILLISECONDS_PER_HOUR = 1000 * 60 * 60;

    public static int MILLISECONDS_PER_DAY = 1000 * 60 * 60 * 24;

    private static final int TIMESPAN_CEIL_TO_SECONDS = 1;

    private static final int TIMESPAN_CEIL_TO_MINUTES = 2;

    private static final int FORMAT_TIMESPAN_DDHHMM = 1;

    private static final int FORMAT_TIMESPAN_HHMM = 2;

    private static final int FORMAT_TIMESPAN_HHMMSS = 3;

    private static final int FORMAT_TIMESPAN_MMSS = 4;

    private static final int FORMAT_TIMESPAN_SS = 5;

    private static final int FORMAT_TIMESPAN_DDHHMMSS = 6;

    private static final int FORMAT_TIMESPAN_DDHHMM_SPACELESS = 7;

    private static final int FORMAT_TIMESPAN_DD = 8;

    private static final int FORMAT_TIMESPAN_DDHH = 9;

    private static final int FORMAT_TIMESPAN_HHMMSS_SPACELESS = 10;

    private static final int FORMAT_TIMESPAN_HHMM_SPACELESS = 11;

    private static final int FORMAT_TIMESPAN_DDHH_SPACELESS = 12;

    private static final int FORMAT_TIMESPAN_DDHHMMSS_SPACELESS = 13;

    private static final int FORMAT_TIMESPAN_HH = 14;

    private static final int FORMAT_TIMESPAN_SS_SPACELESS = 14;

    private static final int FORMAT_TIMESPAN_MMSS_SPACELESS = 15;

    public static String FORMATTER_STRING = "YYYY/MM/DD NN JJ:SS +0";

//    private static const Array TIME_DIVISIONS_NAMES = [LocaleUtil.getText("utils-common-dateUtils-day"),LocaleUtil.getText("utils-common-dateUtils-hous"),LocaleUtil.getText("utils-common-dateUtils-minute"),LocaleUtil.getText("utils-common-dateUtils-second"),LocaleUtil.getText("utils-common-dateUtils-millisecond")];
//
//    private static const Array TIME_DIVISIONS_OVERFLOW_VALUES = [int.MAX_VALUE,24,60,60,1000];
//
//    private static const Array DAY_NAMES_FULL = [LocaleUtil.getText("utils-common-dateUtils-Sun"),LocaleUtil.getText("utils-common-dateUtils-Mon"),LocaleUtil.getText("utils-common-dateUtils-Tue"),LocaleUtil.getText("utils-common-dateUtils-Wed"),LocaleUtil.getText("utils-common-dateUtils-Thu"),LocaleUtil.getText("utils-common-dateUtils-Fri"),LocaleUtil.getText("utils-common-dateUtils-Sat")];
//
//    private static const Array MONTH_NAMES_FULL_GENETIVE = [LocaleUtil.getText("utils-common-dateUtils-Jan"),LocaleUtil.getText("utils-common-dateUtils-Feb"),LocaleUtil.getText("utils-common-dateUtils-Mar"),LocaleUtil.getText("utils-common-dateUtils-Apr"),LocaleUtil.getText("utils-common-dateUtils-May"),LocaleUtil.getText("utils-common-dateUtils-Jun"),LocaleUtil.getText("utils-common-dateUtils-Jul"),LocaleUtil.getText("utils-common-dateUtils-Aug"),LocaleUtil.getText("utils-common-dateUtils-Sep"),LocaleUtil.getText("utils-common-dateUtils-Oct"),LocaleUtil.getText("utils-common-dateUtils-Nov"),LocaleUtil.getText("utils-common-dateUtils-Dec")];

    public static String HOUR = LocaleUtil.getText("utils-common-dateUtils-1hour");

    public static String SEVERAL_HOURS = LocaleUtil.getText("utils-common-dateUtils-severalHours");

    public static String DOZEN_HOURS = LocaleUtil.getText("utils-common-dateUtils-dozenHours");

    public static String DAY = LocaleUtil.getText("model-logic-misc-rankManager-day1");

    public static String SEVERAL_DAYS = LocaleUtil.getText("model-logic-misc-rankManager-day2");

    public static String DOZEN_DAYS = LocaleUtil.getText("model-logic-misc-rankManager-day5");

    public static String MINUTES = LocaleUtil.getText("model-logic-misc-rankManager-minutes1");

    public static int FIRST_BEFORE = -1;

    public static int DATES_EQUAL = 0;

    public static int FIRST_AFTER = 1;
}
