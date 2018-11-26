package model.data.alliances.events {
public class AllianceEventsFilter {


    public var eventType:Object;

    public var isActive:Object;

    public var isLastWeek:Object = false;

    public function AllianceEventsFilter() {
        super();
    }

    public function toDto():* {
        return {
            "t": this.eventType,
            "a": this.isActive,
            "w": this.isLastWeek
        };
    }
}
}
