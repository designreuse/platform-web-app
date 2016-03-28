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
        您当前位置：<a href="#">用户中心</a>
    </li>
    <li>
        <a href="#">企业信息编辑</a>
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
        <li class="pull-right"><a href="${ctx}/company/info" class="btn btn-default">返回</a></li>
    </ul>
</div>
<form class="formtable-cont" action="${ctx}/company/updateComBasicInfo" id="comBasicInfo" method="post">
    <h4 class="header header-fl" id="baseInfo">基本信息</h4>
    <input type="submit" value="保存" class="btn btn-primary header-button"/>
    <div class="clear"></div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">公司名称（中文）：</label>
            <div class="col-sm-7 col-md-8">
                <input type="text" name="orgNameCn" class="form-control" value="${companyInfo.orgBo.orgNameCn}">
                <input type="hidden" name="id"  value="${companyInfo.orgBo.id}">
                <input type="hidden" name="orgNameCnOriginal"  value="${companyInfo.orgBo.orgNameCn}">
            </div>
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">公司名称（俄文）：</label>

            <div class="col-sm-7 col-md-8">
                <input type="text" class="form-control" name="orgNameRu" value="${companyInfo.orgBo.orgNameRu}">
            </div>
        </div>
    </div>
    <div class="formtable-list">
            <label class="col-sm-2 formtable-list-require">公司地址（地区）：</label>
            <div class="col-sm-10">
                <div class="form-inline">

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
                <input type="text" name="addrCn" class="form-control" value="${companyInfo.orgBo.addrCn}">
            </div>
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">公司地址（俄文）：</label>

            <div class="col-sm-7 col-md-8">
                <input type="text" class="form-control" name="addrRu" value="${companyInfo.orgBo.addrRu}">
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">公司介绍（中文）：</label>

            <div class="col-sm-7 col-md-8">
                <textarea name="summaryCn" class="form-control" rows="7" placeholder="请输入500个以内中文字符"
                          >${companyInfo.orgBo.summaryCn}</textarea>
            </div>
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">公司介绍（俄文）：</label>

            <div class="col-sm-7 col-md-8">
                <textarea class="form-control" rows="7" name="summaryRu" placeholder="请输入500个以内英文字符"
                          >${companyInfo.orgBo.summaryRu}</textarea>
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">公司法人：</label>

            <div class="col-sm-7 col-md-8">
                <input type="text" class="form-control" name="corporation" value="${companyInfo.orgBo.corporation}">
            </div>
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">经营范围：</label>

            <div class="col-sm-7 col-md-8">
                <input type="text" class="form-control" name="optRegionCn" value="${companyInfo.orgBo.optRegionCn}">
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">注册地：</label>

            <div class="col-sm-7 col-md-8">
                <input type="text" class="form-control" name="corpRegaddrCn" value="${companyInfo.orgBo.corpRegaddrCn}">
            </div>
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">注册时间：</label>

            <div class="col-sm-7 col-md-8 pad_l20">
                <div class="input-group datepicker date">
                    <input type="text" name="corpRegtime" class="form-control"  style="margin: 0px;"
                           value='<fmt:formatDate value="${companyInfo.orgBo.corpRegtime}" pattern="yyyy-MM-dd"/>'>
                    <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                </div>
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-md-12">
            <label class="col-sm-2">企业状态：</label>

            <div class="col-sm-10 label-cont">
                <c:if test="${companyInfo.orgBo.orgAdultStatus==1}"><span class="icon icon-right"></span>审核通过</c:if>
                <c:if test="${companyInfo.orgBo.orgAdultStatus==2}"><span class="icon icon-wait"></span>待初审 </c:if>
                <c:if test="${companyInfo.orgBo.orgAdultStatus==3}"><span class="icon icon-wait"></span>待审核 </c:if>
                <c:if test="${companyInfo.orgBo.orgAdultStatus==4}"><span class="icon icon-close"></span>审核未通过 </c:if>
            </div>
        </div>
    </div>
