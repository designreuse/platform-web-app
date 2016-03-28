<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <%@include file="../framework/header_common.jsp" %>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="${ctx}/resources/js/html5.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/respond.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/PIE_IE678.js"></script>
    <![endif]-->
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <!--[if IE 7]>
    <link href="${ctx}/resources/font/font-awesome-ie7.min.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
    <![endif]-->
    <title>企业信息编辑</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 企业信息 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a> <span class="c-gray en">&gt;</span><a href="#">企业会员编辑</a></nav>
<div class="pd-20">
<div id="message_position">
    <div id="position_fixed" class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l">
    <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_a_click">
         基本信息</a>
    <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
        服务范围</a>
    <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
        服务部门</a>


    </span>
 </div>
</div>
<form id="orgForm">
    <table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
        <thead>
        <tr class="text-l">
            <th width="106"><span class="l f-16">基本信息</span> <span class="r">
          <button class="btn btn-success radius" type="button" id="orgSubmit"><i class="icon-ok"></i> 保存</button>
          </span> </th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <input type="hidden" value="${orgBo.id}" id="orgId" name="id">
    <table class="table table-border table-bordered table-hover table-bg">
        <tbody>
        <tr>
            <th class="text-r"> 企业状态：</th>
            <td colspan="3">
                <div class="State">
                    <ul>
                        <c:if test="${orgBo.orgAdultStatus ==2}"><li class="onshow">已通过</li></c:if>
                        <c:if test="${orgBo.orgAdultStatus ==3}"><li class="state1">待审核</li></c:if>
                        <c:if test="${orgBo.orgAdultStatus ==1}"><li class="state1">待初审</li></c:if>
                        <c:if test="${orgBo.orgAdultStatus ==4}"><li class="state2">审核未通过</li></c:if>
                    </ul>
                </div>
            </td>
        </tr>
        <tr>
            <th class="text-r" width="150"><span class="c-red">*</span>公司名称（中文）：</th>
            <td width="317"><input type="text" id="orgNameCn" name="orgNameCn" placeholder="控制在25个字、50个字节以内" value="${orgBo.orgNameCn}" style="width:250px" class="input-text required"></td>
            <td class="text-r" width="133">公司名称（俄文）：</td>
            <td width="324"><input type="text" id="orgNameRu" name="orgNameRu" placeholder="控制在25个字、50个字节以内" value="${orgBo.orgNameRu}" style="width:250px" class="input-text required"></td>
        </tr>
        <tr>
            <th rowspan="2" class="text-r"><span class="c-red">*</span>公司地址（中文）：</th>
            <td rowspan="2">
                <select class="select" name="countryType" id="countrySelect" size="1" style="width:150px">
                    <option value="1" <c:if test="${orgBo.countryType==1}">selected</c:if>>中国</option>
                    <option value="2" <c:if test="${orgBo.countryType==2}">selected</c:if>>俄罗斯</option>
                </select>
                <select class="select" name="provId" size="1" style="width:150px" id="provSelect">
                    <option value="">---请选择省---</option>
                    <c:forEach items="${provList}" var="prov">
                        <option value="${prov.id}" <c:if test="${orgBo.provId == prov.id}">selected</c:if> >
                                ${prov.cnname}(${prov.enname})</option>
                    </c:forEach>
                </select>
                <select class="select" name="cityId" size="1" style="width:150px" id="citySelect">
                    <option value="">---请选择市---</option>
                    <c:forEach items="${cityList}" var="city">
                        <option value="${city.id}" <c:if test="${orgBo.cityId==city.id}">selected</c:if> >
                                ${city.cnname}( ${city.enname})</option>
                    </c:forEach>
                </select>
                <select class="select" name="distId" size="1" style="width:150px" id="distSelect">
                    <option value="">---请选择区---</option>
                    <c:forEach items="${distList}" var="dist">
                        <option value="${dist.id}" <c:if test="${orgBo.distId==dist.id}">selected</c:if> >
                                ${dist.cnname}(${dist.enname})</option>
                    </c:forEach>
                </select>
            </td>
            <td class="text-r"><span class="c-red">*</span> 公司地址（中文）：</td>
            <td><input type="text" id="addrCn" name="addrCn" placeholder="控制在25个字、50个字节以内" value="${orgBo.addrCn}" style="width:250px;margin-top:10px;" class="input-text">
            </td>
        </tr>
        <tr>
            <td class="text-r">公司地址（俄文）：</td>
            <td><input type="text" id="addrRu" name="addrRu" placeholder="控制在25个字、50个字节以内" value="${orgBo.addrRu}" style="width:250px;margin-top:10px;" class="input-text"></td>
        </tr>
        <tr>
            <th class="text-r">公司介绍（中文）：</th>
            <td>
                <textarea rows="5" cols="50" name="summaryCn">${orgBo.summaryCn}</textarea>
            </td>
            <td class="text-r">公司介绍（俄文）：</td>
            <td>
                <textarea rows="5" cols="50" name="summaryRu">${orgBo.summaryRu}</textarea>
            </td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span>公司法人：</th>
            <td><input type="text" id="corporation" name="corporation" placeholder="默认为空，为相对路径" value="${orgBo.corporation}" style="width:250px" class="input-text"></td>
            <th class="text-r"><span class="c-red">*</span>经营范围（中文）：</th>
            <td><input type="text" id="optRegion" name="optRegionCn" placeholder="默认为uploadfile" value="${orgBo.optRegionCn}" style="width:250px" class="input-text"></td>
        </tr>
        <tr>
            <th class="text-r">注册地（中文）：</th>
            <td><input type="text" id="corpRegaddr" name="corpRegaddrCn" placeholder="默认为uploadfile" value="${orgBo.corpRegaddrCn}" style="width:250px" class="input-text"></td>
            <th class="text-r">注册时间：</th>
            <td colspan="3" id="shuiwu"><odpf:formatDate style="DATE" date="${orgBo.corpRegtime}"/></td>
        </tr>
        </tbody>
    </table>
