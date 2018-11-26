package ru.xmlex.common.listener;

import java.util.Collection;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

/**
 * Created by xMlex on 18.05.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class ListenerList<T> {
    protected Set<Listener<T>> listeners = new CopyOnWriteArraySet<Listener<T>>();

    public Collection<Listener<T>> getListeners() {
        return listeners;
    }

    /**
     * Добавить слушатель в список
     *
     * @param listener
     * @return возвращает true, если слушатель был добавлен
     */
    public boolean add(Listener<T> listener) {
        return listeners.add(listener);
    }

    /**
     * Удалить слушатель из списока
     *
     * @param listener
     * @return возвращает true, если слушатель был удален
     */
    public boolean remove(Listener<T> listener) {
        return listeners.remove(listener);
    }

}