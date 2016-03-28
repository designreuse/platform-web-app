package com.aladdin.platform.controller;

import cb.base.bo.query.QueryPage;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.*;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;

import com.aladdin.core.service.*;
import com.aladdin.core.vo.*;

import com.aladdin.inf.vo.*;
import com.aladdin.platform.bo.view.*;
import com.aladdin.platform.constans.Constants;
import com.aladdin.platform.result.AjaxResult;
import com.aladdin.platform.utils.DateUtil;
import com.aladdin.platform.utils.StringUtils;
import com.alibaba.fastjson.JSON;
import com.wl.framework.session.context.SessionContext;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by Administrator on 15-7-20.
 */
@Controller
@RequestMapping("/serviceOrder")
public class ServiceOrderController {

    private final static Long wuLiu = 5L;
    private final static Long caiGou = 6L;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;
    @Resource(name="srvOrderCoreService")
    private ISrvOrderCoreService srvOrderCoreService;
    @Resource(name="tradeOrderCoreService")
    private ITradeOrderCoreService tradeOrderCoreService;
    @Resource(name="srvOrderDtlCoreService")
    private ISrvOrderDtlCoreService srvOrderDtlCoreService;
    @Resource(name="constantsCoreService")
    private IConstantsCoreService constantsCoreService;
    @Resource(name="orgCoreService")
    private IOrgCoreService orgCoreService;
    @Resource(name="userCoreService")
    private IUserCoreService userCoreService;
    @Resource(name="proCityDistrictService")
    private IProCityDistrictService proCityDistrictService;
    @Resource(name="catalogCoreService")
    private ICatalogCoreService catalogCoreService;
    @Resource(name="transportCoreService")
    private ITransportCoreService transportCoreService;
    @Resource(name="storeCoreService")
    private IStoreCoreService storeCoreService;
    @Resource(name="orderCoreService")
    private IOrderCoreService orderCoreService;
    @Resource(name="stockCoreService")
    private IStockCoreService stockCoreService;
    @Resource(name = "userSyncImService")
    IUserSyncImService userSyncImService;





    @RequestMapping("/list")
    public String viewList(Model model,Integer status){
        SrvOrderListView srvOrderListView = new SrvOrderListView();
        srvOrderListView.setServiceList(srvOrderCoreService.findService());
        srvOrderListView.setStatusList(constantsCoreService.findConstantsByKey("srv_order_status"));
        srvOrderListView.setStatus(status);
        model.addAttribute("view",srvOrderListView);
        return "service/new_list";
    }

    @RequestMapping("/orderList")
    @ResponseBody
    public EasyUIDataGridBo viewList(SrvOrderQueryVo srvOrderSaveVo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO)Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE)Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<SrvOrderQueryVo> queryParams = new QueryParams();
