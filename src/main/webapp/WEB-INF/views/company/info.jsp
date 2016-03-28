<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <title>用户中心-企业信息查看</title>
    <%@include file="/WEB-INF/common/global/common.jsp" %>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">用户中心</a>
    </li>
    <li>
        <a href="#">企业信息查看</a>
    </li>

</nav>

<div class="container-fluid">
<div class="formtable">
<div class="formtable-nav">
    <ul class="list-inline">
        <li><a href="#baseInfo" class="btn btn-primary">基本信息</a></li>
        <li><a href="#compApti" class="btn btn-primary">企业资质</a></li>
        <li><a href="#serv" class="btn btn-primary">服务范围</a></li>
        <li><a href="#servApti" class="btn btn-primary">服务资质</a></li>
        <li class="pull-right"><a href="${companyInfo.orgBo.id}/edit?orgId=${companyInfo.orgBo.id}" class="btn btn-default">编辑</a></li>
    </ul>
</div>
<div class="formtable-cont">
    <h4 class="header" id="baseInfo">基本信息</h4>

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
            <label class="col-sm-2">公司地址（地区）：</label>

            <div class="col-sm-10 label-cont">${companyInfo.orgBo.provinceNameCn} ${companyInfo.orgBo.cityNameCn} ${companyInfo.orgBo.districtNameCn}</div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">公司地址（中文）：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.addrCn}</div>
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
            <label class="col-sm-5 col-md-4">经营范围：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.optRegionCn}</div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">注册地：</label>

            <div class="col-sm-7 col-md-8 label-cont">${companyInfo.orgBo.corpRegaddrCn}</div>
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">注册时间：</label>

            <div class="col-sm-7 col-md-8 label-cont"><fmt:formatDate value="${companyInfo.orgBo.corpRegtime}"
                                                             pattern="yyyy-MM-dd"/></div>
        </div>
    </div>
    <div class="formtable-list">
            <label class="col-sm-2">企业状态：</label>
            <%--//1初审2通过3待审核4拒绝--%>
            <c:if test="${companyInfo.orgBo.orgAdultStatus==1}">
                <div class="col-sm-10 label-cont">初审 <span class="icon icon-wait"></span></div>
            </c:if>
            <c:if test="${companyInfo.orgBo.orgAdultStatus==2}">
                <div class="col-sm-10 label-cont">审核通过 <span class="icon icon-right"></span></div>
            </c:if>
            <c:if test="${companyInfo.orgBo.orgAdultStatus==3}">
                <div class="col-sm-10 label-cont">待审核 <span class="icon icon-wait"></span></div>
            </c:if>
            <c:if test="${companyInfo.orgBo.orgAdultStatus==4}">
                <div class="col-sm-10 label-cont">拒绝 <span class="icon icon-close"></span></div>
            </c:if>
    </div>
