package ru.xmlex.row.game.logic;

import ru.xmlex.row.game.data.users.UserNote;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xMlex on 06.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class UserNoteManager {

    public List<Object> lastUpdatedNotes;

    public List<UserNote> userNotes = new ArrayList<>();

    public UserNote getById(int i) {
        for (UserNote userNote : userNotes) {
            if (userNote.id == i)
                return userNote;
        }
        return null;
    }
}
