package com.aladdin.platform.taglibs;

import org.springframework.web.servlet.tags.RequestContextAwareTag;

public class NickNameTag extends RequestContextAwareTag {
    private Long userId;

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    @Override
    protected int doStartTagInternal() throws Exception {
//        IFrameworkService userExtendInfoService = getRequestContext().getWebApplicationContext().getBean(IFrameworkService.class);
//        UserExtendInfoEntity user = userExtendInfoService.findUserExtendInfoByUserId(userId);
//        String name;
//        if (user != null) {
//            name = user.getNickName();
//            // 如果显示名不存在，则使用其用户名
//        } else {
//            name = "";
//        }
        //todo
        pageContext.getOut().write("todo");
        return SKIP_BODY;
    }
}
