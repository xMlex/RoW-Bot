package model.logic.sale.bonusItem.blocks {
import model.logic.sale.bonusItem.IAppliableFilling;
import model.logic.sale.bonusItem.dynamicFilling.IFillingElement;
import model.logic.sale.bonusItem.dynamicFilling.IImageFillingElement;

public class ImageFillingBlock implements IAppliableFilling {


    private var _imageUrl:String;

    public function ImageFillingBlock(param1:String) {
        super();
        this._imageUrl = param1;
    }

    public function get imageUrl():String {
        return this._imageUrl;
    }

    public function get type():int {
        return FillingBlocksTypeEnum.IMAGE;
    }

    public function apply(param1:IFillingElement):void {
        var _loc2_:IImageFillingElement = param1 as IImageFillingElement;
        if (_loc2_ == null) {
            return;
        }
        _loc2_.fillImage(this._imageUrl);
    }
}
}
