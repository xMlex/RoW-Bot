package ru.xmlex.row.game.data;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import ru.xmlex.row.game.common.LocaleUtil;

/**
 * Created by xMlex on 01.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class Resources {
    public static final Resources Zero = new Resources();

    public static final Resources MaxValue = new Resources(Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE, Integer.MAX_VALUE);

    public static final String GOLD_MONEY = "Resources_Gold_Money";

    public static final String MONEY = "Resources_Money";

    public static final String URANIUM = "Resources_Uranium";

    public static final String TITANITE = "Resources_Titanite";

    public static final String BIOCHIPS = "Resources_Biochips";

    public static final String BLACKCRYSTALS = "Resources_BlackCrystals";

    public static final String AVPMONEY = "Resources_AvpMoney";

    public static final String CONSTRICTIONITEMS = "Resources_ConstructionItems";
    @Expose
    @SerializedName("g")
    public double goldMoney;
    @Expose
    @SerializedName("m")
    public double money;
    @Expose
    @SerializedName("u")
    public double uranium;
    @Expose
    @SerializedName("t")
    public double titanite;
    @Expose
    @SerializedName("c")
    public double biochips = 0;
    @Expose
    @SerializedName("b")
    public double blackCrystals = 0;
    @Expose
    @SerializedName("a")
    public double avpMoney = 0;
    @Expose
    @SerializedName("i")
    public double constructionItems;

    public UpgradeItems upgradeItems;

    public double idols;

    public Resources(double gold, double credits, double uran, double titan, double param5, double param6, double param7, double param8, double param9) {
        super();
        this.goldMoney = gold;
        this.money = credits;
        this.uranium = uran;
        this.titanite = titan;
        this.biochips = param5;
        this.blackCrystals = param6;
        this.avpMoney = param8;
        this.constructionItems = param9;
        this.idols = param7;
    }

    public Resources(double param1, double param2, double param3, double param4) {
        this(param1, param2, param3, param4, 0, 0, 0, 0, 0);
    }

    public Resources() {
        this(0, 0, 0, 0, 0, 0, 0, 0, 0);
    }

    public static Resources fromGoldMoney(int param1) {
        return new Resources(param1, 0, 0, 0);
    }

    public static Resources fromMoney(int param1) {
        return new Resources(0, param1, 0, 0);
    }

    public static Resources fromUranium(int param1) {
        return new Resources(0, 0, param1, 0);
    }

    public static Resources fromTitanite(int param1) {
        return new Resources(0, 0, 0, param1);
    }

    public static Resources fromBiochips(int param1) {
        return new Resources(0, 0, 0, 0, param1, 0, 0, 0, 0);
    }

    public static Resources fromBlackCrystals(int param1) {
        return new Resources(0, 0, 0, 0, 0, param1, 0, 0, 0);
    }

    public static Resources fromAvpMoney(int param1) {
        return new Resources(0, 0, 0, 0, 0, 0, 0, param1, 0);
    }

    public static Resources fromConstructionItems(int param1) {
        return new Resources(0, 0, 0, 0, 0, 0, 0, 0, param1);
    }

    public static Resources fromType(int param1, int param2) {
        switch (param1) {
            case ResourceTypeId.GOLD_MONEY:
                return fromGoldMoney(param2);
            case ResourceTypeId.MONEY:
                return fromMoney(param2);
            case ResourceTypeId.URANIUM:
                return fromUranium(param2);
            case ResourceTypeId.TITANITE:
                return fromTitanite(param2);
            case ResourceTypeId.BIOCHIPS:
                return fromBiochips(param2);
            case ResourceTypeId.BLACK_CRYSTALS:
                return fromBlackCrystals(param2);
            case ResourceTypeId.AVP_MONEY:
                return fromAvpMoney(param2);
            case ResourceTypeId.CONSTRUCTION_ITEMS:
                return fromConstructionItems(param2);
            default:
                throw new Error("typeId");
        }
    }

    public static Resources FromTUM(int param1, int param2, int param3) {
        return new Resources(0, param3, param2, param1);
    }

    public static Resources accelerate(Resources param1, Resources param2) {
        param1 = param1.clone();
        param1.accelerate(param2);
        return param1;
    }

    public static Resources scale(Resources param1, int param2) {
        param1 = param1.clone();
        param1.scale(param2);
        return param1;
    }

    private boolean isBlackCrystalsEnabled() {
        return false;//UserManager.hasSignInParam("black_crystals");
    }

    public boolean isEmpty() {
        return this.equals(Zero);
    }

    public boolean isOnlyGold() {
        return this.money == 0 && this.uranium == 0 && this.titanite == 0 && this.biochips == 0 && this.goldMoney != 0 && this.blackCrystals == 0 && this.avpMoney == 0;
    }

    public boolean isOnlyCredits() {
        return this.money != 0 && this.uranium == 0 && this.titanite == 0 && this.biochips == 0 && this.goldMoney == 0 && this.blackCrystals == 0 && this.avpMoney == 0;
    }

    public boolean isOnlyTitanium() {
        return this.money == 0 && this.uranium == 0 && this.titanite != 0 && this.biochips == 0 && this.goldMoney == 0 && this.blackCrystals == 0 && this.avpMoney == 0;
    }

    public boolean isOnlyUranium() {
        return this.money == 0 && this.uranium != 0 && this.titanite == 0 && this.biochips == 0 && this.goldMoney == 0 && this.blackCrystals == 0 && this.avpMoney == 0;
    }

    public boolean isOnlyBlackCrystals() {
        return this.money == 0 && this.uranium == 0 && this.titanite == 0 && this.biochips == 0 && this.goldMoney == 0 && this.blackCrystals != 0 && this.avpMoney == 0;
    }

    public boolean isOnlyAvpMoney() {
        return this.money == 0 && this.uranium == 0 && this.titanite == 0 && this.biochips == 0 && this.goldMoney == 0 && this.blackCrystals == 0 && this.avpMoney != 0;
    }

    public boolean isMUT() {
        return this.money != 0 && this.uranium != 0 && this.titanite != 0 && this.biochips == 0 && this.goldMoney == 0 && this.blackCrystals == 0;
    }

    public Resources clone() {
        return new Resources(this.goldMoney, this.money, this.uranium, this.titanite, this.biochips, this.blackCrystals, this.idols, this.avpMoney, this.constructionItems);
    }

    public boolean isTitaniteMoreUranium() {
        return titanite > uranium;
    }

    public double getAny() {
        if (this.money > 0) {
            return this.money;
        }
        if (this.uranium > 0) {
            return this.uranium;
        }
        if (this.titanite > 0) {
            return this.titanite;
        }
        if (this.goldMoney > 0) {
            return this.goldMoney;
        }
        if (this.biochips > 0) {
            return this.biochips;
        }
        if (this.blackCrystals > 0) {
            return this.blackCrystals;
        }
        if (this.avpMoney > 0) {
            return this.avpMoney;
        }
        if (this.constructionItems > 0) {
            return this.constructionItems;
        }
        return 0;
    }

    public String toString() {
        return "{g:" + this.goldMoney + ",m:" + this.money + ",u:" + this.uranium + ",t:" + this.titanite + ",c:" + this.biochips + ",b:" + this.blackCrystals + ",a:" + this.avpMoney + ",i:" + this.constructionItems + "}";
    }

    public String toUserFriendlyString(boolean param1) {
        String val = "";
        if (param1 && this.goldMoney > 0 || !param1) {
            val = val + Math.round(this.goldMoney) + " " + LocaleUtil.getText("model-data-resources-goldMoney");
        }
        if (param1 && this.money > 0 || !param1) {
            if (val.equals("")) {
                val = val + ",  ";
            }
            val = val + Math.round(this.money) + " " + LocaleUtil.getText("model-data-resources-money");
        }
        if (param1 && this.uranium > 0 || !param1) {
            if (val.equals("")) {
                val = val + ", ";
            }
            val = val + Math.round(this.uranium) + " " + LocaleUtil.getText("model-data-resources-uranium");
        }
        if (param1 && this.titanite > 0 || !param1) {
            if (val.equals("")) {
                val = val + ",  ";
            }
            val = val + Math.round(this.titanite) + " " + LocaleUtil.getText("model-data-resources-titanium");
        }
        if (param1 && this.biochips > 0 || !param1) {
            if (val.equals("")) {
                val = val + ",  ";
            }
            val = val + Math.round(this.biochips) + " " + LocaleUtil.getText("model-data-resources-biochips");
        }
        if (param1 && this.blackCrystals > 0 || !param1) {
            if (val.equals("")) {
                val = val + ",  ";
            }
            val = val + Math.round(this.blackCrystals) + " " + LocaleUtil.getText("model-data-resources-blackcrystals");
        }
        if (param1 && this.avpMoney > 0 || !param1) {
            if (val.equals("")) {
                val = val + ",  ";
            }
            val = val + Math.round(this.avpMoney) + " " + LocaleUtil.getText("model-data-resources-avpmoney");
        }
        if (param1 && this.constructionItems > 0 || !param1) {
            if (val.equals("")) {
                val = val + ",  ";
            }
            val = val + Math.round(this.constructionItems) + " " + LocaleUtil.getText("model-data-resources-constructionitems");
        }
        return val;
    }

    public double getVal(String param1) {
        double val = 0;
        if (param1 != null)
            switch (param1) {
                case GOLD_MONEY:
                    val = this.goldMoney;
                    break;
                case MONEY:
                    val = this.money;
                    break;
                case URANIUM:
                    val = this.uranium;
                    break;
                case TITANITE:
                    val = this.titanite;
                    break;
                case BIOCHIPS:
                    val = this.biochips;
                    break;
                case BLACKCRYSTALS:
                    val = this.blackCrystals;
                    break;
                case AVPMONEY:
                    val = this.avpMoney;
                    break;
                case CONSTRICTIONITEMS:
                    val = this.constructionItems;
                    break;
            }
        return val;
    }

    public boolean equals(Resources param1) {
        return param1.goldMoney == this.goldMoney && param1.money == this.money && param1.uranium == this.uranium && param1.titanite == this.titanite && param1.biochips == this.biochips && param1.blackCrystals == this.blackCrystals && param1.idols == this.idols && param1.avpMoney == this.avpMoney && param1.constructionItems == this.constructionItems;
    }

    public boolean greaterOrEquals(Resources param1) {
        return this.goldMoney >= param1.goldMoney && this.money >= param1.money && this.uranium >= param1.uranium && this.titanite >= param1.titanite && this.biochips >= param1.biochips && this.blackCrystals >= param1.blackCrystals && this.avpMoney >= param1.avpMoney && this.constructionItems >= param1.constructionItems;
    }

    public boolean canSubstract(Resources param1) {
        return (param1.goldMoney == 0 || this.goldMoney >= param1.goldMoney) && (param1.uranium == 0 || this.uranium >= param1.uranium) && (param1.titanite == 0 || this.titanite >= param1.titanite) && (param1.money == 0 || this.money >= param1.money) && (param1.biochips == 0 || this.biochips > param1.biochips) && (param1.blackCrystals == 0 || this.blackCrystals > param1.blackCrystals) && (param1.avpMoney == 0 || this.avpMoney >= param1.avpMoney) && (param1.constructionItems == 0 || this.constructionItems >= param1.constructionItems);
    }

    public void add(Resources param1) {
        this.change(param1, 1);
    }

    public void substract(Resources param1) {
        this.change(param1, -1);
    }

    private void change(Resources param1, int param2) {
        this.goldMoney = this.goldMoney + param2 * param1.goldMoney;
        this.money = this.money + param2 * param1.money;
        this.uranium = this.uranium + param2 * param1.uranium;
        this.titanite = this.titanite + param2 * param1.titanite;
        this.biochips = this.biochips + param2 * param1.biochips;
        this.blackCrystals = this.blackCrystals + param2 * param1.blackCrystals;
        this.avpMoney = this.avpMoney + param2 * param1.avpMoney;
        this.constructionItems = this.constructionItems + param2 * param1.constructionItems;
    }

    public Resources sumResources(Resources param1) {
        Resources val = this.clone();
        val.goldMoney = val.goldMoney + param1.goldMoney;
        val.money = val.money + param1.money;
        val.uranium = val.uranium + param1.uranium;
        val.titanite = val.titanite + param1.titanite;
        val.biochips = val.biochips + param1.biochips;
        val.blackCrystals = val.blackCrystals + param1.blackCrystals;
        val.avpMoney = val.avpMoney + param1.avpMoney;
        val.constructionItems = val.constructionItems + param1.constructionItems;
        return val;
    }

    public void accelerate(Resources param1) {
        if (param1 != null) {
            if (this.goldMoney > 0) {
                this.goldMoney = this.goldMoney * param1.goldMoney;
            }
            if (this.money > 0) {
                this.money = this.money * param1.money;
            }
            if (this.uranium > 0) {
                this.uranium = this.uranium * param1.uranium;
            }
            if (this.titanite > 0) {
                this.titanite = this.titanite * param1.titanite;
            }
            if (this.biochips > 0) {
                this.biochips = this.biochips * param1.biochips;
            }
            if (this.blackCrystals > 0) {
                this.blackCrystals = this.blackCrystals * param1.blackCrystals;
            }
            if (this.avpMoney > 0) {
                this.avpMoney = this.avpMoney * param1.avpMoney;
            }
            if (this.constructionItems > 0) {
                this.constructionItems = this.constructionItems * param1.constructionItems;
            }
        }
    }

    public void scale(double param1) {
        this.goldMoney = this.goldMoney * param1;
        this.money = this.money * param1;
        this.uranium = this.uranium * param1;
        this.titanite = this.titanite * param1;
        this.biochips = this.biochips * param1;
        this.blackCrystals = this.blackCrystals * param1;
        this.avpMoney = this.avpMoney * param1;
        this.constructionItems = this.constructionItems * param1;
    }

    public void threshold(Resources param1) {
        this.goldMoney = Math.min(this.goldMoney, param1.goldMoney);
        this.money = Math.min(this.money, param1.money);
        this.uranium = Math.min(this.uranium, param1.uranium);
        this.titanite = Math.min(this.titanite, param1.titanite);
        this.biochips = Math.min(this.biochips, param1.biochips);
        this.blackCrystals = Math.min(this.blackCrystals, param1.blackCrystals);
        this.avpMoney = Math.min(this.avpMoney, param1.avpMoney);
        this.constructionItems = Math.min(this.constructionItems, param1.constructionItems);
    }

    public void threshold2(Resources param1, Resources param2) {
        this.goldMoney = Math.max(param1.goldMoney, Math.min(this.goldMoney, param2.goldMoney));
        this.money = Math.max(param1.money, Math.min(this.money, param2.money));
        this.uranium = Math.max(param1.uranium, Math.min(this.uranium, param2.uranium));
        this.titanite = Math.max(param1.titanite, Math.min(this.titanite, param2.titanite));
        this.biochips = Math.max(param1.biochips, Math.min(this.biochips, param2.biochips));
        this.blackCrystals = Math.max(param1.blackCrystals, Math.min(this.blackCrystals, param2.blackCrystals));
    }

    /**
     * Получаем колличество элементов которых можем купить на имеющиеся ресурсы
     *
     * @param price цена одного элемента
     * @return
     */
    public int getCount(Resources price) {
        Resources res = new Resources();

        double min = 0;

        res.goldMoney = calcCountOne(goldMoney, price.goldMoney);
        res.money = calcCountOne(money, price.money);
        res.uranium = calcCountOne(uranium, price.uranium);
        res.titanite = calcCountOne(titanite, price.titanite);
        res.biochips = calcCountOne(biochips, price.biochips);
        res.blackCrystals = calcCountOne(blackCrystals, price.blackCrystals);
        res.avpMoney = calcCountOne(avpMoney, price.avpMoney);
        res.constructionItems = calcCountOne(constructionItems, price.constructionItems);

        min = reCalcOne(res.goldMoney, min);
        min = reCalcOne(res.money, min);
        min = reCalcOne(res.uranium, min);
        min = reCalcOne(res.titanite, min);
        min = reCalcOne(res.biochips, min);
        min = reCalcOne(res.blackCrystals, min);
        min = reCalcOne(res.avpMoney, min);
        min = reCalcOne(res.constructionItems, min);

        if (min < 0)
            return 0;
        return (int) min;
    }

    public static double reCalcOne(double count, double current) {
        if (current == -1)
            return -1;
        if (count == -1 || count < 0)
            return -1;
        if (current == 0)
            return count;
        if (count != 0 && count < current)
            return count;
        return current;
    }

    public static int calcCountOne(double size, double price) {
        if (price <= 0)
            return 0;
        if (size <= 0)
            return -1;
        return (int) Math.floor(size / price);
    }

    public Resources roundAll() {
        this.goldMoney = Math.round(this.goldMoney);
        this.money = Math.round(this.money);
        this.uranium = Math.round(this.uranium);
        this.titanite = Math.round(this.titanite);
        this.biochips = Math.round(this.biochips);
        this.blackCrystals = Math.round(this.blackCrystals);
        this.avpMoney = Math.round(this.avpMoney);
        this.constructionItems = Math.round(this.constructionItems);
        return this;
    }

    public double capacity() {
        return this.goldMoney + this.money + this.uranium + this.titanite + this.biochips + this.blackCrystals + this.avpMoney + this.constructionItems;
    }

    public boolean isNegative() {
        return this.goldMoney < 0 || this.money < 0 || this.uranium < 0 || this.titanite < 0 || this.biochips < 0 || this.blackCrystals < 0 || this.avpMoney < 0 || this.constructionItems < 0;
    }

    public void clear() {
        this.goldMoney = 0;
        this.money = 0;
        this.uranium = 0;
        this.titanite = 0;
        this.biochips = 0;
        this.blackCrystals = 0;
        this.idols = 0;
        this.avpMoney = 0;
        this.constructionItems = 0;
    }
}