</form>
<%--<div class="clear"></div>--%>
<%--<table class="table table-border table-bordered table-bg table-sort">--%>
    <%--<thead>--%>
    <%--<tr class="text-l">--%>
        <%--<th width="106" class="public_click_content"><span class="l f-16">企业资质</span> <span class="r">--%>
          <%--<button class="btn btn-success radius" type="button" id="orgSrvSubmit"><i class="icon-ok"></i> 保存</button>--%>
          <%--</span> </th>--%>
    <%--</tr>--%>
    <%--</thead>--%>
    <%--<tbody>--%>
    <%--</tbody>--%>
<%--</table>--%>
<%--<table border="0" cellspacing="0" cellpadding="0" class="table table-border table-bordered table-bg table-sort">--%>
    <%--<tbody>--%>
    <%--<tr>--%>
        <%--<th width="182" height="51" class="text-r">营业执照： </th>--%>
        <%--<td width="266"><table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">--%>
            <%--<tr>--%>
                <%--<td width="194" class="upload_img" style="border:0px;margin:0px;padding:0px;">--%>
                    <%--点击上传<br>--%>
                    <%--限JPEG、PNG文件<br>--%>
                    <%--5M大小以内<br>--%>
                <%--</td>--%>
            <%--</tr>--%>
        <%--</table>--%>
            <%--<table width="200" border="0">--%>
                <%--<tr>--%>
                    <%--<td style="border:0px;" class="photo_shenhe"><img src="images/icon_right_s.png">审核通过&nbsp;</td>--%>
                <%--</tr>--%>
            <%--</table></td>--%>
        <%--<td width="186" class="text-r">税务登记证： </td>--%>
        <%--<td width="235">--%>
            <%--<table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">--%>
                <%--<tr>--%>
                    <%--<td width="194" class="upload_img" style="border:0px;margin:0px;padding:0px;">--%>
                        <%--点击上传<br>--%>
                        <%--限JPEG、PNG文件<br>--%>
                        <%--5M大小以内<br>--%>
                    <%--</td>--%>
                <%--</tr>--%>
            <%--</table>--%>
            <%--<table width="200" border="0">--%>
                <%--<tr>--%>
                    <%--<td style="border:0px;" class="photo_shenhe"><img src="images/icon_right_s2.jpg">审核通过&nbsp;</td>--%>
                <%--</tr>--%>
            <%--</table>--%>
        <%--</td>--%>
        <%--<td width="176" class="text-r">组织机构代码证</td>--%>
        <%--<td width="226">--%>
            <%--<input type="file" id="orgCode" class="btn-uploadpic" name="" multiple id="sattachMent">--%>
            <%--<table width="200" border="0">--%>
                <%--<tr>--%>
                    <%--<td style="border:0px;" class="photo_shenhe">&nbsp;</td>--%>
                <%--</tr>--%>
            <%--</table>--%>
        <%--</td>--%>
    <%--</tr>--%>
    <%--</tbody>--%>
