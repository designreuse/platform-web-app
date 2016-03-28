package com.aladdin.platform.controller;

import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.StatisticsBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.ICatalogCoreService;
import com.aladdin.core.service.IStatsTradeOrderService;
import com.aladdin.core.util.DateUtil;
import com.aladdin.core.vo.StatisticsVo;
import com.aladdin.platform.constans.Constants;
import com.google.gson.Gson;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 王兵 on 2015/11/11.
 */
@Controller
@RequestMapping("/statsTradeOrder")
public class StatsTradeOrderController {
    @Resource(name = "statsTradeOrderService")
    private IStatsTradeOrderService statsTradeOrderService;
    @Resource(name = "catalogCoreService")
    private ICatalogCoreService catalogCoreService;
    private DecimalFormat numFormat=new DecimalFormat("#,###");
    private DecimalFormat amountFormat=new DecimalFormat("#,###.00");
    @RequestMapping("/list")
    public String list(Model model) {
        model.addAttribute("catalogList", catalogCoreService.findCatalogByLevel(Constant.CatalogLevel.ONE));
        return "statsTradeOrder/list";
    }

    @RequestMapping("/listBuyer")
    @ResponseBody
    public Map list(StatisticsVo vo, Model model, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                    @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        QueryParams<StatisticsVo> queryParams = new QueryParams<>();
        if(vo.getEndTime()!=null)vo.setEndTime(DateUtil.getEndTimeOfDay(vo.getEndTime()));
        System.out.println((new Gson().toJson(vo)) + "买方企业贸易订单统计参数");
        queryParams.setEntity(vo);
        queryParams.setQueryPageIndex(pageNumber);
        queryParams.setQueryPageSize(pageSize);
        StatisticsBo statisticsBo = statsTradeOrderService.countStatsByBuyerCompany(queryParams);
        Map map = new HashMap<>();
        map.put("stats", statisticsBo);
        map.put("rows", statsTradeOrderService.statsByBuyerCompany(queryParams));
        map.put("total", statisticsBo.getTotalCounts());
        return map;
    }

    @RequestMapping("/listSaler")
    @ResponseBody
    public Map listSaler(StatisticsVo vo, Model model, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                    @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        QueryParams<StatisticsVo> queryParams = new QueryParams<>();
        if(vo.getEndTime()!=null)vo.setEndTime(DateUtil.getEndTimeOfDay(vo.getEndTime()));
        System.out.println((new Gson().toJson(vo)) + "卖方企业贸易订单统计参数");
        queryParams.setEntity(vo);
        queryParams.setQueryPageIndex(pageNumber);
        queryParams.setQueryPageSize(pageSize);
        StatisticsBo statisticsBo = statsTradeOrderService.countStatsBySalerCompany(queryParams);
        Map map = new HashMap<>();
        map.put("stats", statisticsBo);
        map.put("rows", statsTradeOrderService.statsBySalerCompany(queryParams));
        map.put("total", statisticsBo.getTotalCounts());
        return map;
    }
    @RequestMapping("/listProduct")
    @ResponseBody
    public Map listProduct(StatisticsVo vo, Model model, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                         @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        QueryParams<StatisticsVo> queryParams = new QueryParams<>();
        if(vo.getEndTime()!=null)vo.setEndTime(DateUtil.getEndTimeOfDay(vo.getEndTime()));
        System.out.println((new Gson().toJson(vo)) + "商品贸易订单统计参数");
        queryParams.setEntity(vo);
        queryParams.setQueryPageIndex(pageNumber);
        queryParams.setQueryPageSize(pageSize);
        StatisticsBo statisticsBo = statsTradeOrderService.countStatsByProduct(queryParams);
        Map map = new HashMap<>();
        List<StatisticsBo> statisticsBos=statsTradeOrderService.statsByProduct(queryParams);
        map.put("stats", statisticsBo);
        map.put("rows", statisticsBos);
        map.put("total", statisticsBo.getTotalCounts());
        return map;
    }

    @RequestMapping("/distribute")
    @ResponseBody
    public Map distribute(StatisticsVo vo, Model model, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                           @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        QueryParams<StatisticsVo> queryParams = new QueryParams<>();
        if(vo.getEndTime()!=null)vo.setEndTime(DateUtil.getEndTimeOfDay(vo.getEndTime()));
        System.out.println((new Gson().toJson(vo)) + "商品贸易订单-商品分布参数");
        if(vo.getEndTime()!=null)vo.setEndTime(DateUtil.getEndTimeOfDay(vo.getEndTime()));
        List<StatisticsBo> productNum  = statsTradeOrderService.statsProductCount(vo);
        //计算成交量，成交额
        int dealNum=0;
        int dealAmount=0;
        for(int i=0;i<productNum.size();i++){
            long totalNum=0l;
            StatisticsBo statisticsBo = productNum.get(i);
            if(statisticsBo!=null&&null!=statisticsBo.getFinishNum())totalNum=statisticsBo.getFinishNum();
            dealNum+=totalNum;
        }
        List<StatisticsBo> productAmonut  = statsTradeOrderService.statsProductTotalPrice(vo);
        for(int i=0;i<productAmonut.size();i++){
            double totalPrice=0;
            StatisticsBo statisticsBo = productAmonut.get(i);
            if(statisticsBo!=null&&null!=statisticsBo.getTotalPrice())totalPrice=statisticsBo.getTotalPrice();
            dealAmount+=totalPrice;
        }
        Map map = new HashMap<>();
        map.put("productNum", productNum);
        map.put("productAmonut", productAmonut);
        map.put("dealNum", numFormat.format(dealNum));
        map.put("dealAmount", amountFormat.format(dealAmount));
        return map;
    }
    @RequestMapping("/trend")
    @ResponseBody
    public Map trend(StatisticsVo vo, Model model, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                           @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        if(vo.getEndTime()!=null)vo.setEndTime(DateUtil.getEndTimeOfDay(vo.getEndTime()));
        QueryParams<StatisticsVo> queryParams = new QueryParams<>();
        System.out.println((new Gson().toJson(vo)) + "贸易订单-走势参数");
        List<StatisticsBo> productNum  = statsTradeOrderService.statsTradeTrend(vo);
        Map map = new HashMap<>();
        String[] dateArr=new String[productNum.size()];
        double[] tradeOrderNumArr=new double[productNum.size()];
        double[] tradeOrderPriceArr=new double[productNum.size()];
        SimpleDateFormat sdf=new SimpleDateFormat("YYYY年MM月dd日");
        for(int i=0;i<productNum.size();i++){
            String datei=productNum.get(i).getStatsDate()==null?"":sdf.format(productNum.get(i).getStatsDate());
            dateArr[i]=datei;
            tradeOrderNumArr[i]=productNum.get(i).getPerDateNum()==null?0:productNum.get(i).getPerDateNum();
            tradeOrderPriceArr[i]=productNum.get(i).getPerDateAmount()==null?0d:productNum.get(i).getPerDateAmount();
        }
        map.put("dateArr",dateArr);
        map.put("tradeOrderNumArr",tradeOrderNumArr);
        map.put("tradeOrderPriceArr",tradeOrderPriceArr);
        return map;
    }



    public IStatsTradeOrderService getStatsTradeOrderService() {
        return statsTradeOrderService;
    }

    public void setStatsTradeOrderService(IStatsTradeOrderService statsTradeOrderService) {
        this.statsTradeOrderService = statsTradeOrderService;
    }
}
