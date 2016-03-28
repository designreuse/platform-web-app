package com.aladdin.platform.taglibs.common;

public class AjaxPaginationTag extends PaginationTag {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected String baseUrl;

	protected String contextSel;

	public void setContextSel(String contextSel) {
		this.contextSel = contextSel;
	}

	public void setBaseUrl(String baseUrl) {
		this.baseUrl = baseUrl;
	}

	@Override
	protected String buildHrefAttribute(int number) {
		StringBuilder builder = new StringBuilder();
		builder.append("javascript:ajaxTurn2Page(\"" + contextSel + "\", \""
				+ baseUrl + "\", " + number + ");");
		return builder.toString();
	}
}
