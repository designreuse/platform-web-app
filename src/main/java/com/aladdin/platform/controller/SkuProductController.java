package com.aladdin.platform.controller;

import cb.base.bo.query.QueryPage;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.*;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.*;
import com.aladdin.core.vo.*;
import com.aladdin.inf.po.*;
import com.aladdin.platform.bo.view.ShopsSkuEditView;
import com.aladdin.platform.bo.view.SkuAddView;
import com.aladdin.platform.bo.view.SkuListView;
import com.aladdin.platform.bo.view.SkuMessageView;
import com.aladdin.platform.constans.Constants;
import com.aladdin.platform.result.AjaxResult;
import com.aladdin.platform.utils.StringUtils;
import com.alibaba.fastjson.JSON;
import com.wl.framework.session.context.SessionContext;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Administrator on 2015/8/20.
 */
@Controller
@RequestMapping("/sku")
public class SkuProductController {

    @Resource(name = "productCoreService")
    private IProductCoreService productCoreService;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @Resource(name = "skuCoreService")
    ISkuCoreService skuCoreService;

    @Resource(name = "constantsCoreService")
    IConstantsCoreService constantsCoreService;

    @Resource(name = "catalogCoreService")
    private ICatalogCoreService catalogCoreService;

    @Resource(name = "skuConsultCoreService")
    ISkuConsultCoreService skuConsultCoreService;

    @Resource(name = "userSyncImService")
    IUserSyncImService userSyncImService;

    @Resource(name = "shopsCoreService")
    private IShopsCoreService shopsCoreService;

    private static String STATUS="status";
    private static String NATURE="nature";
    private static String IS_OFFLINE="is_offline";
    private static String SKU_STATUS="sku_status";
    private static String DELIVERY_ADDR="delivery_addr";
    private static String UNIT_TYPE="unit_type";
    private static String CURRENCY_TYPE="currency_type";
    private static String QUOTE_TYPE="quote_type";
    private static String PRODUCT_QUALITY="product_quality";
    private static Integer ORDERBY = 10;
    private static String CONSULT_TYPE = "consult_type";
    private static String CONSULT_STATUS = "consult_status";



    @RequestMapping(value = "add",method = RequestMethod.GET)
    public ModelAndView viewAdd(Long shopsId,String shopsName){
//        //初始化一级分类
//        model.addAttribute("catalogList", catalogService.selectByParentId(0L));
//        //交货地
//        model.addAttribute("deliveryAddrList", constantsService.selectByConstantsKey("delivery_addr"));

        ModelAndView mav = new ModelAndView("sku/add_new");
        SkuAddView  skuAddView = new SkuAddView();
        List<CatalogBo> catalogIdFirstList =  catalogCoreService.findCatalogByLevel(Constant.CatalogLevel.ONE);
        List<AldConstantsBo> deliveryAddrList = constantsCoreService.findConstantsByKey(DELIVERY_ADDR);
        List<AldConstantsBo> unitTypeList = constantsCoreService.findConstantsByKey(UNIT_TYPE);
        List<AldConstantsBo> currencyTypeList = constantsCoreService.findConstantsByKey(CURRENCY_TYPE);
        List<AldConstantsBo> quoteTypeList = constantsCoreService.findConstantsByKey(QUOTE_TYPE);
        List<AldConstantsBo> productQualityList = constantsCoreService.findConstantsByKey(PRODUCT_QUALITY);

        skuAddView.setCatalogIdFirstList(catalogIdFirstList);
        skuAddView.setDeliveryAddrList(deliveryAddrList);
        skuAddView.setUnitTypeList(unitTypeList);
        skuAddView.setCurrencyTypeList(currencyTypeList);
        skuAddView.setQuoteTypeList(quoteTypeList);
        skuAddView.setProductQualityList(productQualityList);
        skuAddView.setShopsId(shopsId);
        skuAddView.setShopsName(shopsName);
        mav.addObject("view",skuAddView);
        return mav;
    }

