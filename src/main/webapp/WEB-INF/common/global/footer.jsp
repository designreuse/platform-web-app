<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/21
  Time: 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="com.wl.framework.session.constant.SessionConstant" %>
<%@ page import="com.wl.framework.session.domain.LoginUser" %>
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
<script src="${ctx}/resources/js/chat-pendant-cn.js"></script>
<script type="text/javascript">
    if(""!=window.accessToken){
        var chatLogic = new ChatLogic({
            accessToken:window.accessToken,
            env :"development",
            userId:window.userId,
            twinklingTitle:false,
            defaultAvatar: window.ctx+"/resources/images/pic.jpg"
            //defaultGroupAvatar
        });
        var _rllate = new TranslateElePlugin("rlTransPlugin", "auto", "zh");
        chatLogic.addPlugs(_rllate);
        chatLogic.init();
    }

    window.onload = function(){
        setTimeout(
                function () {
                    while ($("#ctUserListId li:first").html() != undefined) {
                        $("#ctUserListId li:first").addClass("hide");//隐藏我的群组
                        break;
                    }
                }, 500);
    }

</script>
