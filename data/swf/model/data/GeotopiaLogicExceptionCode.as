package model.data {
public class GeotopiaLogicExceptionCode {

    public static const IP_IS_BANNED:int = -6;

    public static const AccountRestriction_CanNotBeAttacked:int = -7;

    public static const AccountRestriction_MessagesSendingForbidden:int = -5;

    public static const AccountRestriction_TradingUnitsForbidden:int = -4;

    public static const AccountRestriction_TradingUnitsAreLimmitedByCurse:int = -8;

    public static const UserRequestLimitReached:int = -14;

    public static const IpAddressRequestLimitReached:int = -15;

    public static const USER_IS_BANNED:int = -3;

    public static const SERVER_UNAVAILABLE:int = -2;

    public static const SERVER_UNKNOWN:int = -1;

    public static const UNKNOWN:int = 0;

    public static const GENERIC_OBJECT_NOT_FOUND:int = 1;

    public static const GENERIC_OBJECT_TYPE_MISMATCH:int = 2;

    public static const GENERIC_OBJECTS_DATA_MISMATCH:int = 3;

    public static const GENERIC_INVALID_OBJECT_LEVEL:int = 4;

    public static const GENERIC_NOT_ENOUGH_RESOURCES:int = 5;

    public static const GENERIC_TROOPS_WRONG_COUNT:int = 6;

    public static const GENERIC_USER_LEVELS_MISMATCH:int = 7;

    public static const GENERIC_OBJECT_TYPE_NOT_FOUND:int = 8;

    public static const GENERIC_INVALID_OBJECT_TYPE:int = 9;

    public static const Generic_NotEnoughFriends:int = 10;

    public static const Generic_UserIsNotFriend:int = 11;

    public static const Generic_InsufficientUserLevel:int = 12;

    public static const Generic_WrongResources:int = 13;

    public static const Generic_WrongTroops:int = 14;

    public static const Generic_UserIsNotPlacedOnMap:int = 15;

    public static const Generic_FunctionalityIsDisabledForUser:int = 16;

    public static const Generic_FunctionalityIsDisabled:int = 17;

    public static const Generic_UserIsUnderElderProtection:int = 18;

    public static const Generic_NoUserOrLocationFound:int = 20;

    public static const Generic_TargetUserIsNotPlacedOnMap:int = 1515;

    public static const Generic_InvalidClientVersion:int = 99;

    public static const Generic_MoreThanOneClient:int = -100;

    public static const SHOP_OBJECT_CANNOT_BE_BOUGHT:int = 101;

    public static const SHOP_NOT_ENOUGH_RESOURCES:int = 102;

    public static const SHOP_REQUIRED_OBJECT_MISSING:int = 103;

    public static const SHOP_OBJECT_OF_SAME_GROUP_IN_PROGRESS:int = 104;

    public static const SHOP_OBJECT_LIMIT_REACHED:int = 105;

    public static const SHOP_MAXIMUM_LEVEL_REACHED:int = 106;

    public static const SHOP_EXISTING_OBJECTS_OF_SAME_TYPE_SHOULD_HAVE_MAX_LEVEL:int = 107;

    public static const SHOP_TROOPS_WRONG_COUNT_TO_BUY:int = 108;

    public static const SHOP_OBJECT_DOES_NOT_HAVE_GOLD_PRICE:int = 109;

    public static const SHOP_TOO_LOW_MONEY_BALANCE:int = 151;

    public static const SHOP_CONSTRUCTION_WORKERS_COUNTlIMIT_REACHED:int = 152;

    public static const SHOP_NOT_ENOUGH_CONSTRUCTION_BLOCKS:int = 153;

    public static const SHOP_TROOPS_QUEUE_LIMIT_REACHED:int = 154;

    public static const SHOP_ADDITIONAL_WORKER_NOT_ENOUGH_TIME:int = 157;

    public static const SHOP_ADDITIONAL_WORKER_CANNOT_REPLACE:int = 158;

    public static const SHOP_AVP_UNITS_CANNOT_FIND_SLOT:int = 159;

    public static const SHOP_AVP_UNITS_CANNOT_BE_BOUGHT:int = 160;

    public static const SHOP_AVP_SLOT_CANNOT_BE_BOUGHT:int = 161;

    public static const DRAWING_ALREADY_EXISTS:int = 201;

    public static const DRAWING_NOT_COLLECTED:int = 202;

    public static const DRAWING_NOT_FOUND:int = 203;

    public static const DRAWING_PART_NOT_FOUND:int = 204;

    public static const Drawing_UserStationAlreadyClicked:int = 205;

    public static const Drawing_PartNotSet:int = 206;

    public static const TECHNOLOGY_ALREADY_EXISTS:int = 300;

    public static const SECTOR_REGULAR_BUILDINGS_SQUARE:int = 401;

    public static const SECTOR_DEFENSIVE_BUILDINGS_SQUARE:int = 402;

    public static const SECTOR_WALLS_ARE_LONGER_THEN_POSSIBLE:int = 403;

    public static const SECTOR_INVALID_NAME:int = 404;

    public static const SECTOR_SCENES_DATA_MISMATCH:int = 405;

    public static const SECTOR_BUILDING_IS_NOT_BROKEN:int = 406;

    public static const SECTOR_YOU_ALREADY_REPAIRED_BUILDING_FOR_USER_TODAY:int = 407;

    public static const SECTOR_BUILDING_COULD_NOT_BE_CLICKED:int = 409;

    public static const SECTOR_BUILDING_HAS_NO_LOCAL_STORAGE:int = 410;

    public static const SECTOR_TOO_EARLY_TO_COLLECT_RESOURCES:int = 411;

    public static const SECTOR_BUILDING_CAN_BE_REPAIRED_BY_OWNER_ONLY:int = 412;

    public static const SECTOR_ROAD_OVERLAP:int = 420;

    public static const SECTOR_RENAMING_BLOCKED:int = 421;

    public static const TRADING_NOT_ENOUGH_CARAVANS:int = 501;

    public static const TRADING_INVALID_OFFER:int = 502;

    public static const TRADING_SAME_RESOURCES_OFFERED:int = 503;

    public static const TRADING_SAME_DRAWINGS_OFFERED:int = 504;

    public static const TRADING_INVALID_EXCHANGE_RATE:int = 505;

    public static const TRADING_OFFER_ALREADY_ACCEPTED_OR_REMOVED_BY_OWNER:int = 506;

    public static const TRADING_DAILY_CREATE_OFFER_LIMIT_REACHED:int = 507;

    public static const TRADING_CAPACITY_DAILY_LIMIT_REACHED:int = 508;

    public static const TRADING_DRAWING_IS_NOT_TRADABLE:int = 509;

    public static const TRADING_OFFER_IS_OBSOLETE:int = 510;

    public static const SECTOR_EXTENSION_EXTENSION_NOT_FOUND:int = 601;

    public static const SECTOR_EXTENSION_SMALLER_EXTENSION_SHOULD_BE_BOUGHT:int = 602;

    public static const SECTOR_EXTENSION_SECTOR_IS_GREATER_OR_EQUALS_TO_EXTENSION:int = 603;

    public static const BOOST_OBJECT_ID_NOT_SET:int = 701;

    public static const BOOST_BOOST_NOT_FOUND:int = 702;

    public static const BOOST_OBJECT_NOT_FOUND_OR_NOT_CONSTRUCTING:int = 703;

    public static const BOOST_RESOURCE_MINING_BOOST_ALREADY_ACTIVE:int = 704;

    public static const BOOST_CAN_NOT_BOOST_BROKEN_BUILDING:int = 705;

    public static const BOOST_CAN_NOT_BOOST_BUILDING:int = 706;

    public static const POINTS_OBJECT_HAS_ZERO_LEVEL:int = 801;

    public static const POINTS_OBJECT_IS_CONSTRUCTING:int = 802;

    public static const POINTS_NEGATIVE_AMOUNT_TO_ADD:int = 803;

    public static const UserResourceFlow_LimitReached:int = 901;

    public static const UserResourceFlow_ResourceCaravansTotalDailyLimitReached:int = 902;

    public static const UserResourceFlow_ResourceCaravansUserDailyLimitReached:int = 903;

    public static const UserResourceFlow_DrawingCaravansTotalDailyLimitReached:int = 904;

    public static const UserResourceFlow_ReceipientIncommingLimitReached:int = 905;

    public static const UserResourceFlow_ReceipientIncommingDrawigsLimitReached:int = 906;

    public static const TREASURE_INVALID_BOX_REQUEST:int = 1001;

    public static const TREASURE_OPENED_BOXES_LIMIT_REACHED:int = 1002;

    public static const TREASURE_OPENED_FRIENDS_BOXES_LIMIT_REACHED:int = 1003;

    public static const TROOPS_ROBBERY_LIMIT_REACHED:int = 1101;

    public static const TROOPS_CANNOT_PERFORM_HOSTILE_ACTIONS_AGAINST_ALLIES:int = 1102;

    public static const Troops_CountNotSet:int = 1103;

    public static const Troops_UnitSizeLimitReached:int = 1104;

    public static const Troops_MissileStrikesLimitReached:int = 1105;

    public static const Troops_MissileStrikeSizeLimitReached:int = 1106;

    public static const TROOPS_REINFORCEMENT_LIMIT_EXCEEDED:int = 1107;

    public static const TROOPS_UNITS_LIMIT_EXCEEDED:int = 1108;

    public static const TROOPS_OUTGOING_UNITS_LIMIT_EXCEEDED:int = 1109;

    public static const Cancel_CouldNotCancelMissileStrike:int = 1407;

    public static const Unit_TargetIsNotSupportedByChosenMissiles:int = 1504;

    public static const Unit_TargetSectorIsOccupiedByUnitOwner:int = 1505;

    public static const FAILED_TO_ADD_CREADIT_STRANGE_VOTES_VALUE:int = 1201;

    public static const KIT_ALREADY_BOUGHT_TODAY:int = 1301;

    public static const KIT_WRONG_USER_LEVEL:int = 1302;

    public static const KIT_COMMAND_CENTER_REQUIRED:int = 1303;

    public static const CANCEL_OBJECT_NOT_FOUND_OR_NOT_CONSTRUCTING:int = 1401;

    public static const CANCEL_CANCELLATION_PERIOD_IS_OVER:int = 1402;

    public static const CANCEL_COULD_NOT_CANCEL_TRADING_OFFER_UNIT:int = 1403;

    public static const CANCEL_COULD_CANCEL_MOVING_FORWARD_UNIT_ONLY:int = 1404;

    public static const CANCEL_CANCEL_ALREADY_IN_PROGRESS:int = 1405;

    public static const CANCEL_CANCEL_IS_NOT_ALLOWED:int = 1406;

    public static const UNIT_AVP_FUNCTIONALITY_DISABLED:int = 1516;

    public static const UNIT_CAN_NOT_ARRIVE_AFTER_AVP_EXPIRATION:int = 1517;

    public static const UNIT_UNIT_NOT_FOUND:int = 1501;

    public static const UNIT_USER_IS_NOT_UNIT_OWNER:int = 1502;

    public static const Unit_TargetHasChangedPosition:int = 1511;

    public static const Unit_TargetIsMoving:int = 1512;

    public static const Unit_TargetIsInactive:int = 1513;

    public static const Mine_MineNotFound:int = 1601;

    public static const Mine_UserIsNotMineOwner:int = 1602;

    public static const Mine_MineIsClosed:int = 1603;

    public static const Mine_TooEarlyToCollect:int = 1604;

    public static const Mine_CountLimitReached:int = 1605;

    public static const Mine_LevelIsTooLow:int = 1607;

    public static const Mine_LevelIsTooHigh:int = 1608;

    public static const SpecialOffer_OfferIndexOutOfRange:int = 1701;

    public static const SpecialOffer_BoughtOffersLimitReached:int = 1702;

    public static const SpecialOffer_OfferAlreadyBought:int = 1703;

    public static const SpecialOffer_BoughtObjectsLimitReached:int = 1704;

    public static const SpecialOffer_CoordinatesNotSetForBuilding:int = 1705;

    public static const Message_MessageLimitPerDayReached:int = 1801;

    public static const Message_AllianceLeaderMessagesDailyLimitReached:int = 1802;

    public static const Message_AllianceDeputiesMessagesDailyLimitReached:int = 1803;

    public static const Cyborg_UserIsNotFriend:int = 1901;

    public static const Cyborg_CyborgLaboratoryRequired:int = 1902;

    public static const Cyborg_CyborgIsAlreadyCreatedFromUser:int = 1903;

    public static const Cyborg_CyborgIsAlreadyCreatedForGivenUser:int = 1904;

    public static const Cyborg_CyborgsCreatedDailyLimitReached:int = 1905;

    public static const Cyborg_CyborgsCreatedForOtherUserDailyLimitReached:int = 1906;

    public static const Cyborg_TotalCyborgsLimitReached:int = 1907;

    public static const Artifact_ArtifactNotFound:int = 2001;

    public static const Artifact_CouldNotMoveExpiringArtifact:int = 2002;

    public static const Artifact_CouldNotMoveArtifactToTemporaryStorage:int = 2003;

    public static const Artifact_InvalidStorageIdsLength:int = 2004;

    public static const Artifact_InvalidActiveSlot:int = 2005;

    public static const Artifact_InvalidActiveSlotSet:int = 2006;

    public static const Artifact_StorageSlotsLimitReached:int = 2007;

    public static const Artifact_InsufficientUserLevel:int = 2008;

    public static const Artifact_CouldNotFindFreeStorageSlot:int = 2009;

    public static const Artifact_ArsenalBuildingNeeded:int = 2010;

    public static const Location_LocationIsNotMine:int = 2101;

    public static const Location_UserIsNotInAlliance:int = 2102;

    public static const Location_CouldNotSendReinforcementToEnemyOrEmptyTower:int = 2103;

    public static const Location_MaximumTowerLevelReached:int = 2104;

    public static const Location_TowerIsNotOccupied:int = 2105;

    public static const Location_NotEnoughAntigenForMutation:int = 2106;

    public static const Location_TowerIsTooFarToSendAntigen:int = 2107;

    public static const Location_TooLowTowerLevel:int = 2108;

    public static const Location_UserIsNotAllowedToUseAntigen:int = 2109;

    public static const Location_ExceedDailyLimitForTowerUpdates:int = 2112;

    public static const Location_OnlyPlariumAllianceAllowed:int = 2113;

    public static const Location_TowerDefenderLimitIsReached:int = 2114;

    public static const Location_TowerSlotNotFound:int = 2115;

    public static const Location_TowerSlotIsAlreadyBought:int = 2116;

    public static const Location_TowerSlotsNotSupported:int = 2117;

    public static const Location_TowerNoSlotsForCurrentTowerLevel:int = 2118;

    public static const BlackMarket_CannotFindItem:int = 2119;

    public static const BlackMarket_ItemCannotBeBought:int = 2120;

    public static const BlackMarket_CannotFindBoughtItem:int = 2121;

    public static const BlackMarket_CannotActivateBoughtItem:int = 2122;

    public static const BlackMarket_ConstructionWorkersCountReached:int = 2123;

    public static const BlackMarket_PurchaseTimeIsUp:int = 2133;

    public static const BlackMarket_IncorrectActivateCount:int = 2132;

    public static const BlackMarket_ResourceBoostLimitReached:int = 2127;

    public static const BlackMarket_ProhibitedToProlongateItem:int = 2136;

    public static const BlackMarket_DrawingPurchaseDailyLimitReached:int = 2200;

    public static const BlackMarket_TroopsPurchaseDailyLimitReached:int = 2201;

    public static const BlackMarket_StrategyTroopsPurchaseDailyLimitReached:int = 2202;

    public static const BlackMarket_BuildingPositionShouldBeSet:int = 2203;

    public static const BlackMarket_BoughtBuildingTypeLimitReached:int = 2205;

    public static const BlackMarket_TechnologyShouldBeLearnedOrBeNearestToLearn:int = 2210;

    public static const BlackMarket_TechnologyShouldBeNearestToLearn:int = 2211;

    public static const Raid_RaidLocationNotFound:int = 2300;

    public static const Raid_CheatGrubNotPass:int = 1408;

    public static const Resurrection_WrongTroopsPassed:int = 2401;

    public static const Skill_NotEnoughSkillPoints:int = 2501;

    public static const Skill_SkillImprovementInProgress:int = 2501;

    public static const Skill_RequiredSkillMissing:int = 2502;

    public static const Skill_MaximumLevelReached:int = 2503;

    public static const Skill_SkillNotFound:int = 2504;

    public static const Skill_WrongPointsAmountToDiscard:int = 2505;

    public static const Skill_DiscardWillBreakSkillDependencies:int = 2506;

    public static const Skill_CouldNotDiscardPointsFromImprovingSkill:int = 2507;

    public static const Skill_InstantIsNotInProgress:int = 2511;

    public static const ResourcesConversion_TypeNotFound:int = 2601;

    public static const ResourcesConversion_JobAlreadyInProgress:int = 2602;

    public static const ResourcesConversion_InvalidScaleFactor:int = 2603;

    public static const ResourcesConversion_StorageLimitWillBeExceeded:int = 2604;

    public static const Occupation_UserHasNoOccupantUnit:int = 2700;

    public static const Occupation_UserIsAlreadyOccupied:int = 2701;

    public static const Occupation_UserIsNotOccupied:int = 2702;

    public static const Occupation_OccupiedUsersLimitReached:int = 2703;

    public static const Occupation_WrongResourceTypeIdToCollect:int = 2704;

    public static const Occupation_TooEarlyToCollectResources:int = 2705;

    public static const CooperativeAttack_UserIsNotInAlliance:int = 2800;

    public static const CooperativeAttack_ToLowRankToAttack:int = 2801;

    public static const CooperativeAttack_TooManySupportUsersSelected:int = 2802;

    public static const CooperativeAttack_WrongSupportUserSelected:int = 2803;

    public static const CooperativeAttack_SupportUserReinforcementNotFound:int = 2804;

    public static const CooperativeAttack_SupportUserNotEnoughReinforcementsFound:int = 2805;

    public static const Alliance_UserAlreadyInAlliance:int = 3001;

    public static const Alliance_LeaderNotFound:int = 3002;

    public static const Alliance_NameOrFlagAlreadyTaken:int = 3003;

    public static const Alliance_NotFound:int = 3004;

    public static const Alliance_Deleted:int = 3005;

    public static const Alliance_UserIsNotAllianceMember:int = 3006;

    public static const Alliance_LeaderShouldDelegateRank:int = 3007;

    public static const Alliance_LowMemberRank:int = 3008;

    public static const Alliance_MembersLimitReached:int = 3009;

    public static const Alliance_InvitationsLimitReached:int = 3010;

    public static const Alliance_UserIsNotAllowedToChangeHisRank:int = 3011;

    public static const Alliance_CannotChangeRankOfEqualMember:int = 3012;

    public static const Alliance_GlobalStatusesLimitReached:int = 3013;

    public static const Alliance_InvalidName:int = 3014;

    public static const Alliance_InvalidFlag:int = 3015;

    public static const Alliance_UserAlreadyInvited:int = 3016;

    public static const Alliance_UserAlreadyRequested:int = 3017;

    public static const Alliance_InvitationNotFound:int = 3018;

    public static const Alliance_UserIsNotInvited:int = 3019;

    public static const Alliance_UserRequestLimitReached:int = 3020;

    public static const Alliance_RequestNotFound:int = 3021;

    public static const Alliance_UserCannotRemoveHimself:int = 3022;

    public static const Alliance_CannotSetRankHigherOrEqualThanCurrentUserRank:int = 3023;

    public static const Alliance_CannotRemoveEqualOrHigherRankUser:int = 3024;

    public static const Alliance_TooLongText:int = 3025;

    public static const Alliance_RequestsLimitReached:int = 3026;

    public static const Alliance_InvalidId:int = 3027;

    public static const Alliance_DiplomacyStatusesLimitReached:int = 3028;

    public static const Alliance_ExtensionsNotSupported:int = 3029;

    public static const Alliance_ExtensionNotFound:int = 3030;

    public static const Alliance_AllianceIsGreaterOrEqualsToExtension:int = 3031;

    public static const Alliance_ExtensionAlreadyBought:int = 3032;

    public static const Alliance_SmallerExtensionShouldBeBoughtFirst:int = 3033;

    public static const Alliance_CannotFindAllianceRelation:int = 3039;

    public static const Alliance_WrongRelationshipStateAction:int = 3040;

    public static const Alliance_CannotStopTerminationStartedByAnotherAlliance:int = 3041;

    public static const Alliance_CannotAttackAllyAllianceTower:int = 3042;

    public static const Alliance_CannotMakeStatusToAllianceWithoutAnyTower:int = 3043;

    public static const Alliance_CannotMakeDiplomaticDecidions:int = 3044;

    public static const Alliance_UserShouldPassTrialPeriod:int = 3045;

    public static const Alliance_AcademySettingsAreIncorrect:int = 3046;

    public static const Alliance_ApproptiateAllianceIsNotFound:int = 3047;

    public static const Alliance_AcademyLimitReached:int = 3048;

    public static const Alliance_IncorrectLevelToJoinAcademy:int = 3049;

    public static const Alliance_AcademyDisabled:int = 3050;

    public static const Alliance_UserWasRemovedLessThan7DaysAgo:int = 3051;

    public static const Alliance_CurrentUserIsAlreadyInAlliance:int = 3052;

    public static const Alliance_NewMembersDisabled:int = 3053;

    public static const Alliance_CannotUseArmyUsersInTrialPeriod:int = 3055;

    public static const Alliance_CannotInitiateAttackInTrialPeriod:int = 3056;

    public static const Alliance_CannotPromoteUserToLeaderInTrialPeriod:int = 3057;

    public static const Alliance_WrongEventSearchParams:int = 3058;

    public static const Alliance_InvalidUserId:int = 3059;

    public static const Alliance_InvalidRankId:int = 3060;

    public static const Alliance_CannotReturnTowerTroops:int = 3061;

    public static const Alliance_KnownAllianceProposalAlreadyExists:int = 3062;

    public static const Alliance_CannotJoinThisAllianceAcademy:int = 3064;

    public static const Alliance_UserAlreadyInOtherAlliance:int = 3067;

    public static const Alliance_ThisChatNotAllowedForUser:int = 3071;

    public static const Alliance_ThisChatHasBeenRemoved:int = 3073;

    public static const Alliance_CannotAttackAllyAllianceCity:int = 3075;

    public static const Alliance_NoAvailableTacticsFound:int = 3080;

    public static const Alliance_CannotApplyDebebuffToOwnAlliance:int = 3081;

    public static const Alliance_InvalidTacticsEffects:int = 3082;

    public static const Alliance_ActiveEffectsLimitsReached:int = 3083;

    public static const Alliance_AllianceIsDebuffProtected:int = 3084;

    public static const Gem_GemsDisabled:int = 3301;

    public static const Gem_NoFreeGemSlots:int = 3302;

    public static const Gem_CannotSetGemIntoSlot:int = 3303;

    public static const Gem_GemNotFound:int = 3304;

    public static const Gem_IncorrectGemsCountForUpgrade:int = 3305;

    public static const Gem_UserDoesntHaveGems:int = 3306;

    public static const Gem_IncostintentGemsTypeOrLevel:int = 3307;

    public static const Gem_ItemIsNotFound:int = 3308;

    public static const Gem_InappropriateItemForSuchGem:int = 3309;

    public static const Gem_NoSuchActiveGem:int = 3310;

    public static const Gem_GemIsAlreadyOfMaxLevel:int = 3311;

    public static const Gem_AllSlotsAreAlreadyActive:int = 3312;

    public static const Gem_UserDoesNotHaveItemForGemSlotActivation:int = 3312;

    public static const Gem_GemLabIsNotAppropriateLevel:int = 3314;

    public static const DiscountOffer_CanNotOpenNewDiscountToday:int = 3501;

    public static const DiscountOffer_NoSuchSegment:int = 3502;

    public static const DiscountOffer_NoSuchType:int = 3503;

    public static const DiscountOffer_CanNotResurrectMoreTroopsThanLeft:int = 3504;

    public static const DiscountOffer_CanNotBuyUsingDiscountOffer:int = 3507;

    public static const SectorTeleportation_UserIsActive:int = 3700;

    public static const SectorTeleportation_UserIsAdmin:int = 3701;

    public static const SectorTeleportation_UserHasOwnUnitsMovingForward:int = 3702;

    public static const SectorTeleportation_TeleportationDelayInProgress:int = 3703;

    public static const SectorTeleportation_UserIsAlreadyMovingOrInactive:int = 3704;

    public static const SectorTeleportation_TargetHasChangedPosition:int = 3705;

    public static const SectorTeleportation_TargetPositionIsNotFree:int = 3706;

    public static const SectorTeleportation_TargetPositionIsNull:int = 3707;

    public static const SectorTeleportation_NoFreePositionsFound:int = 3708;

    public static const SectorTeleportation_RandomTeleportationDelayInProgress:int = 3709;

    public static const SectorTeleportation_UserDoesNotHaveUnlimitedTeleport:int = 3710;

    public static const SectorTeleportation_CanNotUserPreciseTeleport:int = 3711;

    public static const StoryRaid_InsufficientRaidLocationMaxWonLevel:int = 3101;

    public static const VipSupport_InvalidCode:int = 3601;

    public static const Payment_StatusFailed:int = 4001;

    public static const Payment_StatusInitedProcessing:int = 4002;

    public static const LoyalityProgram_NoPrizeForSuchDay:int = 4500;

    public static const LoyalityProgram_UserHasNoPrizes:int = 4501;

    public static const Chat_InvalidRegionalRoomId:int = 4600;

    public static const Chat_UserBanned:int = 4601;

    public static const Chat_RoomNotCreated:int = 4602;

    public static const User_InvalidUserName:int = 5000;

    public static const Facebook_SessionExpire:int = 6000;

    public static const Alliance_NameAlreadyTaken:int = 3003;

    public static const Alliance_NotEnoughResources:int = 3054;

    public static const Vip_ThereIsNoActiveState:int = 3401;

    public static const Vip_CannotContinueBonusItem:int = 3402;

    public static const Vip_CannotBuyActivator:int = 2120;

    public static const Unit_WrongUnitState:int = 1506;

    public static const CooperativeAttack_CantBoostSupportAttack:int = 2807;

    public static const Message_MessageLimitPerMinuteReached:int = 1807;

    public static const Message_DenyLowLevelUserSendMessage:int = 1808;

    public static const Inventory_CouldNotFindSlot:int = 7000;

    public static const Inventory_CouldNotFindInventoryItem:int = 7001;

    public static const Inventory_SlotIsLocked:int = 7002;

    public static const Inventory_InventoryItemIsSealed:int = 7003;

    public static const Inventory_CannotMoveToTempSlot:int = 7004;

    public static const Inventory_SlotIsOccupied:int = 7005;

    public static const Inventory_InvalidSlotKind:int = 7006;

    public static const Inventory_SlotIsPurchasedAlready:int = 7007;

    public static const Inventory_InventoryItemIsNotSealed:int = 7008;

    public static const Inventory_InventoryItemIsInProgress:int = 7009;

    public static const Inventory_InventoryItemIsPowdering:int = 7010;

    public static const Inventory_InventoryItemMaxLevelReached:int = 7011;

    public static const Inventory_NotEnoughDust:int = 7012;

    public static const Inventory_UserLevelTooLow:int = 7013;

    public static const Inventory_CoudNotFindKey:int = 7014;

    public static const Inventory_ItemHasExpired:int = 7015;

    public static const Hero_InvalidName:int = 8000;

    public static const Hero_RaceOrGenderHasBeenSetAlready:int = 8001;

    public static const DynamicResourceMine_CooperativeAttackIsForbidden:int = 9001;

    public static const DynamicResourceMine_CouldNotSendReinforcementToOtherUsersMine:int = 9002;

    public static const DynamicResourceMine_AttackingTroopsAreNotAllowedInReinforcement:int = 9003;

    public static const DynamicResourceMine_DefensiveTroopsShouldBeCombinedWithAttacking:int = 9004;

    public static const DynamicResourceMine_MineIsOccupiedByAllianceMate:int = 9005;

    public static const DynamicResourceMine_MineIsClosed:int = 9006;

    public static const DynamicResourceMine_CountLimitReached:int = 9007;

    public static const AllianceCity_CityIsAlreadyCreatedOrCreating:int = 10001;

    public static const AllianceCity_TooLongName:int = 10002;

    public static const AllianceCity_AllianceHasNoCity:int = 10003;

    public static const AllianceCity_PositionIsTaken:int = 10004;

    public static const AllianceCity_NotEnoughMembersToCreateCity:int = 10005;

    public static const AllianceCity_InvalidPosition:int = 10006;

    public static const AllianceCity_CantMoveCityOften:int = 10007;

    public static const AllianceCity_CityIsUnderProtection:int = 10008;

    public static const AllianceCity_CreationIsNotCompletedYet:int = 10009;

    public static const AllianceCity_CantBuyResources:int = 10010;

    public static const AllianceCity_CityDeleted:int = 10011;

    public static const AllianceCity_NotEnoughCash:int = 10012;

    public static const AllianceCity_AllianceRankTooLow:int = 10013;

    public static const AllianceCity_NotEnoughEmitters:int = 10014;

    public static const AllianceCity_NotEnoughEnemyDowngrades:int = 10015;

    public static const AllianceCity_Upgrading:int = 10016;

    public static const AllianceCity_UnitsSendingIsNotAllowedForAllianceNovice:int = 10017;

    public static const AllianceCity_UnitsSendingIsNotAllowedForNewCity:int = 10018;

    public static const AllianceCity_CityUpgradeIsNotAllowed:int = 10019;

    public static const AllianceCity_RenamingForbidden:int = 10020;

    public static const AllianceCity_OperationIsNotPermitted:int = 10021;

    public static const AllianceCity_UserCanNotAddHimselfToPermittedList:int = 10022;

    public static const AllianceCity_IncorrectCityId:int = 10023;

    public static const AllianceCity_NotEnoughTechPoints:int = 10024;

    public static const AllianceCity_TechnologyIsUpgrading:int = 10025;

    public static const AllianceCity_TechnologyIsAlreadyOfMaxLevel:int = 10026;

    public static const AllianceCity_TechnologyNotFound:int = 10027;

    public static const AllianceCity_MinimalAllianceAgeNotReached:int = 10028;

    public static const AllianceCity_CityIsAlreadyOnMaxlevel:int = 10029;

    public static const AllianceCity_CannotBuyCash:int = 10031;

    public static const AllianceCity_CannotBuyTechPoints:int = 10032;

    public static const AllianceCity_CannotAttackBecauseCooloff:int = 10047;

    public static const AllianceHelp_RequestTypeIsNotFound:int = 10100;

    public static const AllianceHelp_LimitOfSimultaneousRequestsReached:int = 10101;

    public static const AllianceHelp_WrongDurationIndex:int = 10102;

    public static const AllianceHelp_WrongDurationMinutes:int = 10103;

    public static const AllianceHelp_BuildingIsNotFound:int = 10104;

    public static const AllianceHelp_BuildingIsNotUnderConstruction:int = 10105;

    public static const AllianceHelp_ConsulateIsRequiredToCreateRequest:int = 10106;

    public static const AllianceHelp_ResourcesShouldBePositive:int = 10107;

    public static const AllianceHelp_TooMuchResourcesRequested:int = 10108;

    public static const AllianceHelp_RequestedEntityIsNotUser:int = 10109;

    public static const AllianceHelp_RequestedEntityIsNotTower:int = 10110;

    public static const AllianceHelp_RequestedEntityIsNotAllianceCity:int = 10111;

    public static const AllianceHelp_ResponsesLimitPerDayReached:int = 10112;

    public static const AllianceHelp_ResponsesAvailableAreOutForToday:int = 10113;

    public static const AllianceHelp_RequestIsNotFound:int = 10114;

    public static const AllianceHelp_RequestIsNotCompletedYet:int = 10115;

    public static const AllianceHelp_CanNotCreateRequestForTheSameBuildingLevelAgain:int = 10116;

    public static const AllianceHelp_CanNotCreateRequestForAllianceMateAttack:int = 10117;

    public static const AllianceHelp_CanNotCreateRequestForAllianceTowerAttack:int = 10118;

    public static const AllianceHelp_CanNotCreateRequestForAllianceCityAttack:int = 10119;

    public static const AllianceHelp_NoAttackRequestPermission:int = 10120;

    public static const AllianceHelp_RequestToAttackCurrentEntityAlreadyExists:int = 10121;

    public static const AllianceHelp_MaximumAttackRequestsCountForTodayReached:int = 10122;

    public static const AllianceHelp_UserIsUnderAttackProtection:int = 10123;

    public static const AllianceHelp_CanNotAttackFriendlyAllianceTower:int = 10124;

    public static const AllianceHelp_CanNotAttackFriendlyAllianceCity:int = 10125;

    public static const Dragon_ActivationsPerDayLimitReached:int = 9603;

    public static const Dragon_NotEnoughResourcesToActivateDragonAbility:int = 9604;

    public static const Dragon_SelectAbilitiesFirst:int = 9605;

    public static const Dragon_InvalidName:int = 9506;

    public static const Lottery_UserLevelIsLessThanRequired:int = 13008;

    public static const Lottery_TicketTypeNotPresentInConfiguration:int = 13000;

    public static const Lottery_LotteryDoesNotExistOrIsClosed:int = 13002;

    public static const Lottery_LotteryTypeNotPresentInConfiguration:int = 12001;

    public static const Lottery_TryingToContributeMoreTicketsThanAllowedForThisLottery:int = 13004;

    public static const Lottery_AdminOrTestUserCannotBuyOrContributeTickets:int = 13007;

    public static const Lottery_TryingToBuyNegativeTicketsCount:int = 13006;

    public static const Lottery_TryingToContributeMoreTicketsThanAvailable:int = 13005;

    public static const Lottery_UserIsNotAWinner:int = 13009;

    public static const Lottery_UserDoesNotHaveThisLostLottery:int = 13010;

    public static const WisdomSkills_SkillIsAlreadyActive:int = 13018;

    public static const WisdomSkills_WisdomLevelIsLow:int = 13019;

    public static const WisdomSkills_PreviousSkillMustBeSelected:int = 13020;

    public static const WisdomSkills_SkillIsAlreadyAvailable:int = 13021;

    public static const WisdomSkills_SecondSkillLevelCantBeBought:int = 13022;

    public static const TroopsTiers_InvalidTierId:int = 10400;

    public static const TroopsTiers_NotEnoughBattleExperience:int = 10401;

    public static const TroopsTiers_NotEnoughLevelUpPoints:int = 10402;

    public static const TroopsTiers_TierIsAlreadyUpgrading:int = 10403;

    public static const TroopsTiers_TierOfSameTroopsGroupIsAlreadyUpgrading:int = 10404;

    public static const TroopsTiers_TierUpgradeRequirementsAreNotSatisfied:int = 10405;

    public static const TroopsTiers_TierIsNotFound:int = 10406;

    public static const TroopsTiers_NoPointsToDistribute:int = 10407;

    public static const TroopsTiers_CanNotApplyAttackPointsOnDefensiveTroops:int = 10408;

    public static const TroopsTiers_CanNotApplyDefencePointsOnAttackingTroops:int = 10409;

    public static const TroopsTiers_WrongPointsCountToDistribute:int = 10410;

    public static const TroopsTiers_CanNotDistributeMorePointsThanUnapplied:int = 10411;

    public static const TroopsTiers_CanNotSubstractAlreadyDistributedPoints:int = 10412;

    public static const ClanPurchase_SuchGachaChestNotFound:int = 16000;


    public function GeotopiaLogicExceptionCode() {
        super();
    }
}
}
