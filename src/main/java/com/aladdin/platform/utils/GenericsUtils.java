package com.aladdin.platform.utils;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

/**
 * 泛型工具
 */
public class GenericsUtils {
    /**
     * 通过反射,获得定义Class时声明的父类的范型参数的类型.<br>
     * 如public CusCustomerDaoImpl extends DefaultDaoImpl&lt;CusCustomerEntity&gt;返回
     * <code>com.wl.app.valueobject.entity.crm.CusCustomerEntity</code>
     *
     * @param clazz             内省类
     * @return 第一个泛型参数类型, 当不能确定时，返回 <code>Object.class</code>
     */
    public static Class<?> getSuperClassGenricType(Class<?> clazz) {
        return getSuperClassGenricType(clazz, 0);
    }

    /**
     * 通过反射,获得定义Class时声明的父类的范型参数的类型.<br>
     * 如public CusCustomerDaoImpl extends DefaultDaoImpl&lt;CusCustomerEntity&gt;返回
     * <code>com.wl.app.valueobject.entity.crm.CusCustomerEntity</code>
     *
     * @param clazz             内省类
     * @param index             泛型参数索引，从0开始
     * @return 指定索引的泛型参数类型, 当不能确定时，返回 <code>Object.class</code>
     * @throws IndexOutOfBoundsException the index out of bounds exception
     */
    public static Class<?> getSuperClassGenricType(Class<?> clazz, int index) throws IndexOutOfBoundsException {

        Type genType = clazz.getGenericSuperclass();

        if (!(genType instanceof ParameterizedType)) {
            return Object.class;
        }

        Type[] params = ((ParameterizedType) genType).getActualTypeArguments();

        if (index >= params.length || index < 0) {
            return Object.class;
        }
        if (!(params[index] instanceof Class)) {
            return Object.class;
        }
        return (Class<?>) params[index];
    }
}