</form>
<div class="formtable-cont">
    <h4 class="header" id="compApti">企业资质
        <input name="isThree" value="1" type="checkbox" class="mar_l15" <c:if test="${companyInfo.orgBo.isThree==1}">checked="checked" </c:if>/>三证合一</h4>
    <div class="formtable-list pad_t20">
        <div <c:if test="${companyInfo.orgBo.isThree!=1}">class="hidden"</c:if> id="threeCombineForm">
            <form class="col-sm-4" action="${ctx}/company/saveAttach" method="post" >
              <%--  <c:if test="${empty companyInfo.threeCompanyAbility[0].attaPath}">
                    <img class="img-responsive mar_t10" src="${ctx}/resources/images/bn.jpg" alt=""/>
                </c:if>
                <c:if test="${!empty companyInfo.threeCompanyAbility[0].attaPath}">
                    <img class="img-responsive mar_t10" src="${companyInfo.threeCompanyAbility[0].attaPath}" alt=""/>
                </c:if>--%>

                  <div class="uploadModal" style="width: 200px;height: 130px;" >
                      <span class="uploadBtn" id="threeLic"></span>
                      <div  class="progress progress-striped active" style="display:none;">
                          <div  class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>
                      </div>
                      <div class="showModal">
                          <div class="addBtn"></div>
                      </div>
                      <img  src="<c:if test="${empty  companyInfo.threeCompanyAbility[0].attaPath}">${ctx}/resources/images/bn.jpg</c:if>
                             <c:if test="${not empty  companyInfo.threeCompanyAbility[0].attaPath}">${companyInfo.threeCompanyAbility[0].attaPath}</c:if>"
                            alt="" class="img-responsive" />
                  </div>

                <input type="hidden" name="isThree" >
                <input type="file" style="display: none"/>
                <input type="hidden" name="resourceCode"/>
                <input type="hidden" name="disabled" value="false"/>
                <input type="hidden" name="attaPath"/>
                <input type="hidden" name="attaId" value="${companyInfo.threeCompanyAbility[0].attaId}"/>
                <input type="hidden" name="orgId" value="${companyInfo.orgBo.id}"/>
                <input type="hidden" name="attaType" value="5"/>
                <input type="hidden" name="attaStatus" value="${companyInfo.threeCompanyAbility[0].attaStatus}"/>
                <input type="button" class="changeSrvAtta" style="display: none"/>
                <%--//1初审2通过3待审核4拒绝--%>
                <c:if test="${companyInfo.threeCompanyAbility[0].attaStatus==1}"><p><span class="icon icon-wait"></span>初审
                </p></c:if>
                <c:if test="${companyInfo.threeCompanyAbility[0].attaStatus==2}"><p><span class="icon icon-right"></span>通过
                </p></c:if>
                <c:if test="${companyInfo.threeCompanyAbility[0].attaStatus==3}"><p><span class="icon icon-wait"></span>待审核
                </p></c:if>
                <c:if test="${companyInfo.threeCompanyAbility[0].attaStatus==4}"><p><span class="icon icon-close"></span>拒绝
                </p></c:if>
            </form>
        </div>
        <span id="basicAttaForms"  <c:if test="${companyInfo.orgBo.isThree==1}">class="hidden" </c:if>>
        <form class="col-sm-4" action="${ctx}/company/saveAttach" method="post" >
            <span class="dis_inb text_t mar_t10">营业执照：</span>

            <div class="enterprise_license dis_inb">
              <%--  <c:if test="${empty companyInfo.companyAbility.LICENSE_CODE.attaPath}">
                    <img class="img-responsive mar_t10" src="${ctx}/resources/images/bn.jpg" alt=""/>
                </c:if>
                <c:if test="${!empty companyInfo.companyAbility.LICENSE_CODE.attaPath}">
                    <img class="img-responsive mar_t10" src="${companyInfo.companyAbility.LICENSE_CODE.attaPath}" alt=""/>
                </c:if>--%>

                  <div class="uploadModal" style="width: 200px;height: 130px;" >
                      <span class="uploadBtn" id="licLic"></span>
                      <div  class="progress progress-striped active" style="display:none;">
                          <div  class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>
                      </div>
                      <div class="showModal">
                          <div class="addBtn"></div>
                      </div>
                      <img  src="<c:if test="${empty  companyInfo.companyAbility.LICENSE_CODE.attaPath}">${ctx}/resources/images/bn.jpg</c:if>
                             <c:if test="${not empty  companyInfo.companyAbility.LICENSE_CODE.attaPath}">${companyInfo.companyAbility.LICENSE_CODE.attaPath}</c:if>"
                            alt="" class="img-responsive" />
                  </div>

                <input type="hidden" name="isThree" >
                <input type="file" style="display: none"/>
                <input type="hidden" name="resourceCode"/>
                <input type="hidden" name="disabled" value="false"/>
                <input type="hidden" name="attaPath"/>
                <input type="hidden" name="attaId" value="${companyInfo.companyAbility.LICENSE_CODE.attaId}"/>
                <input type="hidden" name="orgId" value="${companyInfo.orgBo.id}"/>
                <input type="hidden" name="attaType" value="1"/>
                <input type="hidden" name="attaStatus" value="${companyInfo.companyAbility.LICENSE_CODE.attaStatus}"/>
                <input type="button" class="changeSrvAtta" style="display: none"/>
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
              <%--  <c:if test="${empty companyInfo.companyAbility.SAX_LICENSE.attaPath}">
                    <img class="img-responsive mar_t10" src="${ctx}/resources/images/bn.jpg" alt=""/>
                </c:if>
                <c:if test="${!empty companyInfo.companyAbility.SAX_LICENSE.attaPath}">
                    <img class="img-responsive mar_t10" src="${companyInfo.companyAbility.SAX_LICENSE.attaPath}" alt=""/>
                </c:if>--%>

                  <div class="uploadModal" style="width: 200px;height: 130px;" >
                      <span class="uploadBtn" id="saxLic"></span>
                      <div  class="progress progress-striped active" style="display:none;">
                          <div  class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>
                      </div>
                      <div class="showModal">
                          <div class="addBtn"></div>
                      </div>
                      <img  src="<c:if test="${empty  companyInfo.companyAbility.SAX_LICENSE.attaPath}">${ctx}/resources/images/bn.jpg</c:if>
                             <c:if test="${not empty  companyInfo.companyAbility.SAX_LICENSE.attaPath}">${companyInfo.companyAbility.SAX_LICENSE.attaPath}</c:if>"
                            alt="" class="img-responsive" />
                      <%-- <input type="text" value="${companyInfo.threeCompanyAbility[0].attaPath}" name="idcardPathUser" class=" inputVal hide"
                              id="idcardPathUser"/>--%>
                  </div>


                <input type="hidden" name="isThree" >
                <input type="file" style="display: none"/>
                <input type="hidden" name="resourceCode"/>
                <input type="hidden" name="disabled" value="false"/>
                <input type="hidden" name="attaPath"/>
                <input type="hidden" name="attaId" value="${companyInfo.companyAbility.SAX_LICENSE.attaId}"/>
                <input type="hidden" name="orgId" value="${companyInfo.orgBo.id}"/>
                <input type="hidden" name="attaType" value="2"/>
                <input type="hidden" name="attaStatus" value="${companyInfo.companyAbility.SAX_LICENSE.attaStatus}"/>
                <input type="button" class="changeSrvAtta" style="display: none"/>
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
              <%--  <c:if test="${empty companyInfo.companyAbility.ORGANIZE_CODE.attaPath}">
                    <img class="img-responsive mar_t10" src="${ctx}/resources/images/bn.jpg" alt=""/>
                </c:if>
                <c:if test="${!empty companyInfo.companyAbility.ORGANIZE_CODE.attaPath}">
                    <img class="img-responsive mar_t10" src="${companyInfo.companyAbility.ORGANIZE_CODE.attaPath}" alt=""/>
                </c:if>--%>

                  <div class="uploadModal" style="width: 200px;height: 130px;" >
                      <span class="uploadBtn" id="orgLic"></span>
                      <div  class="progress progress-striped active" style="display:none;">
                          <div  class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>
                      </div>
                      <div class="showModal">
                          <div class="addBtn"></div>
                      </div>
                      <img  src="<c:if test="${empty  companyInfo.companyAbility.ORGANIZE_CODE.attaPath}">${ctx}/resources/images/bn.jpg</c:if>
                             <c:if test="${not empty companyInfo.companyAbility.ORGANIZE_CODE.attaPath}">${companyInfo.companyAbility.ORGANIZE_CODE.attaPath}</c:if>"
                            alt="" class="img-responsive" />
                  </div>


                <input type="hidden" name="isThree" >
                <input type="file" style="display: none"/>
                <input type="hidden" name="resourceCode"/>
                <input type="hidden" name="disabled" value="false"/>
                <input type="hidden" name="attaPath"/>
                <input type="hidden" name="attaId" value="${companyInfo.companyAbility.ORGANIZE_CODE.attaId}"/>
                <input type="hidden" name="orgId" value="${companyInfo.orgBo.id}"/>
                <input type="hidden" name="attaType" value="3"/>
                <input type="hidden" name="attaStatus" value="${companyInfo.companyAbility.SAX_LICENSE.attaStatus}"/>
                <input type="button" class="changeSrvAtta" style="display: none"/>
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
            </span>
    </div>
