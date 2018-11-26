package xmlex.vk.row.model;

public class RowTime {
    private long _time = 0L;
    private long _last = 0L;

    public void setTime(long t) {
        _time = t;
        _last = System.currentTimeMillis();
    }

    public long getGameTime() {
        return _last - _time;
    }
}
