package model.logic.quests.data.themedEvent {
import common.StringUtil;
import common.localization.LocaleUtil;
import common.queries.util.query;

import model.data.UserPrize;
import model.logic.blackMarketItems.CollectibleThemedItem;
import model.logic.dtoSerializer.DtoDeserializer;
import model.logic.sale.BonusItem;
import model.logic.sale.bonusItem.BonusItemCollection;
import model.logic.sale.bonusItem.BonusItemDescriptions;
import model.logic.sale.bonusItem.BonusItemFullNames;
import model.logic.sale.bonusItem.BonusItemImages;
import model.logic.sale.bonusItem.BonusItemTitles;
import model.logic.tournament.TournamentBonusItem;

public class CollectibleThemedItemsEventMessageInfo {

    private static const KEY_EVENT_COMPLETED:String = "forms-formMessages_messageThemedEvent_eventCompleted";

    private static const KEY_POINTS_EARNED:String = "forms-formMessages_messageThemedEvent_pointsEarned";

    private static const KEY_RATING_REWARD:String = "forms-formMessages_messageThemedEvent_ratingReward";

    private static const TEXT_WITHOUT_AWARD:String = LocaleUtil.getText("forms-formMessages_messageThemedEvent_withoutAward");

    private static const TEXT_NOT_MAX_AWARD:String = LocaleUtil.getText("forms-formMessages_messageThemedEvent_notMaxAward");

    private static const TEXT_MAX_AWARD:String = LocaleUtil.getText("forms-formMessages_messageThemedEvent_maxAward");

    private static const TEXT_RATING:String = LocaleUtil.getText("forms-formMessages_messageThemedEvent_rating");


    private var _hasUserPointsBonus:Boolean;

    private var _hasUserRatingBonus:Boolean;

    private var _eventStartData:Date;

    private var _eventEndData:Date;

    private var _userPointsEarned:int = -1;

    private var _message:String;

    private var _bonusItemCollection:BonusItemCollection;

    private var _userMessageSubType:int;

    private var _eventName:String;

    private var _userRatingPosition:int;

    private var _userItemsGathered:Array;

    private var _userPointsBonus:UserPrize;

    private var _userRatingBonus:UserPrize;

    public function CollectibleThemedItemsEventMessageInfo() {
        super();
    }

    public static function fromDto(param1:*):CollectibleThemedItemsEventMessageInfo {
        if (param1 == null) {
            return null;
        }
        var _loc2_:CollectibleThemedItemsEventMessageInfo = new CollectibleThemedItemsEventMessageInfo();
        _loc2_._userMessageSubType = param1.t;
        _loc2_._eventName = param1.n == null ? "" : param1.n.c;
        _loc2_._userRatingPosition = param1.up;
        _loc2_._userItemsGathered = DtoDeserializer.toArray(param1.ig, CollectibleThemedItem.fromDto);
        _loc2_._userPointsBonus = UserPrize.fromDto(param1.ubp);
        _loc2_._userRatingBonus = UserPrize.fromDto(param1.ubr);
        _loc2_._hasUserPointsBonus = param1.hub;
        _loc2_._hasUserRatingBonus = param1.hur;
        _loc2_._eventStartData = new Date(param1.es);
        _loc2_._eventEndData = new Date(param1.ee);
        return _loc2_;
    }

    public function get userMessageSubType():int {
        return this._userMessageSubType;
    }

    public function get eventName():String {
        return this._eventName;
    }

    public function get userRatingPosition():int {
        return this._userRatingPosition;
    }

    public function get userItemsGathered():Array {
        return this._userItemsGathered;
    }

    public function get userPointsBonus():UserPrize {
        return this._userPointsBonus;
    }

    public function get userRatingBonus():UserPrize {
        return this._userRatingBonus;
    }

    public function messageText():String {
        if (this._message == null) {
            this._message = this.buildMessage();
        }
        return this._message;
    }

    public function header():String {
        return LocaleUtil.buildString(KEY_EVENT_COMPLETED, this._eventName);
    }

    private function buildMessage():String {
        var _loc1_:String = "";
        if (this._userPointsEarned == -1) {
            this._userPointsEarned = this.calculateUserPoints();
        }
        _loc1_ = _loc1_ + (this.header() + StringUtil.NEW_LINE);
        _loc1_ = _loc1_ + (LocaleUtil.buildString(KEY_POINTS_EARNED, this._userPointsEarned) + StringUtil.NEW_LINE);
        _loc1_ = _loc1_ + (this.buildRewardDescription() + StringUtil.NEW_LINE);
        if (this._hasUserPointsBonus) {
            _loc1_ = _loc1_ + (this.rewardToString(this._userPointsBonus) + StringUtil.NEW_LINE);
        }
        if (this._hasUserRatingBonus) {
            _loc1_ = _loc1_ + (LocaleUtil.buildString(KEY_RATING_REWARD, this._userRatingPosition + 1) + StringUtil.NEW_LINE);
            _loc1_ = _loc1_ + (this.rewardToString(this._userRatingBonus) + StringUtil.NEW_LINE);
        }
        _loc1_ = _loc1_ + TEXT_RATING;
        return _loc1_;
    }

    private function buildRewardDescription():String {
        var _loc1_:String = null;
        switch (this._userMessageSubType) {
            case CollectibleThemedItemsEventUserMessageSubType.WITHOUT_AWARD:
                _loc1_ = TEXT_WITHOUT_AWARD;
                break;
            case CollectibleThemedItemsEventUserMessageSubType.NOT_MAX_AWARD:
                _loc1_ = TEXT_NOT_MAX_AWARD;
                break;
            case CollectibleThemedItemsEventUserMessageSubType.MAX_AWARD:
                _loc1_ = TEXT_MAX_AWARD;
        }
        return _loc1_;
    }

    private function rewardToString(param1:UserPrize):String {
        var result:String = null;
        var prize:UserPrize = param1;
        if (prize == null) {
            return "";
        }
        result = "";
        if (this._bonusItemCollection == null) {
            this._bonusItemCollection = new BonusItemCollection().setDescriptionCreator(new BonusItemDescriptions()).setFullNameCreator(new BonusItemFullNames()).setImageCreator(new BonusItemImages()).setTitleCreator(new BonusItemTitles());
        }
        var prizeArray:Array = this._bonusItemCollection.createBonusesArray(prize);
        query(prizeArray).each(function (param1:BonusItem):void {
            var _loc2_:TournamentBonusItem = new TournamentBonusItem(param1);
            result = result + (_loc2_.toString() + StringUtil.NEW_LINE);
        });
        return result;
    }

    private function calculateUserPoints():int {
        return query(this._userItemsGathered).sum(function (param1:CollectibleThemedItem):int {
            return param1.count * param1.itemWeight;
        });
    }
}
}
