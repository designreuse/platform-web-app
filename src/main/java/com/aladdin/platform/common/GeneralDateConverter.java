package com.aladdin.platform.common;

import org.springframework.context.i18n.LocaleContextHolder;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

public class GeneralDateConverter {
    protected Map<String, String> styleMap;

    public void setStyleMap(Map<String, String> styleMap) {
        this.styleMap = styleMap;
    }

    public String format(Date date, String style) {
        if (date == null) {
            return "";
        }
        String pattern = styleMap.get(style);
        if (pattern == null) {
            throw new IllegalArgumentException("Style should be SHORT_DATE, DATE, DATE_HOUR, DATE_HOUR_SECOND, HOUR, HOUR_SECOND, BILL_DATE, BPO_DATE");
        }
        Locale locale = LocaleContextHolder.getLocale();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern, locale);

        return simpleDateFormat.format(date);
    }

    public Date parse(String val, String style) {
        if (val == null) {
            return null;
        }

        String pattern = styleMap.get(style);
        if (pattern == null) {
            throw new IllegalArgumentException("Style should be SHORT_DATE, DATE, DATE_HOUR, DATE_HOUR_SECOND, HOUR, HOUR_SECOND, BILL_DATE");
        }
        Locale locale = LocaleContextHolder.getLocale();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern, locale);

        try {
            return simpleDateFormat.parse(val);
        } catch (ParseException e) {
            throw new IllegalArgumentException("Parse date error. style is" + style, e);
        }
    }
}
