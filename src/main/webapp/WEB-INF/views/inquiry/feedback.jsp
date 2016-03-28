<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>
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
  <link href="${ctx}/resources/font/font-awesome-ie7.min.css" rel="stylesheet" type="text/css" />
  <![endif]-->
    <style>
        .tr-bg-color{
            background: #DDD;
        }
    </style>
  <title>回复询盘</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 商机中心 <span class="c-gray en">&gt;</span> 询盘回盘管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a> <span class="c-gray en">&gt;</span><a href="#">回复询盘</a></nav>
<div class="pd-20">
  <form action="${ctx}/inquiry/feedback" method="post" onsubmit="return checkFeedbackForm()">
  <input type="hidden" name="inquiryId" value="${entity.inquiryId}"/>
      <input type="hidden" name="inquiryType" value="${entity.inquiryType}"/>
      <input type="hidden" name="shopsId" value="${entity.shopsId}" id="shopsId">
      <input type="hidden" name="orgId" value="" id="orgId"/>
      <input type="hidden" name="userId" value="" id="userId">
      <c:if test="${entity.inquiryType == 1}">
      <input type="hidden" name="inquiryFeedbackId" value="${entity.inquiryFeedbackId}"/>
      </c:if>
  <table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
    <thead>
    <tr class="text-l">
      <th width="106"><span class="l f-16">询盘信息</span> <span class="r">询盘编号：${entity.inquiryCode}</span> </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
  </table>
  <table class="table table-border table-bordered table-bg table-sort">
    <tbody>
    <tr>
      <th width="190" class="text-r"> 买方：</th>
      <td>${entity.orgName}</td>
    </tr>
    <c:if test="${entity.inquiryType == 1}">
      <tr>
        <th class="text-r">卖方：</th>
        <td>${entity.feedbackOrgName} &gt; ${entity.feedbackShopsName} &nbsp;  ${entity.userName}</td>
      </tr>
    </c:if>
    <c:if test="${entity.inquiryType == 2}">
      <tr>
        <th class="text-r"><span class="c-red">*</span>目标商铺：</th>
        <td><input id="shopsNameInput" name="shopsName" type="search" class="input-text" style="width:200px" value="" placeholder="请输入店铺名称，支持模糊查询">
            </td>
      </tr>
    </c:if>
    </tbody>
  </table>
  <table class="table table-border table-bordered table-hover table-bg table-sort" id="skuTable">
    <thead>
    <tr class="text-c">
      <th width="412">商品</th>
      <th width="355">商品属性</th>
      <th width="311">采购详情</th>
      <th width="193">单价<br>(CNY)</th>
      <th width="133">总价<br>(CNY)</th>
    </tr>
    </thead>
    <tbody>
    <c:if test="${entity.inquiryType == 2}">
        <c:forEach items="${entity.inquiryProductList}" var="product">
          <c:set var="totalMoney" value="${totalMoney + product.purchareNum * product.unitPrice}" scope="page"/>
            <tr class="text-l">
                <td><img src="${product.logoUrl}" width="80" height="80" class="l mr-10">
                    <span><br>${product.productName}</span>
                </td>
                <td id="product-${product.productId}">
                    <input name='skuId#${product.id}' type='hidden' value='' class="skuId"/>
                    <span class="l">
                    <button type="button" data-dialogModalBind=".dialog_content" data-productId="${product.productId}"
                            class="dialogModalButton btn btn-success radius">选择现有商品</button>
                    &nbsp;&nbsp;<a href="${ctx}/sku/add" class="btn btn-primary radius"><i class="icon-plus"> </i> 添加新商品</a>
                    </span>
                </td>
                <td>
                    采购量：${product.purchareNum}&nbsp;${product.unitName} <br>
                    标准件：${product.standard}&nbsp;${product.unitName}&nbsp;/
                    <c:if test="${product.packageType == 1}">箱</c:if>
                    <c:if test="${product.packageType == 2}">盒子</c:if>
                    <c:if test="${product.packageType == 3}">桶</c:if>
                </td>
                <td>求购价：<fmt:formatNumber value="${product.unitPrice}" pattern="#,##0.00"/><br/>
                    报&nbsp;&nbsp;&nbsp;价：
                  <input type="text" name="unitPrice#${product.id}" id="feedbackUnitPrice" value=""
                         onblur="computeMoney(this,'${product.purchareNum}');" style="width: 50px;"/></td>
                <td class="totalMoney" style="text-align: right;">${product.purchareNum * product.unitPrice}</td>
            </tr>
          <c:set var="total" value="0" />
        </c:forEach>
    </c:if>
    <c:if test="${entity.inquiryType == 1}">
        <c:forEach items="${entity.inquiryProductList}" var="product">
          <c:set var="totalMoney" value="${totalMoney + product.purchareNum * product.unitPrice}" scope="page"/>
            <tr class="text-l">
              <td><img src="${product.logoUrl}" width="80" height="80" class="l mr-10">
                  <span><br>${product.skuName}&nbsp;&nbsp;${product.productName}</span>
              </td>
              <td>
                  <c:if test="${fun:length(product.properties) == 0}">--</c:if>
                  <c:forEach items="${product.properties}" var="prop">
                      ${prop.propertyName}：${prop.propertyValue}<br/>
                  </c:forEach>
              </td>
              <td>
                  采购量：${product.purchareNum}&nbsp;${product.unitName} <br>
                  标准件：${product.standard}&nbsp;${product.unitName}&nbsp;/
                  <c:if test="${product.packageType == 1}">箱</c:if>
                  <c:if test="${product.packageType == 2}">盒子</c:if>
                  <c:if test="${product.packageType == 3}">桶</c:if>
              </td>
              <td>求购价：<fmt:formatNumber value="${product.unitPrice}" pattern="#,##0.00"/><br/>
                  报&nbsp;&nbsp;&nbsp;价：
                <input type="text" name="unitPrice#${product.id}" id="feedbackUnitPrice"
                       onblur="computeMoney(this,'${product.purchareNum}');" style="width: 50px;"/></td>
              <td class="totalMoney" style="text-align: right;">
                  <fmt:formatNumber value="${product.purchareNum * product.unitPrice}" pattern="#,##0.00"/>
              </td>
            </tr>
        </c:forEach>
    </c:if>
    </tbody>
  </table>
  <table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top2">
    <thead>
    <tr class="text-l">
      <th width="106">
          <span class="r">合计：CNY&nbsp;
              <b id="totalMoney">
                <fmt:formatNumber value="${totalMoney}" pattern="#,##0.00"/>
              </b>
          </span>
          <input id="cost" name="cost" type="hidden" value="${totalMoney}"/>
          <input id="costType" name="costType" type="hidden" value="1"/>
      </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
  </table>
  <div class="clear"></div>
  <table class="table table-border table-bordered table-bg table-sort mt-15">
    <tbody>
    <tr>
      <th width="190" class="text-r"><span class="c-red">*</span> 交货地：</th>
      <td width="400">
          <select class="select" name="deliveryAddrId" size="1" style="width:120px">
            <option value="1" <c:if test="${entity.deliveryAddrId == 1}">selected</c:if>>满洲里</option>
            <option value="2" <c:if test="${entity.deliveryAddrId == 2}">selected</c:if>>赤塔</option>
            <option value="3" <c:if test="${entity.deliveryAddrId == 3}">selected</c:if>>乌兰乌德</option>
            <option value="4" <c:if test="${entity.deliveryAddrId == 4}">selected</c:if>>伊尔库兹克</option>
            <option value="5" <c:if test="${entity.deliveryAddrId == 5}">selected</c:if>>新西伯利亚</option>
         </select>
      </td>
      <th class="text-r"><span class="c-red">*</span>询盘有效期： </th>
      <td>

        <input class="Wdate" name="effectiveDate" hidden type="text" value="<odpf:formatDate style='DATE' date='${entity.effectiveDate}'/>" onFocus="WdatePicker({isShowClear:false,readOnly:true,maxDate:'$y-%M-%d'})"/>

         <span id="effectiveDateDiv"></span>

      </td>
    </tr>
    <tr>
      <th width="194" class="text-r"><span class="c-red">*</span>交货日期：</th>
      <td><input class="Wdate" name="deliveryDate" type="text" value="<odpf:formatDate style='DATE' date='${entity.deliveryDate}'/>" onFocus="WdatePicker({isShowClear:false,readOnly:true,minDate:'$y-%M-%d'})"/>
        &nbsp;&nbsp;—>&nbsp;&nbsp;<input class="Wdate" name="lastDate" type="text" value="<odpf:formatDate style='DATE' date='${entity.lastDate}'/>" onFocus="WdatePicker({isShowClear:false,readOnly:true,minDate:'$y-%M-%d'})"/></td>
    </tr>
    <tr>
      <th rowspan="3" valign="top" class="text-r"><span class="c-red">*</span>付款方式：</th>
      <td rowspan="3" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="table-border">
        <tbody>
        <tr>
            <td>支付方式：</td>
            <td>
                线下支付
            </td>
        </tr>
        <tr>
          <td width="32%">预付款比例:</td>
          <td width="68%">
            <select class="select" id="paywayPercent" name="paywayPercent" size="1" style="width:120px">
              <option value="3" <c:if test="${entity.paywayPercent == 3}">selected</c:if>>100%</option>
              <option value="2" <c:if test="${entity.paywayPercent == 2}">selected</c:if>>50%</option>
              <option value="1" <c:if test="${entity.paywayPercent == 1}">selected</c:if>>30%</option>
          </select>
          </td>
        </tr>
        <tr id="paywayLast"<c:if test="${entity.paywayPercent == 3}">style="display:none"</c:if>>
          <td>尾款支付限期:</td>
          <td>
            <select class="select" name="paywayLast" size="1" style="width:120px">
              <option value="1" <c:if test="${entity.paywayLast == 1}">selected</c:if>>提货时付款</option>
              <option value="2" <c:if test="${entity.paywayLast == 2}">selected</c:if>>提货后30天内付款</option>
              <option value="3" <c:if test="${entity.paywayLast == 3}">selected</c:if>>提货后60天内付款</option>
          </select>
          </td>
        </tr>
        </tbody>
      </table></td>
      <th valign="top" class="text-r"><p><span class="c-red">*</span>提货方式：</p></th>
      <td valign="top">
        自提
        <br></td>
    </tr>
    <tr>
      <th valign="top" class="text-r">附加说明：</th>
      <td valign="top">${entity.memo}</td>
    </tr>
    <tr>
      <th valign="top" class="text-r">附加说明回复：</th>
      <td valign="top">
        <textarea class="input-text" name="memo" id="Remarks" style="height:50px;width:300px;"></textarea>
      </td>
    </tr>
    <tr>
      <th class="text-r">&nbsp;</th>
      <td colspan="3">
          <button class="btn btn-success radius" type="submit"><i class="icon-ok"></i> 回复</button>
          <c:if test="${entity.inquiryType == 1}">
          <button class="btn btn-success radius" type="button" onclick="refuseInquiry('${entity.inquiryFeedbackId}','${entity.inquiryType}')">
              <i class="icon-ok"></i> 拒绝</button></td>
          </c:if>
    </tr>
    </tbody>
  </table>
  </form>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
