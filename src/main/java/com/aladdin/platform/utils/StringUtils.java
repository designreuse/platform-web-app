package com.aladdin.platform.utils;


import org.apache.commons.lang.ArrayUtils;

import java.io.*;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.Deflater;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;
import java.util.zip.Inflater;

/**
 * The type String utils.
 */
public class StringUtils extends org.apache.commons.lang.StringUtils {

    private static final long FILE_SIZE_CARRY = 1024;

    private static final long FILE_SIZE_KB = 1 * FILE_SIZE_CARRY;

    private static final long FILE_SIZE_MB = FILE_SIZE_KB * FILE_SIZE_CARRY;

    private static final long FILE_SIZE_GB = FILE_SIZE_MB * FILE_SIZE_CARRY;

    private static final long FILE_SIZE_TB = FILE_SIZE_GB * FILE_SIZE_CARRY;

    /**     */
    private static final int LIMIT_LENGTH = 10;
    /**     */
    private static final int LIMIT_LENGTH_9 = 9;
    /**     */
    private static final int LIMIT_LENGTH_20 = 20;


    /**
     */
    private final static String[][] SPECIAL_CHARACTER = {
            {"&#33;", "!"}, {"&quot;", "\""}, {"&#35;", "#"}, {"&#36;", "$"}, {"&#37;", "%"},
            {"&amp", "&"}, {"&#39;", "'"}, {"&#40;", "("}, {"&#41;", ")"}, {"&#42;", "*"},
            {"&#43;", "+"}, {"&#44;", ","}, {"&#45;", "-"}, {"&#46;", "."}, {"&#47;", "/"},
            {"&#58;", ":"}, {"&#59;", ";"}, {"&lt;", "<"}, {"&#61;", "="}, {"&gt;", ">"},
            {"&#63;", "?"}, {"&#64;", "@"}, {"&#91;", "["}, {"&#92;", "\\"},
            {"&#93;", "]"}, {"&#94;", "^"}, {"&#96;", "`"}, {"&#123;", "{"}, {"&#124;", "|"},
            {"&#125;", "}"}, {"&#126;", "~"}
    };

    /**
     * 将字符串按某个分隔字符拆分后返回数组
     *
     * @param value    the value
     * @param splitter the splitter
     * @return string [ ]
     * @throws { 说明在某情况下,将发生什么异常
     *           }
     */
    public static String[] split2array(String value, String splitter) {

        StringTokenizer stringtokenizer = new StringTokenizer(value, splitter);
        String as[] = new String[stringtokenizer.countTokens()];
        for (int i = 0; i < as.length; i++)
            as[i] = stringtokenizer.nextToken();
        return as;
    }


    /**
     * {方法的功能/动作描述}
     *
     * @param str the str
     * @return string
     * @throws { 说明在某情况下,将发生什么异常
     *           }
     */
    public static String initialCaps(String str) {
        return new StringBuffer().append(Character.toUpperCase(str.charAt(0)))
                .append(str.substring(1)).toString();
    }


    /**
     * Initial lowercase.
     *
     * @param str the str
     * @return the string
     */
    public static String initialLowercase(String str) {
        return new StringBuffer().append(Character.toLowerCase(str.charAt(0)))
                .append(str.substring(1)).toString();
    }


    /**
     * 根据输入的String返回BigDecimal，或者若String非数字串，返回null
     *
     * @param str the str
     * @return big decimal
     * @throws { 说明在某情况下,将发生什么异常
     *           }
     */
    public static BigDecimal getBigDecimal(String str) {
        BigDecimal bd = null;
        if (str == null)
            return null;
        try {
            bd = new BigDecimal(str.trim());
        } catch (Exception e) {
            return null;
        }
        return bd;
    }


