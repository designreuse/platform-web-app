package com.aladdin.platform.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.WebRequest;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WebUtils {
    private static Logger LOGGER = LoggerFactory
            .getLogger(WebUtils.class);
    /**
     * Gets ip addr.
     *
     * @param request the request
     * @return the ip addr
     */
    public static String getIpAddr(HttpServletRequest request) {

//        String ip = request.getHeader("x-forwarded-for");
        String ip= request.getHeader("X-Real-IP");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("x-forwarded-for");
        }

        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }

        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }

        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    public static boolean isAjaxRequest(ServletRequest request) {
        String requestType = ((HttpServletRequest) request).getHeader("X-Requested-With");
        return "XMLHttpRequest".equalsIgnoreCase(requestType);
    }
    public static boolean isAjaxRequest(WebRequest request) {
        String requestType = request.getHeader("X-Requested-With");
        return "XMLHttpRequest".equalsIgnoreCase(requestType);
    }

    public static boolean isMobileRequest(HttpServletRequest request){
        String requestType = request.getHeader("X-Mobile-With");
        return "MobileHttpRequest".equalsIgnoreCase(requestType);
    }

    public static String getReferer(HttpServletRequest request) {
        return request.getHeader("Referer");
    }

    public static void sendForbidden(ServletRequest request, ServletResponse response) {
        org.apache.shiro.web.util.WebUtils.toHttp(response).setStatus(HttpServletResponse.SC_FORBIDDEN);
    }

    public static void sendOk(ServletRequest request, ServletResponse response) {
        org.apache.shiro.web.util.WebUtils.toHttp(response).setStatus(HttpServletResponse.SC_OK);
    }

    public static void sendUnauthorized(ServletRequest request, ServletResponse response) {
        org.apache.shiro.web.util.WebUtils.toHttp(response).setStatus(HttpServletResponse.SC_UNAUTHORIZED);
    }

    public static boolean isSessionTimeout(ServletRequest request, ServletResponse response) {
        HttpServletRequest httpServletRequest = org.apache.shiro.web.util.WebUtils.toHttp(request);
        if (httpServletRequest != null) {
            return httpServletRequest.getRequestedSessionId() != null && httpServletRequest.isRequestedSessionIdValid();
        }

        return false;
    }

    public static void removeCookieFromRequest(String cookieName,final HttpServletResponse response,final HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                if (cookieName.equals(cookies[i].getName())) {
                    Cookie cookie = new Cookie(cookies[i].getName(), null);
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    cookie.setDomain("wl.com");
                    response.addCookie(cookie);
                }
            }
        }
    }

    public static String getCookieFromRequest(final HttpServletRequest request,String cookieName) {
        final Cookie cookie = org.springframework.web.util.WebUtils.getCookie(
                request, cookieName);
        return cookie == null ? null : cookie.getValue();
    }
}

