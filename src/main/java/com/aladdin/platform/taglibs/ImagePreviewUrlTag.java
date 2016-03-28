package com.aladdin.platform.taglibs;

import com.aladdin.platform.utils.StringUtils;
import org.springframework.web.servlet.tags.RequestContextAwareTag;


import java.util.Properties;

public class ImagePreviewUrlTag extends RequestContextAwareTag {

	private String resourcecode;
    private Integer width;
    private Integer height;
    private String scale;

	public void setResourcecode(String resourcecode) {
		this.resourcecode = resourcecode;
	}

    public void setWidth(Integer width) {
        this.width = width;
    }

    public void setHeight(Integer height) {
        this.height = height;
    }

    public void setScale(String scale) {
        this.scale = scale;
    }

    @Override
    protected int doStartTagInternal() throws Exception {
    	if(StringUtils.isEmpty(resourcecode)) {
    		this.pageContext.getOut().write("资源编码为空!");
            return SKIP_BODY;
    	}
        Properties properties = (Properties) this.getRequestContext().getWebApplicationContext().getBean("fwConfig");
        StringBuilder sb = new StringBuilder();
        sb.append(properties.get("common.resource.site"))
                .append("/preview/")
                .append(resourcecode);
        if (this.width != null && this.height != null) {
            sb.append("?")
                    .append("w=")
                    .append(this.width)
                    .append("&")
                    .append("h=")
                    .append(this.height);

        }
        if (scale != null) {
            if (sb.lastIndexOf("?") < 0) {
                sb.append("?");
            }
            sb.append("scale=").append(scale);
        }
        this.pageContext.getOut().write(sb.toString());
        return SKIP_BODY;
    }
}
