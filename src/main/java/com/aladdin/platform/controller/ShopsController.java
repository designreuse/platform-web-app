package com.aladdin.platform.controller;

import cb.base.bo.common.AjaxResult;
import cb.base.bo.query.QueryPage;
import com.aladdin.core.bo.*;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.po.AldShopsAdEntity;
import com.aladdin.core.service.*;
import com.aladdin.core.vo.*;
import com.aladdin.platform.bo.view.ShopsAddView;
import com.aladdin.platform.bo.view.ShopsEditView;
import com.aladdin.platform.bo.view.ShopsListView;
import com.aladdin.platform.constans.Constants;
import cb.base.bo.query.QueryParams;
import com.aladdin.platform.utils.StringUtils;
import com.alibaba.fastjson.JSON;
import com.wl.framework.session.context.SessionContext;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("/shops")
public class ShopsController {


    @Resource(name = "shopsCoreService")
    private IShopsCoreService shopsCoreService;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @Resource(name = "constantsCoreService")
    IConstantsCoreService constantsCoreService;

    @Resource(name = "userCoreService")
    IUserCoreService userCoreService;

    @Resource(name = "adultLogCoreService")
    IAdultLogCoreService adultLogCoreService;

    @Resource(name = "shopsAdCoreService")
    IShopsAdCoreService shopsAdCoreService;

    @Resource(name = "userSyncImService")
    IUserSyncImService userSyncImService;

    @Resource(name = "orgCoreService")
    IOrgCoreService orgCoreService;

    @Resource(name = "catalogCoreService")
    ICatalogCoreService catalogCoreService;



    private static String AUDIT_STATUS = "audit_state";
    private static String MEMBER_SHIP = "member_ship";
    private static String STYLE_MODEL= "style_model";//风格配色
    private static String DISABLED = "disabled";
    private static Integer PLATFORM = 1;
    private static Integer APPLY_TYPE = 3;

    private static Integer ADULTSTATUS_PASS = 1;
    private static Integer ADULTSTATUS_REFUSE = 2;

    private static String CHECKSHOP_FAIL_MSG="您的商铺信息审核被拒绝，请修改后再次提交！<a href='/supply/shops/show' target='_blank'>商铺管理</a>";
    private static String CHECKSHOP_SUCCESS_MSG="恭喜您，您的商铺信息已通过审核，快来发布商品吧！<a href='/supply/shops/sku/newCreateSku' target='_blank'>发布商品</a>";

    private static Integer ENTUSERSTATUS_PERSON = 2;
    private static Integer ENTUSERSTATUS_ORG = 1;


//    private static String CHECKSHOP_FAIL_MSG="<a href='/shops/sku/list'>您的商铺信息审核被拒绝，请修改后再次提交！</a>";

    @RequestMapping("/list")
    public ModelAndView list(Integer status){
        ModelAndView modelAndView = new ModelAndView("shops/listNew");

        //审核状态
        List<AldConstantsBo> auditStatusList = constantsCoreService.findConstantsByKey(AUDIT_STATUS);
        //隶属关系
        List<AldConstantsBo> memberShipList = constantsCoreService.findConstantsByKey(MEMBER_SHIP);
        //状态
        List<AldConstantsBo> statusList = constantsCoreService.findConstantsByKey(DISABLED);

        List<CatalogBo> catalogBos = catalogCoreService.findCatalogByLevel(1);


        ShopsListView shopsListView = new ShopsListView();
        shopsListView.setAuditStatusList(auditStatusList);
        shopsListView.setMemberShipList(memberShipList);
        shopsListView.setStatusList(statusList);
        shopsListView.setCatalogBos(catalogBos);
        shopsListView.setStatus(status);

        modelAndView.addObject("view",shopsListView);
        return modelAndView;
    }

    @RequestMapping("/viewList")
    @ResponseBody
    public EasyUIDataGridBo viewSkuList(ShopsFindVo vo,
                                        @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                        @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo datagridBo = new EasyUIDataGridBo();
        QueryParams<ShopsFindVo> params = new QueryParams<>();
        Date endDate = vo.getEndCreateDate();
        if(endDate!=null){
            Calendar cal = Calendar.getInstance();
            cal.setTime(endDate);
            cal.add(Calendar.DATE, 1);
            cal.add(Calendar.SECOND,-1);
            Date endDateNow = cal.getTime();
            vo.setEndCreateDate(endDateNow);
        }

        params.setEntity(vo);

        Integer count = shopsCoreService.countShops(params);
        datagridBo.setTotal(count);
        List<ShopsFindBo> shopsFindBoList = new ArrayList<>();
        if(count>0){
            QueryPage queryPage = new QueryPage();
            queryPage.setPageSize(pageSize);
            queryPage.setPageIndex(pageNumber);
            params.setQueryPage(queryPage);
            shopsFindBoList = shopsCoreService.findShops(params);
        }
        datagridBo.setRows(shopsFindBoList);
        return datagridBo;
    }