</div>
<div class="formtable-cont">
    <h4 class="header" id="compApti">企业资质<c:if test="${companyInfo.orgBo.isThree==1}"> <span
            class="label label-info">三证合一</span></c:if></h4>
    <c:if test="${companyInfo.orgBo.isThree==1}">
        <div class="col-sm-4">
            <img class="img-responsive mar_t10" src="${companyInfo.threeCompanyAbility[0].attaPath}" alt=""/>
                <%--//1初审2通过3待审核4拒绝--%>
            <c:if test="${companyInfo.threeCompanyAbility[0].attaStatus==1}"><p><span class="icon icon-right"></span>初审
            </p></c:if>
            <c:if test="${companyInfo.threeCompanyAbility[0].attaStatus==2}"><p><span class="icon icon-right"></span>通过
            </p></c:if>
            <c:if test="${companyInfo.threeCompanyAbility[0].attaStatus==3}"><p><span class="icon icon-right"></span>待审核
            </p></c:if>
            <c:if test="${companyInfo.threeCompanyAbility[0].attaStatus==4}"><p><span class="icon icon-right"></span>拒绝
            </p></c:if>
        </div>
    </c:if>
    <c:if test="${companyInfo.orgBo.isThree!=1}">
        <form class="col-sm-4 mar_t30" action="${ctx}/company/saveAttach" method="post">
            <span class="dis_inb text_t">营业执照：</span>

            <div class="enterprise_license dis_inb">
                <c:if test="${empty companyInfo.companyAbility.LICENSE_CODE.attaPath}">
                    <img class="img-responsive" src="${ctx}/resources/images/bn.jpg" alt=""/>
                </c:if>
                <c:if test="${!empty companyInfo.companyAbility.LICENSE_CODE.attaPath}">
                    <img class="img-responsive" src="${companyInfo.companyAbility.LICENSE_CODE.attaPath}"
                         alt=""/>
                </c:if>
                <c:if test="${companyInfo.companyAbility.LICENSE_CODE.attaStatus==1}"><p><span
                        class="icon icon-right"></span>初审</p></c:if>
                <c:if test="${companyInfo.companyAbility.LICENSE_CODE.attaStatus==2}"><p><span
                        class="icon icon-right"></span>通过</p></c:if>
                <c:if test="${companyInfo.companyAbility.LICENSE_CODE.attaStatus==3}"><p><span
                        class="icon icon-right"></span>待审核</p></c:if>
                <c:if test="${companyInfo.companyAbility.LICENSE_CODE.attaStatus==4}"><p><span
                        class="icon icon-right"></span>拒绝</p></c:if>
            </div>
        </form>
        <form class="col-sm-4 mar_t30" action="${ctx}/company/saveAttach" method="post">
            <span class="dis_inb text_t">税务登记证：</span>

            <div class="enterprise_license dis_inb">
                <c:if test="${empty companyInfo.companyAbility.SAX_LICENSE.attaPath}">
                    <img class="img-responsive" src="${ctx}/resources/images/bn.jpg" alt=""/>
                </c:if>
                <c:if test="${!empty companyInfo.companyAbility.SAX_LICENSE.attaPath}">
                    <img class="img-responsive" src="${companyInfo.companyAbility.SAX_LICENSE.attaPath}"
                         alt=""/>
                </c:if>
                <c:if test="${companyInfo.companyAbility.SAX_LICENSE.attaStatus==1}"><p><span
                        class="icon icon-right"></span>初审</p></c:if>
                <c:if test="${companyInfo.companyAbility.SAX_LICENSE.attaStatus==2}"><p><span
                        class="icon icon-right"></span>通过</p></c:if>
                <c:if test="${companyInfo.companyAbility.SAX_LICENSE.attaStatus==3}"><p><span
                        class="icon icon-right"></span>待审核</p></c:if>
                <c:if test="${companyInfo.companyAbility.SAX_LICENSE.attaStatus==4}"><p><span
                        class="icon icon-right"></span>拒绝</p></c:if>
            </div>
        </form>
        <form class="col-sm-4 mar_t30" action="${ctx}/company/saveAttach" method="post">
            <span class="dis_inb text_t">组织机构代码：</span>

            <div class="enterprise_license dis_inb">
                <c:if test="${empty companyInfo.companyAbility.ORGANIZE_CODE.attaPath}">
                    <img class="img-responsive" src="${ctx}/resources/images/bn.jpg" alt=""/>
                </c:if>
                <c:if test="${!empty companyInfo.companyAbility.ORGANIZE_CODE.attaPath}">
                    <img class="img-responsive" src="${companyInfo.companyAbility.ORGANIZE_CODE.attaPath}"
                         alt=""/>
                </c:if>
                <c:if test="${companyInfo.companyAbility.ORGANIZE_CODE.attaStatus==1}"><p><span
                        class="icon icon-right"></span>初审</p></c:if>
                <c:if test="${companyInfo.companyAbility.ORGANIZE_CODE.attaStatus==2}"><p><span
                        class="icon icon-right"></span>通过</p></c:if>
                <c:if test="${companyInfo.companyAbility.ORGANIZE_CODE.attaStatus==3}"><p><span
                        class="icon icon-right"></span>待审核</p></c:if>
                <c:if test="${companyInfo.companyAbility.ORGANIZE_CODE.attaStatus==4}"><p><span
                        class="icon icon-right"></span>拒绝</p></c:if>
            </div>

        </form>
    </c:if>
    <div class="clear"></div>
</div>

<div class="formtable-cont">
    <h4 class="header" id="serv">服务范围</h4>

    <div class="formtable-list">
            <label class="col-sm-2 formtable-list-require">服务范围：</label>

            <div class="col-sm-10 label-cont">
                <c:forEach items="${companyInfo.aldOrgServiceEntityList}" var="srv">
                    <span class="label label-white "> ${srv.srvNameCn}</span>
                </c:forEach>
            </div>
    </div>
    <div class="formtable-list">
            <label class="col-sm-2 formtable-list-require">执行部门：</label>

            <div class="col-sm-10 label-cont">
                <c:forEach items="${companyInfo.departList}" var="depart">
                    <span class="label label-white">${depart.deptName}</span>
                </c:forEach>
            </div>
    </div>
    <div class="formtable-list">
            <label class="col-sm-2 formtable-list-require">服务执行部门配置：</label>

            <div class="col-sm-10 ser-einstellung">

                <c:forEach items="${companyInfo.serviceBoList}" var="srvBo" varStatus="outStat">
                    <div class="col-xs-6">
                        <label class="col-xs-3">${srvBo.srvNameCn}：</label>

                        <div class="col-xs-12 label-cont">
                            <c:forEach var="srvNode" items="${srvBo.srvNodeBoList}" varStatus="status">
                                <p>
                                        ${status.count}. ${srvNode.nodeNameCn}
                                    <span class="label label-white">${srvNode.deptName}</span>
                                </p>
                            </c:forEach>
                        </div>

                    </div>

                </c:forEach>
            </div>
    </div>
</div>
<div class="formtable-cont">
    <h4 class="header" id="servApti">服务资质</h4>

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
</div>

<script>

    //    $(function(){
    //        var minWidth = null;
    //        $(".formtable-list").each(function(){
    //            var $this = $(this);
    //            var listHeight = $this.outerHeight();
    //            $this.find(".col-sm-7 col-md-8").outerHeight(listHeight);
    //            var listWeight = $this.find(".col-sm-5 col-md-4").outerWidth();
    //            if(minWidth == null){
    //                minWidth = listWeight ;
    //            }
    //        });
    //        $(".formtable-list").find(".col-md-12").children(".col-sm-2").outerWidth(minWidth- 1);
    //    });
</script>
<%@include file="/WEB-INF/common/global/footer.jsp" %>
</body>
</html>