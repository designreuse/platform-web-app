package com.aladdin.platform.utils;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.NumberFormat;


/**
 * 数字格式化工具类
 * 〈功能详细描述〉
 *
 * @version [版本号, 2012-12-18]
 */
public class NumberFormatUtils {
    /**
     *
     */
    private static final NumberFormat nf = NumberFormat.getInstance();

    static {
        nf.setMinimumFractionDigits(2);
        nf.setMaximumFractionDigits(2);
    }


    /**
     * BigDecimal转换成String
     * 〈功能详细描述〉
     *
     * @param data the data
     * @return string string
     */
    public static String format(BigDecimal data) {
        if (data == null) {
            return "0";
        }
        nf.setGroupingUsed(true);
        return nf.format(data);
    }

    /**
     * BigDecimal转换成String
     * 〈功能详细描述〉
     *
     * @param data BigDecimal类型数据
     * @param fractionDigits the fraction digits
     * @param group the group
     * @param roundingMode the rounding mode
     * @return string string
     * @paran fractionDigits 最多保留几位有效小数
     * @paran group 是否分组
     * @paran roundingMode 舍入方式
     */
    public static String format(BigDecimal data,int fractionDigits, boolean group, RoundingMode roundingMode) {
        if (data == null) {
            return "0";
        }
        
        nf.setMaximumFractionDigits(fractionDigits);
        nf.setMinimumFractionDigits(2);

        nf.setGroupingUsed(group);
        nf.setRoundingMode(roundingMode);

        return nf.format(data);
    }

    /**
     * Format string.
     *
     * @param number the number
     * @param fractionDigits the fraction digits
     * @param group the group
     * @param roundingMode the rounding mode
     * @return the string
     */
    public static String format(Number number, int fractionDigits, boolean group, RoundingMode roundingMode) {
        if (number == null) {
            return "0";
        }
        NumberFormat nf = NumberFormat.getInstance();

        nf.setMaximumFractionDigits(fractionDigits);
        nf.setMinimumFractionDigits(2);

        nf.setGroupingUsed(group);
        nf.setRoundingMode(roundingMode);

        return nf.format(number);
    }

    /**
     * Format string.
     *
     * @param number the number
     * @return the string
     */
    public static String format(Number number) {
        return format(number, 2, true, RoundingMode.HALF_EVEN);
    }

    /**
     * Format string.
     *
     * @param number the number
     * @param fractionDigits the fraction digits
     * @return the string
     */
    public static String format(Number number, int fractionDigits) {
        return format(number, fractionDigits, true, RoundingMode.HALF_EVEN);
    }

    /**
     * Format string.
     *
     * @param number the number
     * @param group the group
     * @return the string
     */
    public static String format(Number number, boolean group) {
        return format(number, 2, group, RoundingMode.HALF_EVEN);
    }

    /**
     * Format string.
     *
     * @param number the number
     * @param fractionDigits the fraction digits
     * @param group the group
     * @return the string
     */
    public static String format(Number number, int fractionDigits, boolean group) {
        return format(number, fractionDigits, group, RoundingMode.HALF_EVEN);
    }

    /**
     * Format string.
     *
     * @param number the number
     * @param fractionDigits the fraction digits
     * @param minimumFractionDigits the minimum fraction digits
     * @param group the group
     * @return the string
     */
    public static String format(Number number, int fractionDigits, int minimumFractionDigits, boolean group) {
        return format(number, fractionDigits,minimumFractionDigits, group, RoundingMode.HALF_UP);
    }

    /**
     * Format string.
     *
     * @param number the number
     * @param fractionDigits the fraction digits
     * @param minimumFractionDigits the minimum fraction digits
     * @param group the group
     * @param roundingMode the rounding mode
     * @return the string
     */
    public static String format(Number number, int fractionDigits,int minimumFractionDigits, boolean group, RoundingMode roundingMode) {
        if (number == null) {
            return "0";
        }
        NumberFormat nf = NumberFormat.getInstance();

        nf.setMaximumFractionDigits(fractionDigits);
        nf.setMinimumFractionDigits(minimumFractionDigits);
        nf.setGroupingUsed(group);
        nf.setRoundingMode(roundingMode);

        return nf.format(number);
    }

    /**
     * The entry point of application.
     *
     * @param args the input arguments
     */
    public static void main(String[] args) {
		String x=format(0.05, 2, 2, true, RoundingMode.HALF_EVEN);
		System.out.println(x);
	}
}

