<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="js/html5.js"></script>
    <script type="text/javascript" src="js/respond.min.js"></script>
    <script type="text/javascript" src="js/PIE_IE678.js"></script>
    <![endif]-->
    <script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/bootstrap.min.js"></script>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link rel="stylesheet" href="${ctx}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/resources/font/font-awesome-ie7.min.css" type="text/css">

    <![endif]-->
    <title>我的服务订单-服务订单详情</title>
    <style>
        .modal-file-check{
            margin: 10px;
            display: inline-block;
            text-align: center;
        }
        .modal-file-check img {
            width: 119px;
            height: 119px;
            border: 1px solid #dddddd;
        }
    </style>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 贸易订单管理 <span class="c-gray en">&gt;</span> 新建服务订单 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<div class="pd-20">
    <div id="message_position" style="width: 100%; left: 0px; top: 0px; position: fixed;">
        <div id="position_fixed" class="cl pd-5 bg-1 bk-gray mt-20" style="margin: 0px 20px;">
            <span class="l">
                <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_a_click">
                    基本信息</a>
                <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
                    贸易信息</a>
                <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
                    服务信息</a>
                <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
                    执行跟踪</a>
                <a href="#picket" name="_self" class="btn btn-primary radius public_a_click">
                    单据</a>
                <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
                    账单</a>
               </span>
        </div>
    </div>
    <table class="table table-border table-bordered table-bg table-sort public_click_content" style="margin-top: 0px;">
        <thead>
        <tr class="text-l">
            <th width="106">
                <span class="l f-16">基本信息</span>
            </th>
        </tr>
        </thead>
    </table>
    <table class="table table-border table-bordered table-bg table-sort">
        <tbody>
            <tr>
                <th width="10%" class="text-r"> 服务订单编号：</th>
                <td width="40%">SC012345T20150923I0001</td>
                <th width="10%" class="text-r">服务订单状态：</th>
                <td width="40%">执行中</td>
            </tr>
            <tr>
                <th width="10%" class="text-r"> 服务委托方：</th>
                <td width="40%">烟台大家要吃水果水果批发小店</td>
                <th width="10%" class="text-r">委托方联系人：</th>
                <td width="40%">店小二</td>
            </tr>
            <tr>
                <th width="10%" class="text-r"> 服务供应商：</th>
                <td width="40%">诚林XX贸易有限公司</td>
                <th width="10%" class="text-r">客服：</th>
                <td width="40%">小木</td>
            </tr>
            <tr>
                <th width="10%" class="text-r"> 委托服务：</th>
                <td width="40%">出口报检、出口报关</td>
                <th width="10%" class="text-r">下单时间：</th>
                <td width="40%">2015-9-23</td>
            </tr>
            <tr>
                <th width="10%" class="text-r"> 订单备注：</th>
                <td colspan="3">我是服务订单备注我是服务订单备注我是服务订单备注我是服务订单备注我是服务订单</td>
            </tr>
            <tr>
                <th width="10%" class="text-r"> 创建人：</th>
                <td width="40%">满一</td>
                <th width="10%" class="text-r">创建时间：</th>
                <td width="40%">2015-9-23</td>
            </tr>
            <tr>
                <th width="10%" class="text-r"> 创建人电脑IP：</th>
                <td width="40%">192.168.1.2</td>
                <th width="10%" class="text-r">更新时间：</th>
                <td width="40%">2015-9-23</td>
            </tr>
        </tbody>
    </table>
    <table class="table table-border table-bordered table-bg table-sort public_click_content" style="margin-top: 0px;">
        <thead>
        <tr class="text-l">
            <th width="106">
                <span class="l f-16">贸易信息</span>
            </th>
        </tr>
        </thead>
    </table>
    <select class="select" name="" size="1" style="width:200px" id="">
        <option value="1" selected="">水果蔬菜</option>
        <option value="2">水果蔬菜2</option>
    </select>
    <span>关联3条贸易信息</span>
    <table class="table table-border table-bordered table-bg table-sort">
        <tbody>
            <tr>
                <th width="10%" class="text-r"> 贸易合同号：</th>
                <td width="40%">SC023456S20150920I0123</td>
                <th width="10%" class="text-r">合同金额：</th>
                <td width="40%">41,000美元</td>
            </tr>
            <tr>
                <th width="10%" class="text-r"> 买方：</th>
                <td width="40%">俄罗斯大家要吃水果水果批发小店贸易有限公司</td>
                <td colspan="2">
                    <table class="table-bordered">
                        <tbody>
                        <tr>
                            <td width="20%" class="text-r">卖方：</td>
                            <td width="80%">阿拉丁贸易有限公司</td>
                        </tr>
                        <tr>
                            <td width="20%" class="text-r">卖方：</td>
                            <td width="80%">阿拉丁贸易有限公司</td>
                        </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <th width="10%" class="text-r"> 买方联系方式：</th>
                <td width="40%">13000111222， 86-21-55556666, aaaabbbccc@alading.com</td>
                <th width="10%" class="text-r">卖方联系方式：</th>
                <td width="40%">13000111222， 86-21-55556666, aaaabbbccc@alading.com</td>
            </tr>
            <tr>
                <th width="10%" class="text-r"> 交货地：</th>
                <td width="40%">满洲里</td>
                <th width="10%" class="text-r">提货方式：</th>
                <td width="40%">自提</td>
            </tr>
            <tr>
                <th width="10%" class="text-r"> 预计交货日期：</th>
                <td width="40%">2015/3/4</td>
                <th width="10%" class="text-r">最晚交货日期：</th>
                <td width="40%">2015/3/4</td>
            </tr>
            <tr>
                <th width="10%" class="text-r"> 付款方式：</th>
                <td width="40%">
                    <table class="table-bordered">
                        <tbody>
                            <tr>
                                <td width="20%">预付款比例： </td>
                                <td>100%</td>
                            </tr>
                            <tr>
                                <td width="20%">尾款支付限期： </td>
                                <td>发货前付款</td>
                            </tr>
                            <tr>
                                <td width="20%">支付方式： </td>
                                <td>线下支付</td>
                            </tr>
                        </tbody>
                    </table>
                </td>
                <th width="10%" class="text-r">附加说明：</th>
                <td width="40%">2015/3/4</td>
            </tr>
            <tr>
                <th width="10%" class="text-r"> 商品信息：</th>
                <td colspan="3">
                    <table class="table-bordered">
                        <thead>
                            <th>商品</th>
                            <th width="12%">采购量</th>
                            <th width="12%">计量单位</th>
                            <th width="12%">标准件</th>
                            <th width="12%">包装方式</th>
                            <th width="12%">单价（美元）</th>
                            <th width="12%">总价（美元）</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <img src="http://img.51aladdin.com/8764bcab-86f6-4137-ab34-8f1c756f2c71.jpg@.jpg" alt="" width="100px" style="float: left;margin:0 20px;"/>
                                    <p style="margin-top: 30px;">新西兰红玫瑰苹果苹果</p>
                                    <p>HSCODE：0808100000</p>
                                </td>
                                <td>2000</td>
                                <td>千克（KG）</td>
                                <td>10</td>
                                <td>箱</td>
                                <td>8</td>
                                <td>16,000</td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
    <table class="table table-border table-bordered table-bg table-sort public_click_content" style="margin-top: 0px;">
        <thead>
        <tr class="text-l">
            <th width="106">
                <span class="l f-16">服务信息</span>
            </th>
        </tr>
        </thead>
    </table>
    <table class="table table-border table-bordered table-bg table-sort">
        <tbody>
            <tr>
                <th width="10%" class="text-r"> 出口贸易代理：</th>
                <td width="40%">报关行：顺通世航国际报关公司</td>
                <th width="10%" class="text-r">报检代理：</th>
                <td width="40%">报检代理</td>
            </tr>
            <tr>
                <th width="10%" class="text-r"> 报关代理：</th>
                <td width="40%">报关行：顺通世航国际报关公司</td>
                <th width="10%" class="text-r">俄境清关：</th>
                <td width="40%">俄境清关</td>
            </tr>
        </tbody>
    </table>
    <form>
        <table class="table table-border table-bordered table-bg table-sort public_click_content" style="margin-top: 0px;">
            <thead>
            <tr class="text-l">
                <th width="106">
                    <span class="l f-16">国内运输</span>
                    <span class="r"><button class="btn btn-success radius" type="submit"><i class="icon-ok"></i> 保存</button></span>
                </th>
            </tr>
            </thead>
        </table>
        <table class="table table-border table-bordered table-bg table-sort">
            <tbody>
                <tr>
                    <th width="190" class="text-r"> 发货地 ：</th>
                    <td>上海市>上海市>松江区  我是一个仓库地址</td>
                </tr>
                <tr>
                    <th width="190" class="text-r"> 目的地 ：</th>
                    <td>上海市>上海市>松江区  我是一个仓库地址</td>
                </tr>
                <tr>
                    <th width="190" class="text-r"> 联系人 ：</th>
                    <td>车小二  13000111222</td>
                </tr>
                <tr>
                    <th width="190" class="text-r"> 车辆信息 ：</th>
                    <td>
                        <p>
                            <span>围栏车</span>
                            <span>1吨</span>
                            <span>232立方米</span>
                            <input type="text" style="width:120px" class="input-text" value="" placeholder="车牌" nullmsg="车牌">
                            <input type="text" style="width:120px" class="input-text" value="" placeholder="司机姓名" nullmsg="司机姓名">
                            <input type="text" style="width:120px" class="input-text" value="" placeholder="司机手机" nullmsg="司机手机">
                        </p>
                        <p>
                            <span>围栏车</span>
                            <span>1吨</span>
                            <span>232立方米</span>
                            <input type="text" style="width:120px" class="input-text" value="" placeholder="车牌" nullmsg="车牌">
                            <input type="text" style="width:120px" class="input-text" value="" placeholder="司机姓名" nullmsg="司机姓名">
                            <input type="text" style="width:120px" class="input-text" value="" placeholder="司机手机" nullmsg="司机手机">
                        </p>
                    </td>

                </tr>
                <tr>
                    <th width="190" class="text-r"> 预计发货日期 ：</th>
                    <td>2015/3/3</td>
                </tr>
                <tr>
                    <th width="190" class="text-r"> 预计到货日期 ：</th>
                    <td>2015/3/3</td>
                </tr>
                <tr>
                    <th width="190" class="text-r"> 交货方式 ：</th>
                    <td>倒装</td>
                </tr>
            </tbody>
        </table>
    </form>
    <form>
        <table class="table table-border table-bordered table-bg table-sort public_click_content" style="margin-top: 0px;">
            <thead>
                <tr class="text-l">
                    <th width="106">
                        <span class="l f-16">俄境运输</span>
                        <span class="r"><button class="btn btn-success radius" type="submit"><i class="icon-ok"></i> 保存</button></span>
                    </th>
                </tr>
            </thead>
        </table>
        <table class="table table-border table-bordered table-bg table-sort">
            <tbody>
                <tr>
                    <th width="190" class="text-r"> 发货地 ：</th>
                    <td>上海市>上海市>松江区  我是一个仓库地址</td>
                </tr>
                <tr>
                    <th width="190" class="text-r"> 目的地 ：</th>
                    <td>上海市>上海市>松江区  我是一个仓库地址</td>
                </tr>
                <tr>
                    <th width="190" class="text-r"> 联系人 ：</th>
                    <td>车小二  13000111222</td>
                </tr>
                <tr>
                    <th width="190" class="text-r"> 车辆信息 ：</th>
                    <td>
                        <p>
                            <span>围栏车</span>
                            <span>1吨</span>
                            <span>232立方米</span>
                            <input type="text" style="width:120px" class="input-text" value="" placeholder="车牌" nullmsg="车牌">
                            <input type="text" style="width:120px" class="input-text" value="" placeholder="司机姓名" nullmsg="司机姓名">
                            <input type="text" style="width:120px" class="input-text" value="" placeholder="司机手机" nullmsg="司机手机">
                        </p>
                        <p>
                            <span>围栏车</span>
                            <span>1吨</span>
                            <span>232立方米</span>
                            <input type="text" style="width:120px" class="input-text" value="" placeholder="车牌" nullmsg="车牌">
                            <input type="text" style="width:120px" class="input-text" value="" placeholder="司机姓名" nullmsg="司机姓名">
                            <input type="text" style="width:120px" class="input-text" value="" placeholder="司机手机" nullmsg="司机手机">
                        </p>
                    </td>
                </tr>
                <tr>
                    <th width="190" class="text-r"> 预计发货日期 ：</th>
                    <td>2015/3/3</td>
                </tr>
                <tr>
                    <th width="190" class="text-r"> 预计到货日期 ：</th>
                    <td>2015/3/3</td>
                </tr>
                <tr>
                    <th width="190" class="text-r"> 交货方式 ：</th>
                    <td>倒装</td>
                </tr>
            </tbody>
        </table>
    </form>
    <form>
        <table class="table table-border table-bordered table-bg table-sort public_click_content" style="margin-top: 0px;">
            <thead>
            <tr class="text-l">
                <th width="106">
                    <span class="l f-16">国内仓储</span>
                    <span class="r"><button class="btn btn-success radius" type="submit"><i class="icon-ok"></i> 保存</button></span>
                </th>
            </tr>
            </thead>
        </table>
        <table class="table table-border table-bordered table-bg table-sort">
            <tbody>
                <tr>
                    <th width="190" class="text-r"> 仓储需求 ：</th>
                    <td>
                        <p>
                            <span>冷库 10平方米</span>
                            <span>预计存放10天</span>
                            <select class="select" name="" size="1" style="width:200px" id="">
                                <option value="1" selected="">水果蔬菜</option>
                                <option value="2">水果蔬菜2</option>
                            </select>
                            <input type="text" style="width:150px" class="input-text" value="" placeholder="库位" nullmsg="司机手机">
                        </p>
                        <p>
                            <span>冷库 10平方米</span>
                            <span>预计存放10天</span>
                            <select class="select" name="" size="1" style="width:200px" id="">
                                <option value="1" selected="">水果蔬菜</option>
                                <option value="2">水果蔬菜2</option>
                            </select>
                            <input type="text" style="width:150px" class="input-text" value="" placeholder="库位" nullmsg="司机手机">
                        </p>
                    </td>
                </tr>
                <tr>
                    <th width="190" class="text-r"> 预计入库日期 ：</th>
                    <td>2015/3/3</td>
                </tr>
                <tr>
                    <th width="190" class="text-r"> 预计出库日期 ：</th>
                    <td>2015/3/3</td>
                </tr>
            </tbody>
        </table>
    </form>
    <form>
        <table class="table table-border table-bordered table-bg table-sort public_click_content" style="margin-top: 0px;">
            <thead>
            <tr class="text-l">
                <th width="106">
                    <span class="l f-16">俄境仓储</span>
                    <span class="r"><button class="btn btn-success radius" type="submit"><i class="icon-ok"></i> 保存</button></span>
                </th>
            </tr>
            </thead>
        </table>
        <table class="table table-border table-bordered table-bg table-sort">
            <tbody>
            <tr>
                <th width="190" class="text-r"> 仓储需求 ：</th>
                <td>
                    <p>
                        <span>冷库 10平方米</span>
                        <span>预计存放10天</span>
                        <select class="select" name="" size="1" style="width:200px" id="">
                            <option value="1" selected="">水果蔬菜</option>
                            <option value="2">水果蔬菜2</option>
                        </select>
                        <input type="text" style="width:150px" class="input-text" value="" placeholder="库位" nullmsg="司机手机">
                    </p>
                    <p>
                        <span>冷库 10平方米</span>
                        <span>预计存放10天</span>
                        <select class="select" name="" size="1" style="width:200px" id="">
                            <option value="1" selected="">水果蔬菜</option>
                            <option value="2">水果蔬菜2</option>
                        </select>
                        <input type="text" style="width:150px" class="input-text" value="" placeholder="库位" nullmsg="司机手机">
                    </p>
                </td>
            </tr>
            <tr>
                <th width="190" class="text-r"> 预计入库日期 ：</th>
                <td>2015/3/3</td>
            </tr>
            <tr>
                <th width="190" class="text-r"> 预计出库日期 ：</th>
                <td>2015/3/3</td>
            </tr>
            </tbody>
        </table>
    </form>
    <form>
        <table class="table table-border table-bordered table-bg table-sort public_click_content" style="margin-top: 0px;">
            <thead>
            <tr class="text-l">
                <th width="106">
                    <span class="l f-16">执行跟踪</span>
                    <span class="r"><button class="btn btn-success radius" type="submit"><i class="icon-ok"></i> 保存</button></span>
                </th>
            </tr>
            </thead>
        </table>
        <table class="table table-border table-bordered table-bg table-sort">
            <thead>
                <th>基本服务</th>
                <th>服务商</th>
                <th>操作环节</th>
                <th>状态</th>
                <th>附件</th>
                <th>操作角色</th>
                <th>操作人</th>
                <th>环节完成时间</th>
                <th>服务计划完成</th>
            </thead>
            <tbody>
                <tr>
                    <td>出口报关</td>
                    <td>出口代理公司A</td>
                    <td>1. 报关资料准备</td>
                    <td>未开始</td>
                    <td><a id="fileCheck">查看</a></td>
                    <td>客服</td>
                    <td>小森</td>
                    <td>2015/3/4</td>
                    <td>2015/3/3</td>
                </tr>
            </tbody>
        </table>
    </form>
    <form>
        <table   class="table table-border table-bordered table-bg table-sort public_click_content" style="margin-top: 0px;">
            <thead>
            <tr class="text-l">
                <th width="106">
                    <span id="picket" class="l f-16">单据</span>
                    <span class="r"><button class="btn btn-success radius" type="button" id="add"><i class="icon-ok"></i> 新增</button></span>
                </th>
            </tr>
            </thead>
        </table>
        <table class="table table-border table-bordered table-bg table-sort">
            <tr>
                <td>
                    <div id="pickets"></div>
                </td>
            </tr>
        </table>
    </form>
    <table class="table table-border table-bordered table-bg table-sort public_click_content" style="margin-top: 0px;">
        <thead>
        <tr class="text-l">
            <th width="106">
                <span class="l f-16"> 账单</span>
                <span class="r"><button class="btn btn-success radius" type="submit"><i class="icon-ok"></i> 保存</button></span>
            </th>
        </tr>
        </thead>
    </table>
    <table class="table table-border table-bordered table-bg table-sort">
        <thead>
            <th>费用项目</th>
            <th>收/付公司</th>
            <th>收付类型</th>
            <th>币种</th>
            <th>汇率</th>
            <th>实际收/付金额</th>
            <th>实际收/付金额（RMB）</th>
            <th>收付状态</th>
            <th>收/付日期</th>
            </thead>
        <tbody>
            <tr>
                <td>代理费</td>
                <td>收款：阿拉丁<br>  付款：张江男</td>
                <td>收款</td>
                <td>人民币</td>
                <td>1</td>
                <td>3000</td>
                <td>3000</td>
                <td>2已付</td>
                <td>2015/5/5</td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td class="text-r" colspan="9">
                    实收：4,000元     实付：2,000元
                </td>
            </tr>
        </tfoot>
    </table>
