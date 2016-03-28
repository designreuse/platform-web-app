package com.aladdin.platform.controller;

import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.SensitiveBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.service.ISensitiveWordCoreService;
import com.aladdin.core.vo.SensitiveVo;
import com.aladdin.inf.po.AldSensitiveWordEntity;

import com.aladdin.platform.constans.Constants;
import com.wl.framework.session.context.SessionContext;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by Administrator on 2015/10/21.
 */
@Controller
@RequestMapping("/sensitive")
public class SensitiveController {

    @Resource(name="sensitiveWordCoreService")
    private ISensitiveWordCoreService sensitiveWordCoreService;
    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    /**
     * 跳转到列表页面
     * @return
     */
    @RequestMapping("/list")
    public ModelAndView viewList(){
        return new ModelAndView("sensitive/new_list");
    }

    /**
     * easyUI列表参数
     * @param vo
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @RequestMapping("/sensitiveList")
    @ResponseBody
    public EasyUIDataGridBo select(SensitiveVo vo, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                               @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){

        EasyUIDataGridBo bo = new EasyUIDataGridBo();
        QueryParams<SensitiveVo> queryParams = new QueryParams();
        queryParams.setEntity(vo);
        Integer total = sensitiveWordCoreService.countSensitive(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            List<SensitiveBo> sensitiveBos = sensitiveWordCoreService.findSensitive(queryParams);
            bo.setRows(sensitiveBos);
        }
        return bo;
    }

    /**
     * 保存修改
     * @param vo
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public ModelAndView insert(SensitiveVo vo){
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        sensitiveWordCoreService.saveSensitive(vo);
        return new ModelAndView("sensitive/new_list");
    }

    @RequestMapping("/ajaxFindSensitiveIsExist")
    @ResponseBody
    public Boolean ajaxFindSensitiveIsExist(SensitiveVo vo){
        if(!StringUtils.isBlank(vo.getName())){
            return sensitiveWordCoreService.findSensitiveIsExist(vo.getName());
        }
        return false;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public ModelAndView deleteById(Long id){
        sensitiveWordCoreService.deleteSensitiveById(id);
        return new ModelAndView("sensitive/new_list");
    }




}
