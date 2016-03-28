<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <title>会员中心-企业信息查看</title>
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
        <a href="${ctx}/cmpMbr/info?orgId=${companyInfo.orgBo.id}">企业会员详情</a>
    </li>
</nav>
<div class="container-fluid">
<div class="formtable">
<div class="formtable-nav">
    <ul class="list-inline">
        <li><a href="#baseInfo" class="btn btn-primary">基本信息</a></li>
        <li><a href="#compApti" class="btn btn-primary">企业资质</a></li>
        <li><a href="#serv" class="btn btn-primary">服务范围</a></li>
        <li><a href="#industry" class="btn btn-primary">从事行业</a></li>
        <li><a href="#servApti" class="btn btn-primary">其他资质</a></li>
        <li><a href="#checkAnchor" class="btn btn-primary">审核</a></li>
        <li class="pull-right">
            <c:if test="${!companyInfo.orgBo.disabled}">
                <a  href="${ctx}/cmpMbr/changeUseable?orgId=${companyInfo.orgBo.id}&disabled=1" onclick="return confirm('确定要停用该用户吗？')" class="btn btn-danger">停用</a>
            </c:if>
            <c:if test="${companyInfo.orgBo.disabled}">
                <a  href="${ctx}/cmpMbr/changeUseable?orgId=${companyInfo.orgBo.id}&disabled=0"  onclick="return confirm('确定要启用该用户吗？')" class="btn btn-success">启用</a>
            </c:if>
            <a href="${ctx}/cmpMbr/edit?orgId=${companyInfo.orgBo.id}" class="btn btn-default">编辑</a>
        </li>
    </ul>
</div>
<div class="formtable-cont">
    <h4 class="header" id="baseInfo">基本信息</h4>
    <div class="formtable-list">
            <label class="col-sm-2">企业身份：</label>
            <div class="col-sm--10 label-cont" style="margin-top: 3px;">
                <c:forEach items="${fn:split(companyInfo.orgBo.identityNameList,',')}" var="orgIdentity" >
                    <span class="label label-white">${orgIdentity}</span>
                </c:forEach>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">企业状态：</label>
            <div class="col-sm-7 col-md-8 label-cont">
                <%-- //1初审2通过3待审核4拒绝--%>
                <c:if test="${companyInfo.orgBo.orgAdultStatus==1}"><span class="icon icon-wait"></span>初审</c:if>
                <c:if test="${companyInfo.orgBo.orgAdultStatus==2}"><span class="icon icon-right"></span>审核通过</c:if>
                <c:if test="${companyInfo.orgBo.orgAdultStatus==3}"><span class="icon icon-wait"></span>待审核</c:if>
                <c:if test="${companyInfo.orgBo.orgAdultStatus==4}"><span class="icon icon-close"></span>拒绝</c:if>

            </div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">公司名称（中文）：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.orgNameCn}</div>
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">公司名称（俄文）：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.orgNameRu}</div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">公司地址（地区）：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.provinceNameCn} ${companyInfo.orgBo.cityNameCn} ${companyInfo.orgBo.districtNameCn}</div>
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">公司地址（中文）：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.addrCn}</div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">公司地址（俄文）：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.addrRu}</div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">公司介绍（中文）：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.summaryCn}</div>
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">公司介绍（俄文）：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.summaryRu}</div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">公司法人：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.corporation}</div>
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">公司法人（拼音）：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.corporationPy}</div>
        </div>

    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">经营范围(中文)：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.optRegionCn}</div>
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">经营范围(俄文)：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.optRegionRu}</div>
        </div>

    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">注册地（中文）：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.corpRegaddrCn}</div>
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">注册地（俄文）：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.corpRegaddrRu}</div>
        </div>


    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">注册时间：</label>

            <div class="col-sm-7 col-md-8 label-cont"><fmt:formatDate value="${companyInfo.orgBo.corpRegtime}"
                                                             pattern="yyyy-MM-dd"/></div>
        </div>

    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">税务登记号：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.taxCert}</div>
        </div>

    </div>