    @RequestMapping("/list")
    public ModelAndView viewList(Integer status){
        List<AldConstantsBo> statusList = constantsCoreService.findConstantsByKey(STATUS);
        List<AldConstantsBo> natureList = constantsCoreService.findConstantsByKey(NATURE);
        List<AldConstantsBo> isOfflineList = constantsCoreService.findConstantsByKey(IS_OFFLINE);
        List<AldConstantsBo> skuStatusList = constantsCoreService.findConstantsByKey(SKU_STATUS);
        List<CatalogBo> catalogIdFirstList =  catalogCoreService.findCatalogByLevel(Constant.CatalogLevel.ONE);

        ModelAndView mav = new ModelAndView("sku/list");
        SkuListView skuListView = new SkuListView();
        skuListView.setStatusList(statusList);
        skuListView.setNatureList(natureList);
        skuListView.setIsOfflineList(isOfflineList);
        skuListView.setSkuStatusList(skuStatusList);
        skuListView.setCatalogIdFirstList(catalogIdFirstList);
        skuListView.setStatus(status);

        mav.addObject("view",skuListView);

        return mav;
    }

    @RequestMapping("/skuList")
    @ResponseBody
    public EasyUIDataGridBo viewSkuList(SkuFindVo vo,
                           @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                           @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo datagridBo = new EasyUIDataGridBo();
        QueryParams<SkuFindVo> params = new QueryParams<>();
        vo.setDisabled(false);//不可用的不显示
        vo.setOrderBy(ORDERBY);//创建时间倒序
        Date date = vo.getReleaseTimeEnd();
        Date currentDate=null;
        if(date!=null){
            currentDate = moveDay(date,1);
        }
        vo.setReleaseTimeEnd(currentDate);
        params.setEntity(vo);


        Integer count = skuCoreService.countSku(params);
        datagridBo.setTotal(count);
        List<SkuFindBo> skuFindBoList = new ArrayList<>();
        if(count>0){
            QueryPage queryPage = new QueryPage();
            queryPage.setPageSize(pageSize);
            queryPage.setPageIndex(pageNumber);
            params.setQueryPage(queryPage);
            skuFindBoList = skuCoreService.findSku(params);
        }
        datagridBo.setRows(skuFindBoList);
        return datagridBo;
    }

    public  Date moveDay(Date dateTime/*待处理的日期*/,int n/*加减天数*/){

        //日期格式
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat dd=new SimpleDateFormat("yyyy-MM-dd EE hh:mm:ss");

        java.util.Calendar calstart = java.util.Calendar.getInstance();
        calstart.setTime(dateTime);


        calstart.add(java.util.Calendar.DAY_OF_WEEK, n);
        calstart.add(java.util.Calendar.SECOND, -1);


        return calstart.getTime();
    }


    @RequestMapping("/checkSkuProduct")
    @ResponseBody
    public AjaxResult settlement(String skuIds){
        Long user = sessionContext.getLoginUser().getUserId();
        String[]  arr = skuIds.split(",");
        if(arr.length>0){
            for(int i=0;i<arr.length;i++){
                skuCoreService.changeExamineStatus(user,Long.parseLong(arr[i]),true);
            }
        }
        return new AjaxResult(true,"计算成功");
    }
    /**
     * 修改上下架状态
     * @param skuId
     * @return
     */
    @RequestMapping("/changeShelvesStatus")
    @ResponseBody
    public AjaxResult changeShelvesStatus(Long skuId,Integer status){
        Long user = sessionContext.getLoginUser().getUserId();
        if(status==0){//上架
            skuCoreService.changeShelvesStatus(user,skuId,false);
        }else if(status==1){//下架
            skuCoreService.changeShelvesStatus(user,skuId,true);
        }
        return new AjaxResult(true,"下架成功");
    }
    /**
     * 设置停用
     * @param skuId
     * @return
     */
    @RequestMapping("/changeSkuDisabled")
    @ResponseBody
    public AjaxResult changeSkuDisabled(Long skuId){
        Long user = sessionContext.getLoginUser().getUserId();
        skuCoreService.changeSkuDisabled(user,skuId,true);

        return new AjaxResult(true,"设置成功");
    }

