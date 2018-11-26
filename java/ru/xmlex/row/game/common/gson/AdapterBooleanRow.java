package ru.xmlex.row.game.common.gson;

import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;

import java.io.IOException;

/**
 * Created by xMlex on 4/2/16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class AdapterBooleanRow extends TypeAdapter<Boolean> {
    @Override
    public void write(JsonWriter jsonWriter, Boolean aBoolean) throws IOException {
        if (aBoolean == null) {
            jsonWriter.nullValue();
        } else {
            jsonWriter.value(aBoolean);
        }
    }

    @Override
    public Boolean read(JsonReader in) throws IOException {
        JsonToken peek = in.peek();
        switch (peek) {
            case BOOLEAN:
                return in.nextBoolean();
            case NULL:
                in.nextNull();
                return null;
            case NUMBER:
                return in.nextInt() != 0;
            case STRING:
                return Boolean.parseBoolean(in.nextString());
            default:
                throw new IllegalStateException("Expected BOOLEAN or NUMBER but was " + peek);
        }
    }
}
