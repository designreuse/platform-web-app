package com.aladdin.platform.controller;

import cb.base.bo.common.AjaxResult;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.AldKeywordBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.service.IConstantsCoreService;
import com.aladdin.core.service.IKeywordCoreService;
import com.aladdin.core.vo.FriendshipLinkQueryVo;
import com.aladdin.core.vo.KeywordQueryVo;
import com.aladdin.core.vo.KeywordSaveVo;
import com.aladdin.platform.constans.Constants;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by Administrator on 2016/2/23.
 */
@Controller
@RequestMapping("/keyword")
public class keyWordController {

    @Resource(name = "keywordCoreService")
    private IKeywordCoreService keywordCoreService;
    @Resource(name="constantsCoreService")
    private IConstantsCoreService constantsCoreService;
    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @RequestMapping("/list")
    public String viewList(Model model){
        model.addAttribute("disabled",constantsCoreService.findConstantsByKey("disabled"));
        model.addAttribute("appType",constantsCoreService.findConstantsByKey("app_type"));
        return "keyWord/list";
    }

    @RequestMapping("/keywordList")
    @ResponseBody
    public EasyUIDataGridBo viewList(KeywordQueryVo keywordQueryVo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO)Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE)Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<KeywordQueryVo> queryParams = new QueryParams();
        queryParams.setEntity(keywordQueryVo);
        Integer total = keywordCoreService.countKeyword(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            bo.setRows(keywordCoreService.findKeyword(queryParams));
        }
        return bo;
    }


    @RequestMapping(value = "/{id}/edit",method = {RequestMethod.GET})
    public String editView(@PathVariable(value = "id") Long id,Model model){
        AldKeywordBo aldKeywordBo = keywordCoreService.getKeywordById(id);
        model.addAttribute("appType",constantsCoreService.findConstantsByKey("app_type"));
        model.addAttribute("keywordBo",aldKeywordBo);
        return "keyWord/edit";
    }

    @RequestMapping(value = "/edit",method = {RequestMethod.POST})
    @ResponseBody
    public AjaxResult ajaxEdit(KeywordSaveVo keywordSaveVo,Model model){
        keywordSaveVo.setModifyBy(sessionContext.getLoginUser().getUserId());
        keywordSaveVo.setModifyTime(new Date());
        keywordCoreService.saveKeyword(keywordSaveVo);
        model.addAttribute("appType",constantsCoreService.findConstantsByKey("app_type"));
        return new AjaxResult("保存成功");
    }

}
