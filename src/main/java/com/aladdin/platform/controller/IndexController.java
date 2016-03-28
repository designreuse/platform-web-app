package com.aladdin.platform.controller;


import cb.base.bo.query.QueryPage;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.*;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.*;
import com.aladdin.core.vo.*;
import com.aladdin.inf.constant.AppConstant;
import com.aladdin.inf.constant.InquireConstant;
import com.aladdin.inf.constant.NewsConstant;
import com.aladdin.platform.bo.view.HomePageListView;
import com.wl.framework.login.ILoginService;
import com.wl.framework.session.context.SessionContext;
import com.wl.framework.session.domain.LoginUser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 默认首页
 */
@Controller
@RequestMapping("/")
public class IndexController {
    private final static String MODULE_DES = "默认首页";
    private final static String COMMENT = "（融链注册验证码），感谢您注册融链平台，如有疑问请致电客服：021-60877654";

    private final static Integer pageSize = 5;

    @Resource(name = "userCoreService")
    IUserCoreService userCoreService;

    @Resource(name = "shopsCoreService")
    IShopsCoreService shopsCoreService;

    @Resource(name = "skuCoreService")
    ISkuCoreService skuCoreService;

    @Resource(name = "srvOrderCoreService")
    ISrvOrderCoreService srvOrderCoreService;


    @Resource(name = "orgCoreService")
    private IOrgCoreService orgCoreService;

    @Resource(name="fwLoginService")
    private ILoginService loginService;

    @Resource(name="newsCoreService")
    INewsCoreService newsCoreService;


    @Value("#{sysConfig['sso.url']}")
    private String ssoUrl;
    @Value("#{sysConfig['sso.callback.url']}")
    private String ssoCallbackUrl;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;


    @SuppressWarnings("all")
    @RequestMapping(value = "/", method = {RequestMethod.GET})
    public String index(Model model) {
        return "index";
    }

    /**
     * 页面头部
     * @param model
     * @return
     */
    @SuppressWarnings("all")
    @RequestMapping(value = "/index", method = {RequestMethod.GET})
    public String indexhome(Model model) {
        LoginUser user = sessionContext.getLoginUser();
        model.addAttribute("user", user);
        return "indexhome";
    }

    @SuppressWarnings("all")
    @RequestMapping(value = "/header", method = {RequestMethod.GET})
    public String header(Model model) {
        LoginUser user = sessionContext.getLoginUser();
        model.addAttribute("user", user);
        return "framework/header";
    }

    /**
     * 菜单
     * @param model
     * @return
     */
    @SuppressWarnings("all")
    @RequestMapping(value = "/menu", method = {RequestMethod.GET})
    public String menu(Model model) {
        return "framework/menu";
    }

    @SuppressWarnings("all")
    @RequestMapping(value = "/line", method = {RequestMethod.GET})
    public String line(Model model) {
        return "framework/line";
    }


    @SuppressWarnings("all")
    @RequestMapping(value = "/logout", method = {RequestMethod.GET})
    public String logout() {
        loginService.logout();
        return "redirect:"+ssoUrl + "/logout?service=" + ssoCallbackUrl;
    }

    /**
     * 主页
     * @param model
     * @return
     */
    @SuppressWarnings("all")
    @RequestMapping(value = "/home", method = {RequestMethod.GET})
    public ModelAndView home(Model model) {

        QueryPage queryPage = new QueryPage();
        queryPage.setPageSize(pageSize);

        QueryParams<OrgQueryVo> params = new QueryParams();
        OrgQueryVo orgQueryVo = new OrgQueryVo();
        orgQueryVo.setOrgAuditStatusList(Arrays.asList(Constant.Audit.State.AUDIT_FIRST, Constant.Audit.State.AUDIT_WAIT));
        params.setEntity(orgQueryVo);
        params.setQueryPage(queryPage);

        QueryParams<UserQueryVo> userQueryVoparams = new QueryParams();
        UserQueryVo userQueryVo = new UserQueryVo();
        userQueryVo.setStatusTypeList(Arrays.asList(Constant.Audit.State.AUDIT_FIRST, Constant.Audit.State.AUDIT_WAIT));
        userQueryVoparams.setEntity(userQueryVo);
        userQueryVoparams.setQueryPage(queryPage);

        QueryParams<ShopsFindVo> shopsVoQueryParams = new QueryParams();
        ShopsFindVo shopsVo = new ShopsFindVo();
        shopsVo.setShopsStatusList(Arrays.asList(Constant.Audit.State.AUDIT_FIRST,Constant.Audit.State.AUDIT_WAIT));
        shopsVoQueryParams.setEntity(shopsVo);
        shopsVoQueryParams.setQueryPage(queryPage);

        QueryParams<SkuFindVo> skuFindVoQueryParams = new QueryParams();
        SkuFindVo skuFindVo = new SkuFindVo();
        skuFindVo.setSkuStatusList(Arrays.asList(Constant.Audit.State.AUDIT_FIRST,Constant.Audit.State.AUDIT_WAIT));
        skuFindVoQueryParams.setEntity(skuFindVo);
        skuFindVoQueryParams.setQueryPage(queryPage);

        QueryParams<SrvOrderQueryVo> srvOrderQueryVoQueryParams = new QueryParams();
        SrvOrderQueryVo srvOrderQueryVo = new SrvOrderQueryVo();
        srvOrderQueryVo.setStatus(Constant.Service.Status.WAIT_CONFIRM);
        srvOrderQueryVoQueryParams.setEntity(srvOrderQueryVo);
        srvOrderQueryVoQueryParams.setQueryPage(queryPage);

        //获取待审核企业信息
        List<OrgBo> orgList = orgCoreService.findOrg(params);
        //获取待审核用户信息
        List<UserBo> userList = userCoreService.findUser(userQueryVoparams);
        //获取待审核商铺信息
        List<ShopsFindBo> shopsList = shopsCoreService.findShops(shopsVoQueryParams);
        //获取待审核商品信息
        List<SkuFindBo> skuList = skuCoreService.findSku(skuFindVoQueryParams);
        //获取待确认订单信息
        List<SrvOrderBo> srvOrderList = srvOrderCoreService.findSrvOrder(srvOrderQueryVoQueryParams);
        //获取新闻
        NewsQueryVo newsQueryVo=new NewsQueryVo();
        newsQueryVo.setChannel(NewsConstant.NEWS_CHANNEL_NOTICE);
        newsQueryVo.setAppId(AppConstant.APP_PLATFORM);
        newsQueryVo.setDisabled(false);

        QueryParams<NewsQueryVo> newsQueryVoParams =new QueryParams<>();
        newsQueryVoParams.setQueryPage(queryPage);
        newsQueryVoParams.setEntity(newsQueryVo);
        List<NewsBo> newsBoList = newsCoreService.findNews(newsQueryVoParams);

        HomePageListView homePageListView = new HomePageListView();
        homePageListView.setUserList(userList);
        homePageListView.setOrgList(orgList);
        homePageListView.setNewsBoList(newsBoList);
        homePageListView.setShopsList(shopsList);
        homePageListView.setSkuList(skuList);
        homePageListView.setSrvOrderList(srvOrderList);

        ModelAndView mav = new ModelAndView("index/homeNew");
        mav.addObject("view",homePageListView);
        return mav;
    }

}
