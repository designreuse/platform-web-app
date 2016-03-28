package com.aladdin.platform.taglibs;

import com.aladdin.platform.common.GeneralDateConverter;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import java.util.Date;

public class DateFormatTag extends RequestContextAwareTag {
    private String style;
    private Date date;

    public void setStyle(String style) {
        this.style = style;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    protected int doStartTagInternal() throws Exception {
        GeneralDateConverter converter = (GeneralDateConverter) getRequestContext().getWebApplicationContext().getBean("generalDateConverter");
        String result = converter.format(date, style);
        pageContext.getOut().write(result);
        return SKIP_BODY;
    }
}
