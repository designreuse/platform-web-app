package com.aladdin.platform.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {

    /**
     * 默认时间字符串的格式
     */
    public static final String DEFAULT_FORMAT_STR = "yyyy-MM-dd HH:mm:ss";

    private static final long DATE_IN_MILIS = 24 * 60 * 60 * 1000;

    /**
     * 以指定格式格式化时间: <br>
     *
     * @param dateStr the date str
     * @param format  the format
     * @return date
     * @see
     * @since [1.0]
     */
    public static Date StringToDate(String dateStr, String format) {
        if (dateStr == null)
            return new Date();

        if (format == null || format.trim().equals(""))
            format = "yyyy-MM-dd";

        SimpleDateFormat dateFormatter = new SimpleDateFormat(format);
        try {
            return dateFormatter.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return new Date();
    }

    /**
     * Diff in days.
     *
     * @param from the from
     * @param to   the to
     * @return the long
     */
    public static long diffInDays(Date from, Date to) {
        assert from != null;
        assert to != null;

        return (long) Math.abs(Math.ceil(from.getTime() - to.getTime()) / DATE_IN_MILIS);
    }

    /**
     * Gets before date.
     *
     * @param date   the date
     * @param number the number
     * @param type   the type
     * @return the before date
     */
    public static Date getBeforeDate(Date date, int number, DateNumberType type) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar = getFirstTimeOfDay(calendar);
        switch (type) {
            case DAY:
                calendar.add(Calendar.DAY_OF_MONTH, -number);
                break;
            case WEEK:
                calendar.add(Calendar.WEEK_OF_YEAR, -number);
                break;
            case MONTH:
                calendar.add(Calendar.MONTH, -number);
                break;
            case YEAR:
                calendar.add(Calendar.YEAR, -number);
                break;
            default:
                throw new IllegalArgumentException("Invalid DateNumberType.");
        }

        return calendar.getTime();
    }

    /**
     * Gets first time of day.
     *
     * @param date the date
     * @return the first time of day
     */
    public static Date getFirstTimeOfDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        return calendar.getTime();
    }

    /**
     * Gets end time of day.
     *
     * @param date the date
     * @return the end time of day
     */
    public static Date getEndTimeOfDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        calendar.set(Calendar.MILLISECOND, 999);
        return calendar.getTime();
    }

    /**
     * Gets first time of day.
     *
     * @param calendar the calendar
     * @return the first time of day
     */
    public static Calendar getFirstTimeOfDay(Calendar calendar) {
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        return calendar;
    }

    /**
     * The enum Date number type.
     */
    public enum DateNumberType {
        /**
         * The DAY.
         */DAY, /**
         * The WEEK.
         */WEEK, /**
         * The MONTH.
         */MONTH, /**
         * The YEAR.
         */YEAR
    }

    /**
     * Gets day.
     *
     * @return the day
     */
    public static String getDay() {
        SimpleDateFormat formatter;
        formatter = new SimpleDateFormat("d");
        String ctime = formatter.format(new Date());
        return ctime;
    }

    /**
     * Gets month.
     *
     * @return the month
     */
    public static String getMonth() {
        SimpleDateFormat formatter;
        formatter = new SimpleDateFormat("M");
        String ctime = formatter.format(new Date());
        return ctime;
    }

    /**
     * Gets year.
     *
     * @return the year
     */
    public static String getYear() {
        SimpleDateFormat formatter;
        formatter = new SimpleDateFormat("yyyy");
        String ctime = formatter.format(new Date());
        return ctime;
    }

    /**
     * Gets week.
     *
     * @return the week
     */
    public static int getWeek() {
        Calendar c = Calendar.getInstance();
        return c.get(Calendar.DAY_OF_WEEK);
    }

    /**
     * Now date.
     *
     * @return the date
     */
    public static Date now() {
        return Calendar.getInstance().getTime();
    }

    /**
     * Forever date.
     *
     * @return the date
     */
    public static Date forever() {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.YEAR, 9999);
        calendar.set(Calendar.MONTH, Calendar.DECEMBER);
        calendar.set(Calendar.DAY_OF_MONTH, 31);
        calendar.set(Calendar.HOUR, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);

        return calendar.getTime();
    }

    /**
     * 格式化日期为:xxxx年xx月xx日
     * @param time
     * @return
     */
    public static String getNYRDate(String time){

        SimpleDateFormat dateFormat=new SimpleDateFormat(DEFAULT_FORMAT_STR);
        Date date=null;
        try {
            date=dateFormat.parse(time);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        dateFormat=new SimpleDateFormat("yyyy年MM月dd日");
        return dateFormat.format(date);
    }

    /**
     * 格式化日期为:xx月xx日
     * @param time
     * @return
     */
    public static String getYRDate(String time){
        SimpleDateFormat dateFormat=new SimpleDateFormat(DEFAULT_FORMAT_STR);
        Date date=null;
        try {
            date=dateFormat.parse(time);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        dateFormat=new SimpleDateFormat("MM月dd日");
        return dateFormat.format(date);
    }

    /**
     * 格式化日期为:xxxx/xx/xx
     * @param time
     * @return
     */
    public static String getSFDate(String time){
        SimpleDateFormat dateFormat=new SimpleDateFormat(DEFAULT_FORMAT_STR);
        Date date=null;
        try {
            date=dateFormat.parse(time);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        dateFormat=new SimpleDateFormat("yyyy/MM/dd");
        return dateFormat.format(date);
    }

}