<%--</table>--%>
<table class="table table-border table-bordered table-bg table-sort">
    <thead>
    <tr class="text-l">
        <th width="106" class="public_click_content"><span class="l f-16">服务范围</span> <span class="r">
          <button class="btn btn-success radius" type="button" id="serviceSubmit"><i class="icon-ok" ></i> 保存</button>
        </span></th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<form id="serviceForm">
    <table class="table table-border table-bordered table-bg table-sort">
        <tbody>
        <tr>
            <th width="128" height="50" class="text-r"> 服务范围 ：</th>
            <td width="819">
                <c:forEach items="${serviceList}" var="service">
                    &nbsp;&nbsp;${service.srvNameCn} &nbsp;&nbsp;
                </c:forEach>

            </td>
        </tr>
        <tr>
            <th height="50" class="text-r">执行部门： </th>
            <td><div class="demo">
                <div class="plus-tag-add">
                    <form id="321" action="" class="login">
                            <input type='text' id='key'>
                            <input type='button' id='btAdd' class="btn btn-success radius " value="add" onclick="add();">
                            <select id="dept" class="form-control" name="dept" multiple="true" ondblclick="del();">
                                <c:forEach items="${orgBo.deptList}" var="deptList">
                                    <option value="${deptList}">${deptList}</option>
                                </c:forEach>
                            </select>
                    </form>
                </div>
            </div></td>
        </tr>
        </tbody>
    </table>
</form>
<form id="111">
    <div class="clear"></div>
    <table class="table table-border table-bordered table-bg table-sort">
        <thead>
        <tr class="text-l">
            <th width="106" class="public_click_content"><span class="l f-16">服务部门</span> <span class="r">
          <button class="btn btn-success radius" type="button" id="Submit"><i class="icon-ok" ></i> 保存</button>
        </span></th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <table class="table table-border table-bordered table-bg table-sort">
        <tbody>
        <tr>
            <th height="50" class="text-r">服务执行部门配置： </th>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tbody id="deptNode">

                   <c:forEach items="${nodeMap}" var="nodeMap">
                       <tr>
                           <c:forEach items="${nodeMap.key}" var="orgServiceName">
                               <td width="55">${orgServiceName}</td>
                               <c:forEach items="${nodeMap.value}" var="serviceNode">

                                       <td class="myId" nodeid="${serviceNode.nodeId}" serviceid="${serviceNode.serviceId}">
                                           ${serviceNode.nodeNameCn}
                                       <%--<c:forEach items="${srvnodeList}" var="srvNode">--%>
                                           <%--<c:if test="${serviceNode.nodeId == srvNode.nodeId}">--%>
                                               <select class="mySelect">
                                                   <c:forEach items="${deptList}" var="dept">
                                                        <option value="${dept.id}"   <c:forEach items="${srvnodeList}" var="srvNode"><c:if test="${serviceNode.nodeId == srvNode.nodeId && srvNode.deptId == dept.id}">selected</c:if></c:forEach> >${dept.deptName}</option>
                                                   </c:forEach>
                                                </select>
                                           <%--</c:if>--%>
                                       <%--</c:forEach>--%>
                                       </td>
                               </c:forEach>
                           </c:forEach>
                       </tr>
                   </c:forEach>

                </tbody>
            </table></td>
        </tr>
        </tbody>
    </table>
