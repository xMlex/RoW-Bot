package ru.xmlex.row.game.data.map.unitMoving;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

public class MapRefreshInput {
    @Expose
    @SerializedName("b")
    public List<MapTrackingBlock> mapTrackingBlocks = new ArrayList<>(4);

    public static MapRefreshInput fromX(int x, boolean isDop) {

        int xr = MapPosBlockExtensions.xToId(x);
        int yr = xr + 1;//MapPosBlockExtensions.xToId(y);

        MapRefreshInput result = new MapRefreshInput();
        result.mapTrackingBlocks.add(new MapTrackingBlock(xr));

        if (isDop) {
            result.mapTrackingBlocks.add(new MapTrackingBlock(yr));
        }

        return result;
    }
}