</div>
<div class="formtable-cont">
    <h4 class="header" id="compApti">企业资质<c:if test="${companyInfo.orgBo.isThree==1}"><span class="label label-info">三证合一</span></c:if></h4>
    <div class="formtable-list pad_t20">
    <c:if test="${companyInfo.orgBo.isThree==1}">
        <div class="col-sm-4">
            <c:if test="${empty companyInfo.threeCompanyAbility[0].attaPath}">
                <img class="img-responsive mar_t10" src="${ctx}/resources/images/bn.jpg" alt=""/>
            </c:if>
            <c:if test="${!empty companyInfo.threeCompanyAbility[0].attaPath}">
                <img class="img-responsive mar_t10" src="${companyInfo.threeCompanyAbility[0].attaPath}@200w_130h_1l" alt=""  onclick="openUrl(this)"/>
            </c:if>

                <%--//1初审2通过3待审核4拒绝--%>
            <c:if test="${companyInfo.threeCompanyAbility[0].attaStatus==1}"><p><span class="icon icon-wait"></span>初审
            </p></c:if>
            <c:if test="${companyInfo.threeCompanyAbility[0].attaStatus==2}"><p><span class="icon icon-right"></span>通过
            </p></c:if>
            <c:if test="${companyInfo.threeCompanyAbility[0].attaStatus==3}"><p><span class="icon icon-wait"></span>待审核
            </p></c:if>
            <c:if test="${companyInfo.threeCompanyAbility[0].attaStatus==4}"><p><span class="icon icon-close"></span>拒绝
            </p></c:if>
        </div>

    </c:if>
    <c:if test="${companyInfo.orgBo.isThree!=1}">
        <form class="col-sm-4" action="${ctx}/company/saveAttach" method="post">
            <span class="dis_inb text_t mar_t10">营业执照：</span>

            <div class="enterprise_license dis_inb">
                <c:if test="${empty companyInfo.companyAbility.LICENSE_CODE.attaPath}">
                    <img class="img-responsive mar_t10" src="${ctx}/resources/images/bn.jpg" alt=""/>
                </c:if>
                <c:if test="${!empty companyInfo.companyAbility.LICENSE_CODE.attaPath}">
                    <img class="img-responsive mar_t10" src="${companyInfo.companyAbility.LICENSE_CODE.attaPath}@200w_130h_1l"
                         alt="" onclick="openUrl(this)"/>
                </c:if>
                <c:if test="${companyInfo.companyAbility.LICENSE_CODE.attaStatus==1}"><p><span
                        class="icon icon-wait"></span>初审</p></c:if>
                <c:if test="${companyInfo.companyAbility.LICENSE_CODE.attaStatus==2}"><p><span
                        class="icon icon-right"></span>通过</p></c:if>
                <c:if test="${companyInfo.companyAbility.LICENSE_CODE.attaStatus==3}"><p><span
                        class="icon icon-wait"></span>待审核</p></c:if>
                <c:if test="${companyInfo.companyAbility.LICENSE_CODE.attaStatus==4}"><p><span
                        class="icon icon-close"></span>拒绝</p></c:if>
            </div>
        </form>
        <form class="col-sm-4" action="${ctx}/company/saveAttach" method="post">
            <span class="dis_inb text_t mar_t10">税务登记证：</span>

            <div class="enterprise_license dis_inb">
                <c:if test="${empty companyInfo.companyAbility.SAX_LICENSE.attaPath}">
                    <img class="img-responsive mar_t10" src="${ctx}/resources/images/bn.jpg" alt=""/>
                </c:if>
                <c:if test="${!empty companyInfo.companyAbility.SAX_LICENSE.attaPath}">
                    <img class="img-responsive mar_t10" src="${companyInfo.companyAbility.SAX_LICENSE.attaPath}@200w_130h_1l"
                         alt="" onclick="openUrl(this)"/>
                </c:if>
                <c:if test="${companyInfo.companyAbility.SAX_LICENSE.attaStatus==1}"><p><span
                        class="icon icon-wait"></span>初审</p></c:if>
                <c:if test="${companyInfo.companyAbility.SAX_LICENSE.attaStatus==2}"><p><span
                        class="icon icon-right"></span>通过</p></c:if>
                <c:if test="${companyInfo.companyAbility.SAX_LICENSE.attaStatus==3}"><p><span
                        class="icon icon-wait"></span>待审核</p></c:if>
                <c:if test="${companyInfo.companyAbility.SAX_LICENSE.attaStatus==4}"><p><span
                        class="icon icon-close"></span>拒绝</p></c:if>
            </div>
        </form>
        <form class="col-sm-4" action="${ctx}/company/saveAttach" method="post">
            <span class="dis_inb text_t mar_t10">组织机构代码：</span>

            <div class="enterprise_license dis_inb">
                <c:if test="${empty companyInfo.companyAbility.ORGANIZE_CODE.attaPath}">
                    <img class="img-responsive mar_t10" src="${ctx}/resources/images/bn.jpg" alt=""/>
                </c:if>
                <c:if test="${!empty companyInfo.companyAbility.ORGANIZE_CODE.attaPath}">
                    <img class="img-responsive mar_t10" src="${companyInfo.companyAbility.ORGANIZE_CODE.attaPath}@200w_130h_1l"
                         alt="" onclick="openUrl(this)"/>
                </c:if>
                <c:if test="${companyInfo.companyAbility.ORGANIZE_CODE.attaStatus==1}"><p><span
                        class="icon icon-wait"></span>初审</p></c:if>
                <c:if test="${companyInfo.companyAbility.ORGANIZE_CODE.attaStatus==2}"><p><span
                        class="icon icon-right"></span>通过</p></c:if>
                <c:if test="${companyInfo.companyAbility.ORGANIZE_CODE.attaStatus==3}"><p><span
                        class="icon icon-wait"></span>待审核</p></c:if>
                <c:if test="${companyInfo.companyAbility.ORGANIZE_CODE.attaStatus==4}"><p><span
                        class="icon icon-close"></span>拒绝</p></c:if>
            </div>

        </form>
    </c:if>
    </div>