    @RequestMapping("/changeSkuDeleted")
    @ResponseBody
    public AjaxResult changeSkuDeleted(Long skuId){
        Long user = sessionContext.getLoginUser().getUserId();
        skuCoreService.changeSkuDeleted(user,skuId,true);

        return new AjaxResult(true,"设置成功");
    }
    /*@RequestMapping(value = "/save")
    public String saveSku(Model model,InfSkuVo vo,HttpServletRequest request,RedirectAttributes attributes){

        if (vo.getSkuId()!=null)
        {
            AldSkuBo skuBo = skuService.getById(vo.getSkuId());
            vo.setCreateBy(skuBo.getCreateBy());
            vo.setSkuStatus(skuBo.getSkuStatus());
            vo.setCreateTime(skuBo.getCreateTime());
            vo.setIsOffline(skuBo.getIsOffline());
            vo.setShopsId(skuBo.getShopsId());
            vo.setOrgName(skuBo.getOrgName());
            vo.setShopsName(skuBo.getShopsName());
        }
        List<AldSkuPriceEntity> priceEntityList = JSON.parseArray(vo.getPriceList(), AldSkuPriceEntity.class);
        List<AldSkuPhotoEntity> photoEntityList = JSON.parseArray(vo.getPhotoList(), AldSkuPhotoEntity.class);
        List<AldSkuPropertyEntity> propertyEntityList =new ArrayList<>();
        for(String property:request.getParameterMap().keySet()){
            if(property.startsWith("propertyValue_")){
                String propertyId = property.split("_")[1];
                String propertyValue = request.getParameter(property);
                AldSkuPropertyEntity entity = new AldSkuPropertyEntity();
                entity.setPropertyId(Long.parseLong(propertyId));
                entity.setPropertyValue(propertyValue);
                entity.setCreateTime(new Date());
                entity.setCreateBy(sessionContext.getLoginUser().getUserId());
                entity.setDisabled(0);
                propertyEntityList.add(entity);
            }
        }
        skuService.saveSkuInfo(vo, priceEntityList, propertyEntityList,photoEntityList, sessionContext.getLoginUser().getUserId());
        attributes.addFlashAttribute("msg", "保存成功！");
        return "redirect:/sku/list";
    }*/

    /**
     * 保存sku
     */
    @RequestMapping(value = "/addSku")
    @ResponseBody
    public AjaxResult addSku(String skuSaveVoStr, String skuPropertyVoStr, String skuPriceVoStr, String skuPhotoVoStr){
        Long currentUserId = sessionContext.getLoginUser().getUserId();
        SkuSaveVo skuSaveVo = JSON.parseObject(skuSaveVoStr, SkuSaveVo.class);
        List<SkuPropertyVo> skuPropertyVoList =  JSON.parseArray(skuPropertyVoStr, SkuPropertyVo.class);
        List<SkuPriceVo> skuPriceVoList =  JSON.parseArray(skuPriceVoStr, SkuPriceVo.class);
        List<SkuPhotoVo> skuPhotoVoList  =  JSON.parseArray(skuPhotoVoStr, SkuPhotoVo.class);
        skuSaveVo.setCurrentUserId(currentUserId);
        skuSaveVo.setSkuPropertyVoList(skuPropertyVoList);
        skuSaveVo.setSkuPriceVoList(skuPriceVoList);
        skuSaveVo.setSkuPhotoVoList(skuPhotoVoList);
        skuCoreService.saveSku(skuSaveVo);
        return new AjaxResult(true,"计算成功");
    }

    /**
     * 获取商铺名称列表 AutoComplete
     */
    @RequestMapping("/shopName")
    @ResponseBody
    public List ajaxShopName(HttpServletRequest request){
        String s=  request.getParameter("term").toString();
        List<AutoCompleteBo> list=new ArrayList<>();
        if (!StringUtils.isEmpty(s))
        {
            list=shopsCoreService.getAutoCompleteBoByShopName(s);
        }
        return list;
    }

    /**
     * 报价方式列表
     *
     * @return
     */
    @RequestMapping(value = "/getQuoteType")
    @ResponseBody
    public cb.base.bo.common.AjaxResult getQuoteType(Long skuId) {
        cb.base.bo.common.AjaxResult ajaxResult = new cb.base.bo.common.AjaxResult();
        // 报价方式列表
        List<AldConstantsBo> quoteTypeList =  constantsCoreService.findConstantsByKey("quote_type");
        ajaxResult.setIsSuccess(true);
        ajaxResult.setResultData(quoteTypeList);
        return ajaxResult;
    }

