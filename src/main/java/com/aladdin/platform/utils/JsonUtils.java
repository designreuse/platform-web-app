/**
 * Description: <类功能描述-必填> 
 * Copyright:   Copyright (c)2012  
 * Company:     cloudy
 * @author: cloudy
 * @version: 1.0
 * Create at:   2012-12-21 下午4:22:51  
 *
 * Modification History:  
 * Date         Author      Version     Description  
 * ------------------------------------------------------------------  
 * 2012-12-21   cloudy      1.0       如果修改了;必填
 */
package com.aladdin.platform.utils;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.StringWriter;
import java.nio.charset.Charset;

/**
 * JSON帮助工具包
 * 〈功能详细描述〉
 *
 * @author cloudy
 * @version [版本号, 2012-12-17]
 */
public class JsonUtils {

    private static final Logger logger = LoggerFactory.getLogger(JsonUtils.class);
    /*
        public static String toJson(Object obj) {
            String s = castToJson(obj);
            if (s != null) {
                return s;
            } else {
                return toJson(getAttributes(obj));
            }
        }
    */
    private final static ObjectMapper objectMapper = new ObjectMapper();

    static {
        objectMapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
        objectMapper.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
        objectMapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
        objectMapper.disable(SerializationFeature.FAIL_ON_EMPTY_BEANS);
    }

    /**
     * To json.
     *
     * @param obj the obj
     * @return the string
     */
    public static String toJson(Object obj) {
        if (obj == null) return "";
        try {
            StringWriter sw = new StringWriter();
            objectMapper.writeValue(sw, obj);
            return sw.toString();
        } catch (IOException e) {
            logger.error("Failed to generate json:", e);
        }

        return "";
    }

    /**
     * From json.
     *
     * @param json        the json
     * @param targetClass the target class
     * @return the t
     */
    public static <T> T fromJson(String json, Class<T> targetClass) {
        T target = null;

        try {
            target = objectMapper.readValue(json.getBytes(Charset.forName("utf8")), targetClass);
        } catch (IOException e) {
            logger.error("Failed to read from json:", e);
        }

        return target;
    }

}