</div>

<div class="formtable-cont" id="industry">
    <h4 class="header" >从事行业</h4>

    <div class="formtable-list pad_t10">
        <label class="col-sm-2 formtable-list-require">出口：</label>
        <div class="col-sm-10 label-cont">
            <c:forEach items="${companyInfo.orgExportIndustry}" var="du">
                <span class="label label-white" style="margin-top: 5px;">${du.industryNameCn}</span>
            </c:forEach>
        </div>
    </div>
    <div class="formtable-list">
        <label class="col-sm-2 formtable-list-require">进口：</label>
        <div class="col-sm-10 label-cont">
                <c:forEach items="${companyInfo.orgEntryIndustry}" var="du">
                    <span class="label label-white">${du.industryNameCn}</span>
                </c:forEach>
        </div>
    </div>
</div>

<div class="formtable-cont">
    <h4 class="header" id="serv">服务范围</h4>

    <div class="formtable-list pad_t10">
            <label class="col-sm-2 formtable-list-require">服务范围：</label>

            <div class="col-sm-10 label-cont">
                <c:forEach items="${companyInfo.aldOrgServiceEntityList}" var="srv">
                    <span class="label label-white"> ${srv.srvNameCn}</span>
                </c:forEach>
            </div>
    </div>
</div>
<div class="formtable-cont">
    <h4 class="header" id="servApti">其他资质</h4>

    <div class="formtable-list">
        <c:forEach items="${companyInfo.srvAbilitys}" var="attatch">
            <form class="col-sm-3" name="delForm" action="${ctx}/company/saveAttach" method="post">
                <div class="pad_20">

                    <div class="servapti-pic">
                        <p>
                                ${attatch.attaName}

                        </p>

                        <div class="reload-pic">
                            <img src="<c:if test="${empty attatch.attaPath}">${ctx}/resources/images/bn.jpg</c:if><c:if test="${!empty attatch.attaPath}">${attatch.attaPath}</c:if>"
                                 class="img-responsive" alt="">
                            <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0">
                        </div>
                    </div>
                </div>
                <p class="mar_t10 col-xs-12">
                    <c:if test="${attatch.attaStatus==1}">初审</c:if>
                    <c:if test="${attatch.attaStatus==2}"><span class="icon icon-right"></span>审核通过</c:if>
                    <c:if test="${attatch.attaStatus==3}">待审核</c:if>
                    <c:if test="${attatch.attaStatus==4}">拒绝</c:if>
                </p>
            </form>
        </c:forEach>
    </div>