</div>

<form class="formtable-cont" id="exeDepartForm" action="${ctx}/company/addDepart">
    <h4 class="header header" id="serv">服务范围</h4>

    <div class="formtable-list">
        <div class="col-md-12">
            <label class="col-sm-2 formtable-list-require">服务范围：</label>

            <div class="col-sm-10 label-cont select-label">
                <c:forEach items="${companyInfo.aldOrgServiceEntityList}" var="srv">

                    <label class="label label-white">
                        ${srv.srvNameCn}
                    </label>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-md-12">
            <label class="col-sm-2 formtable-list-require">执行部门：</label>

            <div class="col-sm-10 add-label">
                <div class="form-inline">
                    <div class="form-group">
                        <input type="text" class="form-control" name="deptName">
                        <input type="hidden" name="orgId" value="${companyInfo.orgBo.id}">
                    </div>
                    <input type="submit" value="添加" class="btn btn-primary"/>
                    <%--<button type="button" class="btn btn-primary">添加</button>--%>
				    <span class="mar_l15">
                          <c:forEach items="${companyInfo.departList}" var="depart">
                              <span class="label label-white">${depart.deptName}
                                  <button type="button" class="removeDepartBtn">
                                      <span aria-hidden="true">×</span>
                                      <input type="hidden" name='departId' value="${depart.id}"/>
                                  </button>
                              </span>

                          </c:forEach>
                    </span>
                </div>
            </div>
        </div>
    </div>
