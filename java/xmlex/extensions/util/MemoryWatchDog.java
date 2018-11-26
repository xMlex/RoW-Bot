package xmlex.extensions.util;

import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;

public class MemoryWatchDog extends Thread {
    private static final MemoryMXBean mem_bean = ManagementFactory.getMemoryMXBean();
    private static MemoryWatchDog instance = null;
    private static String RNL = "\r\n";

    public static long getMemUsed() {
        return mem_bean.getHeapMemoryUsage().getUsed();
    }

    public static double getMemUsedPercentage() {
        MemoryUsage heapMemoryUsage = mem_bean.getHeapMemoryUsage();
        return 100f * heapMemoryUsage.getUsed() / heapMemoryUsage.getMax();
    }

    public static String getMemUsedPerc() {
        return String.format("%.2f%%", getMemUsedPercentage());
    }

    public static String getMemUsedMb() {
        return getMemUsed() / 1048576 + " Mb";
    }

    public static long getMemMax() {
        return mem_bean.getHeapMemoryUsage().getMax();
    }

    public static String getMemMaxMb() {
        return getMemMax() / 1048576 + " Mb";
    }

    public static long getMemFree() {
        MemoryUsage heapMemoryUsage = mem_bean.getHeapMemoryUsage();
        return heapMemoryUsage.getMax() - heapMemoryUsage.getUsed();
    }

    public static double getMemFreePercentage() {
        return 100f - getMemUsedPercentage();
    }

    public static String getMemFreePerc() {
        return String.format("%.2f%%", getMemFreePercentage());
    }

    public static String getMemFreeMb() {
        return getMemFree() / 1048576 + " Mb";
    }

    public static String getStatus() {
        StringBuilder out = new StringBuilder();
        out.append("*** Memory status ***" + RNL);
        out.append("Max:\t" + getMemMaxMb() + RNL);
        out.append("Free:\t" + getMemFreeMb() + RNL);
        out.append("Usage:\t" + getMemUsedMb() + RNL);
        out.append("Percent Free: " + getMemFreePerc() + " Used: " + getMemUsedPerc() + RNL);
        return out.toString();
    }

    public static MemoryWatchDog getInstance() {
        if (instance == null)
            instance = new MemoryWatchDog();
        return instance;
    }

}