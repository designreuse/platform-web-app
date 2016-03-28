package com.aladdin.platform.taglibs.layout;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

public class HeadericonTag extends TagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String iconCls;

	private String iconAction;

	private String title;

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public void setIconAction(String iconAction) {
		this.iconAction = iconAction;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public int doEndTag() throws JspException {
		try {
			if(title!=null&&!"".equals(title.trim())){
				this.pageContext.getOut().write(
						"<a href='" + iconAction + "' class='icon2x pull-right "
								+ iconCls + "' title='" + title + "'></a>");
			}else{
				this.pageContext.getOut().write(
						"<a href='" + iconAction + "' class='icon2x pull-right "
								+ iconCls + "'></a>");
			}
			
		} catch (IOException e) {
			// TODO: log4j -- joe
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}
}
