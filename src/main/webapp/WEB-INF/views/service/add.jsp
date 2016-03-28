<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/jquery-ui.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link type="text/css" href="${ctx}/resources/css/index.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
    <title>新建服务订单</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span>订单中心<span class="c-gray en">&gt;</span> 服务订单管理 <span class="c-gray en">&gt;</span> 新建服务订单 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<form id="orderForm">
<div class="pd-20">
    <div id="message_position"></div>
    <table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
        <thead>
        <tr class="text-l">
            <th width="106"><span class="l f-16">基本信息</span></th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <table class="table table-border table-bordered table-hover table-bg">
        <tbody>
        <tr>
            <th class="text-r">服务委托方：</th>
            <td>
                <input type="text" id="orgName" name="orgName" placeholder="请输入公司名称" value style="width:250px" class="input-text">
                <input type="hidden" name="orgId" value id="orgId">
            </td>
        </tr>
        <tr>
            <th class="text-r">委托方联系人：</th>
            <td>
                <select class="select" name="contacts" size="1" style="width:120px" id="contacts">
                    <option>-请选择-</option>
                </select>
            </td>
        </tr>
        <tr>
            <th class="text-r">客服：</th>
            <td>
                <select class="select" name="customService" size="1" style="width:120px" id="customService">
                    <c:forEach items="${customServiceList}" var="customService">
                        <option value="${customService.userId}">${customService.userNameCn}</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr>
            <th class="text-r">委托服务：</th>
            <td><table width="79%" border="0" cellpadding="0" cellspacing="0" id="news_add_center">
            <tr>
                <input type="checkbox" name="serviceId" class="chklist"  <c:forEach items="${serviceOrderBo.serviceIdList}" var="serviceId"><c:if test="${serviceId ==1}"> checked</c:if></c:forEach> value="1"/>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">出口代理</span> </label>
                <input type="checkbox" name="serviceId" class="chklist" value="2" <c:forEach items="${serviceOrderBo.serviceIdList}" var="serviceId"><c:if test="${serviceId ==2}"> checked</c:if></c:forEach>/>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">报检代理</span> </label>
                <input type="checkbox" name="serviceId" class="chklist" value="3"<c:forEach items="${serviceOrderBo.serviceIdList}" var="serviceId"><c:if test="${serviceId ==3}"> checked</c:if></c:forEach>/>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">报关代理</span> </label>
                <input type="checkbox" name="serviceId" class="chklist" value="4" <c:forEach items="${serviceOrderBo.serviceIdList}" var="serviceId"><c:if test="${serviceId ==4}"> checked</c:if></c:forEach>/>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">俄境清关</span> </label>
                <input type="checkbox" name="serviceId" class="chklist" value="5" <c:forEach items="${serviceOrderBo.serviceIdList}" var="serviceId"><c:if test="${serviceId ==5}"> checked</c:if></c:forEach>>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">国内运输</span> </label>
                <input type="checkbox" name="serviceId" class="chklist" value="6" <c:forEach items="${serviceOrderBo.serviceIdList}" var="serviceId"><c:if test="${serviceId ==6}"> checked</c:if></c:forEach>/>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">俄境运输</span> </label>
                <input type="checkbox" name="serviceId" class="chklist" value="7" <c:forEach items="${serviceOrderBo.serviceIdList}" var="serviceId"><c:if test="${serviceId ==7}"> checked</c:if></c:forEach>/>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">国内仓储</span> </label>
                <input type="checkbox" name="serviceId" class="chklist" value="8" <c:forEach items="${serviceOrderBo.serviceIdList}" var="serviceId"><c:if test="${serviceId ==8}"> checked</c:if></c:forEach>/>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">俄境仓储</span> </label>
            </tr>
        </table></td>
        </tr>
        <tr>
            <th valign="top" class="text-r">订单备注：</th>
            <td valign="top"><textarea name="memo" cols="80" rows="5"></textarea></td>
        </tr>
        </tbody>
    </table>
    <table class="table table-border table-bordered table-bg table-sort mt-15">
        <thead>
        <tr class="text-l">
            <th width="106" class="c"><span class="">
          <button class="btn btn-success radius" id="save" type="button"><i class="icon-ok"></i> 保存</button>
        </span></th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
</form>

<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/position_top.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/labelauty.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/dateformat.js"></script>
<script>
    window.ctx="${ctx}";
</script>
<script type="text/javascript">

    $(function() {
        $( "#orgName" ).autocomplete({
            source:"${ctx}/serviceOrder/orgName/",
            minLength: 1,
            autoFocus:true,
            select: function(e, ui) {
                $( "#orgId").val(ui.item.id);
            },
            change:function(e,ui){
                $.ajax({
                    url:"${ctx}/serviceOrder/getContacts",
                    type:"post",
                    dataType:"json",
                    data:{
                        orgId:ui.item.id
                    },
                    success:function(e){
                        $("#contacts option").remove()
                        $("#contacts")
                        console.log(e)
                        e.data.forEach(function(d){
                            $("<option>").val(d.userId).text(d.userNameCn).appendTo($("#contacts"));
                        })
                    }
                })
            }
        });
    });


    //参数{input类名，选择类型(单选or多选)}
    $(".rdolist").labelauty("rdolist", "rdo");
    $(".chklist").labelauty("chklist", "check");


    //保存基本信息
    $("#save").click(function(){
        var chk_value =[];//定义一个数组
        $('input[name="serviceId"]:checked').each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数
            var service = {}
            service.serviceId = $(this).val()
            chk_value.push(service);//将选中的值添加到数组chk_value中
        });
        var strJson=JSON.stringify(chk_value);
        $.ajax({
            url:window.ctx+"/serviceOrder/edit?"+$("#orderForm").serialize(),
            type:"post",
            data:{
                json:strJson
            },
            dataType:"json",
            success:function(data){
                if(data.result){
                    location.href="${ctx}/serviceOrder/list"
                }
                alert(data.msg)
            }
        })
    });
</script>

</body>
</html>
