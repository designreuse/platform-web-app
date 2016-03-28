package com.aladdin.platform.taglibs;

import org.springframework.web.servlet.tags.RequestContextAwareTag;

import java.util.Properties;

public class FWConfigTag extends RequestContextAwareTag {

    private String key;

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    @Override
    protected int doStartTagInternal() throws Exception {
        Properties properties = (Properties) this.getRequestContext().getWebApplicationContext().getBean("fwConfig");
        if (properties != null) {
            this.pageContext.getOut().write(properties.getProperty(key));
        }
        return SKIP_BODY;
    }
}
