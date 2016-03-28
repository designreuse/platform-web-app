package com.aladdin.platform.taglibs.layout;

import org.apache.commons.lang.StringUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import java.io.IOException;
import java.io.StringWriter;


public class MagneticTag extends BodyTagSupport {

	/**
     *
     */
	private static final long serialVersionUID = 1L;

	private String id;

	private String iconCls;

	private String cls;

	private String style;

	private String targetLinkUrl;

	private String targetLinkText;

	private boolean sortable = true;

	private String remoteContentUrl;

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
		StringBuilder builder = new StringBuilder();
		builder.append("<li id='"
				+ StringUtils.trimToEmpty(this.id)
				+ "' class='");
		if (StringUtils.isNotEmpty(targetLinkUrl)) {
			builder.append("pointer ");
		}
		builder.append(StringUtils.trimToEmpty(cls)
				+ (sortable ? " sortable ui-sortable" : "")
				+ "' style='"
				+ StringUtils.trimToEmpty(style)
				+ "' "
				+ (hasRemote ? "data-remote-url='"
						+ StringUtils.trimToEmpty(this.remoteContentUrl)
						+ "' data-load-on-start='true' " : ""));
		if (StringUtils.isNotEmpty(targetLinkUrl)) {
		builder.append(" onclick='window.location=\"" + targetLinkUrl + "\"' ");
		}
		builder.append(">");
		if (!StringUtils.isEmpty(targetLinkUrl)
				&& !StringUtils.isEmpty(targetLinkText)) {
			builder.append("<a class='menu-link' href='"
					+ StringUtils.trimToEmpty(targetLinkUrl) + "'>"
					+ StringUtils.trimToEmpty(targetLinkText) + "</a>");
		} else if (StringUtils.isEmpty(targetLinkUrl)
				&& !StringUtils.isEmpty(targetLinkText)) {
			builder.append("<span class='menu-link'>"
					+ StringUtils.trimToEmpty(targetLinkText) + "</span>");
		}
		builder.append("<ul class='tile-group unstyled relative'>");
		builder.append(bodyWriter.toString());
		builder.append("</ul>");
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

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public void setCls(String cls) {
		this.cls = cls;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public void setTargetLinkUrl(String targetLinkUrl) {
		this.targetLinkUrl = targetLinkUrl;
	}

	public void setTargetLinkText(String targetLinkText) {
		this.targetLinkText = targetLinkText;
	}

	public void setSortable(boolean sortable) {
		this.sortable = sortable;
	}

	public void setRemoteContentUrl(String remoteContentUrl) {
		this.remoteContentUrl = remoteContentUrl;
	}
}
