package com.aladdin.platform.taglibs;

import com.aladdin.platform.taglibs.menu.Menu;
import com.aladdin.platform.taglibs.menu.MenuBuilder;
import com.wl.framework.permission.entity.MenuEntity;
import com.wl.framework.permission.service.impl.PermissionService;
import com.wl.framework.session.context.SessionContext;
import com.wl.framework.session.context.impl.SessionContextImpl;
import com.wl.framework.session.domain.LoginUser;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Properties;

public class MenuTag extends RequestContextAwareTag {

    private static final long serialVersionUID = -4294919944455645180L;

    private String theme;

    private Boolean includeRoot = Boolean.TRUE;

    private String id;

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public Boolean getIncludeRoot() {
        return includeRoot;
    }

    public void setIncludeRoot(Boolean includeRoot) {
        this.includeRoot = includeRoot;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    protected int doStartTagInternal() throws Exception {
        ApplicationContext context = this.getRequestContext().getWebApplicationContext();
        SessionContextImpl sessionContext = (SessionContextImpl)context.getBean("fwSessionContext");
        PermissionService fwPermissionService = (PermissionService)context.getBean("fwPermissionService");
        LoginUser user = sessionContext.getLoginUser();
        Properties properties = (Properties) context.getBean("sysConfig");
        String applicationCode = properties.getProperty("base.app.code");
        List<MenuEntity> menuEntities = fwPermissionService.getMenuList(user.getUserId(), applicationCode);

        HttpServletRequest httpServletRequest = (HttpServletRequest) pageContext.getRequest();
        String contextPath = httpServletRequest.getContextPath();

        String html = "";
        html = generateMenuForOperation(contextPath, MenuBuilder.build(applicationCode, menuEntities, contextPath));

        pageContext.getOut().write(html == null ? "" : html);
        return SKIP_BODY;
    }

    private String generateMenuForOperation(String contextPath, Menu parent) {
        StringBuilder builder = new StringBuilder();

        if (parent.isRoot()) {

            builder.append("<div class='menu_dropdown bk_2'>");
//                    .append("<ul class='lm-parent' id='" + id + "'>");

            for (Menu menu : parent.getChildren()) {
                builder.append(generateMenuForOperation(contextPath, menu));
            }

        }

        if (!parent.isRoot()) {
            //如果是叶节点
            if (!parent.hasChildren()) {

                builder.append("<dl>");
                if (StringUtils.isNotEmpty(parent.getPath())) {
                    //如果是地图监控的新开页面 ---wangwenyi
                    if("地图监控".equals(parent.getName())) {
                        builder
                                .append("<a style='padding-left:20px' href='")
                                .append(contextPath)
                                .append(parent.getPath())
                                .append("' target='_blank'>")
                                .append(parent.getName())
                                .append("</a>");
                    }else if("首页".equals(parent.getName())){
                        builder.append("<a style='padding-left:20px' href='")
                                .append(contextPath)
                                .append(parent.getPath())
                                .append("'>")
                                .append(parent.getName())
                                .append("</a>");
                    }else{
                        builder.append("<a style='padding-left:20px' _href='")
                                .append(contextPath)
                                .append(parent.getPath())
                                .append("' href='javascript:void(0)'>")
                                .append(parent.getName())
                                .append("</a>");
                    }

                } else {
                    builder.append("<a>")
                            .append(parent.getName())
                            .append("</a>");
                }
                builder.append("</dl>");

            } else {

                //如果是非叶节点
                builder.append("<dl><dt>");
                    builder.append("<i class='icon-user'></i>")
                            .append(parent.getName());
                builder.append("<b></b></dt>");
//                        .append("</a>");
//                    if (StringUtils.isNotEmpty(parent.getPath())) {
//                        builder.append("<a href='")
//                                .append(contextPath)
//                                .append(parent.getPath())
//                                .append("'  target='main' >")
//                                .append(parent.getName())
//                                .append("</a>");
//                    } else {}


                //递归渲染子节点
                builder.append("<dd><ul>");
                for (Menu menu : parent.getChildren()) {
                    builder.append(generateMenuForOperation(contextPath, menu));
                }
                builder.append("</ul></dd>");
                builder.append("</dl>");
            }

        }

        //关闭div
        if (parent.isRoot()) {
            builder.append("</div>");
        }

        return builder.toString();
    }

    private String generateMenuForAdmin(String contextPath, Menu parent) {
        StringBuilder builder = new StringBuilder();

        if (parent.isRoot()) {

            builder.append("<div class='menu_dropdown bk_2'>");
//                    .append("<ul class='lm-parent' id='" + id + "'>");

            for (Menu menu : parent.getChildren()) {
                builder.append(generateMenuForAdmin(contextPath, menu));
            }

        }

        if (!parent.isRoot()) {
            //如果是叶节点
            if (!parent.hasChildren()) {
                builder.append("<li");
                if ("首页".equals(parent.getParent().getName())) {
                    builder.append(" class='ml20' ");
                }
                builder.append(">");
                if (StringUtils.isNotEmpty(parent.getPath())) {
                    //如果是地图监控的新开页面 ---wangwenyi
                    if("地图监控".equals(parent.getName())){
                        builder.append("<a href='")
                                .append(contextPath)
                                .append(parent.getPath())
                                .append("' target='_blank'>")
                                .append(parent.getName())
                                .append("</a>");
                    }else{
                        builder.append("<a href='")
                                .append(contextPath)
                                .append(parent.getPath())
                                .append("' target='main'>")
                                .append(parent.getName())
                                .append("</a>");
                    }
                } else {
                    builder.append("<a>")
                            .append(parent.getName())
                            .append("</a>");
                }
                builder.append("</li>");

            } else {

                //如果是非叶节点
//                    if (StringUtils.isNotEmpty(parent.getPath())) {
//                        builder.append("<a href='")
//                                .append(contextPath)
//                                .append(parent.getPath())
//                                .append("'  target='main' >")
//                                .append(parent.getName())
//                                .append("</a>");
//                    } else {}
                builder.append("<li>");
                    builder.append("<a href='javascript:;' class='hc'>")
                            .append(parent.getName());
                builder.append("<i class='left-nav'></i>")
                        .append("</a>");


                //递归渲染子节点
                builder.append("<ul class='lm-child lm-child2 hide'>");
                for (Menu menu : parent.getChildren()) {
                    builder.append(generateMenuForAdmin(contextPath, menu));
                }
                builder.append("</ul>");

                builder.append("</li>");
            }

        }

        //关闭div
        if (parent.isRoot()) {
            builder.append("</div>");
        }

        return builder.toString();
    }

    private String generateMenuInWlStyle(String contextPath, Menu parent) {
        StringBuilder builder = new StringBuilder();

        if (parent.isRoot()) {
            builder.append("<div class='ywl-nav-head'><div class='ywl-nav-title'>导航</div></div><div class='ywl-nav-body'>")
                    .append("<ul id='" + id + "'>")
                    .append("<li>");
            if (includeRoot) {
                builder.append("<a class='a-title' href='")
                        .append(parent.getPath())
                        .append("'>")
                        .append(parent.getName())
                        .append("</a>")
                        .append("</li>");
            }

            for (Menu menu : parent.getChildren()) {
                builder.append(generateMenuInWlStyle(contextPath, menu));
            }
        }

        if (!parent.isRoot()) {
            if (!parent.hasChildren()) {
                builder.append("<li>")
                        .append("<a class='a-title' href='")
                        .append(contextPath)
                        .append(parent.getPath())
                        .append("'>")
                        .append(parent.getName())
                        .append("</a>")
                        .append("</li>");
            } else {
                builder.append("<li>");
                builder.append("<a class='a-title' href='javascript:void(0);'>")
                        .append("<i class='icon-caret-right i-middle i-grey'></i>")
                        .append(parent.getName())
                        .append("</a>");
                builder.append("<ul class='ul-nav'>");
                for (Menu menu : parent.getChildren()) {
                    builder.append(generateMenuInWlStyle(contextPath, menu));
                }

                builder.append("</ul>")
                        .append("</li>");
            }
        }

        if (parent.isRoot()) {
            builder.append("</ul>");
            builder.append("</div>");
        }

        return builder.toString();
    }

    private String generateMenuInBootstrapStyle(String contextPath, Menu parent) {
        StringBuilder builder = new StringBuilder();

        if (parent.isRoot()) {
            builder.append("<ul class='nav' id='" + id + "'>");
            builder.append("<li>");
            if (includeRoot) {
                builder.append("<a href='")
                        .append(parent.getPath())
                        .append("'>")
                        .append(parent.getName())
                        .append("</a>")
                        .append("</li>");
            }

            for (Menu menu : parent.getChildren()) {
                builder.append(generateMenuInBootstrapStyle(contextPath, menu));
            }


        }

        if (!parent.isRoot()) {
            if (!parent.hasChildren()) {
                builder.append("<li>")
                        .append("<a href='")
                        .append(contextPath)
                        .append(parent.getPath())
                        .append("'>")
                        .append(parent.getName())
                        .append("</a>")
                        .append("</li>");
            } else {
                builder.append("<li class='dropdown'>");
                builder.append("<a data-toggle='dropdown' class='dropdown-toggle' href='javascript:void(0);'")
                        .append("'>")
                        .append(parent.getName())
                        .append("<b class='caret'></b></a>");
                builder.append("<ul class='dropdown-menu'>");
                for (Menu menu : parent.getChildren()) {
                    builder.append(generateMenuInBootstrapStyle(contextPath, menu));
                }

                builder.append("</ul>")
                        .append("</li>");
            }
        }

        if (parent.isRoot()) {
            builder.append("</ul>");
        }

        return builder.toString();
    }

    private String generateMenuForMember(String contextPath, Menu parent, String align) {
        String topArrowCss = "icon i3-5 ico-arrow";
        String iCss = "";
        if (align.equals("top")) {
            iCss = "icon i20 ico-sitebtm";
        } else if (align.equals("left")) {
            iCss = "icon i20 ico-arrbtm";
        }
        StringBuilder builder = new StringBuilder();

        if (parent.isRoot()) {

            builder.append("<ul class='lm-lv1' id='" + id + "'>");

            for (Menu menu : parent.getChildren()) {
                builder.append(generateMenuForMember(contextPath, menu, align));
            }

        }

        if (!parent.isRoot()) {
            //如果是叶节点
            if (!parent.hasChildren()) {

                boolean isSubRoot = false;

                if (parent.getParent().isRoot()) {
                    isSubRoot = true;
                }

                builder.append("<li>");
                if (StringUtils.isNotEmpty(parent.getPath())) {
                    builder.append("<a href='")
                            .append(contextPath)
                            .append(parent.getPath())
                            .append("'>");
                    if (!isSubRoot) {
                        if (align.equals("top")) {
                            builder.append("<i class='" + topArrowCss + "'></i>");
                        } else {
                            builder.append("<i class='icon i18 im" + parent.getDescription() + "'></i>");
                        }
                    }

                    builder.append(parent.getName())
                            .append("</a>");
                } else {
                    builder.append("<a href='javascript:;'>");
                    if (!isSubRoot) {
                        if (align.equals("top")) {
                            builder.append("<i class='" + topArrowCss + "'></i>");
                        } else {
                            builder.append("<i class='icon i18 im" + parent.getDescription() + "'></i>");
                        }
                    }
                    builder.append(parent.getName())
                            .append("</a>");
                }
                builder.append("</li>");

            } else {

                builder.append("<li><a href='javascript:;'>")
                        .append("<i class='" + iCss + "'></i>")
                        .append(parent.getName())
                        .append("</a>");

                //递归渲染子节点
                builder.append("<ul class='lm-lv2'>");
                for (Menu menu : parent.getChildren()) {
                    builder.append(generateMenuForMember(contextPath, menu, align));
                }
                builder.append("</ul>");

                builder.append("</li>");
            }

        }

        //关闭div
        if (parent.isRoot()) {
            builder.append("</ul>");
        }

        return builder.toString();
    }

    private String getAbsolutePath(HttpServletRequest request) {
        StringBuilder sb = new StringBuilder();
        sb.append(request.getScheme());
        sb.append("://");
        sb.append(request.getServerName());
        sb.append(":");
        sb.append(request.getServerPort());
        sb.append(request.getContextPath());
        return sb.toString();
    }

}
