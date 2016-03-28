package com.aladdin.platform.controller;

import cb.base.bo.common.AjaxResult;
import cb.base.bo.query.QueryPage;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.HelpCenterBo;
import com.aladdin.core.bo.HelpTypeBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.service.IHelpTypeService;
import com.aladdin.core.vo.HelpTypeFindVo;
import com.aladdin.core.vo.HelpTypeSaveVo;
import com.aladdin.platform.constans.Constants;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by liangsheng on 2016/3/16.
 */
@Controller
@RequestMapping("/helpType")
public class HelpTypeController {

    @Resource(name="helpTypeService")
    private IHelpTypeService helpTypeService;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @RequestMapping("/list")
    public ModelAndView viewList(Model model){

        return  new ModelAndView("helpType/list");
    }

    /**
     *  easyUI获取列表页表格数据
     * @param vo
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @RequestMapping("/helpTypeList")
    @ResponseBody
    public EasyUIDataGridBo viewList(HelpTypeFindVo vo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<HelpTypeFindVo> queryParams = new QueryParams<>();
        queryParams.setEntity(vo);
        Integer total  = helpTypeService.countHelpType(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPage(new QueryPage(pageNumber,pageSize));
            List<HelpTypeBo> helpTypeBoList = helpTypeService.findHelpType(queryParams);
            bo.setRows(helpTypeBoList);
        }
        return bo;
    }


    /**
     * 保存资讯
     * @param vo
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public AjaxResult viewSave(HelpTypeSaveVo vo){
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
            helpTypeService.saveHelpType(vo);
        }catch (Exception e){
            isSuccess = false;
        }
        return  new AjaxResult(isSuccess);
    }

    /**
     * @param id
     * @return
     */
    @RequestMapping("/edit")
    @ResponseBody
    public AjaxResult ajaxFindTypeById(Long id){
        HelpTypeBo helpTypeById = helpTypeService.findHelpTypeById(id);
        AjaxResult ajaxResult = new AjaxResult();
        ajaxResult.setResultData(helpTypeById);
        return ajaxResult;
    }

    /**
     * @param id
     * @param disabled
     * @return
     */
    @RequestMapping("/ajaxChangeDisabled")
    @ResponseBody
    public AjaxResult ajaxChangeDisabled(Long id ,Integer disabled){
        AjaxResult ajaxResult = new AjaxResult();
        if(id!=null){
            HelpTypeSaveVo vo = new HelpTypeSaveVo();
            vo.setId(id);
            vo.setDisabled(disabled);
            Long userId = sessionContext.getLoginUser().getUserId();
            vo.setModifyBy(userId);
            vo.setModifyTime(new Date());
            helpTypeService.saveHelpType(vo);
        }
        ajaxResult.setIsSuccess(true);
        return ajaxResult;
    }
}
