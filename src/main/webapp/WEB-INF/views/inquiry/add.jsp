<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
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
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/popModal.css">
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/jquery-ui.css"/>
    <!--[if IE 7]>
    <script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
    <link href="${ctx}/resources/font/font-awesome-ie7.min.css" rel="stylesheet" type="text/css" />
    <![endif]-->
    <style>
        .tr-bg-color{
            background: #DDD;
        }
    </style>
    <title>新建询盘</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 商机中心 <span class="c-gray en">&gt;</span> 询盘回盘管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a> <span class="c-gray en">&gt;</span><a href="#">新建询盘</a></nav>
<div class="pd-20">
    <div id="message_position">
        <div id="position_fixed" class="cl pd-5 bg-1 bk-gray mt-20">
  <span class="l"> 
  <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_a_click">
     基本信息</a></span></div>
    </div>
    <form action="${ctx}/inquiry/add"  method="post" id="inquiryForm" onsubmit="return checkInquiryForm()">
    <input    name="effectiveDate" type="hidden" value="ttt"/>
    <table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
        <thead>
        <tr class="text-l">
            <th width="106"><span class="l f-16">基本信息</span></th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <table class="table table-border table-bordered table-bg table-sort">
        <tbody>
        <tr>
            <th width="190" class="text-r"><span class="c-red">*</span>  买方：</th>
            <td><input name="orgName" id="orgNameInput" type="search" class="input-text" style="width:200px" value="" placeholder="请输入企业名称，支持模糊查询">&nbsp;
                <input type="hidden" name="orgId" value="" id="orgId">
                <input type="hidden" name="userId" value="" id="userId">
                <%--<select name="orgId" id="orgSelect" class="input-text" style="display: none;"></select>--%>
            </td>
        </tr>
        <tr>
            <th class="text-r">目标商铺： </th>
            <td><label>
                <input id="shopsNameInput" name="shopsName" type="search" class="input-text" style="width:200px" value="" placeholder="请输入店铺名称，支持模糊查询">
                <input type="hidden" name="shopsId" value="" id="shopsId">
                <%--<select name="shopsId" id="shopsSelect" class="input-text" style="display: none;"></select>--%>
            </label>
                <button id="dialogModal_ex1" data-dialogModalBind=".dialog_content" class="btn btn-primary radius" type="button">新增询价商品</button>
                <button id="dialogModal_ex2" data-dialogModalBind=".dialog_content11" class="btn btn-primary radius" type="button" style="display: none">选取询价商品</button>

                <div id="dialog_content" class="dialog_content" style="display:none">
                    <div class="dialogModal_header">新增商品</div>
                    <div class="dialogModal_content">
                        <table width="100%" class="table product">
                            <tr>
                                <td valign="top" class="text-r">商品：</td>
                                <td>
                                    <select onchange="loadCs2(this);" class="select" name="catalog1" size="1" style="width:120px">
                                        <option value="">==请选择==</option>
                                        <c:forEach items="${catalogList}" var="catalog">
                                            <option value="${catalog.catalogId}">${catalog.catalogNameCn}</option>
                                        </c:forEach>
                                    </select>
                                    <select onchange="loadCs3(this);" class="select catalogSelect2" name="catalog2" size="1" style="width:120px">
                                        <option value="">==请选择==</option>
                                    </select>
                                    <br>
                                    <select onchange="loadPro(this);" class="select catalogSelect3" name="catalog3" size="1" style="width:120px">
                                        <option value="">==请选择==</option>
                                    </select>
                                    <select onChange="setUnitInfo(this);" class="select productSelect" name="productId" size="1" style="width:120px">
                                        <option value="">==请选择==</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-r">求购价： </td>
                                <td><input type="text" class="input-text" style="width:150px" name="unitPrice">
                                    <input type="hidden" name="unit" value=""/>
                                    <input type="hidden" name="unitName" value=""/>
                                    <select name="costType"><option value="1">元</option></select>
                                    <span class="unitName"></span> </td>
                            </tr>
                            <tr>
                                <td class="text-r">采购量：</td>
                                <td><input type="text" class="input-text" style="width:150px" placeholder=""
                                           name="purchareNum"></td>
                            </tr>
                            <tr>
                                <td class="text-r">标准件：</td>
                                <td><input type="text" class="input-text" style="width:150px" placeholder=""
                                           name="standard"></td>
                            </tr>
                            <tr>
                                <td class="text-r">包装方式：</td>
                                <td><select class="select" name="packageType" size="1" style="width:120px">
                                    <option value="1">箱</option>
                                    <option value="2">盒子</option>
                                    <option value="3">桶</option>
                                </select></td>
                            </tr>
                            <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                        </table>
                    </div>
                    <div class="dialogModal_footer">
                        <button type="button" class="btn btn-primary radius" data-dialogModalBut="ok">保存</button>
                        <button type="button" class="btn radius" data-dialogModalBut="cancel">取消</button>
                    </div>
                </div>

                <div id="dialog_content11" class="dialog_content11" style="display:none">
                    <div class="dialogModal_header">选取询价商品</div>
                    <div class="dialogModal_content">
                        <div id="content" >
                            <div class="la">
                                <table class="skuList table table-border table-bordered table-bg table-hover table-sort">
                                </table>
                            </div>
                            <div class="ra">
                                <table width="100%" class="table sku" style="height:300px">
                                    <tr>
                                        <td class="text-r">求购价： </td>
                                        <td><input type="text" class="input-text" style="width:150px" name="unitPrice">
                                            <input type="hidden" name="unit" value=""/>
                                            <input type="hidden" name="unitName" value=""/>
                                            <select name="costType"><option value="1">元</option></select>
                                            <span class="unitName"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-r">采购量：</td>
                                        <td><input type="text" class="input-text" style="width:150px" placeholder=""
                                                   name="purchareNum"></td>
                                    </tr>
                                    <tr>
                                        <td class="text-r">标准件：</td>
                                        <td><input type="text" class="input-text" style="width:150px" placeholder=""
                                                   name="standard"></td>
                                    </tr>
                                    <tr>
                                        <td class="text-r">包装方式：</td>
                                        <td>
                                            <select class="select" name="packageType" size="1" style="width:120px">
                                                <option value="1">箱</option>
                                                <option value="2">盒子</option>
                                                <option value="3">桶</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>
                                            <button type="button" class="btn btn-primary radius" data-dialogModalBut="ok">选择</button>
                                            <button type="button" class="btn radius" data-dialogModalBut="cancel">取消</button>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="popModal_footer"></div>
                        </div>
                    </div>
                </div>

                <div id="dialog_content22" class="dialog_content22" style="display:none;">
                    <div class="dialogModal_header">修改商品属性</div>
                    <div class="dialogModal_content" style="width: 500px;height: 350px;">
                        <table width="100%" class="table product-edit">
                            <tr>
                                <td class="text-r">求购价： </td>
                                <td><input type="text" class="input-text" style="width:150px" name="unitPrice">
                                    <input type="hidden" name="unit" value=""/>
                                    <input type="hidden" name="unitName" value=""/>
                                    <select name="costType"><option value="1">元</option></select>
                                    <span class="unitName"></span></td>
                            </tr>
                            <tr>
                                <td class="text-r">采购量：</td>
                                <td><input type="text" class="input-text" style="width:150px" placeholder=""
                                           name="purchareNum"></td>
                            </tr>
                            <tr>
                                <td class="text-r">标准件：</td>
                                <td><input type="text" class="input-text" style="width:150px" placeholder=""
                                           name="standard"></td>
                            </tr>
                            <tr>
                                <td class="text-r">包装方式：</td>
                                <td><select class="select" name="packageType" size="1" style="width:120px">
                                    <option value="1">箱</option>
                                    <option value="2">盒子</option>
                                    <option value="3">桶</option>
                                </select></td>
                            </tr>
                            <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                        </table>
                    </div>
                    <div class="dialogModal_footer">
                        <button type="button" class="btn btn-primary radius" data-dialogModalBut="ok">保存</button>
                        <button type="button" class="btn radius" data-dialogModalBut="cancel">取消</button>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <th width="190" class="text-r">&nbsp;</th>
            <td><table class="table table-border table-bordered table-bg table-sort">
                <thead>
                <tr class="text-c">
                    <th width="337">商品</th>
                    <th width="124">商品属性</th>
                    <th width="167">采购详情</th>
                    <th width="124">单价(CNY)</th>
                    <th width="153">总价(CNY) </th>
                    <th width="133">操作</th>
                </tr>
                </thead>
                <tbody id="inquiryProductTable"></tbody>
            </table></td>
        </tr>
        </tbody>
    </table>
    <div class="clear"></div>
    <table class="table table-border table-bordered table-bg table-sort">
        <tbody>
        <tr>
            <th class="text-r" width="190"><span class="c-red">*</span> 交货地：</th>
            <td width="400">
                <select class="select" name="deliveryAddrId" size="1" style="width:120px">
                    <%--<option value="1">满洲里</option>--%>
                    <option value="2">赤塔</option>
                    <option value="3">乌兰乌德</option>
                    <option value="4">伊尔库兹克</option>
                    <option value="5">新西伯利亚</option>
                </select>
            </td>
            <th class="text-r"><span class="c-red">*</span>询盘有效期： </th>
