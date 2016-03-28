package com.aladdin.platform.taglibs.layout;

import org.apache.commons.lang.StringUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import java.io.IOException;
import java.io.StringWriter;
import java.util.Date;

public class MagneticLiTag extends BodyTagSupport {

	public void setLoadOnStart(boolean loadOnStart) {
		this.loadOnStart = loadOnStart;
	}

	private String id;

    private String cls;

    private String style;

    private String remoteContentUrl;

    private boolean loadOnStart = false;

    private boolean autoRefresh = false;

    @Override
    public int doEndTag() throws JspException {
        StringWriter bodyWriter = new StringWriter();
        try {
            if (this.getBodyContent() != null) {
                this.getBodyContent().writeOut(bodyWriter);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        boolean hasRemote = !StringUtils.isEmpty(this.remoteContentUrl);
		String realRemoteContentUrl = " ";
		if (hasRemote) {
			realRemoteContentUrl = StringUtils.trimToEmpty(remoteContentUrl);
			if (-1 < realRemoteContentUrl.indexOf('?')) {
				realRemoteContentUrl += "&timestamp=" + new Date().getTime();
			} else {
				realRemoteContentUrl += "?timestamp=" + new Date().getTime();
			}
		}
        StringBuilder builder = new StringBuilder();
        builder.append("<li "
                + "id='"
                + StringUtils.trimToEmpty(this.id)
                + "' class='outer relative "
                + StringUtils.trimToEmpty(cls)
                + "' style='"
                + StringUtils.trimToEmpty(style)
                + "' "
				+ "data-remote-url = '" + realRemoteContentUrl + "'"
                + (autoRefresh ? " data-auto-refresh = 'true'" : " ")
                + (loadOnStart ? " data-load-on-start = 'true'" : " ")
                + "> ");
        builder.append(StringUtils.trimToEmpty(bodyWriter.toString()));
        builder.append("</li>");

        try {
            pageContext.getOut().write(builder.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }

        return EVAL_BODY_INCLUDE;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setCls(String cls) {
        this.cls = cls;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public void setRemoteContentUrl(String remoteContentUrl) {
        this.remoteContentUrl = remoteContentUrl;
    }

    public void setAutoRefresh(boolean autoRefresh) {
        this.autoRefresh = autoRefresh;
    }
}
