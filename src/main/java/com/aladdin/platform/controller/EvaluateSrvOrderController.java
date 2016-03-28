package com.aladdin.platform.controller;

import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.service.ISrvEvaluateCoreService;
import com.aladdin.core.vo.SrvOrderEvaluateVo;
import com.aladdin.platform.constans.Constants;
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
@RequestMapping("/srvEval")
public class EvaluateSrvOrderController {
    @Resource(name = "srvEvaluateCoreService")
    private ISrvEvaluateCoreService srvEvaluateCoreService;

    @RequestMapping("/list")
    public String list() {
        return "srvEval/list";
    }

    @RequestMapping("/listview")
    @ResponseBody
    public EasyUIDataGridBo list(SrvOrderEvaluateVo vo, Model model, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                 @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        QueryParams<SrvOrderEvaluateVo> queryParams = new QueryParams<>();
        System.out.println((new Gson().toJson(vo))+"服务订单参数");
        queryParams.setEntity(vo);
        queryParams.setQueryPageIndex(pageNumber);
        queryParams.setQueryPageSize(pageSize);
        EasyUIDataGridBo bo=new EasyUIDataGridBo();
        int count=srvEvaluateCoreService.countSrvEvaluate(queryParams);
        bo.setTotal(count);
        //如果条数大于1 则查询所有符合条件的评论信息
        if(count>0) {
            bo.setRows(srvEvaluateCoreService.findSrvEvaluates(queryParams));
        }
        return bo;
    }

    public void setSrvEvaluateCoreService(ISrvEvaluateCoreService srvEvaluateCoreService) {
        this.srvEvaluateCoreService = srvEvaluateCoreService;
    }
}
