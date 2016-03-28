package com.aladdin.platform.controller;

import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.StatisticsBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.ICatalogCoreService;
import com.aladdin.core.service.IStatsQuiryBackService;
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
@RequestMapping("/statsInquiry")
public class StatsInquiryController {
    @Resource(name = "statsQuiryBackService")
    private IStatsQuiryBackService statsQuiryBackService;

    @Resource(name = "catalogCoreService")
    private ICatalogCoreService catalogCoreService;

    @RequestMapping("/list")
    public String list(Model model) {
        model.addAttribute("catalogList", catalogCoreService.findCatalogByLevel(Constant.CatalogLevel.ONE));
        return
                "statsInquiry/list";
    }

    @RequestMapping("/listCompany")
    @ResponseBody
    public Map listCompany(StatisticsVo vo, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                 @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        if(vo.getEndTime()!=null)vo.setEndTime(DateUtil.getEndTimeOfDay(vo.getEndTime()));
        QueryParams<StatisticsVo> queryParams = new QueryParams<>();
        System.out.println((new Gson().toJson(vo))+"公司询盘统计参数");
        queryParams.setEntity(vo);
        queryParams.setQueryPageIndex(pageNumber);
        queryParams.setQueryPageSize(pageSize);
        StatisticsBo statisticsBo=statsQuiryBackService.countStatsByCompany(queryParams);
        Map map=new HashMap<>();
        map.put("stats",statisticsBo);
        map.put("rows",statsQuiryBackService.statsByCompany(queryParams));
        map.put("total",statisticsBo.getTotalCounts());
        return map;
    }
    @RequestMapping("/listProduct")
    @ResponseBody
    public Map listProduct(StatisticsVo vo, Model model, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                 @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        if(vo.getEndTime()!=null)vo.setEndTime(DateUtil.getEndTimeOfDay(vo.getEndTime()));
        QueryParams<StatisticsVo> queryParams = new QueryParams<>();
        queryParams.setEntity(vo);
        queryParams.setQueryPageIndex(pageNumber);
        queryParams.setQueryPageSize(pageSize);
        EasyUIDataGridBo bo=new EasyUIDataGridBo();
        StatisticsBo statisticsBo=statsQuiryBackService.countStatsByProduct(queryParams);
        System.out.println((new Gson().toJson(vo))+"产品询盘统计参数");
        Map map=new HashMap<>();
        map.put("total",statisticsBo.getTotalCounts());
        map.put("rows",statsQuiryBackService.statsByProduct(queryParams));
        map.put("stats",statisticsBo);
        return map;
    }

    @RequestMapping("/distribute")
    @ResponseBody
    public Map listDistribute(StatisticsVo vo){
        if(vo.getEndTime()!=null)vo.setEndTime(DateUtil.getEndTimeOfDay(vo.getEndTime()));
        DecimalFormat decimalFormatNum=new DecimalFormat("#,###");
        DecimalFormat decimalFormatPrice=new DecimalFormat("#,###.00");
        System.out.println((new Gson().toJson(vo))+" 询盘商品分布统计参数");
        Map map=new HashMap<>();
        List<StatisticsBo> productNum=statsQuiryBackService.statsProductCount(vo);
        map.put("productNum",productNum);
        Long totalNum=0l;
        for(int i=0;i<productNum.size();i++){
            totalNum+=productNum.get(0).getInquiryNum();
        }
        map.put("totalNum",decimalFormatNum.format(totalNum));
        List<StatisticsBo> productPrice=statsQuiryBackService.statsProductTotalPrice(vo);
        map.put("productAmonut",productPrice);
        Double productAmonut=0d;
        for(int i=0;i<productPrice.size();i++){
            productAmonut+=productPrice.get(0).getPerCatalogAmount();
        }
        map.put("priceTotalNum",decimalFormatPrice.format(productAmonut));

        return map;
    }

    @RequestMapping("/trend")
    @ResponseBody
    public Map listTrend(StatisticsVo vo){
        if(vo.getEndTime()!=null)vo.setEndTime(DateUtil.getEndTimeOfDay(vo.getEndTime()));
        System.out.println((new Gson().toJson(vo))+"询盘走势统计参数");
        List<StatisticsBo> listBo=statsQuiryBackService.statsInquiryTrend(vo);
        Map map=new HashMap<>();
        String[] dateArr=new String[listBo.size()];
        int[] inquiryNumArr=new int[listBo.size()];
        double[] inquiryPriceArr=new double[listBo.size()];
        SimpleDateFormat sdf=new SimpleDateFormat("YYYY年MM月dd日");
        for(int i=0;i<listBo.size();i++){
            String datei=listBo.get(i).getStatsDate()==null?"":sdf.format(listBo.get(i).getStatsDate());
            dateArr[i]=datei;
            inquiryNumArr[i]=listBo.get(i).getInquiryNum()==null?0:listBo.get(i).getInquiryNum();
            inquiryPriceArr[i]=listBo.get(i).getPerDateAmount()==null?0d:listBo.get(i).getPerDateAmount();
        }
        map.put("dateArr",dateArr);
        map.put("inquiryNumArr",inquiryNumArr);
        map.put("inquiryPriceArr",inquiryPriceArr);
        return map;
    }


    public void setStatsQuiryBackService(IStatsQuiryBackService statsQuiryBackService) {
        this.statsQuiryBackService = statsQuiryBackService;
    }
}