    //进入添加店铺界面
    @RequestMapping(value = "/add",method = RequestMethod.GET)
    public ModelAndView addShops() {
        ModelAndView modelAndView = new ModelAndView("shops/addNew");
        //风格配色
        List<AldConstantsBo> styleModelList = constantsCoreService.findConstantsByKey(STYLE_MODEL);

        ShopsAddView shopsAddView = new ShopsAddView();
        shopsAddView.setCatalogs(catalogCoreService.findCatalogByLevel(1));
        shopsAddView.setStyleModelList(styleModelList);
        modelAndView.addObject("view",shopsAddView);
        return modelAndView;
    }
    // 添加店铺
    @RequestMapping(value = "/saveShop", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult saveShops(ShopsSaveVo shopsSaveVo,String shopsAd){
        Long userId = sessionContext.getLoginUser().getUserId();
        shopsSaveVo.setCurrentUserId(userId);
        List<AldShopsAdEntity> shopsAdEntities =  JSON.parseArray(shopsAd, AldShopsAdEntity.class);
        shopsCoreService.saveShops(shopsSaveVo, PLATFORM,shopsAdEntities);
        return new AjaxResult(true,"编辑商铺成功");
    }


    @RequestMapping(value = "/getUserByMobile", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult getUserByMobile(String mobile){
        UserQueryVo userQueryVo =new UserQueryVo();
        userQueryVo.setMobile(mobile);

        //先检测查询有没有这个号码的人
        QueryParams<UserQueryVo> params0 =new QueryParams();
        params0.setEntity(userQueryVo);
        List<UserBo> userBoList0 = userCoreService.findUser(params0);
        if(userBoList0.size()<=0){
            return new AjaxResult(false,null, "查训数据成功");
        }


        //然后检测该人是否是隶属企业的
        //关系设置成企业
        userQueryVo.setEntUserStatus(ENTUSERSTATUS_ORG);
        QueryParams<UserQueryVo> params1 =new QueryParams();
        params1.setEntity(userQueryVo);
        List<UserBo> userBoList1 = userCoreService.findUser(params1);
        if(userBoList1.size()>0){
            return new AjaxResult(false, userBoList1, "entuserstatus_org");
        }

        //如果该个人已有商铺则不允许再新建
        ShopsFindVo shopsFindVo = new ShopsFindVo();
        shopsFindVo.setShopsType(2);//设置成个人
        shopsFindVo.setMobile(mobile);
        shopsFindVo.setDisabled(0);
        QueryParams<ShopsFindVo> params2 = new QueryParams();
        params2.setEntity(shopsFindVo);
        List<ShopsFindBo> shopsFindBoList = shopsCoreService.findShops(params2);
        if(shopsFindBoList.size()>0){
            return new AjaxResult(false, shopsFindBoList, "shop_exists");
        }


        return new AjaxResult(true, userBoList0, "查训数据成功");
    }

    /**
     * Created by Administrator on 2015/8/20.
     * 获取企业名称列表 AutoComplete
     */
    @RequestMapping("/getOrgName")
    @ResponseBody
    public List getOrgName(HttpServletRequest request){
        String param=  request.getParameter("term").toString();
        List<AutoCompleteBo> lstAuto=new ArrayList<>();
        if (!StringUtils.isEmpty(param)){
            lstAuto = orgCoreService.findOrgNotExistsShop(param);

        }

        return lstAuto;
    }

    /**
     * Created by Administrator on 2015/8/20.
     * 获取企业名称列表 AutoComplete
     */
    /*@RequestMapping(value ="/checkExistShop" , method = RequestMethod.POST )
    @ResponseBody
    public AjaxResult checkExistShop(Long orgId){

        ShopsFindVo shopsFindVo = new ShopsFindVo();
        shopsFindVo.setOrgId(orgId);
        QueryParams<ShopsFindVo> params =new QueryParams();
        params.setEntity(shopsFindVo);
        List<ShopsFindBo> shopsFindBoList = shopsCoreService.findShops(params);

        return new AjaxResult(true,shopsFindBoList,"查询成功");
    }*/

    @RequestMapping(value = "/getUserListByOrgId", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult getUserByOrgId(Long orgId){
        UserQueryVo userQueryVo =new UserQueryVo();
        userQueryVo.setOrgId(orgId);

        QueryParams<UserQueryVo> params =new QueryParams();
        params.setEntity(userQueryVo);
        params.setQueryPage(null);
        List<UserBo> userBoList = userCoreService.findUser(params);

        return new AjaxResult(true, userBoList, "查训数据成功");
    }

    @RequestMapping("/edit/{shopsId}")
    public ModelAndView edit(@PathVariable(value = "shopsId") Long shopsId){
        ModelAndView modelAndView = new ModelAndView("shops/editNew");

        ShopsFindVo shopsFindVo = new ShopsFindVo();
        shopsFindVo.setShopsId(shopsId);
        ShopsBo shopsBo = shopsCoreService.getShopsById(shopsFindVo);

        UserQueryVo userQueryVo =new UserQueryVo();
        userQueryVo.setOrgId(shopsBo.getOrgId());
        QueryParams<UserQueryVo> params =new QueryParams();
        params.setQueryPage(null);
        params.setEntity(userQueryVo);
        List<UserBo> userBoList = userCoreService.findUser(params);

        AdultQueryLogVo adultQueryLogVo = new AdultQueryLogVo();
        adultQueryLogVo.setDynamicId(shopsId);
        adultQueryLogVo.setApplyType(APPLY_TYPE);
        List<AdultLogBo> adultLogBoList= adultLogCoreService.findAdultLog(adultQueryLogVo);

        //风格配色
        List<AldConstantsBo> styleModelList = constantsCoreService.findConstantsByKey(STYLE_MODEL);



        ShopsEditView shopsEditView = new ShopsEditView();
        shopsEditView.setShopsBo(shopsBo);
        shopsEditView.setUserBoList(userBoList);
        shopsEditView.setAdultLogBoList(adultLogBoList);
        shopsEditView.setCatalogBos(catalogCoreService.findCatalogByLevel(1));
        shopsEditView.setShopsAd(shopsAdCoreService.selectByShopsId(shopsId,1));
        shopsEditView.setShopsAdApp(shopsAdCoreService.selectByShopsId(shopsId,2));
        shopsEditView.setStyleModelList(styleModelList);
        modelAndView.addObject("view",shopsEditView);
        return modelAndView;
    }

    @RequestMapping(value = "/checkShop", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult checkShop(Long dynamicId,String adultContent,Integer shopsStatus) throws Exception {
        Long userId = sessionContext.getLoginUser().getUserId();
        Integer adultStatus = 1;
        boolean shopsStatusBoolean=true;
        if(shopsStatus==Constant.Audit.Status.AUDIT_REFUSE){
//            shopsStatus=Constant.Audit.State.AUDIT_REFUSE;
            adultStatus = Constant.Audit.Status.AUDIT_REFUSE ;
            shopsStatusBoolean =false;
        }else if(shopsStatus==Constant.Audit.Status.AUDIT_PASS){
//            shopsStatus=Constant.Audit.State.AUDIT_PASS;
            adultStatus = Constant.Audit.Status.AUDIT_PASS;
            shopsStatusBoolean=true;
        }
//        AdultQueryLogVo adultLogVo = new AdultQueryLogVo();
//        adultLogVo.setDynamicId(dynamicId);

        AdultSaveVo  adultSaveVo = new AdultSaveVo();
        adultSaveVo.setDynamicId(dynamicId);
        adultSaveVo.setAdultContent(adultContent);
        adultSaveVo.setAdultStatus(adultStatus);
        adultSaveVo.setAdultUser(userId);
        //修改审核记录表数据的状态
        adultLogCoreService.updateAdultLog(adultSaveVo);
//        }

        //改变商铺的审核状态
        shopsCoreService.changeExamineStatus(dynamicId,shopsStatusBoolean,adultContent,userId);

        //向店铺所属企业的管理员发消息
        ShopsFindVo shopsFindVo = new ShopsFindVo();
        shopsFindVo.setShopsId(dynamicId);
        ShopsBo ShopsBo = shopsCoreService.getShopsById(shopsFindVo);
        Long orgId = ShopsBo.getOrgId();
        UserQueryVo userQueryVo = new UserQueryVo();
        userQueryVo.setOrgId(orgId);
        userQueryVo.setIsRoot(true);
        QueryParams<UserQueryVo> params = new QueryParams();
        params.setEntity(userQueryVo);
        List<UserBo> userBoList = userCoreService.findUser(params);

        String accessToken = (String) SecurityUtils.getSubject().getSession().getAttribute("accessToken");
        String msg;
        if(shopsStatusBoolean==true){
            msg=CHECKSHOP_SUCCESS_MSG;
        }else{
            msg = CHECKSHOP_FAIL_MSG;
        }
        for(UserBo userBo : userBoList){
            userSyncImService.sendSysMsgByUserId(accessToken,userBo.getUserId(),msg);
        }
        return new AjaxResult(true, "审核完成");
    }

    @RequestMapping(value = "/changeShopsDisabled", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult changeShopsDisabled(Long shopsId){

        shopsCoreService.changeShopsDisabled(shopsId,true);

        return new AjaxResult(true, "停用店铺成功");
    }

    @RequestMapping(value = "/changeShopsAbled", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult changeShopsAbled(Long shopsId){

        shopsCoreService.changeShopsDisabled(shopsId,false);

        return new AjaxResult(true, "启用店铺成功");
    }

}
