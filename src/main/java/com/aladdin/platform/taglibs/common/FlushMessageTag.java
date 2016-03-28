package com.aladdin.platform.taglibs.common;



import com.aladdin.platform.utils.ErrorObject;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.util.List;

public class FlushMessageTag extends TagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public int doEndTag() throws JspException {
		String message = (String) this.pageContext.getRequest().getAttribute(
				"message");
		List<ErrorObject> errors = (List<ErrorObject>) this.pageContext
				.getRequest().getAttribute("errors");

		if (message != null && message.length() > 0) {
			StringBuilder sb = new StringBuilder();
			sb.append("<div class='alert alert-success'>");
			sb.append("<i class='icon-remove close' data-dismiss='alert'></i>");
			sb.append(message);
			sb.append("</div>");
			try {
				this.pageContext.getOut().write(sb.toString());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		StringBuilder sb = new StringBuilder();
		boolean hasError = errors != null && errors.size() > 0;
		sb.append("<div class='alert alert-error' "
				+ (hasError ? "" : "style='display:none;'") + ">");
		sb.append("<i class='icon-remove close' data-dismiss='alert'></i>");
		sb.append("<ul class='error_container'>");
		if (hasError) {
			for (ErrorObject errorObject : errors) {
				sb.append("<li>");
				sb.append(errorObject.getMessage());
				sb.append("</li>");
			}
		}
		sb.append("</ul>");
		sb.append("</div>");
		try {
			this.pageContext.getOut().write(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SKIP_BODY;
	}
}
