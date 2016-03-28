package com.aladdin.platform.taglibs;

public abstract class AbstractEnumRedioTag<T extends Enum<?>> extends
        AbstractRadioTag<T> {

    private static final long serialVersionUID = 1L;

    @Override
    protected Object getRadioValue(T obj) {
        return obj;
    }
}