</div>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">查看附件</h4>
            </div>
            <div class="modal-body">
                <div class="modal-file-check">
                    <a href="">
                        <img src="http://img.51aladdin.com/8764bcab-86f6-4137-ab34-8f1c756f2c71.jpg@.jpg" alt="">
                    </a>
                    <p>出库单.jpg</p>
                </div>
                <div class="modal-file-check">
                    <a href="">
                        <img src="http://img.51aladdin.com/8764bcab-86f6-4137-ab34-8f1c756f2c71.jpg@.jpg" alt="">
                    </a>
                    <p>出库单.jpg</p>
                </div>
                <div class="modal-file-check">
                    <a href="">
                        <img src="http://img.51aladdin.com/8764bcab-86f6-4137-ab34-8f1c756f2c71.jpg@.jpg" alt="">
                    </a>
                    <p>出库单.jpg</p>
                </div>
                <div class="modal-file-check">
                    <a href="">
                        <img src="http://img.51aladdin.com/8764bcab-86f6-4137-ab34-8f1c756f2c71.jpg@.jpg" alt="">
                    </a>
                    <p>出库单.jpg</p>
                </div>
                <div class="modal-file-check">
                    <a href="">
                        <img src="http://img.51aladdin.com/8764bcab-86f6-4137-ab34-8f1c756f2c71.jpg@.jpg" alt="">
                    </a>
                    <p>出库单.jpg</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<div id="model" class="modal fade"   tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="position:absolute;left:50%;top:50;width: 200;height: 300">
    <div  class="modal-dialog" role="document" style="position:absolute;width: 100%;height: 100%">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="ModalLabel">新增单据</h4>
            </div>
            <div class="modal-body">
                <p>单据名称：<input id="picketName" type="text" style="width:150px" class="input-text" value="" placeholder="单据名称"></p>
                <input id="picketImg" type="file" class="btn-uploadpic" name="file">
                <div id="picketImgShow"></div>
            </div>
            <div class="modal-footer">
                <button id="savePicket" type="button" class="btn btn-default" data-dismiss="modal">确认</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<input type="hidden" value="${serviceOrderBo.srvOrderId}" id="srvOrderId"  name="srvOrderId">

