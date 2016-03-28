package com.aladdin.platform.taglibs.common;

import com.aladdin.platform.common.Page;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

public class PaginationTag extends RequestContextAwareTag {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// protected String baseUrl;
	// 总数
	protected long totalElements;
	// 每页数量
	protected int size;
	// 总页数
	protected int totalPages;
	// 当前页数
	protected int number;

	protected int showBefore = 3;

	protected boolean hideInfo;

	// public void setBaseUrl(String baseUrl) {
	// this.baseUrl = baseUrl;
	// }

	public void setPage(Page page) {
		this.totalElements = page.getRecords();
		this.size = page.getPageSize();
		this.totalPages = page.getPages();
		// page 对象的number默认从0开始，为了统一，我们将其值加1
		this.number = page.getCurrentPage();
	}

	public void setTotalElements(long totalElements) {
		this.totalElements = totalElements;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public void setShowBefore(int showBefore) {
		this.showBefore = showBefore;
	}

	public void setHideInfo(boolean hideInfo) {
		this.hideInfo = hideInfo;
	}

	@Override
	protected int doStartTagInternal() throws Exception {
		pageContext.getOut().write(paginationCode());
		return SKIP_BODY;
	}

	protected String paginationCode() throws Exception {
		int startPage = determineStartPage(number);
		int endPage = determineEndPage(startPage, totalPages);

		Integer prev = (number > 1) ? (number - 1) : 0;
		Integer next = (number < totalPages) ? (number + 1) : number;
		StringBuilder sb = new StringBuilder();

		if (!hideInfo) {
			sb.append("<div class=\"span4\">");
			sb.append("<div class=\"dataTables_info\">");
			sb.append(resolveLabel("common.pagination.show"));
			sb.append(((number - 1) * size + 1) + "-");
			sb.append((number * size) > totalElements ? totalElements
					: (number * size));
			sb.append(", ");
			sb.append(resolveLabel("common.pagination.total"));
			sb.append(totalElements);
			sb.append(resolveLabel("common.pagination.unit"));
			sb.append("</div>");
			sb.append("</div>");
		}

		sb.append(!hideInfo ? "<div class=\"span8\">"
				: "<div class=\"span12\">");
		sb.append("<div class=\"dataTables_paginate paging_bootstrap pagination\">");

		if (prev == 0) {
			sb.append("<ul><li class='prev disabled'><a href='#'>←"
					+ resolveLabel("common.pagination.prev") + "</a></li>");
		} else {
			sb.append("<ul><li><a href='" + buildHrefAttribute(prev) + "' >←"
					+ resolveLabel("common.pagination.prev") + "</a></li>");
		}

		if (startPage != 1) {
			sb.append("<li><a href='" + buildHrefAttribute(1) + "' >1"
					+ "</a></li>");
			if (startPage != 2)
				sb.append("<li><a href='#' >...</a></li>");
		}

		for (int index = startPage; index <= endPage; index++) {
			String css;
			String href = buildHrefAttribute(index);
			if (index == number) {
				css = "active";
				href = "#";
			} else {
				css = "";
			}
			sb.append("<li class=\"" + css + "\"><a  href='" + href + "' >"
					+ index + "</a></li>");
		}

		if (endPage < totalPages) {
			if (endPage != (totalPages - 1))
				sb.append("<li><a href='#' >...</a></li>");
			sb.append("<li><a  href='" + buildHrefAttribute(totalPages) + "' >"
					+ totalPages + "</a></li>");
		}

		if (next.equals(number)) {
			sb.append("<li class=\"next disabled\"><a href='#'>"
					+ resolveLabel("common.pagination.next") + "→</a></li>");
		} else {
			sb.append("<li class=\"next\"><a href='" + buildHrefAttribute(next)
					+ "' >" + resolveLabel("common.pagination.next")
					+ "→</a></li>");
		}
		sb.append("</ul>");
		sb.append("</div>");
		sb.append("</div>");
		return sb.toString();
	}

	protected int determineStartPage(int pageNumber) {
		int startPage;
		if (pageNumber - showBefore >= 1) {
			startPage = pageNumber - showBefore;
		} else {
			startPage = 1;
		}
		return startPage;
	}

	protected int determineEndPage(int startPage, int totalPages) {
		int endPage;
		endPage = startPage + 5;
		if (endPage > totalPages) {
			endPage = totalPages;
		}
		return endPage;
	}

	protected String buildHrefAttribute(int number) {
		return "javascript:turn2Page(" + number + ");";
	}

	public String resolveLabel(String label) {
		MessageSource messageSource = getRequestContext().getMessageSource();
		return messageSource.getMessage(label, null, getRequestContext()
				.getLocale());
	}
}
