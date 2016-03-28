<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>交易中心-询盘新增</title>
    <%@include file="/WEB-INF/common/global/common.jsp"%>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">交易中心</a>
    </li>
    <li>
        <a href="${ctx}/inquiry/list">询盘回盘管理</a>
    </li>
    <li>
        <a href="${ctx}/inquiry/add">新增询盘</a>
    </li>
</nav>
<div class="container-fluid datepicker_checktime">
    <form id="inquiryForm" class="formtable">
        <div class="formtable-cont">
            <h4 class="header">新增询盘</h4>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">买方：</label>
                    <div class="col-sm-7 col-md-8 hide-input">
                        <input class="form-control" id="userName"  name="userName" placeholder="请输入买方名称" >
                        <input class="hide" name="userId" id="userId"/>
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">结算币种：</label>
                    <div class="col-sm-7 col-md-8">
                        <select class="form-control" name="costType" id="costType">
                            <c:forEach var="costType" items="${view.costType}">
                                <option value="${costType.constValue}">${costType.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <label class="col-sm-2">目标商铺：</label>
                <div class="col-sm-10">
                    <div class="form-inline">
                        <div class="form-group hide-input">
                            <input class="form-control" id="shopsName"  name="shopsName" placeholder="请输入商铺名称">
                            <input class="hide" name="shopsId" id="shopsId"/>
                        </div>
                        <button class="btn btn-primary " type="button" data-toggle="modal" data-target="#chooseComm" id="findSku" style="display: none">选取询价商品</button>
                        <button class="btn btn-primary" type="button" data-toggle="modal" data-target="#addComm" id="addSku">新增询价商品</button>
                    </div>
                </div>
            </div>
            <div class="formtable-list pad_r10 hide-input">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>商品</th>
                        <th>商品属性</th>
                        <th>采购量</td>
                        <th>标准件</th>
                        <th>求购价</th>
                        <th>总价</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="skuTable">
                    </tbody>
                </table>
                <input class="hide table-hide" name="tableLength" id="tableLength" style="top:auto">
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">询盘有效期：</label>
                    <div class="col-sm-7 col-md-8 hide-input">
                        <select class="form-control" id="effectiveDateSelect" onclick="effectiveDateChange()">
                            <option value="">请选择</option>
                            <c:forEach var="effectiveDate" items="${view.effectiveDate}">
                                <option value="${effectiveDate.constValue}">${effectiveDate.constName}</option>
                            </c:forEach>
                        </select>
                        <input class="hide" name="effectiveDate"/>
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">支付方式：</label>
                    <div class="col-sm-7 col-md-8 label-cont">线下支付</div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">交货地（自提）：</label>
                    <div class="col-sm-7 col-md-8">
                        <select class="form-control" name="deliveryAddrId">
                            <c:forEach var="deliveryAddr" items="${view.deliveryAddrList}">
                                <option value="${deliveryAddr.constValue}">${deliveryAddr.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">预付款比例：</label>
                    <div class="col-sm-7 col-md-8">
                        <select class="form-control" name="paywayPercent" id="paywayPercent">
                            <c:forEach var="paywayPercent" items="${view.paywayPercentList}">
                                <option value="${paywayPercent.constValue}">${paywayPercent.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">预计交货日期：</label>
                    <div class="col-sm-7 col-md-8">
                        <div class="input-group datepicker date mar_l5" id="divDeliveryDate">
                            <input type="text"  class="form-control"  style="margin: 0px;" name="deliveryDate">
                            <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">尾款支付限期：</label>
                    <div class="col-sm-7 col-md-8">
                        <select class="form-control"   name="paywayLast" id="paywayLast">
                            <c:forEach var="paywayLast" items="${view.paywayLastList}">
                                <option value="${paywayLast.constValue}">${paywayLast.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">最晚交货日期：</label>
                    <div class="col-sm-7 col-md-8">
                        <div class="input-group datepicker date mar_l5" id="lastDate">
                            <input type="text" class="form-control"  style="margin: 0px;" name="lastDate">
                            <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">附加说明：</label>
                    <div class="col-sm-7 col-md-8">
                        <textarea class="form-control" rows="5" name="memo"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" id="skuJson" name="skuJson"/>
        <input type="hidden" id="inquiryType" name="inquiryType"/>
        <input type="hidden" id="payType" name="payType" value="1"/>
        <input type="hidden" id="takeGoodsType" name="takeGoodsType" value="1"/>
        <div class="text-center">
            <button class="btn btn-primary">保存</button>
        </div>
    </form>
</div>
<div class="modal fade" id="chooseComm" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="findSkuForm">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">选择商品</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-6 select-prod skuList" id="skuList">
                        </div>
                        <div class="col-xs-6">
                            <div class="row ">
                                <label class="col-xs-5 formtable-list-require mar_t5">求购价：</label>
                                <div class="col-xs-7">
                                    <div class="form-inline">
                                        <div class="form-group">
                                            <input type="text" class="form-control wid-80" name="unitPrice">
                                        </div>
                                        <div class="form-group" id="choosePrice"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mar_t5">
                                <label class="col-xs-5 formtable-list-require mar_t5">采购量：</label>
                                <div class="col-xs-7">
                                    <div class="form-inline">
                                        <div class="form-group">
                                            <input type="text" class="form-control wid-80" name="purchareNum">
                                        </div>
                                        <div class="form-group" id="chooseNum"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mar_t5">
                                <label class="col-xs-5 formtable-list-require mar_t5">标准件：</label>
                                <div class="col-xs-7">
                                    <div class="form-inline">
                                        <div class="form-group">
                                            <input type="text" class="form-control wid-80" name="standard">
                                        </div>
                                        <div class="form-group" id="chooseStand"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mar_t5">
                                <label class="col-xs-5 formtable-list-require mar_t5">包装方式：</label>
                                <div class="col-xs-7">
                                    <div class="form-inline">
                                        <div class="form-group">
                                            <select class="form-control" name="packageType">
                                                <c:forEach var="packageType" items="${view.packageType}">
                                                    <option value="${packageType.constValue}">${packageType.constName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary">选择</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal fade" id="addComm" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="addSkuForm">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">新增商品</h4>
                </div>
                <div class="modal-body">
                    <div class="row modal-row">
                        <label class="col-xs-2 formtable-list-require">商品：</label>
                        <div class="col-xs-10  hide-input">
                            <div class="form-inline">
                                <div class="form-group">
                                    <select class="form-control" id="catalog1"
                                            onchange="loadCs2(this);">
                                        <option value="">请选择</option>
                                        <c:forEach items="${view.catalogList}" var="catalog">
                                            <option value="${catalog.catalogId}">${catalog.catalogNameCn}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <select class="form-control catalogSelect2" id="catalog2"
                                            onchange="loadCs3(this);">
                                        <option value="">请选择</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <select class="form-control catalogSelect3" id="catalog3"
                                            onchange="loadPro(this);">
                                        <option value="">请选择</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <select class="form-control productSelect" name="productId" id="productId">
                                        <option value="">请选择</option>
                                    </select>
                                </div>
                            </div>
                            <input class="hide" name="product" value="" id="product">
                        </div>
                    </div>
                    <div class="row modal-row">
                        <label class="col-xs-2 formtable-list-require">求购价：</label>
                        <div class="col-xs-10">
                            <div class="form-inline">
                                <div class="form-group">
                                    <input type="text" class="form-control wid-100" name="unitPrice">
                                </div>
                                <div class="form-group" id="unitPriceId">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row modal-row">
                        <label class="col-xs-2 formtable-list-require">采购量：</label>
                        <div class="col-xs-10">
                            <div class="form-inline">
                                <div class="form-group">
                                    <input type="text" class="form-control wid-100" name="purchareNum">
                                </div>
                                <div class="form-group" id="purchareNumId"></div>
                            </div>
                        </div>
                    </div>
                    <div class="row modal-row">
                        <label class="col-xs-2 formtable-list-require">标准件：</label>
                        <div class="col-xs-10">
                            <div class="form-inline">
                                <div class="form-group">
                                    <input type="text" class="form-control wid-100" name="standard">
                                </div>
                                <div class="form-group" id="standardId"></div>
                            </div>
                        </div>
                    </div>
                    <div class="row modal-row">
                        <label class="col-xs-2 formtable-list-require">包装方式：</label>
                        <div class="col-xs-10">
                            <div class="form-inline">
                                <div class="form-group">
                                    <select class="form-control" name="packageType">
                                        <c:forEach var="packageType" items="${view.packageType}">
                                            <option value="${packageType.constValue}">${packageType.constName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal fade" id="editComm" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="updateSkuForm">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">编辑商品</h4>
                </div>
                <div class="modal-body">
                    <div class="row modal-row">
                        <label class="col-xs-2 formtable-list-require">求购价：</label>
                        <div class="col-xs-10">
                            <div class="form-inline">
                                <div class="form-group">
                                    <input type="text" class="form-control wid-100" name="unitPrice" id="updateSkuPrice"/>
                                    <span id="updateSkuCost"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row modal-row">
                        <label class="col-xs-2 formtable-list-require">采购量：</label>
                        <div class="col-xs-10">
                            <div class="form-inline">
                                <div class="form-group">
                                    <input type="text" class="form-control wid-100" name="purchareNum" id="updateSkuPurchareNum">
                                    <span id="updateSkuUnit"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row modal-row">
                        <label class="col-xs-2 formtable-list-require">标准件：</label>
                        <div class="col-xs-10">
                            <div class="form-inline">
                                <div class="form-group">
                                    <input type="text" class="form-control wid-100" name="standard" id="updateSkuStandard">
                                    <span id="updateSkuStandardUnit"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row modal-row">
                        <label class="col-xs-2 formtable-list-require">包装方式：</label>
                        <div class="col-xs-10">
                            <div class="form-inline">
                                <div class="form-group">
                                    <select class="form-control" name="packageType" id="updateSkuPackageType">
                                        <c:forEach var="packageType" items="${view.packageType}">
                                            <option value="${packageType.constValue}">${packageType.constName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="updateSkuId" name="skuId">
                <input type="hidden" id="updateProductId" name="productId">
                <div class="modal-footer">
                    <button class="btn btn-primary">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/inquiry/new_add.js"></script>
<script>
//    $(function(){

//        $("#divDeliveryDate").on('changeDate', function(ev) {
//            var datepickerBefore =$("#divDeliveryDate").children("input").val();
//            $("#divLastDate").datetimepicker("setStartDate",datepickerBefore);
//        });
//        $("#divLastDate").on('changeDate', function(ev) {
//            var datepickerBefore =$("#divLastDate").children("input").val();
//            $("#divDeliveryDate").datetimepicker("setEndDate",datepickerBefore);
//        });
//    });

</script>
</body>
</html>