package com.aladdin.platform.controller;

import com.aladdin.core.service.IEvaluateCoreService;
import com.aladdin.core.vo.EvaluateVo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.platform.constans.Constants;
import cb.base.bo.query.QueryParams;
import com.google.gson.Gson;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by 王兵 on 2015/11/11.
 */
@Controller
@RequestMapping("/tradeEval")
public class EvaluateTradeOrderController {
    @Resource(name = "evaluateCoreService")
    private IEvaluateCoreService evaluateCoreService;

    @RequestMapping("/list")
    public String list() {
        return "tradeEval/list";
    }


    @RequestMapping("/listview")
    @ResponseBody
    public EasyUIDataGridBo list(EvaluateVo vo,Model model, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                 @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        QueryParams<EvaluateVo> queryParams = new QueryParams<>();
        queryParams.setEntity(vo);
        System.out.println(new Gson().toJson(vo)+"参数");
        queryParams.setQueryPageIndex(pageNumber);
        queryParams.setQueryPageSize(pageSize);
        EasyUIDataGridBo bo = new EasyUIDataGridBo();
        Integer total = evaluateCoreService.countEvaluate(queryParams);
        bo.setTotal(total);
        if (total > 0) {
            bo.setRows(evaluateCoreService.findEvaluates(queryParams));
        }
        return bo;
    }

    public void setEvaluateCoreService(IEvaluateCoreService evaluateCoreService) {
        this.evaluateCoreService = evaluateCoreService;
    }
}
