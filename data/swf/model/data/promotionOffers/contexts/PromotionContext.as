package model.data.promotionOffers.contexts {
import model.data.promotionOffers.UserPromotionOffer;
import model.logic.conditions.ConditionContext;

public class PromotionContext extends ConditionContext {


    public var promotion:UserPromotionOffer;

    public function PromotionContext() {
        super();
    }
}
}
