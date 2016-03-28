package com.aladdin.platform.controller;

/**
 * Created by Administrator on 15-7-7.
 */

import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.*;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.*;
import com.aladdin.core.vo.*;
import com.aladdin.platform.bo.view.InquiryAddView;
import com.aladdin.platform.bo.view.InquiryDetailView;
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
import java.util.*;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;


    @Resource(name = "inquiryCoreService")
    private IInquiryCoreService inquiryCoreService;
    @Resource(name = "constantsCoreService")
    private IConstantsCoreService constantsCoreService;
    @Resource(name = "catalogCoreService")
    private ICatalogCoreService catalogCoreService;
    @Resource(name = "userCoreService")
    private IUserCoreService userCoreService;
    @Resource(name = "shopsCoreService")
    private IShopsCoreService shopsCoreService;
    @Resource(name = "skuCoreService")
    private ISkuCoreService skuCoreService;
    @Resource(name = "orgCoreService")
    private IOrgCoreService orgCoreService;
    @Resource(name = "userSyncImService")
    IUserSyncImService userSyncImService;

    /**
     * 根据yonghu名称模糊查询列表
     * @param userName 企业名称
     * @return 企业列表
     */
    @RequestMapping("/userList")
    @ResponseBody
    public List getUserList(@RequestParam(value = "term",required = true) String userName) {
        QueryParams<UserQueryVo> params = new QueryParams<>();
        UserQueryVo userQueryVo = new UserQueryVo();
        userQueryVo.setUserName(userName);
        userQueryVo.setRegSource(Constant.User.RegisterFrom.PURCHASE);
        params.setEntity(userQueryVo);
        List<UserBo> list  = userCoreService.findUser(params);
        List<AutoCompleteBo> lstAuto = new ArrayList<>();
        if (list.size() > 0) {
            for (UserBo x : list) {
                AutoCompleteBo auto = new AutoCompleteBo();
                auto.setId(x.getUserId().toString());
                auto.setLabel(x.getUserNameRu());
                auto.setValue(x.getUserNameRu());
                lstAuto.add(auto);
            }
        }
        return lstAuto;
    }

    /**
     * 根据店铺名称模糊查询店铺列表(中文)
     * @param shopName 店铺名称
     * @return 商铺列表
     */
    @RequestMapping("/shopList")
    @ResponseBody
    public List getShopsList(@RequestParam("term") String shopName) {
        List<ShopsFindBo> list = new ArrayList<>();
        if (!StringUtils.isEmpty(shopName)) {
            QueryParams<ShopsFindVo> params = new QueryParams<>();
            ShopsFindVo shopsFindVo = new ShopsFindVo();
            shopsFindVo.setShopsName(shopName);
            params.setEntity(shopsFindVo);
            list = shopsCoreService.findShops(params);
        }

        List<AutoCompleteBo> lstAuto = new ArrayList<>();

        if (list.size() > 0) {
            for (ShopsFindBo x : list) {
                AutoCompleteBo auto = new AutoCompleteBo();
                auto.setId(x.getShopsId().toString());
                auto.setOrgId(x.getOrgId().toString());
                auto.setUserId(x.getUserId().toString());
                auto.setLabel(x.getShopsNameCn());
                auto.setValue(x.getShopsNameCn());
                lstAuto.add(auto);
            }
        }
        return lstAuto;
    }

    /**
     * 根据店铺id，查询该店铺sku列表
     * @param shopsId 店铺ID
     * @param costType
     * @return sku列表
     */
    @RequestMapping("/skuList")
    @ResponseBody
    public List<SkuFindBo> getSkuListByShopsId(Long shopsId,Integer costType,Long productId) {
        QueryParams<SkuFindVo> params = new QueryParams<>();
        SkuFindVo skuFindVo = new SkuFindVo();
        skuFindVo.setShopsId(shopsId);
        skuFindVo.setDisabled(false);
        skuFindVo.setCostType(costType);
        skuFindVo.setProductId(productId);
        params.setEntity(skuFindVo);
        List<SkuFindBo> sku = skuCoreService.findSku(params);
        return sku;
    }




    @RequestMapping("/list")
    public String viewList(Model model){
//        model.addAttribute("service",srvOrderCoreService.findService());
        model.addAttribute("status",constantsCoreService.findConstantsByKey("inquiry_status"));
        return "inquiry/new_list";
    }

    @RequestMapping("/inquiryList")
    @ResponseBody
    public EasyUIDataGridBo viewList(InquiryQueryVo inquirySaveVo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO)Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE)Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();
        QueryParams<InquiryQueryVo> queryParams = new QueryParams();
