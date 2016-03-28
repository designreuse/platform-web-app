package com.aladdin.platform.common;

import com.wl.framework.permission.support.IPermissionDisplay;
import org.apache.shiro.util.StringUtils;
import org.apache.shiro.web.util.WebUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 默认权限部分展示，包含登录失败，鉴权失败的展示
 *
 * Created by zhuyi on 2015/6/15.
 */
public class AldPermissionDisplay implements IPermissionDisplay {

    @Override
    public void displayUnauthorized(HttpServletRequest request, HttpServletResponse response, String unauthorizedUrl) throws IOException {
        //SHIRO-142 - ensure that redirect _or_ error code occurs - both cannot happen due to response commit:
        if (StringUtils.hasText(unauthorizedUrl)) {
            WebUtils.issueRedirect(request, response, unauthorizedUrl);
        } else {
            WebUtils.toHttp(response).sendError(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }

    @Override
    public void displayNotLogin(HttpServletRequest request, HttpServletResponse response, String notLoginUrl) throws IOException {
        if (StringUtils.hasText(notLoginUrl)) {
            WebUtils.saveRequest(request);
            WebUtils.issueRedirect(request, response, notLoginUrl);
        } else {
            WebUtils.toHttp(response).sendError(HttpServletResponse.SC_UNAUTHORIZED);
        }
    }
}