</form>
<form class="formtable-cont" action="${ctx}/company/saveSrvNode" method="post" id="srvCfgForm">
    <h4 class="header header-fl">服务执行部门配置</h4>
    <a class="btn btn-primary header-button" id="srvCfg">保存</a>
    <input type="hidden" name="jsonStr"/>

    <div class="clear"></div>
    <div class="formtable-list">
        <c:forEach items="${companyInfo.serviceBoList}" var="srvBo" varStatus="outStat">

            <div class="col-xs-6">
                <label class="col-md-3">${srvBo.srvNameCn}：</label>

                <div class="col-md-9 form-inline">
                    <c:forEach var="srvNode" items="${srvBo.srvNodeBoList}" varStatus="status">
                        <div name="srvcfgArr" class="form-group">
                            <label>${status.count}. ${srvNode.nodeNameCn}</label>
                            <input type="hidden" name="orgId" value="${companyInfo.orgBo.id}"/>
                            <input type="hidden" name="serviceId" value="${srvBo.serviceId}"/>
                            <input type="hidden" name="nodeId" value="${srvNode.nodeId}"/>
                            <input type="hidden" name="id" value="${srvNode.id}"/>
                            <input type="hidden" name="disabled" value="false"/>
                            <select class="form-control" name="deptId">
                                <option value="">--请选择--</option>
                                <c:forEach items="${companyInfo.departList}" var="depart">
                                    <option value="${depart.id}"
                                            <c:if test="${depart.id==srvNode.deptId}">selected</c:if>>${depart.deptName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:forEach>


    </div>
</form>
<div class="formtable-cont" id="servApti">
    <h4 class="header header-fl">服务资质</h4>
    <span class="btn btn-primary header-button addApti" >新增</span>

    <div class="clear"></div>
    <c:forEach items="${companyInfo.srvAbilitys}" var="attatch">
        <form class="col-sm-3" name="delForm" action="${ctx}/company/saveAttach" method="post">
            <div class="pad_20">

                <div class="servapti-pic">
                    <p>
                            ${attatch.attaName}
                        <input class="fl_r" type="button" value="删除"/>
                        <input type="hidden" name="attaId" value="${attatch.attaId}"/>
                        <input type="hidden" name="orgId" value="${companyInfo.orgBo.id}"/>
                        <input type="hidden" name="attaType" value="${attatch.attaType}"/>
                        <input type="hidden" name="attaStatus" value="${attatch.attaStatus}"/>

                    </p>

                   <%-- <div class="reload-pic">
                        <img src="<c:if test="${empty attatch.attaPath}">${ctx}/resources/images/bn.jpg</c:if><c:if test="${!empty attatch.attaPath}">${attatch.attaPath}</c:if>"
                             class="img-responsive" alt="">
                        <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0">
                        <input type="hidden" name="attaPath">
                        <input type="hidden" name="resourceCode">
                        <input type="button" class="changeSrvAtta" style="display: none"/>
                    </div>--%>


                    <div class="uploadModal" style="width: 200px;height: 130px;" >
                        <span class="uploadBtn" id="serviceLic"></span>
                        <div  class="progress progress-striped active" style="display:none;">
                            <div  class="progress-bar progress-bar-success" role="progressbar"
                                  aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>
                        </div>
                        <div class="showModal">
                            <div class="addBtn"></div>
                        </div>
                        <img  src="<c:if test="${empty attatch.attaPath}">${ctx}/resources/images/bn.jpg</c:if><c:if test="${!empty attatch.attaPath}">${attatch.attaPath}</c:if>" alt="" class="img-responsive" />
                        <input type="text" value="${attatch.attaPath}" name="attaPath" class="inputVal hide"/>
                    </div>

                    <input type="button" class="changeSrvAtta" style="display: none"/>

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
<div class="modal fade" id="addApti">
    <div class="modal-dialog">
        <form class="modal-content" id="addSrvAttachForm" action="${ctx}/company/saveAttach" method="post">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增资质</h4>
            </div>
            <div class="modal-body text-center">
                <div class="form-inline">
                    <div class="form-group">
                        <label class="formtable-list-require">资质名称：</label>
                        <input type="text" name="attaName" class="form-control">
                    </div>
                </div>
                <div class="row">
                   <%-- <div class="col-xs-4 col-xs-offset-4 mar_t20">
                       &lt;%&ndash; <img src="${ctx}/resources/images/bn.jpg" class="img-responsive"/>&ndash;%&gt;
                      &lt;%&ndash;  <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0">&ndash;%&gt;
                        <input type="hidden" name="attaPath">
                      &lt;%&ndash;  <input type="hidden" name="resourceCode">&ndash;%&gt;
                    </div>--%>

                       <div class="uploadModal" style="width: 200px;height: 130px;    margin-left: 240px;
                           margin-top: 20px;" >
                           <span class="uploadBtn" id="test"></span>
                           <div  class="progress progress-striped active" style="display:none;">
                               <div  class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>
                           </div>
                           <div class="showModal">
                               <div class="addBtn"></div>
                           </div>
                           <img  src="${ctx}/resources/images/bn.jpg" alt="" class="img-responsive" />
                            <input type="text" value="" name="attaPath" class="inputVal hide"
                                   id="attaPath"/>
                       </div>

                </div>
            </div>
            <input type="hidden" name="attaType" value="4">
            <input type="hidden" name="orgId" value="${companyInfo.orgBo.id}">
            <input type="hidden" name="disabled" value="false">

            <div class="modal-footer text-center">
                <button type="submit" class="btn btn-primary">提交</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script src="${ctx}/resources/js/imageUpload/SimpleAjaxUploader.min.js"></script>
<script src="${ctx}/resources/js/imageUpload/imgUpLoad.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/company/edit.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/company/editBus.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp" %>
</body>
</html>