<%--
            <td width="683"><input class="Wdate" type="text" name="effectiveDate" id="d" onFocus="WdatePicker({isShowClear:false,readOnly:true,maxDate:'$y-%M-%d'})"/></td>
--%>
            <td>
                <select id="effectiveDateSelect" class="select"  size="1" style="width:120px" onchange="effectiveDateChange()">
                    <option value="1"selected>一天</option>
                    <option value="2">三天</option>
                    <option value="3">五天</option>
                </select>
                <span id="effectiveDateTxt"/>

            </td>

        </tr>
        <tr>
            <th width="194" class="text-r"><span class="c-red">*</span>交货日期：</th>
            <td><input class="Wdate" type="text" name="deliveryDate" id="d2" onFocus="WdatePicker({isShowClear:false,readOnly:true,minDate:'$y-%M-%d'})"/>&nbsp;&nbsp;—>&nbsp;&nbsp;<input class="Wdate" type="text" name="lastDate" id="d3" onFocus="WdatePicker({isShowClear:false,readOnly:true,minDate:'$y-%M-%d'})"/></td>
        </tr>
        <tr>
            <th rowspan="2" valign="top" class="text-r"><span class="c-red">*</span>付款方式：</th>
            <td rowspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="table-border">
                <tbody>
                <tr>
                    <td>支付方式：</td>
                    <td>线下支付</td>
                </tr>
                <tr>
                    <td width="32%">预付款比例:</td>
                    <td width="68%">
                        <select id="paywayPercent" class="select" name="paywayPercent" size="1" style="width:120px" onchange="paywayLastShow()">
                            <option value="1"selected>30%</option>
                            <option value="2">50%</option>
                            <option value="3">100%</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>尾款支付限期:</td>
                    <td><select class="select" id="paywayLast" name="paywayLast" size="1" style="width:120px">
                        <option value="1" selected>提货时付款</option>
                        <option value="2">提货后30天内付款</option>
                        <option value="3">提货后60天内付款</option>
                    </select></td>
                </tr>
                </tbody>
            </table></td>
            <th valign="top"  class="text-r"><p><span class="c-red">*</span>提货方式：</p></th>
            <td valign="top">自提</td>
        </tr>
        <tr>
            <th valign="top" class="text-r">附加说明：</th>
            <td valign="top"><textarea class="input-text" name="memo" id="Remarks" style="height:100px;width:300px;"></textarea></td>
        </tr>
        <tr>
            <th class="text-r">&nbsp;</th>
            <td colspan="3"><button class="btn btn-success radius" type="submit"><i class="icon-ok"></i> 保存</button></td>
        </tr>
        </tbody>
    </table>
    </form>
