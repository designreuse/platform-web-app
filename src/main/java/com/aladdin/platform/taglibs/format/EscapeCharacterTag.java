package com.aladdin.platform.taglibs.format;

import org.springframework.web.servlet.tags.RequestContextAwareTag;

public class EscapeCharacterTag extends RequestContextAwareTag {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * value表示待转义字符
	 */
	private String value;

	@Override
	protected int doStartTagInternal() throws Exception {

		pageContext.getOut().write(this.formatStringToHtml(value));
		return SKIP_BODY;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String formatStringToHtml(String str) {
		if (str != null) {
			str = str.replaceAll(" ", "&nbsp;");
			str = str.replaceAll("<", "&lt;");
			str = str.replaceAll(">", "&gt;");
			str = str.replaceAll("\"", "&quot;");
			str = str.replaceAll("\n".toString(), "<br>");
		}
		return str;
	}
}
