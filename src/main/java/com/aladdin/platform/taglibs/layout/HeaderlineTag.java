package com.aladdin.platform.taglibs.layout;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyTagSupport;
import java.io.IOException;
import java.io.StringWriter;

public class HeaderlineTag extends BodyTagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String pageTitle;

	public void setPageTitle(String pageTitle) {
		this.pageTitle = pageTitle;
	}

	@Override
	public int doEndTag() throws JspException {

		String homeUrl = this.pageContext.getServletContext().getContextPath();
		try {
			StringWriter bodyContent = new StringWriter();
			getBodyContent().writeOut(bodyContent);

			String headerHTML = "<div id='header_line' class='row-fluid'>"
					+ "    <div class='span6'>"
					+ "        <h3 class='page-title'>" + this.pageTitle
					+ "</h3>" + "    </div>" + "    <div class='span6'>"
					+ "        <a class='icon-home pull-right icon2x' href='"
					+ homeUrl + "'></a>";
			if (bodyContent != null) {
				headerHTML += bodyContent.toString();
			}
			headerHTML += "    </div></div>";

			this.pageContext.getOut().write(headerHTML);
		} catch (IOException e) {

			// TODO: log4j
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}
}