    /**
     * 取得SKU价格列表
     *
     * @return
     */
    @RequestMapping(value = "/getSkuPriceList")
    @ResponseBody
    public List<SkuPriceBo> getSkuPriceList(Long skuId) {
        // 取得sku价格列表
        List<SkuPriceBo> skuPriceBoList = new ArrayList<SkuPriceBo>();
        if (skuId != null){
            skuPriceBoList = skuCoreService.findSkuPrice(skuId);
        }
        return skuPriceBoList;
    }

    @RequestMapping(value = "/edit/{skuId}",method = RequestMethod.GET)
    public ModelAndView viewEdit(@PathVariable(value = "skuId") Long skuId){

        // sku信息
        SkuBo skuBo = skuCoreService.getSkuById(skuId);
        // 标准商品属性信息
        ProductPropertyBo productPropertyBo = productCoreService.getProductPropertyByProductId(skuBo.getProductId());
        // 取得sku属性列表
        List<SkuPropertyBo> skuPropertyBoList = skuCoreService.findSkuProperty(skuId);
        skuBo.setSkuPropertyBoList(skuPropertyBoList);
        // 取得sku价格列表
        List<SkuPriceBo> skuPriceBoList = skuCoreService.findSkuPrice(skuId);
        skuBo.setSkuPriceBoList(skuPriceBoList);
        // 取得sku图片列表
        List<SkuPhotoBo> skuPhotoBoList = skuCoreService.findSkuPhoto(skuId);
        skuBo.setSkuPhotoBoList(skuPhotoBoList);

        int skuPhotoCount = skuPhotoBoList.size();
        skuBo.setSkuPhotoCount(skuPhotoCount);
        // 取得一级品类列表
        List<CatalogBo> catalogIdFirstList =  catalogCoreService.findCatalogByLevel(Constant.CatalogLevel.ONE);
        // 取得二级品类列表
        List<CatalogBo> catalogIdSecondList = null;
        if (skuBo.getCatalogIdFirst() != null){
            catalogIdSecondList = catalogCoreService.findCatalogSubsetById(skuBo.getCatalogIdFirst());
        }
        // 取得三级品类列表
        List<CatalogBo> catalogIdList = null;
        if (skuBo.getCatalogIdSecond() != null){
            catalogIdList = catalogCoreService.findCatalogSubsetById(skuBo.getCatalogIdSecond());
        }
        // 取得标准商品列表
        List<ProductBo> productBoList = null;
        if (skuBo.getCatalogId()!= null){
            productBoList = productCoreService.findProductByCatalogId(skuBo.getCatalogId());
        }
        // 交货地列表
        List<AldConstantsBo> deliveryAddrList = constantsCoreService.findConstantsByKey("delivery_addr");
        // 币种列表
        List<AldConstantsBo> currencyTypeList =  constantsCoreService.findConstantsByKey("currency_type");
        // 报价方式列表
        List<AldConstantsBo> quoteTypeList =  constantsCoreService.findConstantsByKey("quote_type");

        // 设定值
        ShopsSkuEditView shopsSkuEditView = new ShopsSkuEditView();
        shopsSkuEditView.setProductPropertyBo(productPropertyBo);
        shopsSkuEditView.setSkuBo(skuBo);
        shopsSkuEditView.setCatalogIdFirstList(catalogIdFirstList);
        shopsSkuEditView.setCatalogIdSecondList(catalogIdSecondList);
        shopsSkuEditView.setCatalogIdList(catalogIdList);
        shopsSkuEditView.setProductBoList(productBoList);
        shopsSkuEditView.setDeliveryAddrList(deliveryAddrList);
        shopsSkuEditView.setCurrencyTypeList(currencyTypeList);
        shopsSkuEditView.setQuoteTypeList(quoteTypeList);

        ModelAndView mav = new ModelAndView("/sku/edit_new");
        mav.addObject("view",shopsSkuEditView);
        return mav;
    }

