package com.aladdin.platform.controller;


import cb.base.bo.common.AjaxResult;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.ActivityBo;
import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.IActivityCoreService;
import com.aladdin.core.service.IConstantsCoreService;
import com.aladdin.core.vo.ActivityAddVo;
import com.aladdin.core.vo.ActivityMemberQueryVo;
import com.aladdin.core.vo.ActivityQueryVo;
import com.aladdin.platform.bo.view.ActivityAddView;
import com.aladdin.platform.bo.view.ActivityListView;
import com.aladdin.platform.constans.Constants;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;

/**
 * 活动管理平台
 * Created 王涛涛  on 15-10-20.
 */
@Controller
@RequestMapping("/activity")
public class ActivityController {

    @Resource(name="activityCoreService")
    private IActivityCoreService activityCoreService;

    @Resource(name="constantsCoreService")
    private IConstantsCoreService constantsCoreService;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;



    /**
     * 跳转到活动管理平台主页面
     * @return ModelAndView
     */
    @RequestMapping("/list")
    public ModelAndView viewActivitylist(){
        List<AldConstantsBo> platTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.APP_TYPE);
        List<AldConstantsBo> disableds = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.DISABLED);
        ActivityListView activityListView = new ActivityListView();
        activityListView.setPlatTypes(platTypes);
        activityListView.setDisableds(disableds);
        return new ModelAndView("activity/new_list","activity",activityListView);
    }

    /**
     *  easyUI获取活动列表页表格数据
     * @param vo
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @RequestMapping("/activityList")
    @ResponseBody
    public EasyUIDataGridBo viewList(ActivityQueryVo vo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<ActivityQueryVo> queryParams = new QueryParams();
        queryParams.setEntity(vo);
        Integer total = activityCoreService.countActivity(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            List<ActivityBo> activityBos = activityCoreService.findActivity(queryParams);
            bo.setRows(activityBos);
        }else{
            bo.setRows(Collections.emptyList());
        }
        return bo;
    }

    /**
     * easyUI获取活动报名列表数据
     * @param vo
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @RequestMapping("/activityMemberList")
    @ResponseBody
    public EasyUIDataGridBo viewActivityMemberList(ActivityMemberQueryVo vo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<ActivityMemberQueryVo> queryParams = new QueryParams();
        queryParams.setEntity(vo);
        Integer total = activityCoreService.countActivityMember(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            //查询活动报名情况
            List<com.aladdin.core.bo.ActivityMemberBo> activityMemberBos = activityCoreService.findActivityMember(queryParams);
            bo.setRows(activityMemberBos);
        }
        return bo;
    }

    /**
     * 活动列表页面跳转到增加活动页面
     * @return ModelAndView
     */
    @RequestMapping("/add")
    public ModelAndView ViewToAdd(){
        List<AldConstantsBo> platTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.APP_TYPE);
        ActivityAddView activityAddView = new ActivityAddView();
        activityAddView.setPlatTypes(platTypes);
        return new ModelAndView("activity/new_add","activity",activityAddView);
    }

    @RequestMapping("/save")
    @ResponseBody
    public AjaxResult viewSaveNews(ActivityAddVo vo){
        Boolean isSuccess = null;
        try {
            if(vo.getActivityLogo() != null && vo.getActivityLogo().lastIndexOf("@") != -1) {
                vo.setActivityLogo(vo.getActivityLogo().substring(0, vo.getActivityLogo().lastIndexOf("@")));
            }
            vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
            activityCoreService.saveActivity(vo);
            isSuccess = true;
        }catch(Exception e){
            isSuccess = false;
        }
        return new AjaxResult(isSuccess);
    }

    @RequestMapping(value = "/ajaxChangeDisabled")
    @ResponseBody
    public AjaxResult ajaxChangeDisabled(Long activityId,Boolean disabled){
        activityCoreService.changeActivityDisabled(activityId, !disabled, sessionContext.getLoginUser().getUserId());
        ActivityBo activityBo = activityCoreService.getActivityById(activityId);
        return new AjaxResult(activityBo);
    }

    @RequestMapping(value = "/ajaxChangeDeleted")
    @ResponseBody
    public AjaxResult ajaxChangeDeleted(Long activityId){
        activityCoreService.changeActivityDeleted(activityId,sessionContext.getLoginUser().getUserId());
        ActivityBo activityBo = activityCoreService.getActivityById(activityId);
        return new AjaxResult(activityBo);
    }
    /**
     * 活动列表页面跳转到活动编辑页面
     * @return
     */
    @RequestMapping("/{id}/edit")
    public ModelAndView viewList(@PathVariable(value = "id") Long id){
        List<AldConstantsBo> platTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.APP_TYPE);
        ActivityBo activityBo = activityCoreService.getActivityById(id);
        ActivityAddView activityAddView = new ActivityAddView();
        activityAddView.setPlatTypes(platTypes);
        activityAddView.setActivityBo(activityBo);
        return new ModelAndView("activity/new_add","activity",activityAddView);
    }

    /**
     * ajax校验结束日期是否在开始日期之前
     * @param vo
     * @return
     */
    @RequestMapping("/ajaxValidateDate")
    @ResponseBody
    public AjaxResult ajaxValidateDate(ActivityAddVo vo){
        Boolean isSuccess = null;
        if(vo.getEndDate().before(vo.getStartDate())){
            isSuccess = false;
        }else{
            isSuccess = true;
        }

        return new AjaxResult(isSuccess);
    }


}