</div>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script language="javascript" src="${ctx}/resources/js/position_top.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-ui.js"></script>
<script src="${ctx}/resources/js/popModal.js"></script>
<script>
    $(function() {
        $("#effectiveDateTxt").html(CurrentDateAddDay(0));
//        alert($("input[name='effectiveDate']").val());

        $("input[name='effectiveDate']").val(CurrentDateAddDay(0));


        $( "#orgNameInput" ).autocomplete({
            source:"${ctx}/inquiry/orgList",
            minLength: 1,
            autoFocus:true,
            select: function(e, ui) {
                $( "#orgId").val(ui.item.id);
            },
            change:function(e,ui){
                $( "#orgId").val(ui.item.id);
            }
        });

        $("#shopsNameInput").autocomplete({
            source:"${ctx}/inquiry/shopList",
            minLength : 1,
            autoFocus:true,
            search: function(e, ui) {
                $("#shopsId").val('');
                $("#userId").val('');
                $("#dialogModal_ex1").show();
                $("#dialogModal_ex2").hide();
            },
            select : function(e,ui){
                $("#shopsId").val(ui.item.id);
                $("#userId").val(ui.item.userId);
                $("#dialogModal_ex1").hide();
                $("#dialogModal_ex2").show();
                $("#inquiryProductTable").empty();
            }
        });
    });

