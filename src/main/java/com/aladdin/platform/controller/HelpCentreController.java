package com.aladdin.platform.controller;

import cb.base.bo.common.AjaxResult;
import cb.base.bo.query.QueryPage;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.HelpCenterBo;
import com.aladdin.core.bo.HelpTypeBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.IConstantsCoreService;
import com.aladdin.core.service.IHelpCenterService;
import com.aladdin.core.service.IHelpTypeService;
import com.aladdin.core.vo.HelpCenterFindVo;
import com.aladdin.core.vo.HelpCenterSaveVo;
import com.aladdin.core.vo.HelpTypeFindVo;
import com.aladdin.platform.bo.view.HelpAddView;
import com.aladdin.platform.bo.view.HelpListView;
import com.aladdin.platform.constans.Constants;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by liangsheng on 2016/3/15.
 */
@Controller
@RequestMapping("/help")
public class HelpCentreController {

    @Resource(name="helpCenterService")
    private IHelpCenterService helpCenterService;

    @Resource(name="helpTypeService")
    private IHelpTypeService helpTypeService;

    @Resource(name="constantsCoreService")
    private IConstantsCoreService constantsCoreService;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @RequestMapping("/list")
    public ModelAndView viewList(Model model){

        List<AldConstantsBo> platTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.APP_TYPE);
        List<AldConstantsBo> disableds = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.DISABLED);
        HelpTypeFindVo vo = new HelpTypeFindVo();
        List<HelpTypeBo> helpTypeBoList = helpTypeService.findHelpType(vo);
        HelpListView helpListView = new HelpListView();
        helpListView.setDisableds(disableds);
        helpListView.setHelpTypeBoList(helpTypeBoList);
        helpListView.setPlatTypes(platTypes);
        return  new ModelAndView("help/list","helpListView",helpListView);
    }


    /**
     *  easyUI获取列表页表格数据
     * @param vo
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @RequestMapping("/helpList")
    @ResponseBody
    public EasyUIDataGridBo viewList(HelpCenterFindVo vo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<HelpCenterFindVo> queryParams = new QueryParams<>();
        queryParams.setEntity(vo);
        Integer total = helpCenterService.countHelpCenter(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPage(new QueryPage(pageNumber,pageSize));
            List<HelpCenterBo> helpCenter = helpCenterService.findHelpCenter(queryParams);
            bo.setRows(helpCenter);
        }
        return bo;
    }


    @RequestMapping(value = "/{id}/edit")
    public ModelAndView editHelp(Model model,@PathVariable(value = "id") Long id) {
        HelpCenterBo helpCenterBo = helpCenterService.findHelpCenterById(id);
        List<AldConstantsBo> platTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.APP_TYPE);
        HelpTypeFindVo vo = new HelpTypeFindVo();
        List<HelpTypeBo> helpTypeBoList = helpTypeService.findHelpType(vo);
        HelpAddView helpAddView = new HelpAddView();
        helpAddView.setPlatTypes(platTypes);
        helpAddView.setHelpCenterBo(helpCenterBo);
        helpAddView.setHelpTypeBoList(helpTypeBoList);
        return new ModelAndView("help/edit","helpAddView",helpAddView);
    }

    /**
     * 跳转到新增页面
     * @return
     */
    @RequestMapping("/add")
    public ModelAndView viewToAdd(){
        List<AldConstantsBo> platTypes = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.APP_TYPE);
        HelpTypeFindVo vo = new HelpTypeFindVo();
        vo.setAppId(Constant.AppCode.SUPPLY);//默认中站
        List<HelpTypeBo> helpTypeBoList = helpTypeService.findHelpType(vo);
        HelpAddView helpAddView = new HelpAddView();
        helpAddView.setPlatTypes(platTypes);
        helpAddView.setHelpTypeBoList(helpTypeBoList);
        return  new ModelAndView("help/add","helpAddView",helpAddView);
    }

    /**
     * 保存资讯
     * @param vo
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public AjaxResult viewSave(HelpCenterSaveVo vo){
        Boolean isSuccess = true;
        try{
            Long id = vo.getId();
            vo.setModifyBy(sessionContext.getLoginUser().getUserId());
            vo.setModifyTime(new Date());
            if(null == id ){
                vo.setCreateBy(sessionContext.getLoginUser().getUserId());
                vo.setCreateTime(new Date());
                vo.setDisabled(0);
                vo.setDeleted(0);
            }
            helpCenterService.saveHelpCenter(vo);
        }catch (Exception e){
            isSuccess = false;
        }
        return  new AjaxResult(isSuccess);
    }

    /**
     * @param appId
     * @return
     */
    @RequestMapping("/ajaxGetHelpType")
    @ResponseBody
    public AjaxResult ajaxGetHelpType(@RequestBody Long appId){
        HelpTypeFindVo vo = new HelpTypeFindVo();
        vo.setAppId(appId);
        List<HelpTypeBo> helpTypeBos =  helpTypeService.findHelpType(vo);
        return new AjaxResult(helpTypeBos);
    }


    /**
     * 修改运价状态
     * @param id
     * @param disabled
     * @return
     */
    @RequestMapping("/ajaxChangeDisabled")
    @ResponseBody
    public AjaxResult ajaxChangeDisabled(Long id ,Integer disabled){
        AjaxResult ajaxResult = new AjaxResult();
        if(id!=null){
            HelpCenterSaveVo vo = new HelpCenterSaveVo();
            vo.setId(id);
            vo.setDisabled(disabled);
            Long userId = sessionContext.getLoginUser().getUserId();
            vo.setModifyBy(userId);
            vo.setModifyTime(new Date());
            helpCenterService.saveHelpCenter(vo);
            HelpCenterBo helpCenterBo = helpCenterService.findHelpCenterById(id);
            ajaxResult.setResultData(helpCenterBo);
        }
        ajaxResult.setIsSuccess(true);
        return ajaxResult;
    }
}
