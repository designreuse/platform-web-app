package com.aladdin.platform.taglibs;

import com.aladdin.platform.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.math.BigDecimal;

public class FileSizeFormatTag extends TagSupport {

    private Object fileSize;

    private static final Logger LOGGER = LoggerFactory.getLogger(FileSizeFormatTag.class);


    @Override
    public int doStartTag() throws JspException {

        try {
            Number num = 0;
            if (this.fileSize != null) {
                if (this.fileSize instanceof Number) {
                    num = (Number) this.fileSize;
                } else {
                    num = new BigDecimal(this.fileSize.toString());
                }
            }

            this.pageContext.getOut().write(StringUtils.formatFileSize(num));
        } catch (IOException e) {
            LOGGER.error("Error occurred while number formatting.", e);
        }

        return SKIP_BODY;
    }


    public Object getFileSize() {
        return fileSize;
    }

    public void setFileSize(Object fileSize) {
        this.fileSize = fileSize;
    }
}
