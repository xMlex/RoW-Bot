package ru.xmlex.common.threading;

import ru.xmlex.common.ConfigSystem;

import java.util.concurrent.*;

/**
 * Created by xMlex on 12.04.16.
 * email: the.mlex@gmail.com
 * Licence: GPL
 */
public class ThreadPoolManager {
    protected static final long MAX_DELAY = TimeUnit.NANOSECONDS.toMillis(Long.MAX_VALUE - System.nanoTime()) / 2;

    private static final ThreadPoolManager instance = new ThreadPoolManager();

    private final ScheduledThreadPoolExecutor scheduledExecutor;
    private final ThreadPoolExecutor executor;

    public static ThreadPoolManager getInstance() {
        return instance;
    }

    public ThreadPoolManager() {
        scheduledExecutor = new ScheduledThreadPoolExecutor(ConfigSystem.THREAD_POOL_SCHEDULE_COUNT);
        executor = new ThreadPoolExecutor(ConfigSystem.THREAD_POOL_COUNT, ConfigSystem.THREAD_POOL_COUNT + 2, 5L, TimeUnit.SECONDS, new LinkedBlockingQueue<Runnable>());
    }

    private static long validate(long delay) {
        return Math.max(0, Math.min(MAX_DELAY, delay));
    }


    public void execute(Runnable r) {
        executor.execute(r);
    }

    public ScheduledFuture<?> schedule(Runnable r, long delay) {
        return scheduledExecutor.schedule(r, validate(delay), TimeUnit.MILLISECONDS);
    }

    public ScheduledFuture<?> scheduleAtFixedRate(Runnable r, long initial, long delay) {
        return scheduledExecutor.scheduleAtFixedRate(r, validate(initial), validate(delay), TimeUnit.MILLISECONDS);
    }
}