    /**
     * 获得一个Timestamp对象，参数为时间格式为 2001-12-24
     *
     * @param time the time
     * @return java . sql . timestamp
     * @throws { 说明在某情况下,将发生什么异常
     *           }
     */
    public static Timestamp stringToTimestamp(String time) {

        if (time == null)
            return null;

        Timestamp timestamp = null;
        ;
        if (time != null && !"".equals(time.trim())) {
            String tmp = parseDateString(time);
            try {
                // test if time is in 'yyyy-mm-dd hh:mm:ss.xxxx' format
                timestamp = Timestamp.valueOf(tmp);
            } catch (Exception ex) {
                //TODO
            }

            if (timestamp == null) {
                if (tmp.length() == 8 && tmp.indexOf('-') < 0) { // yyyymmdd
                    tmp = tmp.substring(0, 4) + "-" + tmp.substring(4, 6) + "-"
                            + tmp.substring(6, 8);
                }
                try {
                    timestamp = Timestamp.valueOf(tmp + " 00:00:00.0");
                } catch (Exception exc) {
                    // throw new Exception("时间格式错误");
                }
            }

            if (timestamp == null) {
                try {
                    // test if lcd is in lone format
                    timestamp = new Timestamp(Long.parseLong(tmp));
                } catch (Exception exc) {
                }
            }
        }
        return timestamp;
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param time the time
     * @return string
     */
    public static String parseDateString(String time) {
        if (time == null || time.indexOf("-") < 0 || time.length() > 10) {
            return time;
        }

        // only parse the yyyy-m-d, yyyy-mm-dd, yyyy-mm-d, yyyy-m-dd

        String temp = time;

        try {
            String year = temp.substring(0, temp.indexOf("-"));
            temp = temp.substring(temp.indexOf("-") + 1);
            String month = temp.substring(0, temp.indexOf("-"));
            if (Integer.parseInt(month) < 10) {
                month = StringUtils.addZero(month, 2);
            }

            String day = temp.substring(temp.indexOf("-") + 1);
            if (Integer.parseInt(day) < 10) {
                day = StringUtils.addZero(day, 2);
            }
            return (year + "-" + month + "-" + day);
        } catch (Exception ex) {
            return time;
        }
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param time the time
     * @return string
     */
    public static String timestampToString(Timestamp time) {
        if (time == null)
            return "";

        String division = "-";

        Calendar cal = Calendar.getInstance();
        cal.setTime(time);
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
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param policyNo the policy no
     * @return string
     */
    public static String addZero(String policyNo) {
        return addZero(policyNo, 15);
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param str       the str
     * @param totalSize the total size
     * @return string
     */
    public static String addZero(String str, int totalSize) {
        if (str == null)
            str = "";
        int length = str.length();
        for (int i = 0; i < totalSize - length; i++) {
            str = "0" + str;
        }
        return str;
    }

    /**
     * Translate a double value to a chinese string
     *
     * @param dMoney double value
     * @return String if input value larger than 10^8 or small than 0.01, return ""
     * else return a chinese string
     */
    public static String toChinese(int dMoney) {
        String[] strArr =
                {"零", "一", "二", "三", "四", "五", "六", "七", "八", "九"};
        String[] strArr1 =
                {"", "", "", "十", "百", "千", "万", "十", "百", "千"};
        String[] strArr2 = new String[10];
        String sRtn = "";
        int iTmp;
        double dTmp;

        try {
            dMoney += 0.001;
            if ((dMoney >= 100000000) || (dMoney < 0.01)) {
                sRtn = "";
            } else {
                for (int i = 0; i < 10; i++) {
                    dTmp = dMoney / Math.pow(10, 7 - i);
                    iTmp = (new Double(dTmp)).intValue();
                    dMoney -= iTmp * Math.pow(10, 7 - i);

                    if (iTmp != 0)
                        strArr2[i] = strArr[iTmp] + strArr1[9 - i];
                    else strArr2[i] = "";

                    if ("一十".equals(strArr2[i])) {
                        strArr2[i] = "十";
                    }

                }

                boolean bFlag = false;
                for (int i = 0; i < 10; i++) {
                    if (!"".equals(strArr2[i])) {
                        sRtn += strArr2[i];
                        bFlag = true;
                    } else {
                        if (i == 3) {
                            sRtn += "万";
                            bFlag = true;
                        } else if (bFlag) {
                            sRtn += "零";
                            bFlag = false;
                        }
                    }
                }


                if (sRtn.startsWith("万"))
                    sRtn = sRtn.substring(1, sRtn.length());
                while (sRtn.startsWith("零"))
                    sRtn = sRtn.substring(1, sRtn.length());
                if (sRtn.lastIndexOf("零") == (sRtn.length() - 1))
                    sRtn = sRtn.substring(0, sRtn.length() - 1);
                while (sRtn.startsWith("零"))
                    sRtn = sRtn.substring(1, sRtn.length());
                // sRtn += "整";
            }
        } catch (Exception ex) {
        }
        return sRtn;
    }

    /**
     * 判断字符串是否为空
     *
     * @param s 字符串
     * @return boolean boolean
     */
    public static final boolean isEmpty(String s) {
        return s == null || s.trim().length() == 0;
    }

    /**
     * Is empty.
     *
     * @param s the s
     * @return the boolean
     */
    public static final boolean isEmpty(Integer s) {
        return s == null;
    }


    /**
     * 转换空字符
     *
     * @param o the o
     * @return string
     */
    public static String convertStringToNull(Object o) {
        if (o == null) {
            return null;
        }
        if (o instanceof String && o.equals("")) {
            return null;
        } else if (o instanceof Integer && Integer.parseInt(o.toString()) == 0) {
            return null;
        } else {
            return o.toString().trim();
        }
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param o the o
     * @return string
     */
    public static String convertNullToString(Object o) {
        if (o == null) {
            return "";
        } else {
            return o.toString().trim();
        }
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param o the o
     * @param t the t
     * @return string
     */
    public static String convertNullToString(Object o, boolean t) {
        if (o == null) {
            if (t) {
                return "&nbsp;";
            } else {
                return "";
            }
        } else {
            return o.toString().trim();
        }
    }

    /**
     * 截取长度－换行
     *
     * @param str    the str
     * @param length the length
     * @return string
     */
    public static String formatStringInPattern(String str, int length) {
        if (str == null) {
            return "";
        }
        String s = str;
        StringBuffer value = new StringBuffer();
        value.append("");
        String temp = "";
        if (str.length() <= length) {
            return str;
        }
        while (s.length() > length) {
            temp = s.substring(0, length) + "<br>";
            s = s.substring(length);
            value.append(temp);
        }
        value.append(s);
        return value.toString();
    }

    /**
     * format the number following the pattern, eg. if the pattern is something
     * like this: "#,###,###.####", then the number 123456.789 will be formatted
     * as "123,456.7890".
     *
     * @param pattern String
     * @param d       double
     * @return String string
     */
    public static String formatNumber(String pattern, double d) {
        NumberFormat numFormatter = new DecimalFormat(pattern);
        return numFormatter.format(d);
    }

    /**
     * format the number following the pattern, eg. if the pattern is something
     * like this: "#,###,###.####", then the number 123456.789 will be formatted
     * as "123,456.7890".
     *
     * @param pattern String
     * @param o       Object
     * @return String string
     */
    public static String formatNumber(String pattern, Object o) {
        NumberFormat numFormatter = new DecimalFormat(pattern);
        return numFormatter.format(o);
    }

    /**
     * this function replaces any single quotation occured with in the passed in
     * string into two immediate single quotations.
     *
     * @param toBeReplaced the to be replaced
     * @return string
     */
    public static String escapeAmp(String toBeReplaced) {
        return toBeReplaced.replaceAll("\\\'", "''");
    }

    /**
     * Instantiates a new String utils.
     */
    public StringUtils() {
    }


    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param s the s
     * @return string
     */
    public static String fromGB(String s) {
        return Tools.fromGB(s);
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param abyte0 the abyte 0
     * @return string
     */
    public static String fromGB(byte abyte0[]) {
        return Tools.fromGB(abyte0);
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param s the s
     * @return string
     */
    public static String msNull(String s) {
        return Tools.msNull(s);
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param s the s
     * @return string
     */
    public static String emptyStringToNull(String s) {
        return Tools.emptyStringToNull(s);
    }


    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param s  the s
     * @param s1 the s 1
     * @param s2 the s 2
     * @return string
     */
    public static String replaceString(String s, String s1, String s2) {
        return Tools.replaceString(s, s1, s2);
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param as the as
     * @return string
     */
    public static String generateArray(String as[][]) {
        return Tools.generateArray(as);
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param s the s
     * @return boolean
     */
    public static boolean isNotEmpty(String s) {
        return s != null && s.length() > 0;
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param al the al
     * @param s  the s
     * @return string
     */
    public static String toString(long al[], String s) {
        String s1 = null;
        if (al != null) {
            s1 = "";
            for (int i = 0; i < al.length; i++)
                if (i == al.length - 1)
                    s1 = s1 + al[i];
                else
                    s1 = s1 + al[i] + s;

        }
        return s1;
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param al the al
     * @return string
     */
    public static String toString(long al[]) {
        return toString(al, ",");
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param s  the s
     * @param s1 the s 1
     * @return int
     */
    public static int countSubstring(String s, String s1) {
        int i = 0;
        for (int j = 0; j >= 0; ) {
            j = s.indexOf(s1);
            if (j >= 0) {
                i++;
                s = s.substring(j + s1.length(), s.length());
            }
        }

        return i;
    }

    /**
     * 将一个包含多行的字符串转换成多个字符串，每个字符串就是其中的一行
     *
     * @param srcString 字符串
     * @return 字符数组 ，每元素就是一行
     */
    public static List readLine(String srcString) {
        BufferedReader reader = null;
        String line = null;
        List list = new ArrayList();
        try {
            try {
                if (srcString != null && srcString.trim().length() > 0) {
                    reader = new BufferedReader(new StringReader(srcString.trim()));
                    reader.ready();
                    while (true) {
                        line = reader.readLine();
                        if (line == null) {
                            break;
                        } else {
                            list.add(line);
                        }
                        line = null;
                    }
                } else {
                    if (srcString != null) {
                        list.add(srcString.trim());
                    }
                }
                return list;
            } finally {
                list = null;
                reader = null;
                if (reader != null) {
                    reader.close();
                    reader = null;
                }
            }
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    /**
     * 在字符串指定位置插入一字串
     *
     * @param srcString  源字符串
     * @param beginIndex 开始位置
     * @param content    欲插入内容
     * @return 处理后字符串 string
     */
    public static String insertString(String srcString, int beginIndex, String content) {
        if (beginIndex < 0) {
            throw new RuntimeException("欲插入字串的开始位置不可小于0！");
        }
        String tmp_1 = null;
        String tmp_2 = null;
        try {
            if (srcString.length() > beginIndex) {
                tmp_1 = srcString.substring(0, beginIndex);
                tmp_2 = srcString.substring(beginIndex);
                return tmp_1 + content + tmp_2;
            } else {
                return srcString + content;
            }
        } finally {
            tmp_1 = null;
            tmp_2 = null;
        }
    }

    /**
     * 获取指定字符串内指定字符在该字符串内的数量
     *
     * @param srcString 指定字符串
     * @param cChar     指定字符
     * @return 指定字符在指定字符串内的数量 number by char
     */
    public static int getNumberByChar(String srcString, char cChar) {
        return getIndexsByChar(srcString, cChar).length;
    }

    /**
     * 获取指定字符串内指定字符在该字符串内的位置（存在多少个则返回多少个）
     *
     * @param srcString 指定字符串
     * @param cChar     指定字符
     * @return 指定字符在指定字符串内的位置 int [ ]
     */
    public static int[] getIndexsByChar(String srcString, char cChar) {
        if (srcString == null || srcString.trim().length() == 0) {
            return new int[0];
        }
        int numIndex = 0;
        int[] aryIndex;
        int[] tmpIndex = new int[srcString.length()];
        byte[] arySrc = srcString.trim().getBytes();
        for (int i = 0; i < arySrc.length; i++) {
            if (arySrc[i] == cChar) {
                tmpIndex[numIndex] = i;
                numIndex++;
            }
        }
        aryIndex = new int[numIndex];
        for (int i = 0; i < aryIndex.length; i++) {
            aryIndex[i] = tmpIndex[i];
        }
        try {
            return aryIndex;
        } finally {
            aryIndex = null;
            tmpIndex = null;
            arySrc = null;
        }
    }


    /**
     * 分割字符串
     *
     * @param srcString 源字符串
     * @param delim     分割符
     * @return 分割后的字符串 string [ ]
     */
    public static String[] splitString(String srcString, String delim) {
        if ((srcString.lastIndexOf(delim) + 1) == srcString.length()) {
            srcString = srcString + delim;
        }
        String sChar;
        String sValue = "";
        boolean isAdd = false;
        List list = new ArrayList();
        String[] aryReturn = null;

        for (int i = 0; i < srcString.length(); i++) {
            if (srcString.substring(i).length() < delim.length()) {
                sChar = srcString.substring(i);
            } else {
                sChar = srcString.substring(i, i + delim.length());
            }
            if (!sChar.equals(delim)) {
                sValue += srcString.substring(i, i + 1);
            } else {
                isAdd = true;
                i += delim.length() - 1;
            }
            if (i == srcString.length() - 1) {
                isAdd = true;
            }

            if (isAdd) {
                list.add(sValue);
                sValue = "";
                isAdd = false;
            }
        }
        aryReturn = new String[list.size()];
        for (int i = 0; i < list.size(); i++) {
            aryReturn[i] = list.get(i).toString();
        }
        try {
            return aryReturn;
        } finally {
            sChar = null;
            sValue = null;
            list = null;
            aryReturn = null;
        }
    }


    /**     */
    private static Pattern patternUpper = Pattern.compile("[A-Z]+");
    /**     */
    private static Pattern patternLower = Pattern.compile("[a-z]+");
    /**     */
    private static Pattern patternDigit = Pattern.compile("[0-9]+");
    /**     */
    private static Pattern patternPunct = Pattern.compile("\\p{Punct}+");
    /**
     * 邮箱
     */
    private static Pattern patternEmail = Pattern.compile("^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\\.([a-zA-Z0-9_-])+)+$");
    /**
     * 电话 格式 021-12345678
     */
    private static Pattern patternPhone = Pattern.compile("[0]{1}[0-9]{2,3}-[0-9]{7,8}");
    /**
     * 手机
     */
    private static Pattern patternMobilePhone = Pattern.compile("^((13[0-9])|(14[0-9])|(15[0-9,\\D])|(18[0-9]))\\d{8}$");

    /**
     * 显示金额
     *
     * @param amount the amount
     * @return string
     */
    public static String showAmount(double amount) {
        BigDecimal a = new BigDecimal(amount);
        a = a.setScale(2, BigDecimal.ROUND_HALF_UP);
        return a.toString();
    }

    /**
     * 解析字符串，获取指定位置的字符串内容，转换成整形
     *
     * @param source 源字串
     * @param start  起始位
     * @param length 长度
     * @return 内容 integer
     */
    public static Integer parseInteger(byte[] source, Integer start, Integer length) {
        Integer target = null;

        String t = parseString(source, start, length);

        target = Integer.valueOf(trim(t));

        return target;
    }

    /**
     * 解析字符串，获取指定位置的字符串内容，转换成浮点型
     *
     * @param source 源字串
     * @param start  起始位
     * @param length 长度
     * @return 内容 big decimal
     */
    public static BigDecimal parseBigDecimal(byte[] source, Integer start, Integer length) {
        BigDecimal target = null;

        String t = parseString(source, start, length);

        target = new BigDecimal(trim(t));

        return target;
    }

    /**
     * 解析字符串，获取指定位置的字符串内容
     *
     * @param source 源字串
     * @param start  起始位
     * @param length 长度
     * @return 内容 string
     */
    public static String parseString(byte[] source, Integer start, Integer length) {
        byte[] value = new byte[length];
        System.arraycopy(source, start, value, 0, length);
        String target = new String(value);
        try {
            target = trim(new String(value, "GBK"));
        } catch (UnsupportedEncodingException e) {
            // TODO 需要对异常做处理
            // TODO 处理异常或Log日志记录 2011-10-28
        }

        return target;
    }

    /**
     * 获取整数的指定长度的内容 右补0
     *
     * @param source 源整数
     * @param length 长度
     * @return 内容 string
     */
    public static String generateNumber(BigDecimal source, Integer length) {
        return generateNumber(source, length, null);
    }

    /**
     * 获取浮点型的指定长度的内容 右补
     *
     * @param source 源浮点型
     * @param length 长度
     * @param scale  精度
     * @return 内容 string
     */
    public static String generateNumber(BigDecimal source, Integer length, Integer scale) {
        String target = null;
        BigDecimal s = source;
        if (source != null) {
            if (scale != null) {
                s = s.setScale(scale, BigDecimal.ROUND_HALF_UP);
            }
            target = generateNumber(s.toString(), length);
        } else {
            target = generateNumber("", length);
        }

        return target;
    }

    /**
     * 获指定长度的内容 右补0
     *
     * @param source 源整数
     * @param length 长度
     * @return 内容 string
     */
    public static String generateNumber(Object source, Integer length) {
        String target = null;

        if (source != null) {
            target = source.toString();
            if (target.length() > length) {
                return null;
            } else if (target.length() < length) {
                target = leftPad(target, length, '0');
            }
        } else {
            target = leftPad("", length, '0');
        }

        return target;
    }

    /**
     * 获取字符串的指定长度的内容 长度不足则右补空格 长度过长则从左截取
     *
     * @param source 源字串
     * @param length 长度
     * @return 内容 string
     */
    public static String generateString(String source, Integer length) {
        String target = source;

        if (target != null) {
            if (target.length() > length) {
                target = substring(target, 0, length);
            } else if (target.length() < length) {
                target = rightPad(target, length, ' ');
            }
        } else {
            target = rightPad("", length, ' ');
        }

        return target;
    }

    /**
     * 校验url是否"/"开头 如果不是"/"开头，则在开头加上"/"
     *
     * @param url url
     * @return url string
     */
    public static String checkUrlFisrtChar(String url) {
        String uri = url;
        if (url != null && url.indexOf("/") != 0) {
            uri = "/" + uri;
        }
        return uri;
    }

    /**
     * 校验密码是否符合要求 必须有大小写和数字 或者标点发符号
     *
     * @param password 密码
     * @return true -符合;false-不符合
     */
    public static Boolean checkPassword(String password) {

        if (password == null || password.length() < 8) {
            return Boolean.FALSE;
        }

        Matcher matcherUpper = patternUpper.matcher(password); // 判断是否含有大写字符
        Matcher matcherLower = patternLower.matcher(password); // 判断是否含有小写字符
        Matcher matcherDigit = patternDigit.matcher(password); // 判断是否含有数字
        Matcher matcherPunct = patternPunct.matcher(password); // 判断是否含有特殊字符

        if (!matcherUpper.find(0)
                || !matcherLower.find(0)
                || (!matcherDigit.find(0)
                && !matcherPunct.find(0))) {
            return Boolean.FALSE;
        }
        return Boolean.TRUE;
    }

    /**
     * 解析路径 组成路径集合
     *
     * @param areaPath 区域路径
     * @return paths list
     */
    public static List<String> parsePath(String areaPath) {
        String path = areaPath;
        List<String> paths = new ArrayList<String>();

        while (indexOf(path, "/") != -1) {
            paths.add(path);

            path = substring(path, 0, lastIndexOf(path, "/"));
        }

        return paths;
    }

    /**
     * 解析路径，获取上级路径的集合
     *
     * @param areaPath 区域路径
     * @return paths list
     */
    public static List<String> parentPath(String areaPath) {
        String path = areaPath;
        List<String> paths = new ArrayList<String>();
        paths.add("/");

        int pos = lastIndexOf(path, "/");
        if (pos >= 0) {
            path = substring(path, 0, pos);
        }

        while (indexOf(path, "/") != -1) {
            paths.add(path);

            path = substring(path, 0, lastIndexOf(path, "/"));
        }

        return paths;
    }

    /**
     * 获取名字集合
     *
     * @param name 名字字符串
     * @return 名字集合 list
     */
    public static List<String> parseName(String name) {
        List<String> receiver = new ArrayList<String>();

        String[] receivers1 = split(name, ",");
        for (String receiver1 : receivers1) {
            String[] receivers2 = split(receiver1, ";");
            for (String receiver2 : receivers2) {
                receiver.add(receiver2);
            }
        }
        if (receiver.isEmpty()) {
            receiver.add(name);
        }
        return receiver;
    }

    /**
     * 异或两个自串
     *
     * @param pan    the pan
     * @param pin    the pin
     * @param length 长度
     * @return 数据 string
     */
    public static String xor(String pan, String pin, int length) {
        return new String(xor(pan.toCharArray(), pin.toCharArray(), length));
    }

    /**
     * 异或两个byte自串
     *
     * @param pan    the pan
     * @param pin    the pin
     * @param length 长度
     * @return 数据 byte [ ]
     */
    public static byte[] xor(byte[] pan, byte[] pin, int length) {
        int i = 0;
        byte[] result = new byte[length];
        for (i = 0; i < length; i++) {

            result[i] = (byte) (pan[i] ^ pin[i]);

        }
        return result;
    }

    /**
     * 异或两个char数组
     *
     * @param pan    the pan
     * @param pin    the pin
     * @param length 长度
     * @return 数据 char [ ]
     */
    public static char[] xor(char[] pan, char[] pin, int length) {
        int i = 0;
        char[] result = new char[length];
        for (i = 0; i < length; i++) {

            result[i] = (char) (pan[i] ^ pin[i]);

        }
        return result;
    }

    /**
     * 压缩字符串
     *
     * @param source 源字串
     * @return 压缩后字串 string
     * @throws java.io.IOException the iO exception
     */
    public static String compress(String source) throws IOException {
        if (source == null || source.length() == 0) {
            return source;
        }
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        GZIPOutputStream gzip = new GZIPOutputStream(out);
        gzip.write(source.getBytes());
        gzip.close();
        return out.toString("ISO-8859-1");
    }

    /**
     * 解压字符串
     *
     * @param target 压缩字串
     * @return 源字串 string
     * @throws java.io.IOException the iO exception
     */
    public static String uncompress(String target) throws IOException {
        if (target == null || target.length() == 0) {
            return target;
        }
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        ByteArrayInputStream in = new ByteArrayInputStream(target
                .getBytes("ISO-8859-1"));
        GZIPInputStream gunzip = new GZIPInputStream(in);
        byte[] buffer = new byte[256];
        int n;
        while ((n = gunzip.read(buffer)) >= 0) {
            out.write(buffer, 0, n);
        }
        // toString()使用平台默认编码，也可以显式的指定如toString("GBK")
        return out.toString();
    }

    /**
     * 压缩
     *
     * @param data 待压缩数据
     * @return byte[] 压缩后的数据
     */
    public static byte[] compress(byte[] data) {
        byte[] output = new byte[0];

        Deflater compresser = new Deflater();
        compresser.reset();
        // compresser.setDictionary(dictionary.getBytes());
        compresser.setLevel(Deflater.BEST_COMPRESSION);
        compresser.setStrategy(Deflater.HUFFMAN_ONLY);
        compresser.setInput(data);

        compresser.finish();
        ByteArrayOutputStream bos = new ByteArrayOutputStream(data.length);
        try {
            byte[] buf = new byte[1024];
            while (!compresser.finished()) {
                int i = compresser.deflate(buf);
                bos.write(buf, 0, i);
            }
            output = bos.toByteArray();
        } catch (Exception e) {
            output = data;
            // TODO 处理异常或Log日志记录 2011-10-28
        } finally {
            try {
                bos.close();
            } catch (IOException e) {
                // TODO 需要对异常做处理
                // TODO 处理异常或Log日志记录 2011-10-28
            }
        }
        compresser.end();
        return output;
    }

    /**
     * 解压缩
     *
     * @param data 待压缩的数据
     * @return byte[] 解压缩后的数据
     */
    public static byte[] decompress(byte[] data) {
        byte[] output = new byte[0];

        Inflater decompresser = new Inflater();
        decompresser.reset();
        decompresser.setInput(data);

        ByteArrayOutputStream o = new ByteArrayOutputStream(data.length);
        try {
            byte[] buf = new byte[1024];
            while (!decompresser.finished()) {
                int i = decompresser.inflate(buf);
                o.write(buf, 0, i);
            }
            output = o.toByteArray();
        } catch (Exception e) {
            output = data;
            // TODO 处理异常或Log日志记录 2011-10-28
        } finally {
            try {
                o.close();
            } catch (IOException e) {
                // TODO 需要对异常做处理
                // TODO 处理异常或Log日志记录 2011-10-28
            }
        }

        decompresser.end();
        return output;
    }

    /**
     * 判断是否全数字
     *
     * @param str the str
     * @return boolean
     */
    public static boolean isFullDigit(String str) {
        Matcher matcherUpper = patternUpper.matcher(str); // 判断是否含有大写字符
        Matcher matcherLower = patternLower.matcher(str); // 判断是否含有小写字符
        Matcher matcherPunct = patternPunct.matcher(str); // 判断是否含有特殊字符

        if (matcherUpper.find(0) || matcherLower.find(0) || matcherPunct.find(0)) {
            return Boolean.FALSE;
        }
        return Boolean.TRUE;
    }

    /**
     * Format string.
     *
     * @param origin the origin
     * @return the string
     */
    public static String format(String origin) {
        if (origin == null || origin.equalsIgnoreCase("null"))
            return "";
        return origin;
    }

    /**
     * Trans from double to chs.
     *
     * @param num the num
     * @return the string
     */
    public static String transFromDoubleToChs(double num) {
        Map<String, String> tans = new HashMap<String, String>();
        Map<Integer, String> pos = new HashMap<Integer, String>();
        tans.put("0", "零");
        tans.put("1", "一");
        tans.put("2", "二");
        tans.put("3", "三");
        tans.put("4", "四");
        tans.put("5", "五");
        tans.put("6", "六");
        tans.put("7", "七");
        tans.put("8", "八");
        tans.put("9", "九");
        pos.put(1, "");
        pos.put(2, "十");
        pos.put(3, "百");
        pos.put(4, "千");

        StringBuffer result = new StringBuffer();
        if (num == 0)
            return "零";
        NumberFormat formatter = new DecimalFormat("0.000000000000");
        String digit = formatter.format(num);

        int pIndex = digit.indexOf(".");
        String intPart = digit.substring(0, pIndex);// 整数部分
        String douPart = digit.substring(pIndex + 1, digit.length());// 分数部分

        // 处理整数部分
        int length = intPart.length();
        for (int i = 0; i < length; i++) {
            String val = intPart.substring(i, i + 1);
            if (val.equals("0")) {
                if (i < length - 1) {
                    if (!intPart.substring(i + 1, i + 2).equals("0")) {
                        result.append(tans.get("0"));
                    }
                }
                continue;
            }
            String scale = pos.get(length - i);
            result.append(tans.get(val));
            result.append(scale);
        }

        // 处理分数部分
        length = douPart.length();
        for (int i = 0; i < length; i++) {
            if (douPart.charAt(douPart.length() - 1) == '0') {
                douPart = douPart.substring(0, douPart.length() - 1);
            } else {
                break;
            }
        }
        length = douPart.length();
        if (length == 0) return result.toString();
        if (intPart.equals("0")) result.append(tans.get("0"));
        result.append("点");
        for (int i = length; i > 0; i--) {
            String val = douPart.substring(length - i, length - i + 1);
            result.append(tans.get(val));
        }

        return result.toString();
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param amount the amount
     * @return string
     */
    public static String formatMoney(String amount) {
        if (amount == null || amount.equals("")) {
            return amount;
        }
        try {
            double damount = Double.parseDouble(amount);
            amount = showAmount(damount);
        } catch (Exception e) {
            // TODO 需要对异常做处理
        } finally {
            return amount;
        }
    }


    /**
     * 检查上传的Excel文件文件名是否合规
     *
     * @param fileName the file name
     * @return int
     */
    public static int fileNameCheck(String fileName) {
        if (fileName == null) {
            return 1;
        }
        int position = fileName.lastIndexOf(".");
        if (position < 16) {
            return 1;
        }
        String preName = fileName.substring(position - 12, position);
        try {
            long test = Long.parseLong(preName);
        } catch (Exception e) {
            return 1;
        }
        String extend = fileName.substring(position + 1);
        if (!extend.equalsIgnoreCase("xls")) {
            return 2;
        }
        return 0;
    }


    /**
     * 判断是否电话
     *
     * @param phone the phone
     * @return boolean
     */

    public static boolean isPhone(String phone) {

        Matcher matcher = patternPhone.matcher(phone);
        boolean ph = matcher.matches();
        if (ph) {
            return true;
        } else {
            return false;
        }
    }


    /**
     * 判断是否手机
     *
     * @param phone the phone
     * @return boolean
     */

    public static boolean isMobilePhone(String phone) {


        Matcher mat = patternMobilePhone.matcher(phone);
        boolean ph = mat.matches();
        if (ph) {
            return true;
        } else {
            return false;
        }
    }


//    /**
//     * 处理特殊字符
//     *
//     * @param specialString the special string
//     * @return string
//     */
//    public static String DealSpecialChar(String specialString) {
//        if (isNotEmpty(specialString)) {
//            StringBuilder result = new StringBuilder();
//            @SuppressWarnings("unchecked")
//            Map<String, String> specialChars = ArrayUtils.toMap(SPECIAL_CHARACTER);
//            for (int i = 0; i < specialString.length(); i++) {
//                String temp = String.valueOf(specialString.charAt(i));
//                if (specialChars.containsKey(temp)) {
//                    result.append(specialChars.get(temp));
//                } else {
//                    result.append(temp);
//                }
//            }
//            return result.toString();
//        } else {
//            return specialString;
//        }
//    }


    /**
     * 给url添加指定的字符串，比如appendPiex("http://www.wl.com/abc.jsp","abc")
     * 返回http://www.wl.com/abcabc.jsp
     *
     * @param url  the url
     * @param piex the piex
     * @return string
     */
    public static String appendPiex(String url, String piex) {
        if (isNotEmpty(url)) {
            StringBuilder builder = new StringBuilder(url.substring(0, url.lastIndexOf(".")));
            String priex = url.substring(url.lastIndexOf("."));
            if (isNotEmpty(piex)) {
                builder.append(piex).append(priex);
            }
            return builder.toString();
        }
        return null;
    }

    /**
     * 为一个图片url添加前缀
     * 如:http://style.wl.com/img_uploaded/admin/upload/fp/pic/2012
     * /2012525/JwV2DZnBjJANXjuzHLTEMcWpa.jpg 添加后的地址为:
     * http://style.wl.com/img_uploaded
     * /admin/upload/fp/pic/2012/2012525/prefixJwV2DZnBjJANXjuzHLTEMcWpa.jpg
     *
     * @param url    the url
     * @param prefix the prefix
     * @return string
     */
    public static String appendPrefix(String url, String prefix) {
        if (isNotEmpty(url)) {
            StringBuilder builder = new StringBuilder(url.substring(0, url.lastIndexOf("/")));
            String priex = url.substring(url.lastIndexOf("/") + 1, url.length());
            if (isNotEmpty(prefix)) {
                builder.append("/").append(prefix).append(priex);
            }
            return builder.toString();
        }
        return null;
    }


    static String areas[] = {"台湾", "海外", "香港", "澳门"};

    /**
     * 去除地址中的重复字段
     *
     * @param address the address
     * @return string
     * @author wangwenbo
     */
    public static String trimDupAdd(String address) {
        if (address == null) return address;
        String result = address;
        for (int i = 0; i < areas.length; i++) {
            while (result.indexOf(areas[i] + areas[i]) != -1) {
                result = result.replaceAll(areas[i] + areas[i], areas[i]);
            }
        }
        return result;
    }


    /**
     * The entry point of application.
     *
     * @param args the input arguments
     */
    public static void main(String[] args) {

        System.out.println(appendPiex("http://www.baidu.com/wwww.jsp", "_100x200"));

    }

    /**
     * The constant STR_2_INT_ARR_CONVETER.
     */
    public final static TypeConverter<String, Integer> STR_2_INT_ARR_CONVETER = new TypeConverter<String, Integer>() {
        @Override
        public Integer convert(String s) {
            if (StringUtils.isEmpty(s)) {
                return null;
            } else {
                return Integer.valueOf(s);
            }
        }
    };

    /**
     * Convert string 2 array.
     *
     * @param source    the source
     * @param converter the converter
     * @return the list
     */
    public static <T> List<T> convertString2Array(String source, TypeConverter<String, T> converter) {
        if (StringUtils.isEmpty(source)) {
            return new ArrayList<T>(0);
        }
        List<T> array = new ArrayList<T>();
        String[] splitted = source.trim().split(",");

        for (String src : splitted) {
            array.add(converter.convert(src));
        }

        return array;
    }

    /**
     * The interface Type converter.
     */
    public static interface TypeConverter<Src, Dest> {

        /**
         * Convert dest.
         *
         * @param src the src
         * @return the dest
         */
        public Dest convert(Src src);
    }

    /**
     * Is mobile.
     *
     * @param input the input
     * @return the boolean
     */
    public static boolean isMobile(String input) {
        Pattern p = Pattern.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");
        Matcher m = p.matcher(input);
        return m.matches();
    }

    /**
     * Is email.
     *
     * @param input the input
     * @return the boolean
     */
    public static boolean isEmail(String input) {
        Pattern p = Pattern.compile("^\\s*\\w+(?:\\.{0,1}[\\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\\.[a-zA-Z]+\\s*$");
        Matcher m = p.matcher(input);
        return m.matches();
    }

    /**
     * Format file size.
     *
     * @param number the number
     * @return the string
     */
    public static String formatFileSize(Number number) {
        String ret = "0";
        if (number != null) {
            long longValue = number.longValue();
            if (longValue > FILE_SIZE_TB) {
                ret = divide(longValue, FILE_SIZE_TB) + " TB";
            } else if (longValue > FILE_SIZE_GB) {
                ret = divide(longValue, FILE_SIZE_GB) + " GB";
            } else if (longValue > FILE_SIZE_MB) {
                ret = divide(longValue, FILE_SIZE_MB) + " MB";
            } else {
                ret = divide(longValue, FILE_SIZE_KB) + " KB";
            }
        }

        return ret;
    }

    private static BigDecimal divide(long divide, long divider) {
        return new BigDecimal(divide).divide(new BigDecimal(divider), 2, RoundingMode.HALF_EVEN).setScale(2);
    }

    /**
     * 数字处理，整数部分每三位用“ , ”分隔，小数部分保留两位。
     *
     * @param money the money
     * @return the string
     */
    public static String formatKiloCeilMoney(String money) {
        // 四舍五入保留两位小数
        if (!"".equals(money) && money != null) {
            money = new BigDecimal(money).setScale(2, BigDecimal.ROUND_HALF_UP)
                    .toString();
        }
        String result = "0.00";
        String str[] = money.split("\\.");
        StringBuffer temp = new StringBuffer(str[0]);
        int len = temp.length();
        for (int i = len - 3; i > 0; i -= 3) {
            if (i < 0) {
                break;
            }
            if (temp.charAt(i - 1) != '-') {
                temp.insert(i, ",");
            }
        }
        if (len > 0) {
            result = temp.toString();
        } else {
            result = "0";
        }
        if (str.length == 1) {
            result += ".00";
        }
        if (str.length == 2) {
            if (str[1].length() == 1) {
                result += "." + str[1] + "0";
            } else {
                result += "." + str[1];
            }
        }
        return result;
    }


    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param str the str
     * @return limit default
     */
    public static String getLimitDefault(String str) {
        return getLimit(str, LIMIT_LENGTH);
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param str the str
     * @return limit 9
     */
    public static String getLimit9(String str) {
        return getLimit(str, LIMIT_LENGTH_9);

    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param str the str
     * @return limit 20
     */
    public static String getLimit20(String str) {
        // TODO Auto-generated method stub
        return getLimit(str, LIMIT_LENGTH_20);
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param str
     * @param length
     * @return
     */
    private static String getLimit(String str, int length) {
        // TODO Auto-generated method stub
        if (StringUtils.isEmpty(str) || str.length() <= length) {
            return str;
        } else {
            return str.substring(0, length) + "...";
        }
    }


    /**
     * The constant EMPTY_STRING.
     */
    public static final String EMPTY_STRING = "";

    /**
     * 加密, 转成 utf-8 字符串 〈功能详细描述〉
     *
     * @param key the key
     * @return string
     */
    public static String encode(String key) {
        if (null == key || "".equals(key.trim())) {
            return key;
        }

        try {
            key = URLEncoder.encode(key, "utf-8");
        } catch (UnsupportedEncodingException ex) {
        }

        return key;
    }

    /**
     * 解密, 从 utf-8 字符串 还原 〈功能详细描述〉
     *
     * @param key the key
     * @return string
     */
    public static String decode(String key) {
        if (null == key || "".equals(key.trim())) {
            return key;
        }

        try {
            key = URLDecoder.decode(key, "utf-8");
        } catch (UnsupportedEncodingException ex) {
        }

        return key;
    }

    /**
     * 生成36位的uuid. 〈功能详细描述〉
     *
     * @return string
     */
    public static String generateUUID() {
        UUID uuid = UUID.randomUUID();
        return uuid.toString();

    }

    /**
     * 生成36位的uuid。字符全为大写 〈功能详细描述〉
     *
     * @return string
     */
    public static String generateUUIDWithUppercase() {
        UUID uuid = UUID.randomUUID();
        return uuid.toString().toUpperCase();

    }

    /**
     * 判别一组String值是否都是UUID. 〈功能详细描述〉
     *
     * @param str the str
     * @return boolean
     */
    public static boolean isUUID(String... str) {
        for (int i = 0; i < str.length; i++) {
            try {
                UUID.fromString(str[i]);
            } catch (Exception e) {
                return false;
            }
        }

        return true;
    }

    /**
     * 将InputStream转换为字符串
     *
     * @param is the is
     * @return string
     * @throws { 说明在某情况下,将发生什么异常
     *           }
     */
    public static String converts(InputStream is) {
        StringBuilder sb = new StringBuilder();
        String readline = "";
        try {
            /**
             * 若乱码，请改为new InputStreamReader(is, "GBK").
             */
            BufferedReader br = new BufferedReader(new InputStreamReader(is));
            while (br.ready()) {
                readline = br.readLine();
                sb.append(readline);
            }
            br.close();
        } catch (IOException ie) {

        }
        return sb.toString();
    }

    /**
     * 功能：把一般字串转成base64字串
     *
     * @param str String
     * @return String 成功把str转换成base64编码,失败返回null
     */
//    public static String string2Base64(String str) {
//        if (0 == str.length()) {
//            return str;
//        }
//        String rt = Base64.encodeBase64String(str.getBytes());
//        return rt.replaceAll("\r", "").replaceAll("\n", "");
//
//    }

    /**
     * 将字符串以指定的字符集BASE64编码
     *
     * @param str         the str
     * @param charSetName the char set name
     * @return string
     */
//    public static String string2Base64(String str, String charSetName) {
//        if (0 == str.length()) {
//            return str;
//        }
//        String rt = null;
//        try {
//            rt = Base64.encodeBase64String(str.getBytes(charSetName));
//            rt = rt.replaceAll("\r", "").replaceAll("\n", "");
//        } catch (UnsupportedEncodingException e) {
//            throw new RuntimeException(e);
//        }
//        return rt;
//    }

    /**
     * 功能：把base64字串还原
     *
     * @param base64str String
     * @return String 成功还原，失败返回null
     */
//    public static String base642String(String base64str) {
//        if (0 == base64str.length()) {
//            return base64str;
//        }
//        return new String(Base64.decodeBase64(base64str));
//    }

    /**
     * 将base64编码字符串还原，并以指定字符集识别。
     *
     * @param base64str   the base 64 str
     * @param charSetName the char set name
     * @return string
     */
//    public static String base642String(String base64str, String charSetName) {
//        if (0 == base64str.length()) {
//            return base64str;
//        }
//        try {
//            return new String(Base64.decodeBase64(base64str), charSetName);
//        } catch (IOException ex) {
//            return null;
//        }
//    }

    /**
     * 判断字符串中是否包含指定子串，在判断是将忽略大小写。<br>
     * 例如，containsIgnoreCase("Hello world", "hello")将返回true
     *
     * @param str    the str
     * @param subStr the sub str
     * @return boolean
     */
    public static boolean containsIgnoreCase(String str, String subStr) {
        return str.toUpperCase().indexOf(subStr.toUpperCase()) > -1;
    }

    /**
     * 使用传入的参数替换掉字符串中包含的形如{n}的字符串。例如对于“测试{0}和{1}”， 调用该方法format("测试{0}和{1}", "A",
     * "B")将会返回“测试A和B”。
     *
     * @param value      the value
     * @param parameters 为了保证结果的正确性，请注意参数值的顺序
     * @return string
     */
    public static String format(String value, Object... parameters) {
        Pattern p = Pattern.compile("\\{\\d\\}");
        Matcher m = p.matcher(value);
        int i = 0;
        while (m.find())
            value = value.replace(m.group(), (String) parameters[i++]);

        return value;
    }

    /**
     * 如果该参数字符串不为null，长度大于0，且至少包含一个non-whitespace字符，那么该方法返回true
     * <p/>
     * <pre>
     * StringUtils.hasText(null) = false
     * StringUtils.hasText("") = false
     * StringUtils.hasText(" ") = false
     * StringUtils.hasText("12345") = true
     * StringUtils.hasText(" 12345 ") = true
     * </pre>
     *
     * @param str the String to check, may be <code>null</code>
     * @return <code>true</code> if the String is not null, length > 0, and not
     * whitespace only
     */
    public static boolean hasText(String str) {
        if (str == null)
            return false;

        str = str.trim();
        int strLen;
        if ((strLen = str.length()) == 0)
            return false;

        for (int i = 0; i < strLen; i++) {
            if (!Character.isWhitespace(str.charAt(i))) {
                return true;
            }
        }

        return false;
    }

    /**
     * 将数组元素拼装成字符串，每个元素以指定的<code>delim</code>分隔。
     *
     * @param array the array
     * @param delim the delim
     * @return string
     */
    public static String join(int[] array, String delim) {
        if (array.length == 0) {
            return EMPTY_STRING;
        }

        StringBuffer s = new StringBuffer();
        for (int i : array) {
            s.append(delim + i);
        }

        return s.substring(delim.length());
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param array the array
     * @param delim the delim
     * @return string
     */
    public static String join(Integer[] array, String delim) {
        if (array.length == 0) {
            return EMPTY_STRING;
        }

        StringBuffer s = new StringBuffer();
        for (Integer i : array) {
            s.append(delim + i);
        }

        return s.substring(delim.length());
    }

    /**
     * 将数组元素拼装成字符串，每个元素以指定的<code>delim</code>分隔。
     *
     * @param array the array
     * @param delim the delim
     * @return string
     */
    public static String join(double[] array, String delim) {
        if (array.length == 0) {
            return EMPTY_STRING;
        }

        StringBuffer s = new StringBuffer();
        for (double i : array) {
            s.append(delim + i);
        }

        return s.substring(delim.length());
    }

    /**
     * 将数组元素拼装成字符串，每个元素以指定的<code>delim</code>分隔。
     *
     * @param array the array
     * @param delim the delim
     * @return string
     */
    public static String join(long[] array, String delim) {
        if (array.length == 0) {
            return EMPTY_STRING;
        }

        StringBuffer s = new StringBuffer();
        for (long i : array) {
            s.append(delim + i);
        }

        return s.substring(delim.length());
    }

    /**
     * 将数组元素拼装成字符串，每个元素以指定的<code>delim</code>分隔。
     *
     * @param array the array
     * @param delim the delim
     * @return string
     */
    public static String join(float[] array, String delim) {
        if (array.length == 0) {
            return EMPTY_STRING;
        }

        StringBuffer s = new StringBuffer();
        for (float i : array) {
            s.append(delim + i);
        }

        return s.substring(delim.length());
    }

    /**
     * 将数组元素拼装成字符串，每个元素以指定的<code>delim</code>分隔。
     *
     * @param array the array
     * @param delim the delim
     * @return string
     */
    public static String join(short[] array, String delim) {
        if (array.length == 0) {
            return EMPTY_STRING;
        }

        StringBuffer s = new StringBuffer();
        for (short i : array) {
            s.append(delim + i);
        }

        return s.substring(delim.length());
    }

    /**
     * 将数组元素拼装成字符串，每个元素以指定的<code>delim</code>分隔。
     *
     * @param array the array
     * @param delim the delim
     * @return string
     */
    public static String join(char[] array, String delim) {
        if (array.length == 0) {
            return EMPTY_STRING;
        }

        StringBuffer s = new StringBuffer();
        for (char i : array) {
            s.append(delim + i);
        }

        return s.substring(delim.length());
    }

    /**
     * 将数组元素拼装成字符串，每个元素以指定的<code>delim</code>分隔。
     *
     * @param array          the array
     * @param delim          the delim
     * @param addSingleQuote 是否将每个数组元素以单引号包裹
     * @return string
     */
    public static String join(String[] array, String delim,
                              boolean addSingleQuote) {
        if (array.length == 0) {
            return EMPTY_STRING;
        }

        StringBuffer buf = new StringBuffer();
        for (String s : array) {
            if (addSingleQuote) {
                s = "'" + s + "'";
            }

            buf.append(delim + s);
        }

        return buf.substring(delim.length());
    }

    /**
     * Join string.
     *
     * @param array          the array
     * @param delim          the delim
     * @param addSingleQuote the add single quote
     * @return the string
     */
    public static String join(Integer[] array, String delim,
                              boolean addSingleQuote) {
        if (array.length == 0) {
            return EMPTY_STRING;
        }

        StringBuffer buf = new StringBuffer();
        for (Integer s : array) {
            if (addSingleQuote) {
                buf.append("'" + s + "'");
            }

            buf.append(delim);
        }

        return buf.substring(0, buf.length() - 1);
    }

    /**
     * 将字符"<",">"转义为"&lt;","&gt;"
     *
     * @param str the str
     * @return string
     */
    public static String escapeIllegalChars(String str) {
        if (org.apache.commons.lang.StringUtils.isBlank(str)) {
            return str;
        }

        return str.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    }

    /**
     * 去除给定内容中的换行、HTML标记、空格、script，style以及首尾空格转义符;
     *
     * @param richText the rich text
     * @return string
     */
    public static String removeHTML(String richText) {
        if (org.apache.commons.lang.StringUtils.isBlank(richText))
            return richText;

        return richText
                .replaceAll("[\\r\\n\\s]+", "")
                .replaceAll(
                        "(?i)<(script|style)[^>]*>([\\S\\s]*?)</(script|style)>",
                        "")
                .replaceAll("(?i)<img[^<>]*/?>([\\S\\s]*?)(</img>)?", "")
                .replaceAll("</?[^<>]+/?>", "")
                .replaceAll("(^(&nbsp;)*)|((&nbsp;)*$)", "");
    }

    /**
     * 去除给定内容中包含的script代码，以及CSS注入
     *
     * @param richText the rich text
     * @return string
     */
    public static String removeScripts(String richText) {
        if (org.apache.commons.lang.StringUtils.isBlank(richText))
            return richText;

        return richText
                .replaceAll(
                        "(?i)<(script|style|link|meta)[^>]*/?>([\\S\\s]*?)(</(script|style|link|meta)>)?",
                        "");
    }

    /**
     * 取得给定内容中包含的图片URL地址，并用逗号隔开
     *
     * @param html the html
     * @return string
     */
    public static String parseImageUrl(String html) {
        StringBuffer imgUrls = new StringBuffer();
        Pattern p = Pattern
                .compile("(?i)<img([^<>]+)src=['\"]?([^<>'\"]+[^/'\"]?)['\"]?([^<>]*)/?>([\\S\\s]*?)(</img>)?");
        Matcher m = p.matcher(html);
        while (m.find()) {
            imgUrls.append("," + m.group(2));
        }

        if (imgUrls.length() > 0) {
            return imgUrls.substring(1);
        }

        return org.apache.commons.lang.StringUtils.EMPTY;
    }

    /**
     * 功能描述: <br>
     * 〈功能详细描述〉
     *
     * @param value      the value
     * @param regexDelim the regex delim
     * @param a          the a
     * @return int [ ]
     */
    public static int[] toArray(String value, String regexDelim, int[] a) {
        if (org.apache.commons.lang.StringUtils.isBlank(value)) {
            return new int[0];
        }

        String[] array = value.split(regexDelim);
        if (a == null || array.length > a.length) {
            a = new int[array.length];
        } else {
            a = ArrayUtils.subarray(a, 0, array.length);
        }

        for (int i = 0; i < array.length; i++) {
            a[i] = Integer.parseInt(array[i]);
        }

        return a;
    }

    /**
     * 替换字符串中的换行符
     *
     * @param str the str
     * @return string
     */
    public static String removeLineBreak(String str) {
        if (org.apache.commons.lang.StringUtils.isNotBlank(str))
            str = str.replaceAll("\r", "").replaceAll("\n", "");
        return str;
    }

    /**
     * 判断字符串是否数字
     *
     * @param str the str
     * @return boolean
     * @author huangshaokang
     */
    public  boolean isNumber(String str) {
        for (int i = 0; i < str.length(); i++) {
            if (!Character.isDigit(str.charAt(i)))
                return false;
        }
        return true;
        }

    public static String stringNull(String o){
        if(o==null){
            return "";
        }else{
            return o;
        }
    }

    public static Object objectNull(Object o){
        if(o==null){
            return "";
        }else{
            return o;
        }
    }
}
