package com.aladdin.platform.taglibs.common;

import com.aladdin.platform.common.Page;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

public class IndexTag extends RequestContextAwareTag {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int index;
	private Page page;

	public void setIndex(int index) {
		this.index = index;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	@Override
	protected int doStartTagInternal() throws Exception {
		int result = index + 1 + (page.getCurrentPage() * page.getPageSize());
		pageContext.getOut().write(String.valueOf(result));

		return SKIP_BODY;
	}
}
