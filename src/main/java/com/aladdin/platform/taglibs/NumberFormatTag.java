package com.aladdin.platform.taglibs;
import com.aladdin.platform.utils.NumberFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.math.BigDecimal;

public class NumberFormatTag extends TagSupport {

    private static final Logger LOGGER = LoggerFactory.getLogger(NumberFormatTag.class);

    private Object number;

    private Boolean group = Boolean.TRUE;

    private Integer fractionDigits = 2;
    
    private Integer minimumFractionDigits=2;


	@Override
    public int doEndTag() throws JspException {


        try {
            Number num = 0;
            if (this.number != null) {
                if (this.number instanceof Number) {
                    num = (Number) this.number;
                } else {
                    num = new BigDecimal(this.number.toString());
                }
                String numberStr = NumberFormatUtils.format(num, this.fractionDigits, this.minimumFractionDigits, this.group);
                this.pageContext.getOut().write(numberStr);
            }
        } catch (IOException e) {
            LOGGER.error("Error occurred while number formatting:", e);
        }
        return SKIP_BODY;
    }

    public Object getNumber() {
        return number;
    }

    public void setNumber(Object number) {
        this.number = number;
    }

    public Boolean getGroup() {
        return group;
    }

    public void setGroup(Boolean group) {
        this.group = group;
    }

    public Integer getFractionDigits() {
        return fractionDigits;
    }

    public void setFractionDigits(Integer fractionDigits) {
        this.fractionDigits = fractionDigits;
    }
    public Integer getMinimumFractionDigits() {
		return minimumFractionDigits;
	}

	public void setMinimumFractionDigits(Integer minimumFractionDigits) {
		this.minimumFractionDigits = minimumFractionDigits;
	}
}
