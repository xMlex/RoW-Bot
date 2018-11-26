package model.data.users.messages {
public class FeatureTypeKeyBuilder {


    private var _typeId:int;

    public function FeatureTypeKeyBuilder(param1:int) {
        super();
        this._typeId = param1;
    }

    public function get key():String {
        switch (this._typeId) {
            case MessageTypeId.AllianceCitiesEnabled:
                return "forms-formHelp_allianceCity_header";
            default:
                return "";
        }
    }
}
}
