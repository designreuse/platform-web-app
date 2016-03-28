<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="com.wl.framework.session.constant.SessionConstant" %>
<%@ page import="com.wl.framework.session.domain.LoginUser" %>
<%-- 返回顶部按钮 --%>
<a href="#top" class="scrolltop" data-action="scrolltop" scroll-affix="300" title="返回顶部1"><i class="icon-double-angle-up"></i></a>
<script>

    <%
        if (SecurityUtils.getSubject().getSession().getAttribute(SessionConstant.SESSION_LOGIN_USER_KEY) == null){
    %>
    window.userId = "";
    <%
        }else{
    %>
    window.userId = <%=((LoginUser)SecurityUtils.getSubject().getSession().getAttribute(SessionConstant.SESSION_LOGIN_USER_KEY)).getUserId()%>;
    <%
        }
    %>
    <%
           String accessToken = "";
           if(null != SecurityUtils.getSubject().getSession().getAttribute("accessToken")){
                accessToken = SecurityUtils.getSubject().getSession().getAttribute("accessToken").toString();
           }
    %>;
    window.accessToken = '<%=accessToken%>';
</script>
<!-- E:footer -->
<!--面包屑版块 -->
<script src="http://imsdk.rltx.com/templet2/javascripts/chat-pendant.js"></script>
<script type="text/javascript">
    if(""!=window.accessToken){
        var chatLogic = new ChatLogic({
            accessToken:window.accessToken,
            env :"development",
            userId:window.userId,
            defaultAvatar:"images/pic.jpg"
            //defaultGroupAvatar
        });
        var _rllate = new TranslateElePlugin("rlTransPlugin", "auto", "zh");
        chatLogic.addPlugs(_rllate);
        chatLogic.init();
    }

</script>