//    $("#paywayPercent").change(function(){
//        if($("#paywayPercent").val()==3){
//            $("#paywayLast").attr("style","display:none")
//        }else{
//            $("#paywayLast").removeAttr("style")
//        }
//    })
    /**
    * 查询商品分类 生成select
    * @param cid      父分类id
    * @param target   目标select
     */
    function loadCatalogList(url,target){
        cleanOption(target);
        $.get(url,function(data){
            data.forEach(function(d){
                target.append($("<option/>").val(d.catalogId).text(d.catalogNameCn));
            });
        },"json");
    }
    //清除select下除了第一个之外的option
    function cleanOption(target){
        target.children().first().siblings().remove();
    }
    //加载二级产品分类
    function loadCs2(s){
        loadCatalogList("${ctx}/inquiry/catalogList/"+$(s).val(),$("select.catalogSelect2:visible"));
        cleanOption($("select.catalogSelect3:visible"));
        cleanOption($("select.productSelect:visible"));
    }
    //加载三级产品分类
    function loadCs3(s){
        cleanOption($("select.productSelect:visible"));
        loadCatalogList("${ctx}/inquiry/catalogList/"+$(s).val(),$("select.catalogSelect3:visible"));
    }

    //加载产品列表
    function loadPro(s){
        var target = $("select.productSelect:visible");
        cleanOption(target);
        $.get("${ctx}/inquiry/productList/"+$(s).val(),function(data){
            var skuIds = $("#inquiryProductTable tr").map(function(d){
                return $(this).attr("data-productId");
            }).get();
            data.forEach(function(d){
                if($.inArray(d.productId + '',skuIds) >= 0) return;
                $("<option/>") .val(d.productId)
                        .text(d.productNameCn)
                        .attr("data-logoUrl", d.logoUrl)
                        .attr("data-unitId", d.unitId)
                        .attr("data-unitName", d.unitName)
                        .appendTo(target);
            });
        },"json");
    }

    function setUnitInfo(s){
        var option = $(s).find("option:selected");
        var table = $(s).closest("table");
        $("input[name='unit']",table).val(option.attr("data-unitId"));
        $("input[name='unitName']",table).val(option.attr("data-unitName"));
        $("span.unitName",table).text(option.attr("data-unitName"));
    }

    $(function(){
        $('#dialogModal_ex1').click(function(){
            $('.dialog_content').dialogModal({
                onOkBut: function() {
                    //    var catalog1 = $("select[name='catalog1']",table).val();    //一级分类id
                    //    var catalog2 = $("select[name='catalog2']",table).val();    //二级分类id
                    //    var catalog3 = $("select[name='catalog3']",table).val();    //三级分类id
                    var table = $("table.product:visible");
                    var productSelect = $("select[name='productId']",table);
                    var obj = {};
                    obj.productId = productSelect.val();                                  //产品id
                    if(!obj.productId){
                        alert("请选择产品！");
                        return false;
                    }
                    obj.skuNameCn = "";                                                   //sku名称
                    obj.productName = $("option:selected",productSelect).text();          //产品名称
                    obj.prop = "--";                                             //产品属性
                    obj.logoUrl = $("option:selected",productSelect).attr("data-logoUrl");//产品图片
                    obj.costType = $("select[name='costType']",table).val();               //货币类型
                    obj.unit = $("input[name='unit']",table).val();                         //单位id
                    obj.unitName = $("input[name='unitName']",table).val();                 //单位名称
                    obj.unitPrice = $("input[name='unitPrice']",table).val();               //单价
                    if(!obj.unitPrice){
                        alert("请输入求购价！");
                        return false;
                    }
                    obj.purchareNum = $("input[name='purchareNum']",table).val();         //采购数量
                    if(!obj.purchareNum){
                        alert("请输入采购量！");
                        return false;
                    }
                    obj.standard = $("input[name='standard']",table).val();               //标准件
                    if(!obj.standard){
                        alert("请输入标准件！");
                        return false;
                    }
                    var packageTypeSelect = $("select[name='packageType']",table);
                    obj.packageType = packageTypeSelect.val();                          //包装方式编号
                    obj.packageTypeName = $("option:selected",packageTypeSelect).text();  //包装方式名称
                    $("#inquiryProductTable").append(buildTr(obj));
                },
                onCancelBut: function() {
                },
                onLoad: function() {
                },
                onClose: function() {
                }
            });
        });
        $('#dialogModal_ex2').click(function(){
            $('.dialog_content11').dialogModal({
                onOkBut: function() {
                    var table = $("table.sku:visible");
                    var skuTr = $("table.skuList:visible tr.tr-bg-color");
                    if(!skuTr.size()){
                        alert("请选择商品！");
                        return false;
                    }
                    var obj = {};
                    obj.skuId = skuTr.attr("data-skuId");                           //产品id
                    obj.productId = skuTr.attr("data-productId");                           //产品id
                    obj.skuNameCn = skuTr.attr("data-skuNameCn");                           //产品id
                    obj.productName = skuTr.attr("data-productName");                       //产品名称
                    obj.prop = skuTr.attr("data-prop");                                     //产品属性
                    obj.logoUrl = skuTr.attr("data-logoUrl");                               //产品属性
                    obj.unit = skuTr.attr("data-unit");                                     //单位id
                    obj.unitName = skuTr.attr("data-unitName");                             //单位名称
                    obj.costType = $("select[name='costType']",table).val();                //货币类型
                    obj.unitPrice = $("input[name='unitPrice']",table).val();               //单价
                    if(!obj.unitPrice){
                        alert("请输入求购价！");
                        return false;
                    }
                    obj.purchareNum = $("input[name='purchareNum']",table).val();           //采购数量
                    if(!obj.purchareNum){
                        alert("请输入采购量！");
                        return false;
                    }
                    obj.standard = $("input[name='standard']",table).val();                 //标准件
                    if(!obj.standard){
                        alert("请输入标准件！");
                        return false;
                    }
                    var packageTypeSelect = $("select[name='packageType']",table);
                    obj.packageType = packageTypeSelect.val();                            //包装方式编号
                    obj.packageTypeName = $("option:selected",packageTypeSelect).text();    //包装方式名称
//                    $("#shopsSelect").attr("readonly","disabled");
                    $("#inquiryProductTable").append(buildTr(obj));
                },
                onCancelBut: function() {
                },
                onLoad: function() {
                    var skuTable = $("table.skuList:visible");
                    $.get("${ctx}/inquiry/skuList?shopsId="+$("#shopsId").val()+"&flag="+new Date().getTime(),
                            function(data){
                                skuTable.empty();
                                if(data.length == 0){ alert('没有商品数据！');
                            }
                            var skuIds = $("#inquiryProductTable tr").map(function(d){
                                return $(this).attr("data-skuId");
                            }).get();
                        data.forEach(function(d){
                            if($.inArray(d.skuId + '',skuIds) >= 0) return;
                            var tr = $("<tr onclick='clickSkuTableTr(this)'></tr>")
                            .attr("data-unit", d.unit)
                            .attr("data-unitName", d.unitName)
                            .attr("data-skuId", d.skuId)
                            .attr("data-productId", d.productId)
                            .attr("data-skuNameCn", d.skuNameCn)
                            .attr("data-productName", d.productName)
                            .attr("data-logoUrl",d.logoUrl);
                            var prop = "";
                            d.properties.forEach(function (p) {
                                prop += p.propertyNameCn + "：" + p.propertyValue + "<br/>";
                            });
                            tr.attr("data-prop",prop)
                            .append($("<td><img src='"+ d.logoUrl +"' width='80' height='80' class='l mr-10' />" +
                                    "<span class='l'>"+ d.skuNameCn+"<br/>"+ d.productName+"<br/>" +
                                    "</span></td>")
                            )
                            .appendTo(skuTable);
                        });
                    },"json");
                },
                onClose: function() {
                }
            });
        });
    });

    function buildTr(obj){
        var tr = $("<tr></tr>").attr("data-json",JSON.stringify(obj)).attr("data-skuId",obj.skuId).attr("data-productId",obj.productId);
        $("<td><img src='"+obj.logoUrl+"' width='80' height='80' class='l mr-10'>"+
                " <span class='l'> "+obj.skuNameCn+"<br/>"+obj.productName+"<br></span></td>").appendTo(tr);
        $("<td>"+obj.prop+"<input type='hidden' name='jsonObj' value='"+JSON.stringify(obj)+"'/></td>").appendTo(tr);
        $("<td>采购量："+obj.purchareNum+"&nbsp;"+obj.unitName+"<br/>标准件："+obj.standard+"&nbsp;"+obj.unitName+"/"+obj.packageTypeName+"</td>").appendTo(tr);
        $("<td>求购价："+obj.unitPrice+"</td>").appendTo(tr);
        $("<td>"+(obj.purchareNum*obj.unitPrice)+"</td>").appendTo(tr);
        $("<td class='f-14 user-manage'>" +
                "<a title='编辑' href='javascript:;' onClick='editProduct(this);' class='btn btn-success radius'><i class='icon-edit'></i></a>&nbsp;&nbsp;" +
                "<a title='删除' href='javascript:;' onClick='$(this).parent().parent().remove();' class='btn btn-danger radius'>" +
                "<i class='icon-trash'></i></a></td>").appendTo(tr);
        return tr;
    }
    function clickSkuTableTr(tr){
        var unitName = $(tr).attr("data-unitName");
        $(tr).closest("div#content").find("span.unitName").text(unitName);
        $(tr).addClass("tr-bg-color");
        $(tr).siblings().removeClass("tr-bg-color");
    }

    function editProduct(tr){
        $('.dialog_content22').dialogModal({
            onOkBut: function() {
                var t = $(tr).closest("tr");
                var json = JSON.parse(t.attr("data-json"));
                var table = $("table.product-edit:visible");
                json.costType = $("select[name='costType']",table).val();               //货币类型
                json.unit = $("input[name='unit']",table).val();                       //单位id
                json.unitName = $("input[name='unitName']",table).val();               //单位名称
                json.unitPrice = $("input[name='unitPrice']",table).val();             //单价
                json.purchareNum = $("input[name='purchareNum']",table).val();         //采购数量
                json.standard = $("input[name='standard']",table).val();               //标准件
                var packageTypeSelect = $("select[name='packageType']",table);
                json.packageType = packageTypeSelect.val();                            //包装方式编号
                json.packageTypeName = $("option:selected",packageTypeSelect).text();  //包装方式名称
                t.replaceWith(buildTr(json));
            },
            onCancelBut: function() {
            },
            onLoad: function() {
                var json = JSON.parse($(tr).closest("tr").attr("data-json"));
                var table = $("table.product-edit:visible");
                $("span.unitName",table).text(json.unitName);
                $("input[name='costType']",table).val(json.costType);               //货币类型
                $("input[name='unit']",table).val(json.unit);                       //单位id
                $("input[name='unitName']",table).val(json.unitName);               //单位名称
                $("input[name='unitPrice']",table).val(json.unitPrice);             //单价
                $("input[name='purchareNum']",table).val(json.purchareNum);         //采购数量
                $("input[name='standard']",table).val(json.standard);               //标准件
                $("select[name='packageType']",table).val(json.packageType);        //包装方式编号
            },
            onClose: function() {
            }
        });
    }
    function checkInquiryForm(){
//        alert($("input[name='effectiveDate']").val());
//        alert($("input[name='deliveryDate']").val());
//        alert($("input[name='lastDate']").val());
        var a = $("input[name='deliveryDate']").val();
        var b = $("input[name='lastDate']").val();
        if(a > b){
            alert("最晚交货日期必须在预计交货日期之后！");
            return false;
        }
        if(!$("#orgId").val()){
            alert("请选择买方企业！");
            return false;
        }
        if($("#inquiryProductTable tr").size() == 0){
            alert("请添加询盘商品！");
            return false;
        }
    }


  function  paywayLastShow(){
      //alert($("#paywayPercent").val());
     if(3==$("#paywayPercent").val()){
         $("#paywayLast").hide();
     }else{
         $("#paywayLast").show();
     }
  }

    function effectiveDateChange(){
        if(1==$("#effectiveDateSelect").val()){
            $("#effectiveDateTxt").html(CurrentDateAddDay(0));
            $("input[name='effectiveDate']").val(CurrentDateAddDay(0));
            alert($("input[name='effectiveDate']").val());

        }else if(2==$("#effectiveDateSelect").val()){
            $("#effectiveDateTxt").html(CurrentDateAddDay(2));
            $("input[name='effectiveDate']").val(CurrentDateAddDay(2));
        }else if(3==$("#effectiveDateSelect").val()){
            $("#effectiveDateTxt").html(CurrentDateAddDay(4));
            $("input[name='effectiveDate']").val(CurrentDateAddDay(4));
        }
    }

    function CurrentDateAddDay(n){
        var s, d, t, t2;
        t = new Date().getTime();
        t2 = n * 1000 * 3600 * 24;
        t+= t2;
        d = new Date(t);
        s = d.getUTCFullYear() + "-";
        s += ("00"+(d.getUTCMonth()+1)).slice(-2) + "-";
        s += ("00"+d.getUTCDate()).slice(-2);
        return s;
    }
</script>
</body>
</html>