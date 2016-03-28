package com.aladdin.platform.controller;

/**
 * Created by Administrator on 15-7-7.
 */

import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.OrderBo;
import com.aladdin.core.bo.SrvOrderBo;
import com.aladdin.core.bo.TradeOrderBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.*;
import com.aladdin.core.vo.*;


import com.aladdin.inf.service.IOrderInfService;
import com.aladdin.inf.vo.*;
import com.aladdin.platform.bo.view.OrderView;
import com.aladdin.platform.constans.Constants;
import com.aladdin.platform.result.AjaxResult;
import com.aladdin.platform.utils.DateUtil;
import com.alibaba.fastjson.JSON;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.*;

@Controller
@RequestMapping("/order")
public class OrderController {


    @Resource(name = "orderCoreService")
    private IOrderCoreService orderCoreService;
    @Resource(name = "constantsCoreService")
    private IConstantsCoreService constantsCoreService;
    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;
    @Resource(name = "userCoreService")
    private IUserCoreService userCoreService;
    @Resource(name = "orgCoreService")
    private IOrgCoreService orgCoreService;
    @Resource(name = "tradeOrderCoreService")
    private ITradeOrderCoreService tradeOrderCoreService;
    @Resource(name = "srvOrderCoreService")
    private ISrvOrderCoreService srvOrderCoreService;


    @RequestMapping("/list")
    public String viewList(Model model){
        model.addAttribute("addr", constantsCoreService.findConstantsByKey("delivery_addr"));
        model.addAttribute("type",constantsCoreService.findConstantsByKey("order_status"));
        return "order/new_list";
    }

    @RequestMapping("/orderList")
    @ResponseBody
    public EasyUIDataGridBo viewList(OrderQueryVo vo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO)Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE)Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<OrderQueryVo> queryParams = new QueryParams();
//        if(vo.getEndCreateTime()!=null){
//            vo.setEndCreateTime(DateUtil.getBeforeDate(vo.getEndCreateTime(),-1, DateUtil.DateNumberType.DAY));
//        }
        queryParams.setEntity(vo);
        Integer total = orderCoreService.countOrder(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            bo.setRows(orderCoreService.findOrder(queryParams));
        }
        return bo;
    }

    @RequestMapping("/{id}/edit")
    public String viewEdit(@PathVariable(value = "id") Long id,Model model){
        QueryParams<UserQueryVo> params = new QueryParams<>();
        UserQueryVo userQueryVo = new UserQueryVo();
        OrderView orderView = new OrderView();
        OrderBo orderBo = orderCoreService.getOrderById(id);

        userQueryVo.setUserOrgId(orderBo.getBuyOrgId());
        params.setEntity(userQueryVo);
        orderView.setBuyUserList(userCoreService.findUser(params));

        userQueryVo.setUserOrgId(orderBo.getSaleOrgId());
        params.setEntity(userQueryVo);
        orderView.setSaleUserList(userCoreService.findUser(params));
        orderView.setOrderBo(orderBo);
        orderView.setDeliveryAddrList(constantsCoreService.findConstantsByKey("delivery_addr"));
        orderView.setPaywayPercent(constantsCoreService.findConstantsByKey("payway_percent"));
        orderView.setFinalPayType(constantsCoreService.findConstantsByKey("final_pay_type"));
        orderView.setPackageType(constantsCoreService.findConstantsByKey("package_type"));

        TradeOrderVo aldTradeOrderEntity = new TradeOrderVo();
        aldTradeOrderEntity.setOrderId(id);
        List<TradeOrderBo> tradeOrderBos = tradeOrderCoreService.findTradeOrder(aldTradeOrderEntity);
        orderView.setSrvOrderList(tradeOrderBos);
        if(tradeOrderBos.size()>0){
            orderView.setSrvOrderBo(srvOrderCoreService.getSrvOrderById(tradeOrderBos.get(0).getSrvOrderId()));
        }
        orderView.setOrgBo(orgCoreService.getOrgByOrgId(Constant.Org.SpecialOrg.MZL_ORG_ID));
        orderView.setCount(tradeOrderCoreService.getSrvCount(id));
        model.addAttribute("orderView",orderView);
        return "order/new_edit";
    }

    @RequestMapping(value = "/changeStatus")
    public @ResponseBody
    AjaxResult updateStatus(Long orderId, Integer status){
        try {
            orderCoreService.changeOrderStatus(orderId, status, Constant.Order.Status.ING,sessionContext.getLoginUser().getUserId());
            return  new AjaxResult(true,"修改成功");
        } catch (Exception e) {
            return  new AjaxResult(false,"修改失败");
        }
    }

    @RequestMapping(value = "/edit")
    public @ResponseBody
    AjaxResult saveOrder(OrderSaveVo orderSaveVo){
        try{
            List<OrderSkuVo> orderSaveVos =JSON.parseArray(orderSaveVo.getSkuJson(),OrderSkuVo.class);
            orderSaveVo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
            orderCoreService.updateOrder(orderSaveVo, orderSaveVos);
            return new AjaxResult(true,"修改成功");
        }catch (Exception e){
            return new AjaxResult(false,"修改失败");
        }

    }


    @RequestMapping(value = "/getSrvOrder")
    public @ResponseBody
    AjaxResult getSrvOrder(Long srvOrderId){
        SrvOrderBo srvOrderBo = srvOrderCoreService.getSrvOrderById(srvOrderId);
        return new AjaxResult(srvOrderBo);
    }
}

