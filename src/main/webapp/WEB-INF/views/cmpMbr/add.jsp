<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>用户中心-企业信息编辑</title>
    <%@include file="/WEB-INF/common/global/common.jsp" %>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">会员中心</a>
    </li>
    <li>
        <a href="${ctx}/cmpMbr/list">企业会员管理</a>
    </li>
    <li>
        <a href="${ctx}/cmpMbr/add">企业会员编辑</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">


        <form class="formtable-cont" action="${ctx}/cmpMbr/addMbr" id="cmpMbrBasicInfo" method="post">
            <h4 class="header header-fl" id="baseInfo">基本信息</h4>
            <input type="submit" id="save" value="保存" class="btn btn-primary header-button"/>

            <div class="clear"></div>
            <div class="formtable-list">
                <label class="col-sm-2 formtable-list-require">企业身份：</label>

                <div class="col-sm-10 select-label mar_t5 mar_l-5">
                    <c:forEach items="${companyInfo.identityBoList}" var="identity" varStatus="status">
                        <c:set var="iscontain" value="false"/>
                        <label class="btn btn-default mar_l10">
                            <input type="checkbox" name="identities"
                                   value="${identity.identityId}"/> ${identity.identityName}
                        </label>
                    </c:forEach>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">公司名称（中文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <input type="text" name="orgNameCn" class="form-control" value="${companyInfo.orgBo.orgNameCn}">
                        <input type="hidden" name="id" value="${companyInfo.orgBo.id}">
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require" >公司名称（俄文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <input type="text" name="orgNameRu" class="form-control" value="${companyInfo.orgBo.orgNameRu}">
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <label class="col-sm-2 formtable-list-require">公司地址（地区）：</label>

                <div class="col-sm-10">
                    <div class="form-inline">
                        <div class="form-group">
                            <select class="form-control" id="countryId" name="countryType">
                                <option value="">--国家--</option>
                                <c:forEach items="${companyInfo.countryList}" var="ctr">
                                    <option value="${ctr.constValue}"
                                            <c:if test="${companyInfo.orgBo.countryType==ctr.constValue}">selected</c:if> >
                                            ${ctr.constName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <select class="form-control" id="provinceId" name="provId">
                                <option value="">--省份--</option>
                                <c:forEach items="${companyInfo.provList}" var="prov">
                                    <option value="${prov.id}"
                                            <c:if test="${companyInfo.orgBo.provId==prov.id}">selected</c:if> >
                                            ${prov.cnname}(${prov.enname})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <select class="form-control" id="cityId" name="cityId">
                                <option value="">--市/地区--</option>
                                <c:forEach items="${companyInfo.cityList}" var="cityId">
                                    <option value="${cityId.id}"
                                            <c:if test="${companyInfo.orgBo.cityId==cityId.id}">selected</c:if> >
                                            ${cityId.cnname}( ${cityId.enname})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <select class="form-control" id="districtId" name="distId">
                                <option value="">---区/县---</option>
                                <c:forEach items="${companyInfo.distList}" var="dictId">
                                    <option value="${dictId.id}"
                                            <c:if test="${companyInfo.orgBo.distId==dictId.id}">selected</c:if> >
                                            ${dictId.cnname}( ${dictId.enname})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">公司地址（中文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <input type="text" class="form-control" name="addrCn">
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">公司地址（俄文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <input type="text" class="form-control" name="addrRu">
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">公司介绍（中文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <textarea class="form-control" rows="7" name="summaryCn"
                                  placeholder="请输入500个以内中文字符">${companyInfo.orgBo.summaryCn}</textarea>
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">公司介绍（俄文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <textarea name="summaryRu" class="form-control" rows="7"
                                  placeholder="请输入500个以内俄文字符"></textarea>
                    </div>
                </div>
            </div>
            <div class="formtable-list formtable-list-require" >
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">公司法人：</label>

                    <div class="col-sm-7 col-md-8"><input name="corporation" class="form-control"/></div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">公司法人（拼音）：</label>

                    <div class="col-sm-7 col-md-8">
                        <input type="text" name="corporationPy" class="form-control">
                    </div>
                </div>

            </div>
            <div class="formtable-list ">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">经营范围(中文)：</label>

                    <div class="col-sm-7 col-md-8">
                        <input type="text" class="form-control" name="optRegionCn">
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">经营范围(俄文)：</label>

                    <div class="col-sm-7 col-md-8">
                        <input type="text" class="form-control" name="optRegionRu">
                    </div>
                </div>

            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">注册地（中文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <input type="text" class="form-control" value="${companyInfo.orgBo.corpRegaddrCn}" name="corpRegaddrCn">
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">注册地（俄文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <input type="text" class="form-control" value="${companyInfo.orgBo.corpRegaddrRu}" name="corpRegaddrRu">
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">注册时间：</label>
                    <div class="col-sm-7 col-md-8">
                        <div class="input-group datepicker date mar_l5">
                            <input type="text" name="corpRegtime" class="form-control"  style="margin: 0px;"
                               value='<fmt:formatDate value="${companyInfo.orgBo.corpRegtime}" pattern="yyyy-MM-dd"/>'>
                            <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">税务登记号：</label>

                    <div class="col-sm-7 col-md-8">
                        <input type="text" class="form-control" value="${companyInfo.orgBo.taxCert}" name="taxCert">
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/company/edit.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/cmpMbr/add.js"></script>
</body>
</html>