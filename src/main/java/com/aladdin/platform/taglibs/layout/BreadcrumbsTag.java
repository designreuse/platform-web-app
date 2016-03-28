package com.aladdin.platform.taglibs.layout;

import org.springframework.web.servlet.tags.RequestContextAwareTag;

public class BreadcrumbsTag extends RequestContextAwareTag {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected int doStartTagInternal() throws Exception {
		// pageContext.getOut().write("<ul class='breadcrumb'><li><i class='icon-home'></i><a href='"
		// + pageContext.getServletContext().getContextPath() + "'>Home</a>");
		// pageContext.getOut().write("<i class='icon-angle-right'></i>");
		// pageContext.getOut().write("</li>");
		// pageContext.getOut().write("</ul>");

		return SKIP_BODY;
	}
}