</form>
<%--<table class="table table-border table-bordered table-bg table-sort">--%>
    <%--<thead>--%>
    <%--<tr class="text-l">--%>
        <%--<th width="106" class="public_click_content"><span class="l f-16">服务资质</span> <span class="r">--%>
          <%--<button class="btn btn-success radius" type="button" id="orderService"><i class="icon-ok"></i> 保存</button>--%>
        <%--</span></th>--%>
    <%--</tr>--%>
    <%--</thead>--%>
    <%--<tbody>--%>
    <%--</tbody>--%>
<%--</table>--%>
<%--<table class="table table-border table-bordered table-bg table-sort">--%>
    <%--<tbody>--%>
    <%--<tr>--%>
        <%--<td width="260" height="51" class="text-r">--%>
            <%--<input type="file" class="btn-uploadpic" name="" multiple id="attachment">--%>
            <%--<input type="text" class="input-text pt-20" id="attachmentName" style="width:150px" value="输入图片名称">点击上传限JPEG、PNG文件5M大小以内--%>
        <%--</td>--%>
    <%--</tr>--%>
    <%--</tbody>--%>
<%--</table>--%>

</div>
<script language="javascript" src="${ctx}/resources/js/jquery-1.8.0.min.js"></script>
<%--<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>--%>
<%--<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>--%>
<%--<script type="text/javascript" src="${ctx}/resources/js/Validform_v5.3.2_min.js"></script>--%>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script language="javascript" src="${ctx}/resources/js/position_top.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/validation/jquery.validate.min.js"></script>
<script src="${ctx}/resources/js/labelauty.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script>
    /*
    添加删除部门
     */
    function add()
    {
        if(!$("#key").val()){
            alert("请输入部门名称")
            return
        }
        var flag = true
        var listbox = document.getElementById("dept");
        var value = document.getElementById("key").value;
        var text = document.getElementById("key").value;
        var option = document.createElement("OPTION");
        option.value = value;
        option.text =text ;
        $("#dept").children("option").each(function(){
            if($(this).text() == document.getElementById("key").value){
                alert("部门已存在")
                flag = false;
                return false
            }
        })
        if(flag){
            listbox.options.add(option);
        }
        $("#key").val("")
    }

    function del(){
        var objdel=document.getElementById("dept");
        for(var i=objdel.options.length-1;i>=0;i--)
        {
            if(objdel.options[i].selected)
            {
                objdel.remove(i);
            }
        }
    }