</div>
<div class="formtable-cont">
    <c:if test="${companyInfo.orgBo.orgAdultStatus==1 or companyInfo.orgBo.orgAdultStatus==3}">
        <h4 class="header header-fl" id="checkAnchor">审核记录</h4>
        <button  data-toggle="modal" id="orgCheckbtn" data-target="#reviewLog" class="btn btn-primary header-button">企业审核</button>
    </c:if>
    <c:if test="${companyInfo.orgBo.orgAdultStatus!=1 and companyInfo.orgBo.orgAdultStatus!=3}">
        <h4 class="header" id="checkAnchor">审核记录</h4>
    </c:if>
    <div class="clear"></div>
    <div class="pad_r10 formtable-list">
        <table class="table table-bordered table-hover">
            <thead>
            <tr>
                <th>申请人</th>
                <th>申请内容</th>
                <th>申请时间</th>
                <th>状态</th>
                <th>审核人</th>
                <th>审核意见</th>
                <th>审核时间</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${companyInfo.adultLogList}" var="adult">
                <tr>
                    <td>
                        <c:if test="${companyInfo.orgBo.countryType==1}">
                            ${adult.userNameCn}
                        </c:if>
                        <c:if test="${companyInfo.orgBo.countryType==2}">
                            ${fn:replace(adult.userNameRu,","," ")}
                        </c:if>
                    </td>
                    <td>${adult.applyContent}</td>
                    <td><fmt:formatDate value="${adult.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>
                        <c:if test="${adult.adultStatus==1}">审核中</c:if>
                        <c:if test="${adult.adultStatus==2}">审核通过</c:if>
                        <c:if test="${adult.adultStatus==3}">审核拒绝</c:if>
                    </td>
                    <td>${adult.adultUserNameCn}</td>
                    <td>${adult.adultContent}</td>

                    <td><fmt:formatDate value="${adult.adultTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <table class="table table-bordered table-hover mar_t20">
            <thead>
            <tr>
                <th>申请人</th>
                <th>申请内容</th>
                <th>申请时间</th>
                <th>状态</th>
                <th>审核人</th>
                <th>审核意见</th>
                <th>审核时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${companyInfo.attaAdultLogList}" var="adult">
                <tr>
                    <td>
                        <c:if test="${companyInfo.orgBo.countryType==1}">
                            ${adult.userNameCn}
                        </c:if>
                        <c:if test="${companyInfo.orgBo.countryType==2}">
                            ${fn:replace(adult.userNameRu,","," ")}
                        </c:if>
                    </td>
                    <td>${adult.applyContent}</td>
                    <td><fmt:formatDate value="${adult.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>
                        <c:if test="${adult.adultStatus==1}">审核中</c:if>
                        <c:if test="${adult.adultStatus==2}">审核通过</c:if>
                        <c:if test="${adult.adultStatus==3}">审核拒绝</c:if>
                    </td>
                    <td>${adult.adultUserNameCn}</td>
                    <td>${adult.adultContent}</td>
                    <td><fmt:formatDate value="${adult.adultTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>
                        <c:if test="${adult.attaStatus==1 or adult.attaStatus==3}">
                          <button type="button" attaId="${adult.attaId}"  name="attaCheck" data-toggle="modal" data-target="#reviewLog" attaName="${adult.attaName}" class="btn btn-primary">审核</button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>
</div>

<div class="modal fade" id="reviewLog" tabindex="-1">
    <div class="modal-dialog">
        <form class="modal-content" id="checkForm" method="post" action="${ctx}/cmpMgr/checkAtta">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">审核</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <label class="col-xs-3 formtable-list-require text-right">审核意见：</label>
                    <div class="col-xs-8">
                        <textarea class="form-control" name="adultContent" rows="7"></textarea>
                    </div>
                </div>
            </div>
            <input style="display: none" value="${companyInfo.orgBo.id}" name="orgId"/>
            <input style="display: none" type="radio" value="1" name="attaStatusAction"/>
            <input style="display: none"  name="attaName"/>
            <input style="display: none"  type="radio" value="0" name="attaStatusAction" />
            <input style="display: none"   name="attaId" />
            <input style="display: none" type="radio" value="1" name="adultAction"/>
            <input style="display: none"  type="radio" value="2" name="adultAction" />
            <div class="modal-footer">
                <button  class="btn btn-primary" >通过</button>
                <button  class="btn btn-default">拒绝</button>
            </div>
        </form>
    </div>
</div>

</div>
<script type="text/javascript" src="${ctx}/resources/js/cmpMbr/info.js"></script>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>