    @RequestMapping("/message")
    public ModelAndView message(){
        List<AldConstantsBo> consultStatusList = constantsCoreService.findConstantsByKey(CONSULT_STATUS);
        List<AldConstantsBo> consultTypeList = constantsCoreService.findConstantsByKey(CONSULT_TYPE);

        ModelAndView mav = new ModelAndView("sku/message");
        SkuMessageView skuMessageView = new SkuMessageView();
        skuMessageView.setConsultStatusList(consultStatusList);
        skuMessageView.setConsultTypeList(consultTypeList);

        mav.addObject("view",skuMessageView);
        return mav;
    }


    @RequestMapping("/messageList")
    @ResponseBody
    public EasyUIDataGridBo messageList(SkuConsultVo vo,
                                        @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                        @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo datagridBo = new EasyUIDataGridBo();
        QueryParams<SkuConsultVo> params = new QueryParams<>();

        Date endDate = vo.getEndDate();
        if(endDate!=null){
            Calendar cal = Calendar.getInstance();
            cal.setTime(endDate);
            cal.add(Calendar.DATE, 1);
            Date endDateNow = cal.getTime();
            vo.setEndDate(endDateNow);
        }

        params.setEntity(vo);

        Integer count = skuConsultCoreService.countMessage(params);
        datagridBo.setTotal(count);
        List<SkuConsultFindBo> skuConsultFindBoList = new ArrayList<>();
        if(count>0){
            QueryPage queryPage = new QueryPage();
            queryPage.setPageSize(pageSize);
            queryPage.setPageIndex(pageNumber);
            params.setQueryPage(queryPage);
            skuConsultFindBoList = skuConsultCoreService.findMessage(params);
        }
        datagridBo.setRows(skuConsultFindBoList);
        return datagridBo;
    }

    /**
     * Created by Administrator on 2015/8/20.
     * 获取商铺名称列表 审核sku信息
     */
    @RequestMapping(value = "/answer")
    public @ResponseBody
    AjaxResult answer(SkuConsultReplyVo vo){
        Long currentUserId = sessionContext.getLoginUser().getUserId();
        vo.setReplyUserId(currentUserId);

        skuConsultCoreService.replyMessage(vo);
        return new AjaxResult(true,"回复成功");
    }

    /**
     * Created by Administrator on 2015/8/20.
     * 删除上平留言回复信息
     */
    @RequestMapping(value = "/deleteReplyMessage")
    public @ResponseBody
    AjaxResult deleteReplyMessage(Long id){
        Long currentUserId = sessionContext.getLoginUser().getUserId();

        skuConsultCoreService.deleteReplyMessage(id,currentUserId);
        return new AjaxResult(true,"删除回复成功");
    }

    /**
     * Created by Administrator on 2015/8/20.
     * 删除商品留言信息
     */
    @RequestMapping(value = "/deleteMessage")
    public @ResponseBody
    AjaxResult deleteMessage(Long id){
        Long currentUserId = sessionContext.getLoginUser().getUserId();

        skuConsultCoreService.deleteMessage(id,currentUserId);
        return new AjaxResult(true,"删除留言成功");
    }
    /**
     * Created by Administrator on 2015/8/20.
     * sku修改状态
     */
    @RequestMapping(value = "/changeExamineStatus")
    public @ResponseBody
    AjaxResult changeExamineStatus(Long skuId,String productNameCn,Long shopsId,Integer status) throws Exception {
        Long currentUserId = sessionContext.getLoginUser().getUserId();
        String accessToken = (String) SecurityUtils.getSubject().getSession().getAttribute("accessToken");

        ShopsFindVo shopsFindVo = new ShopsFindVo();
        shopsFindVo.setShopsId(shopsId);
        ShopsBo ShopsBo = shopsCoreService.getShopsById(shopsFindVo);
        Long shopsContacts = ShopsBo.getShopsContacts();
        if(status==Constant.SKU.Status.pass){
            skuCoreService.changeExamineStatus(currentUserId,skuId,true);
        }else if(status==Constant.SKU.Status.refuse){
            skuCoreService.changeExamineStatus(currentUserId,skuId,false);
            String msg= "您的商品【"+productNameCn+"】审核被拒绝，请修改后再次提交！<a href='/supply/shops/sku/list' target='_blank'>商品管理</a>";
            userSyncImService.sendSysMsgByUserId(accessToken,shopsContacts,msg);
        }
        return new AjaxResult(true,"修改SKU状态成功");
    }



}
