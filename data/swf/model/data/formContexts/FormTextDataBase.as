package model.data.formContexts {
public class FormTextDataBase {


    public var header:String;

    public var description:String;

    public var buttonOk:String;

    public var buttonCancel:String;

    public function FormTextDataBase(param1:String = "", param2:String = "", param3:String = "", param4:String = "") {
        super();
        this.header = param1;
        this.description = param2;
        this.buttonOk = param3;
        this.buttonCancel = param4;
    }
}
}
