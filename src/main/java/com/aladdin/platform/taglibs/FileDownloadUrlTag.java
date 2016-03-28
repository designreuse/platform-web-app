package com.aladdin.platform.taglibs;

import org.springframework.web.servlet.tags.RequestContextAwareTag;

import java.util.Properties;

public class FileDownloadUrlTag extends RequestContextAwareTag {

    private String resourcecode;

    public void setResourcecode(String resourcecode) {
		this.resourcecode = resourcecode;
	}

	@Override
    protected int doStartTagInternal() throws Exception {
        Properties properties = (Properties) this.getRequestContext().getWebApplicationContext().getBean("fwConfig");
        StringBuilder sb = new StringBuilder();
        sb.append(properties.get("common.resource.site"))
                .append("/file/")
                .append(resourcecode);
        this.pageContext.getOut().write(sb.toString());
        return SKIP_BODY;
    }
}
