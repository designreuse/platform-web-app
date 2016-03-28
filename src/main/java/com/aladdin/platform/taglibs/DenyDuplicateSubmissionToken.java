package com.aladdin.platform.taglibs;



import com.aladdin.platform.constans.Constants;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.concurrent.atomic.AtomicLong;

/**
 * 〈一句话功能简述〉<br>
 * 〈功能详细描述〉
 *
 * @version [版本号, 2012-12-18]
 */
public class DenyDuplicateSubmissionToken extends SimpleTagSupport {

	/**
	 */
	private String name;

	/**
	 */
	private String value;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	/**
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.jsp.tagext.SimpleTagSupport#doTag()
	 */
	@Override
	public void doTag() throws JspException, IOException {
		PageContext pc = (PageContext) this.getJspContext();
		JspWriter out = pc.getOut();
		AtomicLong token = new AtomicLong(System.currentTimeMillis());
		pc.getSession().setAttribute(Constants.TRANSACTION_TOKEN_KEY, token);
		out.println("<input type='hidden' value='" + token.get()
				+ "' name='"+ Constants.TOKEN_KEY+"'>");

	}
}
