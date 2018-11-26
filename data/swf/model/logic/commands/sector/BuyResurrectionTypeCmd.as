package model.logic.commands.sector {
import model.data.Resources;
import model.data.scenes.types.GeoSceneObjectType;
import model.data.units.resurrection.dtoModels.BuyResurrectionTypeDto;
import model.data.units.resurrection.dtoModels.BuyResurrectionTypeResultDto;
import model.data.users.troops.Troops;
import model.logic.StaticDataManager;
import model.logic.UnitResurrectionHelper;
import model.logic.UserManager;
import model.logic.commands.BaseCmd;
import model.logic.commands.server.JsonCallCmd;
import model.logic.commands.user.UserRefreshCmd;
import model.logic.ratings.TournamentBonusManager;
import model.logic.troops.TroopsManager;
import model.logic.units.UnitUtility;

public class BuyResurrectionTypeCmd extends BaseCmd {


    private var _requestDto;

    private var _requestObject:BuyResurrectionTypeDto;

    public function BuyResurrectionTypeCmd(param1:Troops, param2:int, param3:Boolean = false) {
        super();
        this._requestObject = new BuyResurrectionTypeDto();
        this._requestObject.troops = param1;
        this._requestObject.lossesType = param2;
        this._requestObject.useDiscount = param3;
        this._requestDto = UserRefreshCmd.makeRequestDto(this._requestObject.toDto());
    }

    private static function normalizationUserData(param1:BuyResurrectionTypeResultDto):void {
        var _loc2_:Resources = null;
        if (param1.price != null) {
            _loc2_ = param1.price.roundAll();
            UserManager.user.gameData.account.resources.substract(_loc2_);
        }
        TournamentBonusManager.addTournamentsStatistics(param1.tournamentUserPointsDiff);
    }

    private static function normalizationTroopsData(param1:BuyResurrectionTypeDto):void {
        var _loc2_:* = undefined;
        var _loc3_:GeoSceneObjectType = null;
        var _loc4_:int = 0;
        for (_loc2_ in param1.troops.countByType) {
            _loc3_ = StaticDataManager.getObjectType(_loc2_);
            _loc4_ = param1.troops.countByType[_loc2_];
            TroopsManager.refreshAllianceMissionData(_loc3_, _loc4_);
        }
        UnitUtility.AddTroopsToBunker(UserManager.user, param1.troops);
        UserManager.user.gameData.troopsData.troops.dirtyNormalized = true;
        UnitResurrectionHelper.removeTroopsFromResurrectionKitsByType(param1.troops, param1.lossesType);
    }

    override public function execute():void {
        new JsonCallCmd("BuyResurrectionType", this._requestDto, "POST").ifResult(function (param1:*):void {
            if (!UserRefreshCmd.updateUserByResultDto(param1, _requestDto)) {
                if (param1.o != null) {
                    normalizationUserData(BuyResurrectionTypeResultDto.fromDto(param1.o));
                }
                normalizationTroopsData(_requestObject);
            }
            if (_onResult != null) {
                _onResult();
            }
        }).ifFault(_onFault).ifIoFault(_onIoFault).doFinally(_onFinally).execute();
    }
}
}
