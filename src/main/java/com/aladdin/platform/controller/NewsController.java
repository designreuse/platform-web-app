package com.aladdin.platform.controller;

import cb.base.bo.common.AjaxResult;
import cb.base.bo.query.QueryPage;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.NewsBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.IConstantsCoreService;
import com.aladdin.core.service.INewsCoreService;
import com.aladdin.core.vo.NewsQueryVo;
import com.aladdin.core.vo.NewsSaveVo;
import com.aladdin.inf.po.AldNewsEntity;
import com.aladdin.platform.bo.view.NewsAddView;
import com.aladdin.platform.bo.view.NewsListView;
import com.aladdin.platform.bo.view.NoticeDitailView;
import com.aladdin.platform.bo.view.NoticeListView;
import com.aladdin.platform.constans.Constants;
import com.wl.framework.session.context.SessionContext;
import com.wl.framework.session.domain.LoginUser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by 宋亚周 on 15-7-20.
 */
@Controller
@RequestMapping("/news")
public class NewsController {


    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @Resource(name = "newsCoreService")
    private INewsCoreService newsCoreService;

    @Resource(name="constantsCoreService")
    private IConstantsCoreService constantsCoreService;

    /**
     * 跳转到资讯列表页面
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView viewNewsList(){
        //加载平台列表
        List<AldConstantsBo> platTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.APP_TYPE);
        List<AldConstantsBo> disableds = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.DISABLED);
        List<AldConstantsBo> newsTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.NEWS_TYPE_CN);
        NewsListView newsListView=new NewsListView();
        newsListView.setPlatTypes(platTypes);
        newsListView.setDisableds(disableds);
        newsListView.setNewsTypes(newsTypes);
        return  new ModelAndView("news/new_list","newsBo",newsListView);
    }

    /**
     * 根据平台id返回对应的栏目
     * @param appId
     * @return
     */
    @RequestMapping("/ajaxGetChannel")
    @ResponseBody
    public AjaxResult ajaxGetChannel(@RequestBody Long appId){
        List<AldConstantsBo> aldConstants = null;
       if (appId == null){
           aldConstants = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.NEWS_TYPE);
       }
       //平台
       if(appId == Constant.newsColumns.plat.PLAT_FORM_CODE){
           aldConstants = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.NEWS_TYPE_PLAT);
       }
        //中文
       if(appId == Constant.newsColumns.plat.CHINESE_SITE_CODE){
           aldConstants = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.NEWS_TYPE_CN);
       }
        //俄文
        if(appId == Constant.newsColumns.plat.RUSSIA_SITE_CODE){
           aldConstants = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.NEWS_TYPE_RU);
        }
        return new AjaxResult(aldConstants);
    }


    /**
     *  easyUI获取活动列表页表格数据
     * @param vo
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @RequestMapping("/newsList")
    @ResponseBody
    public EasyUIDataGridBo viewList(NewsQueryVo vo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<NewsQueryVo> queryParams = new QueryParams<>();
        queryParams.setEntity(vo);
        Integer total = newsCoreService.countNews(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPage(new QueryPage(pageNumber,pageSize));
            List<NewsBo> news = newsCoreService.findNews(queryParams);
            bo.setRows(news);
        }
        return bo;
    }

    /**
     * 跳转到新增页面
     * @return
     */
    @RequestMapping("/add")
    public ModelAndView viewToAdd(){
        List<AldConstantsBo> platTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.APP_TYPE);
        List<AldConstantsBo> newsTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.NEWS_TYPE_CN);
        NewsAddView newsAddView = new NewsAddView();
        newsAddView.setPlatTypes(platTypes);
        newsAddView.setNewsTypes(newsTypes);
        newsAddView.setDate(new Date());
        return  new ModelAndView("news/new_add","newsAddView",newsAddView);
    }

    /**
     * 保存资讯
     * @param vo
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public AjaxResult viewSaveNews(NewsSaveVo vo){
        Boolean isSuccess = null;
        try{
            vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
            newsCoreService.saveNews(vo);
            isSuccess = true;
        }catch (Exception e){
            isSuccess = false;
        }
        return  new AjaxResult(isSuccess);
    }

    private final static String regxpForHtml = "<([^>]*)>";

    /**
     * 跳转到平台公告列表页面
     * @param queryPage
     * @return
     */
    @RequestMapping("/actionList")
    public ModelAndView noticeListView(QueryPage queryPage){
        QueryParams<NewsQueryVo> params = new QueryParams<>();
        NewsQueryVo vo = new NewsQueryVo();
        vo.setChannel(Constant.newsColumns.channel.PLATFORM_ANNOUNCEMENT);
        vo.setAppId(Constant.newsColumns.plat.PLAT_FORM_CODE);
        vo.setDisabled(false);
        params.setQueryPage(queryPage);
        params.setEntity(vo);
        Integer rowCount = newsCoreService.countNews(params);
        List<NewsBo> newsBos = newsCoreService.findNews(params);
        for (NewsBo bo:newsBos){
            bo.setContent(bo.getContent().replaceAll(regxpForHtml,""));
        }
        NoticeListView noticeListView = new NoticeListView();
        noticeListView.setNewsBos(newsBos);
        noticeListView.setRowCount(rowCount);
        noticeListView.setPageIndex(queryPage.getPageIndex());
        noticeListView.setPageSize(queryPage.getPageSize());
        return new ModelAndView("news/new_notice","news",noticeListView);
    }

    @RequestMapping("/{id}/noticeDetail")
    public ModelAndView noticeDetail(@PathVariable(value = "id") Long id){
        NewsBo newsBo = newsCoreService.getNewsById(id);
        NoticeDitailView noticeDitailView = new NoticeDitailView();
        noticeDitailView.setNewsBo(newsBo);
        return new ModelAndView("news/new_notice_detail","news",noticeDitailView);
    }



    @RequestMapping(value = "/{id}/edit")
    public ModelAndView editNews(Model model,@PathVariable(value = "id") Long id) {
        NewsBo newsBo = newsCoreService.getNewsById(id);
        List<AldConstantsBo> platTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.APP_TYPE);
        List<AldConstantsBo> newsTypes = new ArrayList<>();
        if(newsBo.getAppId().equals(Constant.newsColumns.plat.PLAT_FORM_CODE)){
            newsTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.NEWS_TYPE_PLAT);
        }else if(newsBo.getAppId().equals(Constant.newsColumns.plat.CHINESE_SITE_CODE)){
            newsTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.NEWS_TYPE_CN);
        }else{
            newsTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.NEWS_TYPE_RU);
        }
        NewsAddView newsAddView = new NewsAddView();
        newsAddView.setPlatTypes(platTypes);
        newsAddView.setNewsTypes(newsTypes);
        newsAddView.setNewsBo(newsBo);
        newsAddView.setDate(newsBo.getReleaseTime());
        return new ModelAndView("news/new_add","newsAddView",newsAddView);
    }

    @RequestMapping(value = "/ajaxChangeDisabled")
    @ResponseBody
    public AjaxResult ajaxChangeDisabled(Long newsId,Boolean disabled){
        newsCoreService.changeNewsDisabled(newsId,!disabled,sessionContext.getLoginUser().getUserId());
        NewsBo newsById = newsCoreService.getNewsById(newsId);
        return new AjaxResult(newsById);
    }

    @RequestMapping(value = "/ajaxChangeDeleted")
    @ResponseBody
    public AjaxResult ajaxChangeDeleted(Long newsId){
        newsCoreService.changeNewsDeleted(newsId,sessionContext.getLoginUser().getUserId());
        NewsBo newsById = newsCoreService.getNewsById(newsId);
        return new AjaxResult(newsById);
    }

}
