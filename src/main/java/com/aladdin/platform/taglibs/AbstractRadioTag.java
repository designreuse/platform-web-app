package com.aladdin.platform.taglibs;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.MessageSource;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import java.util.List;

public abstract class AbstractRadioTag<T> extends RequestContextAwareTag {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private String name;
    private String style;
    private boolean required = false;
    private String value;
    private String clazz = "";
    private boolean disabled = false;
    private boolean readonly = false;
    private boolean inline = true;

    protected String getName() {
        if (name == null) {
            return getDefaultName();
        }
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public boolean isRequired() {
        return required;
    }

    public void setRequired(boolean required) {
        this.required = required;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getClazz() {
        return clazz;
    }

    public void setClazz(String clazz) {
        this.clazz = clazz;
    }

    public boolean isDisabled() {
        return disabled;
    }

    public void setDisabled(boolean disabled) {
        this.disabled = disabled;
    }

    public boolean getInline() {
        return inline;
    }

    public void setInline(boolean inline) {
        this.inline = inline;
    }

    protected abstract String getDefaultName();

    protected WebApplicationContext getApplicationContext() {
        return getRequestContext().getWebApplicationContext();
    }

    protected MessageSource getMessageSource() {
        return getRequestContext().getMessageSource();
    }

    protected abstract List<T> getList();

    protected abstract Object getRadioValue(T obj);

    protected abstract String getRadioLabel(T obj);

    @Override
    protected int doStartTagInternal() throws Exception {
        StringBuilder builder = new StringBuilder();
        if (getInline()) {
            builder.append(" <span class=\"inline\">");
        }

        List<T> list = getList();
        for (int i = 0; i < list.size(); i++) {
            StringBuilder finalClazz = new StringBuilder(getClazz());
            T t = list.get(i);
            builder.append("<label class=\"radio\">");
            builder.append("<input type=\"radio\" name=\"" + getName()
                    + "\" value=\"" + getRadioValue(t) + "\"");
            // 因为getValue获取的是String，所有要用String来比较
            if (("" + getRadioValue(t)).equals(getValue())) {
                builder.append(" checked ");
            }
            if (isRequired() && i == 0) {
                builder.append(" required ");
                finalClazz.append(" required ");
            }
            if (finalClazz.length() > 0) {
                builder.append(" class=\"" + finalClazz.toString() + "\" ");
            }
            if (StringUtils.isNotBlank(getStyle())) {
                builder.append(" style=\"" + getStyle() + "\" ");
            }
            if (isDisabled()) {
                builder.append(" disabled ");
            }
            if (isReadonly()) {
                builder.append(" readonly=\"readonly\" ");
            }
            builder.append("> ");
            builder.append(getRadioLabel(t));
            builder.append("</label>");
            builder.append("\r\n");
        }

        if (getInline()) {
            builder.append("</span>");
        }
        pageContext.getOut().write(builder.toString());
        return SKIP_BODY;
    }

    /**
     * @return the readonly
     */
    public boolean isReadonly() {
        return readonly;
    }

    /**
     * @param readonly
     *            the readonly to set
     */
    public void setReadonly(boolean readonly) {
        this.readonly = readonly;
    }
}
