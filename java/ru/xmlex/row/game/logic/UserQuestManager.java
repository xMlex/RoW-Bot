package ru.xmlex.row.game.logic;

import ru.xmlex.row.game.data.User;
import ru.xmlex.row.game.logic.quests.commands.CloseQuestCmd;
import ru.xmlex.row.game.logic.quests.commands.StartQuestCmd;
import ru.xmlex.row.game.logic.quests.data.Quest;
import ru.xmlex.row.game.logic.quests.data.QuestState;
import ru.xmlex.row.instancemanager.listeners.UserListener;

/**
 * Created by xMlex on 09.05.2016.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserQuestManager implements UserListener {
    private Quest[] quest = new Quest[]{};

    public Quest[] getQuest() {
        return quest;
    }

    public void setQuest(Quest[] quest) {
        this.quest = quest;
    }

    @Override
    public void processUser(User user) {
        processClose(user);
        processByCategoryAndKind(user, Quest.CategotyId_Daily, Quest.DailyQuestKind_Daily);
        processByCategoryAndKind(user, Quest.CategotyId_Daily, Quest.DailyQuestKind_Alliance);
        processByCategoryAndKind(user, Quest.CategotyId_Daily, Quest.DailyQuestKind_Vip);
    }

    public Quest getQuestById(int id) {
        for (Quest q : quest) {
            if (q.id == id)
                return q;
        }
        return null;
    }

    public void processClose(User user) {
        for (QuestState openedState : user.gameData.questData.openedStates) {
            Quest q = getQuestById(openedState.questId);
            if (q != null && openedState.isComplete()) {
                boolean close = false;
                switch (q.categoryId) {
                    case Quest.CategoryId_Construction:
                        close = true;
                        break;
//                    case Quest.CategoryId_Tournament:
//                        close = true;
//                        break;
                    case Quest.CategoryId_Features:
                        close = true;
                        break;
                    case Quest.CategoryId_Wizard:
                        close = true;
                        break;
                    case Quest.CategotyId_Daily:
                        switch (q.dailyQuestKind) {
                            case Quest.DailyQuestKind_Daily:
                                close = true;
                                break;
                            case Quest.DailyQuestKind_Alliance:
                                close = user.gameData.allianceData.isInAlliance();
                                break;
                            case Quest.DailyQuestKind_Vip:
                                close = false; // TODO Проверка VIP
                                break;
                        }
                        break;
                }
                //System.out.println("Cat: " + q.categoryId + " Name: " + q.name + " complete: " + openedState.isComplete());
                if (close) {
                    //System.out.println("Stop: q: " + q.id + " name: " + q.name);
                    user.getClient().executeCmd(new CloseQuestCmd(q.id));
                }
            }
        }
    }

    public void processByCategoryAndKind(User user, int category, int kind) {
        Quest quest = null;

        for (QuestState openedState : user.gameData.questData.openedStates) {
            Quest q = getQuestById(openedState.questId);
            if (!simpleAvailable(q, user))
                continue;
            if (q.categoryId != category || (q.dailyQuestKind != 0 && q.dailyQuestKind != kind)) {
                continue;
            }

            if ((openedState.isComplete() || openedState.inProgress()))
                return;
            if (quest == null) {
                quest = q;
                //System.out.println("Start: q: " + q.id + " name: " + q.name);
                user.getClient().executeCmd(new StartQuestCmd(q.id));
            }

        }
    }

    public boolean simpleAvailable(Quest q, User user) {
        if (q == null)
            return false;
        switch (q.categoryId) {
            case Quest.CategoryId_Wizard:
                return true;
            case Quest.CategotyId_Daily:
                switch (q.dailyQuestKind) {
                    case Quest.DailyQuestKind_Daily:
                        return true;
                    case Quest.DailyQuestKind_Alliance:
                        return user.gameData.allianceData.isInAlliance();
                    case Quest.DailyQuestKind_Vip:
                        return false; // TODO Проверка VIP
                }
                break;
        }
        return false;
    }
}
