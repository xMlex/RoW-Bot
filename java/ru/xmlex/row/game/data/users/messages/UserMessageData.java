package ru.xmlex.row.game.data.users.messages;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.List;

/**
 * Created by xMlex on 11.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserMessageData {

    public int version;
    @Expose
    @SerializedName("i")
    public int nextMessageId;
    @Expose
    @SerializedName("s")
    public int messagesSentToday;

    public List<Object> messages;

    public int battleReportOwnSectorLossesThreshold;

    public int battleReportTowerLossesThreshold;

    public int battleReportReinforcementLossesThreshold;

    public boolean ignoreSuccessIntelligenceDefense;

    public boolean ignoreSuccessSectorDefence;

    public boolean ignoreSuccessTowerGuardDefense;

    public List<Object> diplomaticAdviserBattleReportsTypes;

    public boolean denyLowLevelUserSendMessage;

    public List<Object> blackList;

//    public  Dictionary  messagesCountByGroup ;

    public int addedByClientCount = 0;

//    public  model.data.users.messages.ClientMessagesDataByTypes  clientMessageData ;
//
//    public  Dictionary  knownUserConversation ;
//
//    public  Dictionary  knownAllianceConversation ;
//
//    public  Array  knownBattleReports ;
//
//    public  Array  knownDiplomaticMessages ;
//
//    public  Array  knownScientistMessages ;
//
//    public  Array  knownTradeMessages ;
//
//    public  Dictionary  addedByClientMessages ;

    public boolean messagesDirty = true;

    public boolean personalExternalMessagesDirty = true;

    public boolean advisersExternalMessagesDirty = true;

    public boolean advisersExternalMessagesDirtyLoadOld = true;
}