//    //表单校验
//    $("#orgForm").validate({
//        rules:{
//            orgNameCn:{
//                required:true
//            },
//            orgNameRu:{
//                required:true
//            }
//        },
//        messages:{
//            orgNameCn:{
//                required:"必填"
//            },
//            orgNameRu:{
//                required:"必填"
//            }
//        }
//    });


    //保存基本信息
    $("#orgSubmit").click(function(){

        if(!$("#orgNameCn").val()){
            alert("企业名称（中文）必须填写");
            return;
        }
        if(!$("#addrCn").val()){
            alert("公司地址（中文）必须填写");
            return;
        }
        if(!$("#corporation").val()){
            alert("公司法人必须填写");
            return;
        }
        if(!$("#optRegion").val()){
            alert("经营范围（中文）必须填写");
            return;
        }



        $("#corpRegtime").val(new Date($("#corpRegtime").val().replace(/-/,"/")))
        $.ajax({
            url:window.ctx+"/enterprise/edit",
            type:"POST",
            data:$("#orgForm").serialize(),
            success:function(){
                alert("保存成功！");
                $("#corpRegtime").val(new Date($("#corpRegtime").val()).Format("yyyy-MM-dd hh:mm"))
            },error:function(){
                alert("保存失败！");
            }
        })
    });

    //启用禁用
    $("#start").click(function(){
        updateDisabled(false,false)
    })
    $("#end").click(function(){
        updateDisabled(true,true)
    })
    var updateDisabled = function(e,data){
        $.ajax({
            url:window.ctx+"/enterprise/edit",
            type:"POST",
            data:{
                disabled:e,
                id:$("#orgId").val()
            },
            success:function(){
                if(data == true){
                    $("#start").attr("style","")
                    $("#end").attr("style","display:none")
                }else{
                    $("#end").attr("style","")
                    $("#start").attr("style","display:none")
                }
            }
        })
    }

    //保存服务
    $("#serviceSubmit").click(function(){
        var obj=[];
        var chk_value =[];
            $("#dept").children("option").each(function(){
                var dept={};
                dept.deptName =$(this).text();
                dept.orgId=$("#orgId").val();
                obj.push(dept);
            })
        var objJson=JSON.stringify(obj);
        $.ajax({
            url:window.ctx+"/enterprise/SrvEdit",
            type:"POST",
            dataType:"json",
            data:{
                dept:objJson,
                orgId:$("#orgId").val()
            },
            success:function(data){

                $("#deptNode").empty();

                var option = '';
                $.each(data,function(key,values){
                    if('deptList' == key){
                        $(values).each(function(){
                            option += '<option value="'+this.id+'">'+this.deptName+'</option>';
                        });
                    }
                });



                var str = '';
                $.each(data,function(key,values){
                    if('出口代理' == key || '出口报检' == key || '出口报关' == key || '俄境清关' == key
                            || '国内运输' == key || '俄境运输' == key || '国内仓储' == key || '俄境仓储' == key){
//                        var count = 1;
                        str +='<tr><td width="55">' + key +'</td>';
                        $(values).each(function(){
                            str +='<td class="myId" nodeId="'+this.nodeId+'" serviceId="'+this.serviceId+'">' +this.nodeNameCn + '<select class="mySelect">'+option+'</select></td>';
//                            count ++;
                        });
//                        str += '';
                    }


                });
                str += '</tr>';
                $("#deptNode").append(str);
//                $.each(data.deptList,function(dept){
//                    alert(dept.deptName);
//                });
//                alert(data.key);
//                var str
//                $("#deptNode").remove()
//                for(var orgServiceBo in data.orgServiceList){
//                    str+='<tr><td>'+orgServiceBo.srvId+'</td>'
//                    for(var nodeBo in data.nodeMap){
//                        if(orgServiceBo == nodeBo.key){
//                            str+='<td>'+nodeBo.value.nodeId+'.'+nodeBo.value.nodeNameCnCnCn+'</td><td><select name="dept" class="dept">'
//                        }
//                        str+='<td>'+nodeList.nodeId+'.'+nodeList.nodeNameCnCnCn+'</td><td><select name="dept" class="dept">'
//                        for(var deptBo in data.deptList){
//                            str+='<option value="'+deptBo.id+'">'+deptBo.name+'</option>'
//                        }
//                        str+='</select></td>'
//                    }
//                    str+='</tr>'
//                }
//
//                $("#deptNode").append(str)
                alert("保存成功！");
            },error:function(){
                alert("保存失败！");
            }
        })
    })


    $("#Submit").click(function(){
        var srvnode = [];
        $(".myId").each(function(){
            var obj = {};
            obj.nodeId = $(this).attr("nodeid");
            obj.serviceId = $(this).attr("serviceid");
            obj.orgId = $("#orgId").val();
            obj.deptId = $(this).children(".mySelect").val();
            srvnode.push(obj);
        });

        var srvNodeJson=JSON.stringify(srvnode);


        $.ajax({
            url:window.ctx+"/enterprise/SaveSrvnode",
            type:"POST",
            dataType:"json",
            data:{
                jsonList:srvNodeJson
            },
            success:function(data){
                alert("保存成功！");
            },error:function(){
                alert("保存失败！");
            }
        });
    });



    $(document).ready(function () {
        //参数{input类名，选择类型(单选or多选)}
        $(".chklist").labelauty("chklist", "check");
        $("#corpRegtime").val(new Date($("#corpRegtime").val()).Format("yyyy-MM-dd"))
    });