//        if(srvOrderSaveVo.getEndCreateTime()!=null){
//            srvOrderSaveVo.setEndCreateTime(DateUtil.getBeforeDate(srvOrderSaveVo.getEndCreateTime(),-1, DateUtil.DateNumberType.DAY));
//        }
        queryParams.setEntity(srvOrderSaveVo);
        Integer total = srvOrderCoreService.countSrvOrder(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            bo.setRows(srvOrderCoreService.findSrvOrder(queryParams));
        }
        return bo;
    }



    @RequestMapping(value = "/srvOrderNodeList")
    @ResponseBody
    public EasyUIDataGridBo getNodeList(SrvOrderNodeVo srvOrderNodeVo,
                                        @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO)Integer pageNumber,
                                        @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE)Integer pageSize){
        QueryParams<SrvOrderNodeVo> params = new QueryParams<>();
        params.setEntity(srvOrderNodeVo);
        params.setQueryPageSize(pageSize);
        params.setQueryPageIndex(pageNumber);
        EasyUIDataGridBo easyUIDataGridBo = new EasyUIDataGridBo();
        easyUIDataGridBo.setTotal(srvOrderCoreService.countSrvOrderNode(params));
        easyUIDataGridBo.setRows(srvOrderCoreService.findSrvOrderNode(params));
        return easyUIDataGridBo;
    }


    @RequestMapping(value = "/{id}/edit",method = RequestMethod.GET)
    public String viewEdit(@PathVariable(value = "id") Long id,Model model){
        QueryParams<UserQueryVo> queryParams = new QueryParams<>();
        QueryParams<EntSrvStorageQueryVo> entSrvStorageQueryVoQueryParams = new QueryParams<>();
        EntSrvStorageQueryVo srvStorageQueryVo = new EntSrvStorageQueryVo();
        //查询车辆信息
        QueryParams<ParkCarQueryVo> parkCarQueryVoQueryParams = new QueryParams<>();
        ParkCarQueryVo parkCarQueryVo = new ParkCarQueryVo();
        parkCarQueryVo.setDisabled(false);
        parkCarQueryVoQueryParams.setEntity(parkCarQueryVo);

        SrvOrderEditView srvOrderEditView = new SrvOrderEditView();
        //所有服务节点
        QueryParams<SrvOrderNodeVo> params = new QueryParams<>();
        SrvOrderNodeVo srvOrderNodeVo = new SrvOrderNodeVo();
        srvOrderNodeVo.setSrvOrderId(id);
        params.setEntity(srvOrderNodeVo);
        List<SrvOrderNodeBo> srvOrderNodeBoList= srvOrderCoreService.findSrvOrderNode(params);
        //详情dtl
        List<SrvOrderDtlBo> serviceList = srvOrderDtlCoreService.findSrvOrderDtl(id);
        //服务详情
        SrvOrderBo srvOrderBo = srvOrderCoreService.getSrvOrderById(id);
        //服务
       List<ServiceBo> srvOrderBoList =  srvOrderCoreService.findService();

        //查询关联订单
        TradeOrderVo aldTradeOrderEntity = new TradeOrderVo();
        aldTradeOrderEntity.setSrvOrderId(id);
        List<TradeOrderBo> tradeOrderBos= tradeOrderCoreService.findTradeOrder(aldTradeOrderEntity);

        //委托联系人
        UserQueryVo userQueryVo = new UserQueryVo();
        userQueryVo.setOrgId(srvOrderBo.getOrgId());
        queryParams.setEntity(userQueryVo);
        List<UserBo> contacts = userCoreService.findUser(queryParams);

        //客服
        UserQueryVo queryVo = new UserQueryVo();
        queryVo.setDeptId(Constant.Org.dept.CUSTOM);
        queryParams.setEntity(queryVo);
        List<UserBo> customService = userCoreService.findUser(queryParams);

        if(tradeOrderBos.size()>0){
            TradeOrderBo  tradeOrderBo = tradeOrderBos.get(0);
            TradeOrderBo orderBo =tradeOrderCoreService.getTradeOrderById(tradeOrderBo.getTradeOrderId());
            srvOrderEditView.setTradeOrderBo(orderBo);
        }


        Map<String, Object> map = new HashMap<>();
        for (SrvOrderDtlBo bo : serviceList) {
            if (Constant.Service.Id.EXPORT_TRADE_AGENCY.equals(bo.getServiceId())) {
                map.put("service1", srvOrderDtlCoreService.getExportTradeByDtlId(bo.getSrvOrderDtlId()));
                map.put("service1dtl", bo.getSrvOrderDtlId());
            }
//          出口报检
            if (Constant.Service.Id.INSPECTION_AGENCY.equals(bo.getServiceId())) {
                map.put("service2", srvOrderDtlCoreService.getInspectionByDtlId(bo.getSrvOrderDtlId()));
                map.put("service2dtl", bo.getSrvOrderDtlId());
            }
//          出口报关
            if (Constant.Service.Id.CUSTOMS_AGENCY.equals(bo.getServiceId())) {
                map.put("service3", srvOrderDtlCoreService.getApplyProxyByDtlId(bo.getSrvOrderDtlId()));
                map.put("service3dtl", bo.getSrvOrderDtlId());
            }
//          俄境清关
            if (Constant.Service.Id.RUSSIAN_CUSTOMS_CLEARANCE.equals(bo.getServiceId())) {
                map.put("service4", srvOrderDtlCoreService.getRuClearanceByDtlId(bo.getSrvOrderDtlId()));
                map.put("service4dtl", bo.getSrvOrderDtlId());
            }
//          国内运输
            if (Constant.Service.Id.TRANSPORT_IN_CHINA.equals(bo.getServiceId())) {
                SrvOrderTransBo srvOrderTransBo = srvOrderDtlCoreService.getTransByDtlId(bo.getSrvOrderDtlId());
                map.put("service5", srvOrderTransBo);
                map.put("service5dtl", bo.getSrvOrderDtlId());
                if (map.get("service5") != null) {
                    if (srvOrderTransBo.getStartProvId() != null) {
                        srvOrderEditView.setStarProvList(proCityDistrictService.getProvinceByCountryId(Long.valueOf(Constant.Service.CountryType.COUNTRY_TYPE_CN)));
                    }
                    if (srvOrderTransBo.getStartCityId() != null && srvOrderTransBo.getStartProvId() != null) {
                        srvOrderEditView.setStarCityList(proCityDistrictService.getCityByProvinceId(Long.valueOf(srvOrderTransBo.getStartProvId())));
                    }
                    if (srvOrderTransBo.getStartCityId() != null && srvOrderTransBo.getStartDistId() != null) {
                        srvOrderEditView.setStarDistList(proCityDistrictService.getDistrictByCityId(Long.valueOf(srvOrderTransBo.getStartCityId())));
                    }

                    if (srvOrderTransBo.getEndProvId() != null) {
                        srvOrderEditView.setEndProvList(proCityDistrictService.getProvinceByCountryId(Long.valueOf(Constant.Service.CountryType.COUNTRY_TYPE_CN)));
                    }
                    if (srvOrderTransBo.getEndCityId() != null && srvOrderTransBo.getEndProvId() != null) {
                        srvOrderEditView.setEndCityList(proCityDistrictService.getCityByProvinceId(Long.valueOf(srvOrderTransBo.getEndProvId())));
                    }
                    if (srvOrderTransBo.getEndCityId() != null && srvOrderTransBo.getEndDistId() != null) {
                        srvOrderEditView.setEndDistList(proCityDistrictService.getDistrictByCityId(Long.valueOf(srvOrderTransBo.getEndCityId())));
                    }
                }
            }
//          俄境运输
            if (Constant.Service.Id.TRANSPORT_IN_RUSSIA.equals(bo.getServiceId())) {
                map.put("service6", srvOrderDtlCoreService.getTransByDtlId(bo.getSrvOrderDtlId()));
                map.put("service6dtl", bo.getSrvOrderDtlId());
            }
//          国内仓储
            if (Constant.Service.Id.STORAGE_IN_CHINA.equals(bo.getServiceId())) {
                map.put("service7", srvOrderDtlCoreService.getStoreByDtlId(bo.getSrvOrderDtlId()));
                map.put("service7dtl", bo.getSrvOrderDtlId());
            }
//          俄境仓储
            if (Constant.Service.Id.STORAGE_IN_RUSSIA.equals(bo.getServiceId())) {
                map.put("service8", srvOrderDtlCoreService.getStoreByDtlId(bo.getSrvOrderDtlId()));
                map.put("service8dtl", bo.getSrvOrderDtlId());
            }
        }

        //商品三级分类
        srvOrderEditView.setCatalogList(catalogCoreService.findCatalogByLevel(Constant.CatalogLevel.ONE));
        srvOrderEditView.setSrvOrderBo(srvOrderBo);
        srvOrderEditView.setSrvOrderNodeBoList(srvOrderNodeBoList);
        srvOrderEditView.setTradeOrderBoList(tradeOrderBos);
        srvOrderEditView.setDtlMap(map);
        srvOrderEditView.setServiceBoList(srvOrderBoList);
        srvOrderEditView.setCarType(constantsCoreService.findConstantsByKey("car_type"));
        srvOrderEditView.setLoadType(constantsCoreService.findConstantsByKey("load_type"));
        srvOrderEditView.setParkDriverBoList(transportCoreService.findDriver(null));
        srvOrderEditView.setParkCarBoList(transportCoreService.findCar(parkCarQueryVoQueryParams));
        srvOrderEditView.setDeliveryAddr(constantsCoreService.findConstantsByKey("delivery_addr"));
        srvOrderEditView.setDeliveryType(constantsCoreService.findConstantsByKey("delivery_type"));
        srvOrderEditView.setVolumeType(constantsCoreService.findConstantsByKey("volume_type"));
        srvOrderEditView.setStorageType(constantsCoreService.findConstantsByKey("storage_type"));
        srvOrderEditView.setCostType(constantsCoreService.findConstantsByKey("currency_type"));
        srvOrderEditView.setPackageType(constantsCoreService.findConstantsByKey("package_type"));
        srvOrderEditView.setOrgBo(orgCoreService.getOrgByOrgId(Constant.Org.SpecialOrg.MZL_ORG_ID));
        //仓库列表
        srvStorageQueryVo.setStorageType(Constant.Storage.STORAGE_TYPE_COMMON);
        srvStorageQueryVo.setCountryType(Constant.Country.CHINA);
        entSrvStorageQueryVoQueryParams.setEntity(srvStorageQueryVo);
        srvOrderEditView.setStoreListCn(storeCoreService.findStorePrice(entSrvStorageQueryVoQueryParams));
        srvStorageQueryVo.setCountryType(Constant.Country.RUB);
        entSrvStorageQueryVoQueryParams.setEntity(srvStorageQueryVo);
        srvOrderEditView.setStoreListRu(storeCoreService.findStorePrice(entSrvStorageQueryVoQueryParams));
        //暖库列表
        srvStorageQueryVo.setStorageType(Constant.Storage.STORAGE_TYPE_WARM);
        srvStorageQueryVo.setCountryType(Constant.Country.CHINA);
        entSrvStorageQueryVoQueryParams.setEntity(srvStorageQueryVo);
        srvOrderEditView.setStoreListHeatCn(storeCoreService.findStorePrice(entSrvStorageQueryVoQueryParams));
        srvStorageQueryVo.setCountryType(Constant.Country.RUB);
        entSrvStorageQueryVoQueryParams.setEntity(srvStorageQueryVo);
        srvOrderEditView.setStoreListHeatRu(storeCoreService.findStorePrice(entSrvStorageQueryVoQueryParams));
        //冷库列表
        srvStorageQueryVo.setStorageType(Constant.Storage.STORAGE_TYPE_COLD);
        srvStorageQueryVo.setCountryType(Constant.Country.CHINA);
        entSrvStorageQueryVoQueryParams.setEntity(srvStorageQueryVo);
        srvOrderEditView.setStoreListColdCn(storeCoreService.findStorePrice(entSrvStorageQueryVoQueryParams));
        srvStorageQueryVo.setCountryType(Constant.Country.RUB);
        entSrvStorageQueryVoQueryParams.setEntity(srvStorageQueryVo);
        srvOrderEditView.setStoreListColdRu(storeCoreService.findStorePrice(entSrvStorageQueryVoQueryParams));
        //仓库
        QueryParams<StoreQueryVo> storeQueryVoQueryParams = new QueryParams<>();
        StoreQueryVo storeQueryVo = new StoreQueryVo();
        storeQueryVo.setDisabled(false);
        storeQueryVoQueryParams.setEntity(storeQueryVo);
        srvOrderEditView.setStockList(storeCoreService.findStore(storeQueryVoQueryParams));
        srvOrderEditView.setContacts(contacts);
        srvOrderEditView.setCustomService(customService);
        model.addAttribute("view",srvOrderEditView);
        //todo 客服
        return "service/new_edit";
    }


    @RequestMapping(value = "/{id}/execute",method = RequestMethod.GET)
    public String viewExecute(@PathVariable(value = "id") Long id,Model model){
        Boolean flag = false;
        SrvOrderExecuteView srvOrderExecuteView = new SrvOrderExecuteView();
        QueryParams<SrvOrderNodeVo> params = new QueryParams<>();
        QueryParams<SrvOrderNodeVo> params1 = new QueryParams<>();
        SrvOrderNodeVo srvOrderNodeVo = new SrvOrderNodeVo();
        srvOrderNodeVo.setSrvOrderId(id);
        params.setEntity(srvOrderNodeVo);
        params1.setEntity(srvOrderNodeVo);
        params.setQueryPage(new QueryPage());
        List<SrvOrderNodeBo> srvOrderNodeBoList= srvOrderCoreService.findSrvOrderNode(params);
        List<SrvOrderNodeBo> nodeBoList= srvOrderCoreService.findSrvOrderNode(params1);
        //服务
        List<ServiceBo> srvOrderBoList =  srvOrderCoreService.findService();
        //服务详情
        SrvOrderBo srvOrderBo = srvOrderCoreService.getSrvOrderById(id);

        List<SrvOrderDtlBo> srvOrderDtlBos = srvOrderCoreService.findDtlService(id);
        if(srvOrderBo.getServiceIdList().size() != srvOrderDtlBos.size()){
            if(srvOrderBo.getStatus().equals(Constant.Service.Status.WAIT_ALLOT)){
                srvOrderCoreService.changeSrvOrderStatus(srvOrderBo.getSrvOrderId(),Constant.Service.Status.RUNNING_EXECUTE,sessionContext.getLoginUser().getUserId());
            }
        }
        srvOrderBo.setStatus(Constant.Service.Status.RUNNING_EXECUTE);
        if(srvOrderDtlBos.size()==0){
            for(SrvOrderNodeBo srvOrderNodeBo:nodeBoList){
                if(srvOrderNodeBo.getStatus().equals(Constant.ServiceNode.Status.FINISH)){
                    flag = true;
                }else{
                    flag = false;
                    break;
                }
            }
        }

        //查询关联订单
        TradeOrderVo aldTradeOrderEntity = new TradeOrderVo();
        aldTradeOrderEntity.setSrvOrderId(id);
        List<TradeOrderBo> tradeOrderBos= tradeOrderCoreService.findTradeOrder(aldTradeOrderEntity);

        if(tradeOrderBos.size()>0){
            TradeOrderBo  tradeOrderBo = tradeOrderBos.get(0);
            TradeOrderBo orderBo =tradeOrderCoreService.getTradeOrderById(tradeOrderBo.getTradeOrderId());
            srvOrderExecuteView.setOrderBo(orderBo);
        }

        List<AldConstantsBo> nodeStatus = constantsCoreService.findConstantsByKey("node_status");

        List<OrgBo> orgBoList = srvOrderCoreService.findOrderDtlOrg(id);
        srvOrderExecuteView.setNodeStatus(nodeStatus);
        srvOrderExecuteView.setOrgBoList(orgBoList);
        srvOrderExecuteView.setOrgBo(orgCoreService.getOrgByOrgId(Constant.Org.SpecialOrg.MZL_ORG_ID));
        srvOrderExecuteView.setSrvOrderBo(srvOrderBo);
        srvOrderExecuteView.setSrvOrderBoList(srvOrderBoList);
        srvOrderExecuteView.setSrvOrderNodeBoList(srvOrderNodeBoList);
        srvOrderExecuteView.setTradeOrderBos(tradeOrderBos);
        srvOrderExecuteView.setSrvOrderDtlBos(srvOrderDtlBos);
        srvOrderExecuteView.setFlag(flag);
        model.addAttribute("view",srvOrderExecuteView);
        return "service/new_execute";
    }


    @RequestMapping(value = "/executeSave")
    @ResponseBody
    public AjaxResult executeSave(SrvOrderNodeVo srvOrderNodeVo){
        Long userId = sessionContext.getLoginUser().getUserId();
        srvOrderNodeVo.setUserId(userId);
        srvOrderNodeVo.setCurrentUserId(userId);
        List<SrvOrderNodeAttachmentVo> attachmentVos =  JSON.parseArray(srvOrderNodeVo.getAttaJson(),SrvOrderNodeAttachmentVo.class);
        srvOrderCoreService.saveSrvOrderNode(srvOrderNodeVo,attachmentVos);
        return new AjaxResult(true,"修改成功");
    }



    @RequestMapping(value = "/add")
    public String viewAdd(Model model,Long orderId){
        SrvOrderAddView srvOrderAddView = new SrvOrderAddView();
        QueryParams<UserQueryVo> params = new QueryParams<>();
        UserQueryVo userQueryVo = new UserQueryVo();
        userQueryVo.setDeptId(Constant.Org.dept.CUSTOM);
        params.setEntity(userQueryVo);
        OrderBo orderBo = orderCoreService.getOrderById(orderId);

        //获取客服List
        List<UserBo> userBoList = userCoreService.findUser(params);//125为成林客服部门
        //获取服务列表
        List<ServiceBo> serviceBoList = srvOrderCoreService.findService();

        srvOrderAddView.setUserBoList(userBoList);
        srvOrderAddView.setServiceBoList(serviceBoList);
        srvOrderAddView.setOrderId(orderId);
        srvOrderAddView.setOrderBo(orderBo);
        model.addAttribute("srvOrderView",srvOrderAddView);
        return "service/new_add";
    }

    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    public @ResponseBody
    AjaxResult update(SrvOrderSaveVo orderVo){
        if(orderVo.getActingOrgId() == null){
            orderVo.setAuditStatus(Constant.Audit.Status.AUDIT_PASS);
        }
        orderVo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        srvOrderCoreService.saveSrvOrder(orderVo);
        return new AjaxResult(true,"保存成功");
    }

    @RequestMapping(value = "/changeStatus",method = RequestMethod.POST)
    public @ResponseBody
    AjaxResult updateStatus(Long srvOrderId,Integer status) {
        srvOrderCoreService.changeSrvOrderStatus(srvOrderId, status,sessionContext.getLoginUser().getUserId());
        SrvOrderBo bo = srvOrderCoreService.getSrvOrderById(srvOrderId);
        if(status.equals(Constant.Service.Status.WAIT_ALLOT)){
            String url = "";
            if(bo.getCountryType().equals(Constant.Country.CHINA)){
                url ="<a href='/supply/srvOrder/detail/"+bo.getSrvOrderId()+"' target='_blank'>点此查看详情</a>";
            }else{
                url = "<a href='/purchase/srvOrder/detail/"+bo.getSrvOrderId()+"' target='_blank'>点此查看详情</a><br/>Ваша заявка на обслуживание(【"+bo.getSrvOrderCode()+"】) уже подтверждена ,и мы начали выполнять сервис услуги,<a href='/purchase/srvOrder/detail/"+bo.getSrvOrderId()+"' target='_blank'>просим вас детально проверить</a>." ;
            }
            String message = "您的服务订单申请（【"+bo.getSrvOrderCode()+"】）已经确认，服务将进入执行环节,"+url;

            Object accessToken = SecurityUtils.getSubject().getSession().getAttribute("accessToken");
            try {
                userSyncImService.sendSysMsgByUserId(accessToken.toString(), bo.getContacts(), message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
            return new AjaxResult();
    }

    @RequestMapping(value = "/changeAuditStatus",method = RequestMethod.POST)
    public @ResponseBody
    AjaxResult updateAuditStatus(Long srvOrderId,Integer status) {
            srvOrderCoreService.changeSrvOrderAuditing(srvOrderId, status,sessionContext.getLoginUser().getUserId());
            return new AjaxResult();
    }


    @RequestMapping(value = "/saveFee",method = RequestMethod.POST)
    public @ResponseBody
    AjaxResult orderEdit(SrvOrderFeeVo vo){
        try{
            vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
            Long feeId = srvOrderCoreService.saveSrvOrderFee(vo);
            return new AjaxResult(true,feeId,"保存成功");
        }catch (Exception e){
            return new AjaxResult(false,"保存失败");
        }
    }

    @RequestMapping(value = "/detil",method = RequestMethod.POST)
    public @ResponseBody
    AjaxResult detilEdit(SrvOrderDtlVo srvOrderDtlVo){
        srvOrderDtlVo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        srvOrderCoreService.allotService(srvOrderDtlVo);
        return new AjaxResult(true,"添加成功");
    }

    @RequestMapping(value = "/getOrder/{orderid}",method = RequestMethod.GET)
    public String getorder(@PathVariable(value = "orderid")Long orderid, Model model){
        getOrderUpdate(orderid, model);
        return "service/orderInfo";
    }

    @RequestMapping(value = "/getOrderEdit/{orderid}",method = RequestMethod.GET)
    public String getOrderEdit(@PathVariable(value = "orderid")Long orderid,Model model){
        getOrderUpdate(orderid, model);
        model.addAttribute("catalogList",catalogCoreService.findCatalogByLevel(Constant.CatalogLevel.ONE));
        model.addAttribute("deliveryAddr",constantsCoreService.findConstantsByKey("delivery_addr"));
        model.addAttribute("costType",constantsCoreService.findConstantsByKey("currency_type"));
        model.addAttribute("packageType",constantsCoreService.findConstantsByKey("package_type"));
        return "service/orderInfoUpdate";
    }


    private void getOrderUpdate(Long tradeOrderId,Model model){
        TradeOrderBo bo =tradeOrderCoreService.getTradeOrderById(tradeOrderId);
        model.addAttribute("srvOrderBo",srvOrderCoreService.getSrvOrderById(bo.getSrvOrderId()));
        model.addAttribute("tradeOrderBo", bo);
    }


    @RequestMapping(value = "/serviceTrans",method = RequestMethod.POST)
    public @ResponseBody
    AjaxResult orderEdit(SrvOrderTransVo vo){
            List<TransAutoVo> voList = JSON.parseArray(vo.getTransJson(), TransAutoVo.class);
            vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
            Long transId = srvOrderCoreService.saveSrvOrderTrans(vo, voList);
            return new AjaxResult(true,transId,"保存成功");
    }


    @RequestMapping(value = "/serviceStore",method = RequestMethod.POST)
    public @ResponseBody
    AjaxResult orderEdit(SrvOrderStoreVo vo){
        List<StoreAutoVo> voList = JSON.parseArray(vo.getStoreJson(),StoreAutoVo.class);
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        Long storeId = srvOrderCoreService.saveSrvOrderStore(vo, voList);
        return new AjaxResult(true,storeId,"保存成功");
    }

    /**
     * Created by Administrator on 2015/8/20.
     * 获取商铺名称列表 AutoComplete
     */
    @RequestMapping("/getContacts")
    @ResponseBody
    public List ajaxOrgName(HttpServletRequest request){
        QueryParams<UserQueryVo> params = new QueryParams<>();
        UserQueryVo userQueryVo = new UserQueryVo();
        String s=  request.getParameter("term").toString();
        List<UserBo> list=new ArrayList<>();
        if (!StringUtils.isEmpty(s))
        {
            userQueryVo.setUserName(s);
            params.setEntity(userQueryVo);
            params.setQueryPage(new QueryPage());
            list=userCoreService.findUser(params);
        }
        List<AutoCompleteBo> lstAuto=new ArrayList<>();

        if (list.size()>0)
        {for(UserBo x : list) {
                if(x.getCountryId()!=null){
                    AutoCompleteBo auto=new AutoCompleteBo();
                    auto.setId(x.getUserId().toString());
                    if(x.getCountryId().equals(Constant.User.Country.CHINA)){
                        auto.setLabel(x.getUserNameCn());
                        auto.setValue(x.getUserNameCn());
                    }else{
                        auto.setLabel(x.getUserNameRu());
                        auto.setValue(x.getUserNameRu());
                    }
                    lstAuto.add(auto);
                }
            }
        }
        return lstAuto;
    }

    @RequestMapping(value = "/tradeOrderSave",method = RequestMethod.POST)
    public @ResponseBody
    AjaxResult tradeOrderSave(TradeOrderVo vo){
        List<TradeOrderProductVo> voList = JSON.parseArray(vo.getSkuJson(),TradeOrderProductVo.class);
        vo.setOrderId(0L);//手动输入
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        srvOrderCoreService.saveSrvOrderTrade(vo,voList);
        return new AjaxResult(true,"保存成功");
    }

    @RequestMapping(value = "/order/edit",method = RequestMethod.POST)
    public @ResponseBody
    Map serviceFree(Long id,Model model,QueryParams<InfOrderVo> params){
        Map map = new HashMap();
        InfOrderVo entity = new InfOrderVo();
        entity.setOrderId(id);
        params.setEntity(entity);
//        List<AldOrderBo> orderBoList = orderService.select(params);
//        model.addAttribute("orderBo", orderBoList.get(0));
        return map;
    }

     @RequestMapping(value = "/getOrg")
     @ResponseBody
     public AjaxResult getContacts(Long userId){
        AjaxResult ajaxResult = new AjaxResult();
         Map<String,Object> map=new HashMap<>();
         UserBo userBo = userCoreService.getUserByUserId(userId);
         map.put("orgName", userBo);
         map.put("entStatus",userBo.getEntUserStatus());
         map.put("actingOrgList",orgCoreService.findActingOrg(userBo.getCountryId()));
        ajaxResult.setData(map);
        return ajaxResult;
    }

    @RequestMapping(value = "/correlation",method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult correlation(Long serviceId, String tradeCode){
        QueryParams<OrderQueryVo> params = new QueryParams();
        OrderQueryVo orderQueryVo = new OrderQueryVo();
        orderQueryVo.setOrderCode(tradeCode);
        params.setEntity(orderQueryVo);
        List<OrderBo> orderList = orderCoreService.findOrder(params);
        if(orderList.size()>0){
           Boolean flag =srvOrderCoreService.relevanceSrvOrderTrade(orderList.get(0).getOrderId(),serviceId,sessionContext.getLoginUser().getUserId());
            return new AjaxResult(flag,"");
        }
        return new AjaxResult(false,"");
    }

    @RequestMapping(value = "/findDeptBymOrgId",method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult findDeptBymOrgId(Long orgId) {
        if(orgId !=null){
            OrgDepartmentQueryVo orgDepartmentQueryVo = new OrgDepartmentQueryVo();
            orgDepartmentQueryVo.setOrgId(orgId);
            List<DepartmentBo> departmentBoList = orgCoreService.findCoreDepartment(orgDepartmentQueryVo);
            return new AjaxResult(departmentBoList);
        }
        return new AjaxResult();
    }

    @RequestMapping(value = "/findOrgByServiceId",method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult findOrgByServiceId(Long serviceId) {
        return new AjaxResult(orgCoreService.findOrgByServiceId(serviceId));
    }

    @RequestMapping(value = "/getNodeByNodeId",method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult getNodeByNodeId(Long nodeId) {
        return new AjaxResult(srvOrderCoreService.findNodeAttachmentById(nodeId));
    }


    @RequestMapping(value = "/getStoreList",method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult getStoreList(Integer storage,Long countryType) {
        QueryParams<EntSrvStorageQueryVo> entSrvStorageQueryVoQueryParams = new QueryParams<>();
        EntSrvStorageQueryVo entSrvStorageQueryVo = new EntSrvStorageQueryVo();
        entSrvStorageQueryVo.setCountryType(countryType);
        entSrvStorageQueryVo.setStorageType(storage);
        entSrvStorageQueryVoQueryParams.setEntity(entSrvStorageQueryVo);
        return new AjaxResult(storeCoreService.findStorePrice(entSrvStorageQueryVoQueryParams));
    }

    @RequestMapping(value = "/getStockList",method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult getStockList() {
        QueryParams<StoreQueryVo> params = new QueryParams<>();
        StoreQueryVo stockQueryVo = new StoreQueryVo();
        stockQueryVo.setDisabled(false);
        params.setEntity(stockQueryVo);
        return new AjaxResult(storeCoreService.findStore(params));
    }

    @RequestMapping(value = "/delTradeOrder",method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult delTradeOrder(Long tradeOrderId) {
        tradeOrderCoreService.delTradeOrder(tradeOrderId,sessionContext.getLoginUser().getUserId());
        return new AjaxResult(true,"删除成功");
    }

    @RequestMapping(value = "/getAtta",method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult getAtta(Long nodeId) {
        return new AjaxResult(srvOrderCoreService.findNodeAttachmentById(nodeId));
    }



    @RequestMapping(value = "/isSrvPriceNotNull")
    @ResponseBody
    public AjaxResult isSrvPriceNotNull(Long srvOrderId){
        return new AjaxResult(srvOrderCoreService.isSrvPriceNotNull(srvOrderId),"");
    }
}
