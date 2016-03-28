package com.aladdin.platform.utils;

import java.math.BigDecimal;
import java.net.InetAddress;
import java.sql.Blob;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.StringTokenizer;


/**
 * The type Tools.
 */
public class Tools {

    /**
     * 功能描述: 根据17位身份证号码获取身份证号第18位校验码<br>
     * 〈功能详细描述〉
     *
     * @param sPre17ID 17位身份证号(15位号码出生年2位数字更换为4位年数字获得)
     * @return 第18位身份证号 id 18 check code
     * @throws Exception the exception
     */
    public static String getId18CheckCode(String sPre17ID) throws Exception {
        int[] nCertiCheckW = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8,
                4, 2, 1};
        int nCount = 0;
        int nIdNum = 0;
        if ((sPre17ID == null) || (sPre17ID.length() != 17)) {
            throw new Exception("Invalid certi code length");
        }
        for (int i = 0; i < 17; i++) {
            char c = sPre17ID.charAt(i);
            if ((c <= '9') || (c >= '0')) {
                nIdNum = c - '0';
            } else {
                throw new Exception("Invalid Certi Code char");
            }
            nCount += nIdNum * nCertiCheckW[i];
        }
        nCount = nCount % 11;
        switch (nCount) {
            case 0:
                return "1";
            case 1:
                return "0";
            case 2:
                return "X";
            case 3:
                return "9";
            case 4:
                return "8";
            case 5:
                return "7";
            case 6:
                return "6";
            case 7:
                return "5";
            case 8:
                return "4";
            case 9:
                return "3";
            case 10:
                return "2";
            default:
                return "";
        }
    }

    /**
     * 功能描述: 转换传入字符串对象(编码格式为GBK)的编码格式为当前平台默认编码格式<br>
     * 〈功能详细描述〉
     *
     * @param inStr 需要改变编码的字符串
     * @return 经过转换编码格式为当前平台默认编码格式的字符串 ，如果方法产生异常返回字符串""对象
     * @see
     */
    public static String fromGB(String inStr) {
        try {
            if (inStr == null)
                return "";
            return (new String(inStr.getBytes("GBK")));
        } catch (Exception e) {
            return "";
        }
    }

    /**
     * 功能描述:把GBK编码的字节数组数据转换成字符串对象(编码格式为当前平台默认编码) <br>
     * 〈功能详细描述〉
     *
     * @param inBytes the in bytes
     * @return 经过转换编码格式为当前平台默认编码的字符串 ，如果方法产生异常返回字符串""对象
     * @Param inBytes 字节数组
     */
    public static String fromGB(byte[] inBytes) {

        try {

            if (inBytes == null)
                return "";
            return (new String(inBytes));

        } catch (Exception e) {
            return "";
        }
    }

    /**
     * 功能描述: 把字符串对象转换为长整形(long)数据<br>
     * 〈功能详细描述〉
     *
     * @param inStr the in str
     * @return 对应inStr的长整形数据 ，如果方法产生异常返回0
     * @Param inStr 字符串对象
     * @see
     */
    public static long toLong(String inStr) {
        try {
            if (inStr == null) {
                return 0;
            } else {
                return Long.parseLong(inStr);
            }
        } catch (Exception e) {
            return 0;
        }
    }

    /**
     * 功能描述: 把字符串对象转换为整型(int)数据<br>
     * 〈功能详细描述〉
     *
     * @param inStr the in str
     * @return 对应inStr的整型数据 ，如果方法产生异常返回0
     * @Param inStr 字符串对象
     * @see
     */
    public static int toInteger(String inStr) {
        try {
            if (inStr == null) {
                return 0;
            } else {
                // return Integer.valueOf(valueOf(inStr)).intValue();
                return Integer.parseInt(inStr);
            }
        } catch (Exception e) {
            return 0;
        }
    }

    /**
     * 功能描述: 从字符串src中，删除子字符串subString<br>
     * 〈功能详细描述〉
     *
     * @param src the src
     * @param subString the sub string
     * @return 去掉子字符串的字符串 string
     * @Param src 原字符串
     * @Param subString 要删除的子字符串
     */
    public static String removeSubString(String src, String subString) {
        if (src == null) {
            return null;
        }
        StringTokenizer token = new StringTokenizer(src, subString, false);
        String result = "";
        while (token.hasMoreTokens()) {
            result += token.nextToken();
        }
        return result;
    }

    /**
     * 功能描述: 把字符串对象转换为双精度浮点型(double)数据<br>
     * 〈功能详细描述〉
     *
     * @param inStr the in str
     * @return 对应inStr的双精度浮点型(double)数据 ，如果方法产生异常返回0
     * @Param inStr 字符串对象
     * @see
     */
    public static double toDouble(String inStr) {
        try {
            if (inStr == null) {
                return 0;
            } else {
                // Modify by yun.xia
                String src = removeSubString(inStr, ",");
                return Double.parseDouble(src);
            }
        } catch (Exception e) {
            return 0;
        }
    }

    /**
     * 功能描述: 把字符串对象转换为单精度浮点型(float)数据<br>
     * 〈功能详细描述〉
     *
     * @param inStr the in str
     * @return 对应inStr的单精度浮点型(float)数据 ，如果方法产生异常返回0
     * @Param inStr 字符串对象
     * @see
     */
    public static float toFloat(String inStr) {
        try {
            if (inStr == null) {
                return 0;
            } else {
                return Float.parseFloat(inStr);
            }
        } catch (Exception e) {
            return 0;
        }
    }

    /**
     * 功能描述:过滤字符串对象，把null转换为字符串""对象<br>
     * 〈功能详细描述〉
     *
     * @param inStr the in str
     * @return 过滤后的字符串对象 string
     * @Param inStr 字符串对象
     * @see
     */
    public static String msNull(String inStr) {
        if (inStr == null) {
            return "";
        } else {
            return inStr;
        }
    }

    /**
     * 功能描述:从Blob对象中获取字节数组数据 <br>
     * 〈功能详细描述〉
     *
     * @return byte[] 返回的字节数组数据
     * @throws Exception
     * @Param Blob oracle.sql.Blob
     * @see
     */
    private static byte[] blobToBytes(Blob pBlob) throws Exception {
        byte[] buffer = null;
        if (pBlob != null) {
            buffer = pBlob.getBytes((long) 1, (int) pBlob.length());
        }
        return buffer;
    }

    /**
     * 功能描述: 把字符串对象转换为BigDecimal对象<br>
     * 〈功能详细描述〉
     *
     * @param str the str
     * @return 对应inStr的BigDecimal对象 ，如果方法产生异常返回null
     * @Param inStr 字符串对象
     * @see
     */
    public static BigDecimal getBigDecimal(String str) {
        BigDecimal bd = null;
        if (str == null)
            return null;
        try {
            bd = new BigDecimal(str);
        } catch (Exception e) {
            return null;
        }
        return bd;
    }

    /**
     * 功能描述:根据年，月，日，转化为Timestamp类型 <br>
     * 〈功能详细描述〉
     *
     * @param sDate the s date
     * @return the timestamp
     * @Param sDate 字符串对象(格式为"yyyy-mm-dd")
     * @Return Timestamp对象
     * @see
     */
    public static Timestamp getTimestamp(String sDate) {
        Timestamp ts = null;
        if (sDate == null || "".equals(sDate))
            return null;
        ts = Timestamp.valueOf(sDate + " 00:00:00.000000000");
        return ts;
    }

    /**
     * 功能描述: 根据年，月，日，转化为当点最后一刻的Timestamp类型<br>
     * 〈功能详细描述〉
     *
     * @param sDate the s date
     * @return the end timestamp
     * @Param sDate 字符串对象(格式为"yyyy-mm-dd")
     * @Return Timestamp对象
     * @see
     */
    public static Timestamp getEndTimestamp(String sDate) {
        Timestamp ts = null;
        if (sDate == null || "".equals(sDate))
            return null;
        ts = Timestamp.valueOf(sDate + " 23:59:59.999999999");
        return ts;
    }

    // following date involved static mothods by rock yang, 2001-7
    // NOTE: year and month have literal meaning. e.g. 2000-7-1, year = 2001,
    // month = 7, date = 1

    /**
     * 功能描述: 转换java.util.Date对象为字符串对象(格式为"yyyy-MM-dd")<br>
     * 〈功能详细描述〉
     *
     * @param date the date
     * @return 格式为 "yyyy-MM-dd"的字符串对象
     * @Param java.util.date对象类型
     * @see
     */
    public static String Date2String(Date date) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return simpleDateFormat.format(date);
    }

    /**
     * 功能描述: 转换字符串对象(格式为yyyy-MM-dd)为java.util.Date对象<br>
     * 〈功能详细描述〉
     *
     * @param sDate the s date
     * @return java.util.Date对象 java . util . date
     * @throws java.text.ParseException the parse exception
     * @Param sDate 字符串对象(格式为yyyy-MM-dd)
     * @see
     */
    public static Date toDate(String sDate)
            throws java.text.ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd"); // HH:mm:ss
        return simpleDateFormat.parse(sDate);
    }

    // 在URL后面添加一个标记，保证用户提交的URL是由服务器生成的
    // 例如 在客户端显示一个车险定损的图片,以 showimage?img_id=123
    // 方式定义URL,用户可能修改img_id来看到不该看到的图片
    // 因此对该URL做标记，在showimage程序中检查标记是否与URL符合
    // 相关的方法有
    // encryptURL
    // checkEncryptURL

    /**
     * 功能描述: 日期增加 <br>
     * 〈功能详细描述〉
     *
     * @param oldDate the old date
     * @param addDays the add days
     * @return 返回为Timestamp对象类型的经过增减的数据 timestamp
     * @Param oldDate Timestamp对象指原有的时间
     * @Param addDays 日期的增量
     * @see
     */
    public static Timestamp addDate(Timestamp oldDate, int addDays) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date(oldDate.getTime()));
        calendar.add(calendar.DATE, addDays);
        return new Timestamp(calendar.getTime().getTime());
    }

    /**
     * 功能描述: 日期增加 <br>
     * 〈功能详细描述〉
     *
     * @param oldDate the old date
     * @param addDays the add days
     * @return 返回为Timestamp对象类型的经过增减的数据 timestamp
     * @Param oldDate Timestamp对象指原有的时间
     * @Param addDays 日期的增量
     * @see
     */
    public static Timestamp addDate(Date oldDate, int addDays) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date(oldDate.getTime()));
        calendar.add(calendar.DATE, addDays);
        return new Timestamp(calendar.getTime().getTime());
    }

    /**
     * 功能描述: 获取java.util.Date对象数据<br>
     * 〈功能详细描述〉
     *
     * @param year the year
     * @param month the month
     * @param date the date
     * @return java.util.Date数据 java . util . date
     * @Param year 整型数值 年
     * @Param month 整型数值 月
     * @Param date 整型数值 日
     * @see
     */
    public static Date toDate(int year, int month, int date) {
        return toDate(year, month, date, 0, 0, 0);
    }

    /**
     * 功能描述: 根据年、月、日、小时、分钟、秒数据获取相应的java.util.Date对象数据<br>
     * 〈功能详细描述〉
     *
     * @param year the year
     * @param month the month
     * @param date the date
     * @param hrs the hrs
     * @param min the min
     * @param sec the sec
     * @return java.util.Date数据 java . util . date
     * @Param year 年
     * @Param month 月
     * @Param date 日
     * @Param hrs 小时
     * @Param min 分钟
     * @Param sec 秒
     * @see
     */
    public static Date toDate(int year, int month, int date, int hrs,
                                        int min, int sec) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month - 1, date, hrs, min, sec);
        return calendar.getTime();
    }

    /**
     * 功能描述: 获取java.util.Date对象数据中的年<br>
     * 〈功能详细描述〉
     *
     * @param date the date
     * @return 整型数据 年
     * @Param date java.util.Date对象
     * @see
     */
    public static int getYear(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return calendar.get(Calendar.YEAR);
    }

    /**
     * 功能描述: 根据从1970年1月1日00：00：00开始到某一时刻的毫秒数据获取年<br>
     * 〈功能详细描述〉
     *
     * @param date the date
     * @return 整型数据 年
     * @Param long 从1970年1月1日00：00：00开始到某一时刻的毫秒数据
     * @see
     */
    public static int getYear(long date) {
        return getYear(new Date(date));
    }

    /**
     * 功能描述: 根据java.util.Date对象数据获取月<br>
     * 〈功能详细描述〉
     *
     * @param date the date
     * @return 整型数据 月
     * @Param date java.util.Date对象
     * @see
     */
    public static int getMonth(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return calendar.get(Calendar.MONTH) + 1;
    }

    /**
     * 功能描述: 根据从1970年1月1日00：00：00开始到某一时刻的毫秒数据获取月<br>
     * 〈功能详细描述〉
     *
     * @param date the date
     * @return 整型数据 月
     * @Param date 从1970年1月1日00：00：00开始到某一时刻的毫秒数据
     * @see
     */
    public static int getMonth(long date) {
        return getMonth(new Date(date));
    }

    /**
     * 功能描述: 根据java.util.Date对象数据获取日<br>
     * 〈功能详细描述〉
     *
     * @param date the date
     * @return 整型数据 日
     * @Param date java.util.Date对象
     * @see
     */
    public static int getDate(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return calendar.get(Calendar.DAY_OF_MONTH);
    }

    /**
     * 功能描述:根据从1970年1月1日00：00：00开始到某一时刻的毫秒数据获取日 <br>
     * 〈功能详细描述〉
     *
     * @param date the date
     * @return 整型数据 日
     * @Param long 从1970年1月1日00：00：00开始到某一时刻的毫秒数据
     * @see
     */
    public static int getDate(long date) {
        return getDate(new Date(date));
    }

    /**
     * 功能描述: 根据java.util.Date对象数据获取时<br>
     * 〈功能详细描述〉
     *
     * @param date the date
     * @return 整型数据 时
     * @Param date java.util.Date对象
     * @see
     */
    public static int getHours(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return calendar.get(Calendar.HOUR);
    }

    /**
     * 功能描述: 根据从1970年1月1日00：00：00开始到某一时刻的毫秒数据获取分<br>
     * 〈功能详细描述〉
     *
     * @param date the date
     * @return 整型数据 分
     * @Param long 从1970年1月1日00：00：00开始到某一时刻的毫秒数据
     * @see
     */
    public static int getMinutes(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return calendar.get(Calendar.MINUTE);
    }


    /**
     * 功能描述: 根据java.util.Date对象数据获取秒<br>
     * 〈功能详细描述〉
     *
     * @param date the date
     * @return 整型数据 秒
     * @Param date java.util.Date对象
     * @see
     */
    public static int getSeconds(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        return calendar.get(Calendar.SECOND);
    }

    /**
     *
     *

     */
    /**
     * 功能描述: 根据java.util.Date对象数据获取格式为 yyyy年mm月dd日的字符串对象<br>
     * 〈功能详细描述〉
     *
     * @param d the d
     * @return 格式为 yyyy年mm月dd日的字符串对象
     * @Param d java.util.Date对象
     * @see
     */
    public static String getChineseDate(Date d) {
        if (d == null) {
            return " 年 月 日";
        } else {
            return "" + getYear(d) + "年" + getMonth(d) + "月" + getDate(d) + "日";
        }
    }

    /**
     * 功能描述: 根据日期获取格式为 yyyy年mm月dd日的字符串对象<br>
     * 〈功能详细描述〉
     *
     * @param d the d
     * @return 格式为 yyyy年mm月dd日的字符串对象
     * @Param d 从1970年1月1日00：00：00开始到某一时刻的毫秒数据
     * @see
     */
    public static String getChineseDate(long d) {
        return getChineseDate(new Date(d));
    }

    /**
     * 功能描述: 字符串化Object对象数据，如果对象是java.util.Date的实例则调用Tools.Data2String方法获取返回值<br>
     * 〈功能详细描述〉
     *
     * @param obj the obj
     * @return 字符串数据 string
     * @Param Object 需字符串化的对象
     * @see
     */
    public static String toString(Object obj) {
        if (obj == null) {
            return "";
        } else if (obj instanceof Date) {
            return Date2String((Date) obj);
        } else {
            return obj.toString();
        }
    }

	/*----------------------------------------------------------------------
       Function name: convertBirthDateToAge(Dabe birthDate,Date nowDate)
	   Description: covert birthdate to age
	   Input:     birthday, the current date you want to compare
	   Output:     age
	   Author:        Richard Zhang, Rodolf Li
	   Date:      Aug 15,2001
	   -----------------------------------------------------------------------*/


	/*----------------------------------------------------------------------
	   Function name: getDouble()
	   Description: covert double to double
	   Input:     ORIGIN double, count, bDischarge
	   Output:     final double
	   Author:        Richard Zhang
	   Date:      Aug 15,2001
	   -----------------------------------------------------------------------*/


    /**
     * 功能描述: 获取格式化小数位的浮点数(截尾)<br>
     * 〈功能详细描述〉
     *
     * @param dOrigin 原始的浮点数
     * @param nCount 需要保留小数位位数
     * @return 格式化后的浮点数 double discharge tail
     * @see
     */
    public static double getDoubleDischargeTail(double dOrigin, int nCount) {
        return getDouble(dOrigin, nCount, true);
    }


    /**
     * 功能描述: 获取格式化小数位的浮点数(四舍五入)<br>
     * 〈功能详细描述〉
     *
     * @param dOrigin 原始的浮点数
     * @param nCount 需要保留小数位位数
     * @return 格式化后的浮点数 double not discharge tail
     * @see
     */
    public static double getDoubleNotDischargeTail(double dOrigin, int nCount) {
        return getDouble(dOrigin, nCount, false);
    }


    /**
     * 功能描述: 获取格式化小数位的浮点数<br>
     * 〈功能详细描述〉
     *
     * @param dOrigin 原始的浮点数
     * @param nCount 需要保留小数位位数
     * @param bDischarge the b discharge
     * @return 格式化后的浮点数 double
     * @see
     */
    public static double getDouble(double dOrigin, int nCount,
                                   boolean bDischarge) {
        long lTemp = (long) Math.pow(10, nCount);
        if (bDischarge == true) {
            return (long) (dOrigin * lTemp) / (double) lTemp;
        } else {
            return Math.round(dOrigin * lTemp) / (double) lTemp;
        }
    }

    /**
     * 功能描述: 获取相隔两个时刻间的月份<br>
     * 〈功能详细描述〉
     *
     * @param startDate the start date
     * @param endDate the end date
     * @return 月份数 month amount
     * @Param startDate 开始时刻
     * @Param endDate 结束时刻
     * @see
     */
    public static int getMonthAmount(Date startDate, Date endDate) {
        int nYear = 0;
        int nMonth = 0;
        int nDay = 0;
        int nMonthAmount = 0;
        Calendar cldStart = Calendar.getInstance();
        Calendar cldEnd = Calendar.getInstance();

        cldStart.setTime(startDate);
        cldEnd.setTime(endDate);

        nYear = cldEnd.get(cldEnd.YEAR) - cldStart.get(cldStart.YEAR);
        nMonth = cldEnd.get(cldEnd.MONTH) - cldStart.get(cldStart.MONTH);
        nDay = cldEnd.get(cldEnd.DATE) - cldStart.get(cldStart.DATE);

        if (nDay > 14)
            nMonthAmount = nYear * 12 + nMonth + 1;
        else
            nMonthAmount = nYear * 12 + nMonth;
        return nMonthAmount;
    }

    /**
     * 功能描述: 获取相隔两个时刻间的天数<br>
     * 〈功能详细描述〉
     *
     * @param startDate the start date
     * @param endDate the end date
     * @return 天数 day amount
     * @Param startDate 开始时刻
     * @Param endDate 结束时刻
     * @see
     */
    public static int getDayAmount(Date startDate, Date endDate) {

        int nDayAmount = 0;
        Calendar cldStart = Calendar.getInstance();
        Calendar cldEnd = Calendar.getInstance();

        cldStart.setTime(startDate);
        cldEnd.setTime(endDate);
        int nStart = cldStart.get(cldStart.DAY_OF_YEAR);
        int nEnd = cldEnd.get(cldEnd.DAY_OF_YEAR);
        if (nEnd - nStart > 0)
            nDayAmount = nEnd - nStart;
        else
            nDayAmount = 365 - (nEnd - nStart);
        return nDayAmount;
    }


    /**
     * 功能描述:将double转化为String <br>
     * 〈功能详细描述〉
     *
     * @param d the d
     * @param limit the limit
     * @param hasComma the has comma
     * @param bDischarge the b discharge
     * @return 转化后的String string
     * @Param d double数据
     * @Param limit 小数位数
     * @Param hasComma 生成的String是否使用逗号(,)分隔
     * @Param bDischarge 是否不采用四舍五入。=true 直接去为尾
     * @see
     */
    public static String doubleToStr(double d, int limit, boolean hasComma,
                                     boolean bDischarge) {
        d = getDouble(d, limit, bDischarge);
        String sFormat = "#";
        if (hasComma) {
            sFormat += ",";
        }
        sFormat += "##0";
        if (limit > 0) {
            sFormat += ".";
            for (int i = 0; i < limit; i++) {
                sFormat += "0";
            }
        }
        DecimalFormat numberFormatter = new DecimalFormat(sFormat);
        return numberFormatter.format(d);
    }

    /**
     * 功能描述: 转换长整型数值为字符串对象 解决科学计数法问题<br>
     * 〈功能详细描述〉
     *
     * @param d the d
     * @return d对应的字符串对象 string
     * @Param d 长整型数值
     * @see
     */
    public static String doubleToStr(double d) {
        String str = NumberFormat.getInstance().format(d);
        String str2 = "";
        int i = 0;
        while ((i >= 0) && str.length() > 0) {
            i = str.indexOf(",");
            if (i == -1) {
                str2 += str;
                break;
            } else {
                str2 += str.substring(0, i);
                str = str.substring(i + 1, str.length());
            }
        }
        return str2;
    }

    /**
     * 功能描述: 将空字符串转化为null<br>
     * 〈功能详细描述〉
     *
     * @param value the value
     * @return 如果value为空或者为 ""返回空值否则直接返回value
     * @Param value 传入的字符串
     * @see
     */
    static public String emptyStringToNull(String value) {
        if (value == null)
            return null;
        value = value.trim();
        if (value.length() == 0)
            return null;
        return value;
    }


    /**
     * 功能描述:将日期格式转换为yyyy-mm-dd格式的String <br>
     * 〈功能详细描述〉
     *
     * @param date the date
     * @param division the division
     * @return 相应的字符串对象 string
     * @Param date 日期
     * @Param division分割符
     * @see
     */
    static public String dateToString(Date date, String division) {
        if (date == null)
            return null;
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH) + 1;
        int day = cal.get(Calendar.DAY_OF_MONTH);
        String result = "" + year;
        result += division;
        if (month < 10)
            result += "0";
        result += month;
        result += division;
        if (day < 10)
            result += "0";
        result += day;
        return result;
    }


    /**
     * 功能描述: 将日期格式转换为yyyy-mm-dd格式的String<br>
     * 〈功能详细描述〉
     *
     * @param date the date
     * @param division the division
     * @return 格式为yyyy -mm-dd的字符串对象
     * @Param date java.sql.Timestamp对象类型日期
     * @Param division分割符
     * @see
     */
    static public String dateToString(Timestamp date, String division) {
        if (date == null)
            return null;
        return dateToString(new Date(date.getTime()), division);
    }

    /**
     * 功能描述: 生成javascript的Array<br>
     * 〈功能详细描述〉
     *
     * @param sValue String[][]类型的两维数组
     * @return 返回javascript数组的代码 string
     * @see
     */
    static public String generateArray(String[][] sValue) {
        if (sValue == null) {
            sValue = new String[0][0];
        }

        StringBuffer buff = new StringBuffer(4096);
        buff.append("new Array(");
        String[] ss;
        String s;
        for (int i = 0; i < sValue.length; i++) {
            ss = sValue[i];
            if (ss == null) {
                ss = new String[0];
            }
            if (i > 0) {
                buff.append(",");
            }
            buff.append("new Array(");
            for (int j = 0; j < ss.length; j++) {
                if (j > 0) {
                    buff.append(",");
                }
                s = ss[j];
                if (s == null) {
                    s = "&nbsp;";
                } else if ("".equals(s.trim())) {
                    s = "&nbsp;";
                }
                buff.append("\"" + convertString(s) + "\"");
            }
            buff.append(")");
        }
        buff.append(")");
        return buff.toString();
    }

    private static String convertString(String sSource) {
        if (sSource == null) {
            return null;
        }
        StringBuffer buff = new StringBuffer(1024);
        int n = sSource.length();
        char c;
        for (int i = 0; i < n; i++) {
            c = sSource.charAt(i);
            if (c == '"') {
                buff.append('\\');
                buff.append(c);
            } else if (c == '\\') {
                buff.append('\\');
                buff.append(c);
            } else if (c == '\r') {
                buff.append("\\r");
            } else if (c == '\n') {
                buff.append("\\n");
            } else {
                buff.append(c);
            }
        }
        return buff.toString();
    }

    /**
     * 判断一个数是否是0
     *
     * @param value 要判断的数
     * @param digits 判断到小数后的位数
     * @return 是否是0 boolean
     */
    public static boolean isZero(double value, int digits) {
        return getDouble(value, digits, false) == 0;
    }

    /**
     * 获取obj的String表达,当obj为null时，返回defaultValue
     *
     * @param obj the obj
     * @param defaultValue the default value
     * @return object string
     */
    public static String getObjectString(Object obj, String defaultValue) {
        if (obj == null) {
            return defaultValue;
        } else {
            return obj.toString();
        }
    }

    /**
     * The entry point of application.
     *
     * @param args the input arguments
     * @throws Exception the exception
     */
    public static void main(String[] args) throws Exception {

    }

    /**
     * 字符串的替换
     *
     * @param oldStr the old str
     * @param newStr the new str
     * @param wholeStr the whole str
     * @return 经过替换的字符串 string
     * @Param oldStr 需被替换的字符串对象
     * @Param newStr 替换为的字符串对象
     * @Param wholeStr 需要进行处理的字符串对象
     */

    public static String replaceString(String oldStr, String newStr,
                                       String wholeStr) {
        if (wholeStr == null)
            return "";

        if (oldStr == null)
            return wholeStr;
        if (newStr == null)
            return wholeStr;
        int start, end;
        StringBuffer result = new StringBuffer();
        result = result.append(wholeStr);
        start = 0;

        while (wholeStr.indexOf(oldStr, start) > -1) {
            start = wholeStr.indexOf(oldStr, start);
            end = start + oldStr.length();
            result.replace(start, end, newStr);
            wholeStr = result.toString();
            start += newStr.length();
        }
        return wholeStr;
    }

    /**
     * 四舍五入取digits位小数
     *
     * @param value 需处理的浮点数
     * @param digits 小数位数
     * @return String string
     */
    public static String roundString(double value, int digits) {
        String format = "#";
        if (digits > 0) {
            format += ".";
        }
        for (int i = 0; i < digits; i++) {
            format += "#";
        }
        DecimalFormat numberFormatter = new DecimalFormat(format);
        return numberFormatter.format(value);
    }

    /**
     * 获取IP
     *
     * @return ip
     * @throws  {
     *说明在某情况下,将发生什么异常
     *}
     */
    public static String getIp() {
        String ip = null;
        try {
            String info = InetAddress.getLocalHost().toString();
            int n = info.lastIndexOf("/");
            ip = info.substring(n + 1);
        } catch (Exception e) {
        }
        return ip;
    }
}
