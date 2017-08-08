package cn.com.bohui.bohuifin.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class TimeUtil {
    private static SimpleDateFormat sdf;

    public static String getDate(String template) {
        sdf = new SimpleDateFormat(template);
        return sdf.format(new Date());
    }

    public static String getStrYMDHMS() {
        sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(new Date());
    }

    public static String getStrYMDHMS(Date date) {
        sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(date);
    }

    public static String getStr2YMDHM(Date date) {
        sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
        return sdf.format(date);
    }

    public static Date getDateYMD(String timeStr) {
        timeStr = timeStr + " 00:00:00";
        return getDateYMDHMS(timeStr);
    }

    public static Date getDateYMDHM(String timeStr) {
        sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        try {
            return sdf.parse(timeStr);
        } catch (ParseException e) {
            System.out.print("日期格式有误，应为yyyy-MM-dd HH:mm");
            return new Date();
        }
    }

    public static Date getDateYMDHMS(String timeStr) {
        sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            return sdf.parse(timeStr);
        } catch (ParseException e) {
            System.out.print("日期格式有误，应为yyyy-MM-dd HH:mm:ss");
            return new Date();
        }
    }

    public static Date getDateYMDHMSNoConnector(String timeStr) {
        sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        try {
            return sdf.parse(timeStr);
        } catch (ParseException e) {
            System.out.print("日期格式有误，应为yyyyMMddHHmmss");
            return new Date();
        }
    }

    public static String getStrYMDChina(long time) {
        sdf = new SimpleDateFormat("yyyy年MM月dd日");
        return sdf.format(new Date(time));
    }

    public static String getStrYMD(Date date) {
        sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);
    }

    public static String getStrYMDHM() {
        return getStrYMDHM(new Date());
    }

    public static String getStrYMDHM(Date date) {
        sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        return sdf.format(date);
    }

    public static String getStrYMDHMNoConnector(Date date) {
        sdf = new SimpleDateFormat("yyyyMMddHHmm");
        return sdf.format(date);
    }

    public static String getStrY2MHHM(long time) {
        sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
        return sdf.format(new Date(time));
    }

    public static String getStrMHHM(long time) {
        sdf = new SimpleDateFormat("MM-dd HH:mm");
        return sdf.format(new Date(time));
    }

    public static String getStrYMDHMSNoConnector() {
        sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        return sdf.format(new Date());
    }

    public static String getStrYMDHMSsNoConnector() {
        sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        return sdf.format(new Date());
    }

    public static String getStr12HMChina(Date date) {
        String str12HM = getStr12HM(date);
        String[] split = str12HM.split(" ");
        return split[1] + split[0];
        /*if (amOrPm.equalsIgnoreCase("AM")) {
            return "上午" + split[0];
        } else {
            return "下午" + split[0];
        }*/
    }

    public static String getStr12HM(Date date) {
        sdf = new SimpleDateFormat("hh:mm a");
        return sdf.format(date);
    }

    public static String getMonthStr(long time) {

        sdf = new SimpleDateFormat("MM月dd号");
        return sdf.format(new Date(time));
    }

    public static String getTime(long time) {
        sdf = new SimpleDateFormat("HH:mm:ss");
        return sdf.format(time);
    }


    public static int daysOfTow(Date fromDate, Date toTime) {

        Calendar aCalendar = Calendar.getInstance();

        aCalendar.setTime(fromDate);

        int day1 = aCalendar.get(Calendar.DAY_OF_YEAR);

        aCalendar.setTime(toTime);

        int day2 = aCalendar.get(Calendar.DAY_OF_YEAR);

        return day2 - day1;
    }

    public static Calendar getCalendar(long time) {

        Date date = new Date(time);
        Calendar calendar = Calendar.getInstance();

        calendar.setTime(date);
        return calendar;
    }

    /***
     * @param time
     * @return
     */
    public static String getDescribeOfDate(long time) {

        long nowTime = new Date().getTime();

        long dTime = nowTime - time;
        if (dTime < 60 * 1000) { // 如果是1分钟以内

            long secondTime = dTime / 1000;

            if (secondTime < 1) {

                secondTime = 1;
            }
            return secondTime + "秒前";
        } else if (dTime < 60 * 60 * 1000) {// 如果是1小时以内


            return dTime / (60 * 1000) + "分钟前";
        } else {
            Date date = new Date(time);
            Date nowDate = new Date(nowTime);
            if (daysOfTow(date, nowDate) == 0) {
                // 如果是当天就显示几小时前
                return dTime / (60 * 60 * 1000) + "小时前";
            } else if (daysOfTow(date, nowDate) == 1) {

                return "昨天" + getTime(time);

            } else if (daysOfTow(new Date(time), new Date(nowTime)) == 2) {

                return "前天" + getTime(time);

            } else {

                if (getCalendar(time).get(Calendar.YEAR) == getCalendar(nowTime).get(Calendar.YEAR)) {
                    //同一年
                    return getMonthStr(time);
                } else {
                    //不是同一年
                    return getStrYMDHM(date);
                }


            }
        }
    }
}