</div>

<div id="dialog_content" class="dialog_content" style="display:none">
    <div class="dialogModal_header">选取询价商品</div>
    <div class="dialogModal_content">
        <div id="content" >
            <div class="la_1">
                <table class="skuList table table-border table-bordered table-bg table-hover table-sort">
                </table>
            </div>
        </div>
    </div>
    <div class="dialogModal_footer">
        <button type="button" class="btn btn-primary radius" data-dialogModalBut="ok">选取</button>
        <button type="button" class="btn radius" data-dialogModalBut="cancel">取消</button>
    </div>
</div>

<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script language="javascript" src="${ctx}/resources/js/position_top.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-ui.js"></script>
<script src="${ctx}/resources/js/popModal.js"></script>
<script>

    $("#paywayPercent").change(function(){
        if($("#paywayPercent").val()==3){
            $("#paywayLast").attr("style","display:none")
        }else{
            $("#paywayLast").removeAttr("style")
        }
    })

    //模糊搜索店铺
    $("#shopsNameInput").autocomplete({
        source:"${ctx}/inquiry/shopList",
        minLength : 1,
        autoFocus:true,
        search: function(e, ui) {
            $("#shopsId").val('');
            $("#orgId").val('');
            $("#userId").val('');
        },
        select : function(e,ui){
            $("#shopsId").val(ui.item.id);
            $("#orgId").val(ui.item.orgId);
            $("#userId").val(ui.item.userId);
            $("table.skuList:visible").empty();
        }
    });

    $(function(){
        $('#effectiveDateDiv').text($("input[name='effectiveDate']").val());

        $('.dialogModalButton').click(function(){
            var productId = $(this).attr("data-productId");
            $('.dialog_content').dialogModal({
                onOkBut: function() {
                    var skuTr = $("table.skuList:visible tr.tr-bg-color");
                    $("#product-"+productId +" input").val(skuTr.attr("data-skuId"));
                    $("#product-"+productId +" span").html(skuTr.attr("data-prop"));
                },
                onCancelBut: function() {},
                onLoad: function() {
                    var shopsId = $("#shopsId").val();
                    if(!shopsId){
                        alert("请先选择店铺！");
                        return;
                    }
                    var skuTable = $("table.skuList:visible");
                    $.get("${ctx}/inquiry/skuList",{shopsId:shopsId,productId:productId},function(data){
                         skuTable.empty();
                        if(data.length == 0){
                            alert('没有商品数据！');
                        }
                         data.forEach(function(d){
                             var tr = $("<tr onclick='clickSkuTableTr(this)'></tr>")
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
                             .append($("<td><img src='"+ d.logoUrl +"' width='80' height='80' class='l mr-10'/>" +
                             "<span class='l'>"+ d.skuNameCn+"<br/>"+ d.productName+"<br/>"+
                             "</span></td>")).appendTo(skuTable);
                         });
                     },"json");
                },
                onClose: function() {}
            });
        });
    });
    function clickSkuTableTr(tr){
        $(tr).addClass("tr-bg-color");
        $(tr).siblings().removeClass("tr-bg-color");
    }
    function refuseInquiry(inquiryFeedbackId,inquiryType){
        $.get("${ctx}/inquiry/refuse",{inquiryFeedbackId:inquiryFeedbackId,type:inquiryType},function(){
            window.location.href="${ctx}/inquiry/list";
        });
    }
    function checkFeedbackForm(){
        if(!$("#feedbackUnitPrice").val()){
            alert("回盘报价不能为空");
            return false;
        }

        if(${entity.inquiryType == 2}){
            if(!$("#shopsId").val()){
                alert("请选择目标店铺！");
                return false;
            }
        }
        $("input.skuId").each(function(i,d){
            if(!$(d).val()){
                alert("请选择现有商品！");
                return false;
            }
        });
    }

    function computeMoney(purchareInput,purchareNum){
        var input = $(purchareInput);
        var exp = /^([1-9]\d{0,6})(\.\d{1,2})?$/;   //验证金额的正则表达式
        if(!exp.test(input.val())){
            input.focus();
            alert("请输入正确的报价！");
            return;
        }
        input.parent().next().find("div.totalMoney").text(toThousands(input.val() * purchareNum));
        var totalMoney = 0;
        input.closest("table").find("div.totalMoney").each(function(i,d){
            totalMoney += parseFloat($(d).text().trim().replace(/,/g,''));
        });
        $("#totalMoney").text(toThousands(totalMoney));
        $("#cost").val(totalMoney);
    }

    /**
     * 对金钱格式化
     */
    function toThousands(num) {
        var num = (num.toFixed(2) || 0).toString(), result = '',suffix = '';
        var index = num.indexOf('.');
        if(index > 0){
            suffix = num.slice(index) ;
            if(suffix.length < 3){
                suffix += '0';
            }
            num = num.slice(0,index);
        }
        while (num.length > 3) {
            result = ',' + num.slice(-3) + result;
            num = num.slice(0, num.length - 3);
        }
        if (num) { result = num + result; }
        result += index > 0 ? suffix : '.00';
        return result;
    }

    function toThousand(num) {
        var result = (num.toFixed(2) || 0).toString().replace(/(d)(?=(?:d{3})+$)/g, '$1,');
        if(result.indexOf('.') < 0){
            result += '.00';
        }
        return result;
    }
</script>
</body>
</html>