package xmlex.vk.row.model;

import xmlex.ext.Rnd;

import java.util.Date;

public class ServerTimeManager {

    private long _serverTimeMs, _timerMs, _sessionStartTimeMs, _totalInGameTimeMs,
            _inactivityTimeMs = 0, _startTimeMs = 0;

    public ServerTimeManager() {
        _startTimeMs = System.currentTimeMillis();
    }

    public long getTimer() {
        return System.currentTimeMillis() - _startTimeMs;
    }

    public Date getServerTimeNow() {
        return new Date(calcServerTimeMs());
    }

    public Date toServerTime(Date param1) {
        long _loc2_ = getServerTimeNow().getTime() - new Date().getTime();
        return new Date(param1.getTime() + _loc2_);
    }

    public Date toClientTime(Date param1) {
        long _loc2_ = getServerTimeNow().getTime() - new Date().getTime();
        return new Date(param1.getTime() - _loc2_);
    }

    public long getSessionStartTimeMs() {
        return _sessionStartTimeMs;
    }

    public long getSessionInGameTimeMs() {
        return calcServerTimeMs() - _sessionStartTimeMs - _inactivityTimeMs;
    }

    public long getTotalInGameTimeMs() {
        return _totalInGameTimeMs + getSessionInGameTimeMs();
    }

    public void addInactivityTime(long param1) {
        _inactivityTimeMs = _inactivityTimeMs + param1;
    }

    public long calcServerTimeMs() {
        return calcServerTimeMs(getTimer());
    }

    public long calcServerTimeMs(long pos) {
        long c = pos - _timerMs;
        return _serverTimeMs + c;
    }

    public void update(long pos) {
        _serverTimeMs = pos;
        _timerMs = getTimer();
    }

    public void initialize(long servTime, long totaltimeInGame) {
        _serverTimeMs = servTime;
        _timerMs = getTimer();
        _sessionStartTimeMs = servTime - Rnd.get(20000, 100000);
        _totalInGameTimeMs = totaltimeInGame;
    }
}
