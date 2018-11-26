package model.data.map.unitMoving {
public class MapRefreshInput {


    public var trackedBlocks:Array;

    public function MapRefreshInput() {
        this.trackedBlocks = [];
        super();
    }

    public function toDto():* {
        var _loc1_:* = {"b": MapTrackingBlock.toDtos(this.trackedBlocks)};
        return _loc1_;
    }
}
}