<input type="hidden" value="${serviceOrderBo.orgId}" id="orgId"  name="orgId">
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script language="javascript" src="${ctx}/resources/js/position_top.js"></script>
<script language="javascript" src="${ctx}/resources/js/serviceorder/mySrvDetail.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>

<script>
    $(function(){
        $(document).on("change","#picketImg",function(){
//            var skuImgSize = $("#skuImgListId").find("img").length;
//            if(skuImgSize > 5){
//                alert("最多上传6张图片")
//                return false;
//            }
            var $dom = $(this);
            var id=$dom.attr("id");
            if (!/\.(gif|jpg|jpeg|png|pdf|bmp|GIF|JPG|PNG|BMP|JPEG|PDF)$/.test($dom.val())) {
                alert('"错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp .pdf格式图像!"');
                return false;
            }
            if ($dom.get(0).files[0].size > 1024 * 1024 * 5){
                alert('不能上传超过5M的文件，您上传的文件过大，请重新上传！');
                $dom.val(null);
                return false;
            }
            $.ajaxFileUpload({
                url:'${ctx}/aldUpload/uploadImg',
                secureuri:false,
                fileElementId:id,
                dataType:"json",
                success: function(data){
                    if(data.result){
                        var src= data.data.urlPath;
                        var resourceCode =  data.data.resourceCode;
                        var imgStr = '<div><img id="uploadImgNew" src="'+src+'"data-code="'+resourceCode+'"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
                        var inputStr = '<input type="button" class="delPhoto" value="删除"/></div>';
                        $("#picketImgShow").append(imgStr+inputStr);
                    }else{
                        alert("上传图片失败");
                    }
                },error: function (xml, status, e){
                    alert("上传图片失败");
                }
            });
        });

        $(document).on("click","#savePicket",function(){
            if(!$("#picketName").val()){
                alert("请输入单据名称");
                return;
            }
            if(!$("uploadImgNew")||$("#uploadImgNew").attr("src")==undefined){
                alert("请选择上传的单据图片！");
                return;
            }

            $.ajax({
                url:'${ctx}/serviceOrder/addPicket',
                data:{"attaName":$("#picketName").val(),
                    "attaPath":$("#uploadImgNew").attr("src"),
                    "srvOrderId":$("#srvOrderId").val(),
                    "srvOrgId":$("#orgId").val()
                },
                dataType:"json",
                type:"post",
                success: function(data){
                    alert("上传单据成功!");
                    $("#srvOrderId").remove();
                    var imgStr = '<img  src="'+$("#uploadImgNew").attr("src")+'"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'

                    $("#pickets").append(imgStr);
                },error: function (xml, status, e){
                    alert("上传图片失败");
                }
            });

        })
    })




    $("#fileCheck").on('click', function(){
        $("#myModal").modal("show");
    });
    $("#add").on('click', function(){
        $("#picketName").val(null);
        $("#picketImg").attr("src","");
        $("#picketImgShow").empty();

        $("#model").modal("show");
    });
</script>
</body>
</html>