package com.aladdin.platform.taglibs;

import com.wl.framework.session.context.SessionContext;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import javax.annotation.Resource;

public class CurrentNickNameTag extends RequestContextAwareTag {
    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @Override
    protected int doStartTagInternal() throws Exception {
        pageContext.getOut().print(StringUtils.trimToEmpty(sessionContext.getLoginUser().getNickname()));
        return SKIP_BODY;
    }
}
