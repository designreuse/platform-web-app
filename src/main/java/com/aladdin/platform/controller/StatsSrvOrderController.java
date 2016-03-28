package com.aladdin.platform.controller;

import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.StatisticsBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.service.ISrvEvaluateCoreService;
import com.aladdin.core.service.ISrvOrderCoreService;
import com.aladdin.core.service.IStatsSrvOrderService;
import com.aladdin.core.util.DateUtil;
import com.aladdin.core.vo.SrvOrderEvaluateVo;
import com.aladdin.core.vo.StatisticsVo;
import com.aladdin.platform.constans.Constants;
import com.google.gson.Gson;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 王兵 on 2015/11/11.
 */
@Controller
@RequestMapping("/statsSrvOrder")
public class StatsSrvOrderController {
    @Resource(name = "statsSrvOrderService")
    private IStatsSrvOrderService statsSrvOrderService;
    @Resource(name="srvOrderCoreService")
    private ISrvOrderCoreService srvOrderCoreService;

    @RequestMapping("/list")
    public String list(Model model) {
        model.addAttribute("service",srvOrderCoreService.findService());
        return "statsSrvOrder/list";
    }

    @RequestMapping("/listCompany")
    @ResponseBody
    public Map listCompany(StatisticsVo vo, Model model, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                 @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        if(vo.getEndTime()!=null)vo.setEndTime(DateUtil.getEndTimeOfDay(vo.getEndTime()));
        QueryParams<StatisticsVo> queryParams = new QueryParams<>();
        System.out.println((new Gson().toJson(vo))+"服务订单参数");
        queryParams.setEntity(vo);
        queryParams.setQueryPageIndex(pageNumber);
        queryParams.setQueryPageSize(pageSize);
        StatisticsBo statisticsBo=statsSrvOrderService.countStatsByCompany(queryParams);
        Map map=new HashMap<>();
        //如果条数大于1 则查询所有符合条件的评论信息
        if(statisticsBo.getTotalCounts()>0) {
            map.put("stats",statisticsBo);
            map.put("rows",statsSrvOrderService.statsByCompany(queryParams));
            map.put("total", statisticsBo.getTotalCounts());
        }
        return map;
    }

    @RequestMapping("/listSrvItem")
    @ResponseBody
    public Map listProduct(StatisticsVo vo, Model model, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                 @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        if(vo.getEndTime()!=null)vo.setEndTime(DateUtil.getEndTimeOfDay(vo.getEndTime()));
        System.out.println((new Gson().toJson(vo))+"服务订单参数");
        Map map=new HashMap<>();
        map.put("rows",this.statsSrvOrderService.statsBySrvItem(vo));
        map.put("stats",this.statsSrvOrderService.countStatsBySrvItem(vo));
        return map;
    }

    @RequestMapping("/distribute")
    @ResponseBody
    public Map listDistribute(StatisticsVo vo){
        if(vo.getEndTime()!=null)vo.setEndTime(DateUtil.getEndTimeOfDay(vo.getEndTime()));
        System.out.println((new Gson().toJson(vo))+" 服务订单分布统计参数");
        Map<String,List<StatisticsBo>> map=new HashMap<>();
        map.put("srvNum",statsSrvOrderService.statsSrvCount(vo));
        map.put("srvAmonut",statsSrvOrderService.statsSrvTotalPrice(vo));
        return map;
    }

    @RequestMapping("/trend")
    @ResponseBody
    public Map listTrend(StatisticsVo vo){
        if(vo.getEndTime()!=null)vo.setEndTime(DateUtil.getEndTimeOfDay(vo.getEndTime()));
        System.out.println((new Gson().toJson(vo))+"服务订单走势统计参数");
        List<StatisticsBo> listBo=statsSrvOrderService.statsSrvTrend(vo);
        Map map=new HashMap<>();
        String[] dateArr=new String[listBo.size()];
        int[] srvNumArr=new int[listBo.size()];
        double[] srvPriceArr=new double[listBo.size()];
        SimpleDateFormat sdf=new SimpleDateFormat("YYYY年MM月dd日");
        for(int i=0;i<listBo.size();i++){
            String datei=listBo.get(i).getStatsDate()==null?"":sdf.format(listBo.get(i).getStatsDate());
            dateArr[i]=datei;
            srvNumArr[i]=listBo.get(i).getOrderNum()==null?0:listBo.get(i).getOrderNum();
            srvPriceArr[i]=listBo.get(i).getOrderAmount()==null?0d:listBo.get(i).getOrderAmount();
        }
        map.put("dateArr",dateArr);
        map.put("srvNumArr",srvNumArr);
        map.put("srvPriceArr",srvPriceArr);
        return map;
    }

}
