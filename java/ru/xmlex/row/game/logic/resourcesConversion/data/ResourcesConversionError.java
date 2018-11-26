package ru.xmlex.row.game.logic.resourcesConversion.data;

import ru.xmlex.row.game.data.Resources;

/**
 * Created by xMlex on 09.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class ResourcesConversionError {
    public int code;

    public Resources resources;

    public ResourcesConversionError(int param1) {
        this(param1, null);
    }

    public ResourcesConversionError(int param1, Resources param2) {
        super();
        this.code = param1;
        this.resources = param2;
    }
}