</script>
<script type="text/javascript">








//// 更新选中标签标签
//$(function(){
//    setSelectTips();
//    $('.plus-tag').append($('.plus-tag a'));
//});
//var searchAjax = function(name, id, isAdd){
//    setSelectTips();
//};
//// 搜索
//(function(){
//    var $b = $('.plus-tag-add button'),$i = $('.plus-tag-add input');
//    $i.keyup(function(e){
//        if(e.keyCode == 13){
//            $b.click();
//        }
//    });
//    $b.click(function(){
//        var name = $i.val().toLowerCase();
//        if(name != '') setTips(name,-1);
//        $i.val('');
//        $i.select();
//    });
//})();
//// 推荐标签
//(function(){
//    var str = ['展开推荐标签', '收起推荐标签']
//    $('.plus-tag-add a').click(function(){
//        var $this = $(this),
//                $con = $('#mycard-plus');
//
//        if($this.hasClass('plus')){
//            $this.removeClass('plus').text(str[0]);
//            $con.hide();
//        }else{
//            $this.addClass('plus').text(str[1]);
//            $con.show();
//          }
//    });
//    $('.default-tag a').live('click', function(){
//        var $this = $(this),
//                name = $this.attr('title'),
//                id = $this.attr('value');
//        setTips(name, id);
//    });
//    // 更新高亮显示
//    setSelectTips = function(){
//        var arrName = getTips();
//        if(arrName.length){
//            $('#myTags').show();
//        }else{
//            $('#myTags').hide();
//        }
//        $('.default-tag a').removeClass('selected');
//        $.each(arrName, function(index,name){
//            $('.default-tag a').each(function(){
//                var $this = $(this);
//                if($this.attr('title') == name){
//                    $this.addClass('selected');
//                    return false;
//                }
//            })
//        });
//    }
//
//})();
//启用禁用

Date.prototype.Format = function (fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

//上传
$('#sattachMent').on('change', function(fileType) {
    fileSubmit("attachment",1,$("#attachmentName").val())
})
var fileSubmit =function(fileId,fileType,fileName) {
    $.ajaxFileUpload({
        url:window.ctx+'/uploadImg',
        secureuri:false,
        fileElementId:fileId,//file标签的id
        dataType: 'json',//返回数据的类型
        data:{
            attachmentType:fileType,
            attachmentName:fileName
        },//一同上传的数据
        success: function (data, status) {

        },
        error: function (data, status, e) {
            alert(e);
        }
    });
};

$(function(){
    var provSelect = $("#provSelect");
    var countrySelect = $("#countrySelect");
    var citySelect = $("#citySelect");
    var distSelect = $("#distSelect");
    if("" === "${orgBo}"){
        var countryId = countrySelect.val()
        citySelect.hide();
        distSelect.hide();
        loadAddress("/address/province/"+countryId,provSelect);
    }
    if("" === $("#distSelect").val()){
        distSelect.hide();
    }
    countrySelect.on("change",function(){
        var countryId = countrySelect.val();
        if(countryId){
            citySelect.hide();
            distSelect.hide();
            citySelect.children().first().siblings().remove();
            distSelect.children().first().siblings().remove();
            loadAddress("/address/province/"+countryId,provSelect);
        }
    });
    provSelect.on("change",function(){
        var provId = provSelect.val();
        if(provId){
            distSelect.hide();
            distSelect.children().first().siblings().remove();
            loadAddress("/address/city/"+provId,citySelect);
        }
    });
    citySelect.on("change",function(){
        var cityId = citySelect.val();
        if(cityId){
            loadAddress("/address/district/"+cityId,distSelect);
        }
    });

})

function loadAddress(url,target){
    $.get(window.ctx+url,function(data){
        target.children().first().siblings().remove();
        data.forEach(function(d,i) {
            target.append($("<option></option>").val(d.id).text(d.cnname+"("+ d.enname+")"));
        });
        if(data.length>0){
            target.show();
        }
    },"json");
}


</script>
</body>
</html>