//        if(inquirySaveVo.getCreateTimeEnd()!=null){
//            inquirySaveVo.setCreateTimeEnd(DateUtil.getBeforeDate(inquirySaveVo.getCreateTimeEnd(),-1, DateUtil.DateNumberType.DAY));
//        }
        queryParams.setEntity(inquirySaveVo);
        Integer total = inquiryCoreService.countInquiry(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            bo.setRows(inquiryCoreService.findInquiry(queryParams));
        }
        return bo;
    }

    /**
     * 新增询盘
     * @param model 页面元素
     * @return 新增询盘页
     */
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addInquiry(Model model) {
        InquiryAddView inquiryAddView = new InquiryAddView();
        inquiryAddView.setDeliveryAddrList(constantsCoreService.findConstantsByKey("delivery_addr"));
        inquiryAddView.setPaywayPercentList(constantsCoreService.findConstantsByKey("payway_percent"));
        inquiryAddView.setPaywayLastList(constantsCoreService.findConstantsByKey("payway_last"));
        inquiryAddView.setCostType(constantsCoreService.findConstantsByKey("currency_type"));
        inquiryAddView.setPackageType(constantsCoreService.findConstantsByKey("package_type"));
        inquiryAddView.setEffectiveDate(constantsCoreService.findConstantsByKey("effective_date"));
        inquiryAddView.setCatalogList(catalogCoreService.findCatalogByLevel(Constant.CatalogLevel.ONE)); //查询一级商品分类
        model.addAttribute("view",inquiryAddView);
        return "inquiry/new_add";
    }

    /**
     * 新增询盘保存
     * @param saveVo 询盘VO类
     * @return 列表页
     */
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult editInquiry(InquirySaveVo saveVo) {
        UserBo userBo =userCoreService.getUserByUserId(saveVo.getUserId());
        if (userBo != null) {
            saveVo.setOrgId(userBo.getOrgId());
        }
        saveVo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        List<InquiryProductVo> productVos = JSON.parseArray(saveVo.getSkuJson(),InquiryProductVo.class);
        inquiryCoreService.saveInquiry(saveVo,productVos);

        return new AjaxResult(true,"新增成功");

    }


    @RequestMapping("/adult")
    @ResponseBody
    public AjaxResult adult(Long inquiryId,Boolean flag) {
        Map<String, Object> result = inquiryCoreService.auditInquiry(inquiryId,flag);
        if(flag){
            //定向询盘给询盘店铺发送消息，不定向询盘给推荐的多个店铺发送消息。
            Object accessToken = SecurityUtils.getSubject().getSession().getAttribute("accessToken");
            Integer inquiryType = (Integer) result.get("inquiryType");
            Long userId = (Long) result.get("userId");
            InquiryDetailBo inquiry = inquiryCoreService.getInquiry(inquiryId, inquiryType, null);
            List<InquiryProductBo> inquiryProductList = inquiry.getInquiryProductList();
            StringBuilder productNames = new StringBuilder();
            for (int i = 0; i < inquiryProductList.size(); i++) {
                InquiryProductBo bo = inquiryProductList.get(i);
                productNames.append(bo.getProductNameCn());
                if (i < inquiryProductList.size() - 1) {
                    productNames.append("、");
                }
            }
            UserBo userBo =userCoreService.getUserByUserId(userId);
            String message = "俄罗斯采购商【" + userBo.getOrgNameRu() + "】向您求购【" + productNames + "】，";

            List<Long> inquiryFeedbackIdList = (List<Long>) result.get("inquiryFeedbackIdList");
            List<Long> shopsUserIdList = (List<Long>) result.get("shopsUserIdList");

            for (int i = 0; i < inquiryFeedbackIdList.size(); i++) {
                String url = "<a href='/supply/inquiry/detail?inquiryId=" + result.get("inquiryId") + "&inquiryType=" +
                        result.get("inquiryType") + "&inquiryFeedbackId=" + inquiryFeedbackIdList.get(i) + "' target='_blank'>点击给他报价吧！</a>";
                try {
                    userSyncImService.sendSysMsgByUserId(accessToken.toString(), shopsUserIdList.get(i), message + url);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return new AjaxResult(true,"审核成功");
    }

    @RequestMapping(value = "/feedBackSave", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult editFeedBack(InquiryFeedbackVo saveVo) {
        saveVo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        List<InquiryFeedbackProductVo> productVos = JSON.parseArray(saveVo.getSkuJson(),InquiryFeedbackProductVo.class);
        Long inquiryFeedbackId =inquiryCoreService.replyInquiry(saveVo,productVos);
        InquiryDetailBo inquiryDetailBo = inquiryCoreService.getInquiry(saveVo.getInquiryId(), saveVo.getInquiryType(), inquiryFeedbackId);
        Map<String, Object> map = getMessageData(inquiryDetailBo);

        String btnStrCn = "点此查看";
        String btnStrRu = "прошу вас проверить";

        String urlCn = "<a href='/purchase/inquiry/detail?inquiryId=" + saveVo.getInquiryId() + "&inquiryType=" + saveVo.getInquiryType() + "&inquiryFeedbackId=" + inquiryFeedbackId + "' target='_blank'>" + btnStrCn + "</a>";
        String urlRu = "<a href='/purchase/inquiry/detail?inquiryId=" + saveVo.getInquiryId() + "&inquiryType=" + saveVo.getInquiryType() + "&inquiryFeedbackId=" + inquiryFeedbackId + "' target='_blank'>" + btnStrRu + "</a>";

        String orgNameCn = map.get("orgNameCn").toString();
        String orgNameRu = map.get("orgNameRu").toString();
        Integer orgType = (Integer) map.get("orgType");
        if(Constant.Org.Type.COMPANY.equals(orgType)){
            orgNameCn = orgNameCn + "/" + map.get("userNameCn");
            orgNameRu = orgNameRu + "/" + map.get("userNameRu");
        }
        String messageCn = "中国供应商【" + orgNameCn + "】回复给您关于【" + map.get("productNameCn") + "】的报价，" + urlCn + "。<br/>";
        String messageRu = "Китайский поставщик【" + orgNameRu + "】 ,ответил вам о цене【" + map.get("productNameRu") + "】," + urlRu + ".";

        Object accessToken = SecurityUtils.getSubject().getSession().getAttribute("accessToken");
        try {
            Long buyerUserId = (Long) map.get("buyerUserId");
            userSyncImService.sendSysMsgByUserId(accessToken.toString(), buyerUserId, messageCn + messageRu);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new AjaxResult(true,"回复成功");

    }

    //查询消息中的公司名，姓名，和商品名。
    private Map<String, Object> getMessageData(InquiryDetailBo inquiry) {
        //发送消息
        ShopsFindVo shopsFindVo = new ShopsFindVo();
        shopsFindVo.setShopsId(inquiry.getShopsId());
        ShopsBo shopsBo = shopsCoreService.getShopsById(shopsFindVo);
        String orgNameCn = shopsBo.getOrgNameCn();
        String orgNameRu = shopsBo.getOrgNameRu();

        String userNameCn = shopsBo.getUserNameCn();
        String userNameRu = shopsBo.getUserNameRu();

        StringBuilder productNameCn = new StringBuilder();
        StringBuilder productNameRu = new StringBuilder();
        List<InquiryProductBo> inquiryProductList = inquiry.getInquiryProductList();
        for (int i = 0; i < inquiryProductList.size(); i++) {
            InquiryProductBo bo = inquiryProductList.get(i);
            productNameCn.append(bo.getProductNameCn());
            productNameRu.append(bo.getProductNameRu());
            if (i < inquiryProductList.size() - 1) {
                productNameCn.append("、");
                productNameRu.append("、");
            }
        }
        Map<String, Object> map = new HashMap<>();
        map.put("orgType",inquiry.getSellerOrgType());
        map.put("orgNameCn", orgNameCn);
        map.put("orgNameRu", orgNameRu);
        map.put("userNameCn", userNameCn);
        map.put("userNameRu", userNameRu);
        map.put("productNameCn", productNameCn);
        map.put("productNameRu", productNameRu);
        map.put("buyerUserId", inquiry.getUserId());
        map.put("saleUserId", inquiry.getSellerUserId());
        map.put("buyerOrgNameRu", inquiry.getBuyerOrgNameRu());
        map.put("shopsContactsMobile", shopsBo.getShopsContactsMobile());
        return map;
    }

    @RequestMapping(value = "/confirm", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult confirmSave(Long inquiryId,Integer status,Long feedBackId,Integer inquiryType,Long actingId) {
        InquiryDetailBo inquiryDetailBo =inquiryCoreService.getInquiry(inquiryId,inquiryType,feedBackId);
        Long userId = sessionContext.getLoginUser().getUserId();
        Map<String, Object> map = getMessageData(inquiryDetailBo);
        if(Constant.Inquiry.Status.WAIT_SELLER_CONFIRM.equals(status)){
            inquiryCoreService.sellerConfirm(userId,inquiryId,feedBackId,actingId);
            inquiryCoreService.changeInquiryFeedbackAuditStatus(userId,inquiryId,feedBackId,Constant.Audit.Status.AUDIT_PASS);
            String orgNameCn = map.get("orgNameCn").toString();
            String orgNameRu = map.get("orgNameRu").toString();
            Integer orgType = (Integer) map.get("orgType");
            if(Constant.Org.Type.COMPANY.equals(orgType)){
                orgNameCn = orgNameCn + "/" + map.get("userNameCn");
                orgNameRu = orgNameRu + "/" + map.get("userNameRu");
            }
            String url = "<a href='/supply/inquiry/detail?inquiryId=" + inquiryId + "&inquiryType=" + inquiryType + "&inquiryFeedbackId=" + feedBackId + "' target='_blank'>点此查看</a>";
            String message = "恭喜您，您与俄罗斯采购商【" + map.get("buyerOrgNameRu")+ "】关于【" + map.get("productNameCn") + "】的贸易订单已达成，" + url + "。<br/>";
            String url1 = "<a href='/purchase/inquiry/detail?inquiryId=" + inquiryId + "&inquiryType=" + inquiryType + "&inquiryFeedbackId=" + feedBackId + "' target='_blank'>点此查看！</a>";
            String url1Ru = "<a href='/purchase/inquiry/detail?inquiryId=" + inquiryId + "&inquiryType=" + inquiryType + "&inquiryFeedbackId=" + feedBackId + "' target='_blank'>прошу вас проверить！</a>";
            String message1 = "恭喜您，您与中国供应商【" + orgNameCn + "】关于【" + map.get("productNameCn") + "】的贸易订单已达成" + url1 + "。<br/>";
            String messageRu = "Мы вас поздравляем,Вы и китайский поставщик【" + orgNameRu + "】  совершили торговый заказ 【" + map.get("productNameRu") + "】," + url1Ru + ".";
            Object accessToken = SecurityUtils.getSubject().getSession().getAttribute("accessToken");
            try {
                Long buyerUserId = (Long) map.get("buyerUserId");
                Long saleUserId = (Long) map.get("saleUserId");
                userSyncImService.sendSysMsgByUserId(accessToken.toString(),saleUserId, message);
                userSyncImService.sendSysMsgByUserId(accessToken.toString(), buyerUserId, message1+messageRu);
                //发送短信
                String mobile = (String) map.get("shopsContactsMobile");
                userCoreService.seedCaptchaSms(mobile, message);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }else{
            inquiryCoreService.buyerConfirm(userId,inquiryId,feedBackId,inquiryType,actingId);
            inquiryCoreService.changeInquiryAuditStatus(userId,inquiryId,feedBackId,Constant.Audit.Status.AUDIT_PASS);
            //向供应商发送消息
            String url = "<a href='/supply/inquiry/detail?inquiryId=" + inquiryId + "&inquiryType=" + inquiryType + "&inquiryFeedbackId=" + feedBackId + "' target='_blank'>点此达成贸易订单！</a>";
            String message = "俄罗斯采购商【" + map.get("buyerOrgNameRu") + "】已经确认了您关于【" + map.get("productNameCn") + "】的报价，" + url + "。<br/>";

            Object accessToken = SecurityUtils.getSubject().getSession().getAttribute("accessToken");
            try {
                Long saleUserId = (Long) map.get("saleUserId");
                userSyncImService.sendSysMsgByUserId(accessToken.toString(), saleUserId, message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return new AjaxResult(true,"确认成功");

    }

    /**
     * 根据询盘类型和状态，查看询盘详情！
     *
     * @param inquiryId
     * @param inquiryType
     * @param inquiryStatus
     * @param model
     * @return
     */
    @RequestMapping("/feedBack")
    public String viewInquireFeedBack(Long inquiryId,Long feedbackId,Integer inquiryType,Integer inquiryStatus, Model model) {
        InquiryDetailView inquiryDetailView = new InquiryDetailView();
        inquiryDetailView.setInquiryBo(inquiryCoreService.getInquiry(inquiryId, inquiryType, feedbackId));
        if(Constant.Inquiry.Status.WAIT_BUYER_CONFIRM.equals(inquiryStatus)){
            inquiryDetailView.setOrgBo(orgCoreService.findActingOrg(Constant.Country.RUB));
            model.addAttribute("view",inquiryDetailView);
            return "inquiry/new_confirm"; //买家确认or卖家确认
        }
        if(Constant.Inquiry.Status.WAIT_SELLER_CONFIRM.equals(inquiryStatus)){
            inquiryDetailView.setOrgBo(orgCoreService.findActingOrg(Constant.Country.CHINA));
            model.addAttribute("view",inquiryDetailView);
            return "inquiry/new_confirm"; //买家确认or卖家确认
        }
        model.addAttribute("view",inquiryDetailView);
        if(Constant.Inquiry.Status.ING.equals(inquiryStatus)){
            return "inquiry/new_feedBack"; //询盘回复页面
        }
        return null;
    }

    @RequestMapping("/detail")
    public String viewInquiryDetail(Long inquiryId,Long feedbackId,Integer inquiryType, Model model) {
        InquiryDetailView inquiryDetailView = new InquiryDetailView();
        inquiryDetailView.setInquiryBo(inquiryCoreService.getInquiry(inquiryId, inquiryType, feedbackId));
        model.addAttribute("view",inquiryDetailView);
        return "inquiry/new_detail"; //询盘详情页面
    }

    @RequestMapping("/getSkuBo")
    @ResponseBody
    public AjaxResult getSkuBo(Long skuId){
        AjaxResult ajaxResult = new AjaxResult();
        SkuBo skuBo = skuCoreService.getSkuById(skuId);
        ajaxResult.setData(skuBo);
        return ajaxResult;
    }

    @RequestMapping("/changeStatus")
    @ResponseBody
    public AjaxResult changeStatus(Long inquiryId){
        inquiryCoreService.cancleInquiry(sessionContext.getLoginUser().getUserId(),inquiryId);
        return new AjaxResult(true,"订单已取消");
    }

    @RequestMapping("/changeAuditStatus")
    @ResponseBody
    public AjaxResult changeAuditStatus(Integer status,Integer auditStatus,Long inquiryId,Long feedBackId,Integer inquiryType){
        InquiryDetailBo inquiryDetailBo =inquiryCoreService.getInquiry(inquiryId,inquiryType,feedBackId);
        Map<String, Object> map = getMessageData(inquiryDetailBo);
        if(Constant.Inquiry.Status.WAIT_BUYER_CONFIRM.equals(status)){
            inquiryCoreService.changeInquiryAuditStatus(sessionContext.getLoginUser().getUserId(),inquiryId,feedBackId,auditStatus);
            //向供应商发送消息
//            InquiryDetailBo inquiry = inquiryCoreService.getInquiry(inquiryId, inquiryType, feedBackId);
//            List<InquiryProductBo> inquiryProductList = inquiry.getInquiryProductList();
//            StringBuilder productNames = new StringBuilder();
//            for (int i = 0; i < inquiryProductList.size(); i++) {
//                InquiryProductBo bo = inquiryProductList.get(i);
//                productNames.append(bo.getProductNameCn());
//                if (i < inquiryProductList.size() - 1) {
//                    productNames.append("、");
//                }
//            }
            String url = "<a href='/supply/inquiry/detail?inquiryId=" + inquiryId + "&inquiryType=" + inquiryType + "&inquiryFeedbackId=" + feedBackId + "' target='_blank'>点此达成贸易订单！</a>";
            String message = "俄罗斯采购商【" +  map.get("buyerOrgNameRu")+ "】已经确认了您关于【" +  map.get("productNameCn") + "】的报价，" + url + "。<br/>";

            Object accessToken = SecurityUtils.getSubject().getSession().getAttribute("accessToken");
            try {
                Long saleUserId = (Long) map.get("saleUserId");
                userSyncImService.sendSysMsgByUserId(accessToken.toString(),saleUserId, message);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        if(Constant.Inquiry.Status.WAIT_SELLER_CONFIRM .equals(status)){
            inquiryCoreService.changeInquiryFeedbackAuditStatus(sessionContext.getLoginUser().getUserId(),inquiryId,feedBackId,auditStatus);
            //向供应商发送消息
//            InquiryDetailBo inquiry = inquiryCoreService.getInquiry(inquiryId, inquiryType, feedBackId);
//            ShopsBo shopsBo = shopsCoreService.getShopsByUserId(inquiry.getSellerUserId());
//            List<InquiryProductBo> inquiryProductList = inquiry.getInquiryProductList();
//            StringBuilder productNames = new StringBuilder();
//            for (int i = 0; i < inquiryProductList.size(); i++) {
//                InquiryProductBo bo = inquiryProductList.get(i);
//                productNames.append(bo.getProductNameCn());
//                if (i < inquiryProductList.size() - 1) {
//                    productNames.append("、");
//                }
//            }
            String orgNameCn = map.get("orgNameCn").toString();
            String orgNameRu = map.get("orgNameRu").toString();
            Integer orgType = (Integer) map.get("orgType");
            if(Constant.Org.Type.COMPANY.equals(orgType)){
                orgNameCn = orgNameCn + "/" + map.get("userNameCn");
                orgNameRu = orgNameRu + "/" + map.get("userNameRu");
            }
            String url = "<a href='/supply/inquiry/detail?inquiryId=" + inquiryId + "&inquiryType=" + inquiryType + "&inquiryFeedbackId=" + feedBackId + "' target='_blank'>点此查看</a>";
            String message = "恭喜您，您与俄罗斯采购商【" + map.get("buyerOrgNameRu")+ "】关于【" + map.get("productNameCn") + "】的贸易订单已达成，" + url + "。<br/>";
            String url1 = "<a href='/purchase/inquiry/detail?inquiryId=" + inquiryId + "&inquiryType=" + inquiryType + "&inquiryFeedbackId=" + feedBackId + "' target='_blank'>点此查看！</a>";
            String url1Ru = "<a href='/purchase/inquiry/detail?inquiryId=" + inquiryId + "&inquiryType=" + inquiryType + "&inquiryFeedbackId=" + feedBackId + "' target='_blank'>прошу вас проверить！</a>";
            String message1 = "恭喜您，您与中国供应商【" + orgNameCn + "】关于【" + map.get("productNameCn") + "】的贸易订单已达成" + url1 + "。<br/>";
            String messageRu = "Мы вас поздравляем,Вы и китайский поставщик【" + orgNameRu + "】  совершили торговый заказ 【" + map.get("productNameRu") + "】," + url1Ru + ".";
            Object accessToken = SecurityUtils.getSubject().getSession().getAttribute("accessToken");
            try {
                Long buyerUserId = (Long) map.get("buyerUserId");
                Long saleUserId = (Long) map.get("saleUserId");
                userSyncImService.sendSysMsgByUserId(accessToken.toString(),saleUserId, message);
                userSyncImService.sendSysMsgByUserId(accessToken.toString(), buyerUserId, message1+messageRu);
                //发送短信
                String mobile = (String) map.get("shopsContactsMobile");
                userCoreService.seedCaptchaSms(mobile, message);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        return new AjaxResult(true,"审批成功");
    }

}
