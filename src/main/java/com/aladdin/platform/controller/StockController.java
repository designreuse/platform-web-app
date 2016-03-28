package com.aladdin.platform.controller;

import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.*;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.service.*;
import com.aladdin.core.vo.SrvOrderQueryVo;
import com.aladdin.core.vo.StockQueryVo;
import com.aladdin.core.vo.StockSaveVo;
import com.aladdin.platform.bo.view.StockDetailView;
import com.aladdin.platform.bo.view.StockListView;
import com.aladdin.platform.constans.Constants;
import com.aladdin.platform.result.AjaxResult;
import com.alibaba.fastjson.JSON;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

/**
 * Created by zhaohu on 2015/11/16.
 */
@Controller
@RequestMapping("/stock")
public class StockController {
    @Resource(name = "stockCoreService")
    private IStockCoreService stockCoreService;
    @Resource (name = "constantsCoreService")
    private IConstantsCoreService constantsCoreService;
    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;
    @Resource(name = "catalogCoreService")
    private ICatalogCoreService catalogCoreService;
    @Resource(name = "srvOrderCoreService")
    private ISrvOrderCoreService srvOrderCoreService;
    @Resource(name = "tradeOrderCoreService")
    private ITradeOrderCoreService tradeOrderCoreService;
    @Resource(name = "storeCoreService")
    private IStoreCoreService storeCoreService;
    @Resource(name = "transportCoreService")
    private ITransportCoreService transportCoreService;
    /**
     * 进入出入库明细页面
     * @param id(从仓库页面传入的仓库ID)
     * @return
     */
    @RequestMapping("/list")
    public String viewList(Model model,Long id){
        StockListView view = new StockListView();
        view.setLevel(catalogCoreService.findCatalogByLevel(1));
        view.setWarehouseId(id);
        model.addAttribute("view", view);
        return "stock/list";
    }
    /**
     * 按照条件查询出入库明细
     * @param storeVo
     * @return
     */
    @RequestMapping("/stockList")
    @ResponseBody
    public EasyUIDataGridBo stockList(StockQueryVo storeVo, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                    @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();
        QueryParams<StockQueryVo> queryParams = new QueryParams<>();
        queryParams.setEntity(storeVo);
        Integer total=stockCoreService.countInOutStock(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            bo.setRows(stockCoreService.findInOutStock(queryParams));
        }else{
            bo.setRows(Collections.emptyList());
        }
        return bo;
    }

    /**
     * 按照服务订单查询商品信息
     * @param srvOrderId
     * @return
     */
    @RequestMapping("/productList")
    @ResponseBody
    public AjaxResult productList(Long srvOrderId, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                              @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        List<TradeOrderProductBo> list = tradeOrderCoreService.findTradeOrderProduct(srvOrderId);
            SrvOrderBo bo = srvOrderCoreService.getSrvOrderById(srvOrderId);
        HashMap<String,Object> map =new HashMap<>();
        map.put("list",list);
        map.put("bo",bo);
        return new AjaxResult(map);
    }
    /**
     * 按照服务订单名称模糊查询服务订单名
     * @return
     */
    @RequestMapping("/serOrderName")
    @ResponseBody
    public List serOrderName(HttpServletRequest request){
        String name=  request.getParameter("term").toString();
        SrvOrderQueryVo vo = new SrvOrderQueryVo();
        vo.setSrvOrderCode(name);
        QueryParams<SrvOrderQueryVo> queryParams = new QueryParams<>();
        queryParams.setEntity(vo);
        List<SrvOrderBo> list = srvOrderCoreService.findSrvOrder(queryParams);
        List<AutoCompleteBo> lstAuto=new ArrayList<>();
        if (list.size()>0)
        {
            for(SrvOrderBo x : list) {
                AutoCompleteBo auto=new AutoCompleteBo();
                auto.setId(x.getSrvOrderId().toString());
                auto.setLabel(x.getSrvOrderCode());
                auto.setValue(x.getSrvOrderCode());
                lstAuto.add(auto);
            }
        }
        return lstAuto;
    }


    /**
     * 按照仓库名称模糊查询仓库名
     * @param
     * @return
     */
    @RequestMapping("/storeName")
    @ResponseBody
    public List storeName(HttpServletRequest request){
        String name=  request.getParameter("term").toString();
        List<StoreBo> list = storeCoreService.findWarehouseByWarehouseName(name);
        List<AutoCompleteBo> lstAuto=new ArrayList<>();

        if (list.size()>0)
        {
            for(StoreBo x : list) {
                AutoCompleteBo auto=new AutoCompleteBo();
                auto.setId(x.getId().toString());
                auto.setLabel(x.getWarehouseName().toString());
                auto.setValue(x.getWarehouseName());
                lstAuto.add(auto);
            }
        }
        return lstAuto;
    }

    /**
     * 按照库管员名称模糊查询库管员
     * @param
     * @return
     */
    @RequestMapping("/managerName")
    @ResponseBody
    public List managerName(HttpServletRequest request){
        String name=  request.getParameter("term").toString();
        List<WarehouseManagerBo> list = storeCoreService.findWareHouseManager(name);
        List<AutoCompleteBo> lstAuto=new ArrayList<>();
        if (list.size()>0)
        {
            for(WarehouseManagerBo x : list) {
                AutoCompleteBo auto=new AutoCompleteBo();
                auto.setId(x.getId().toString());
                auto.setLabel(x.getUserName());
                auto.setValue(x.getUserName());
                lstAuto.add(auto);
            }
        }
        return lstAuto;
    }

    /**
     * 进入出入库明细页面
     * @param id(从出入库详细页面传入的仓库ID)
     * @return
     */
    @RequestMapping("/detail")
    public String detail(Model model,Long id,String type,String pageType){
        StockDetailView view = new StockDetailView();
        view.setStockBo(stockCoreService.getInOutStockById(id));

       // view.setWarehouseManagerBoList(storeCoreService.findWareHouseManager());
        if (type.equals("out")) {
            view.setInOutList(constantsCoreService.findConstantsByKey("out_detail"));
        } else if (type.equals("in")) {
            view.setInOutList(constantsCoreService.findConstantsByKey("in_detail"));
        }
        model.addAttribute("view", view);
        String url="";
        if(pageType.equals("detail")){
            url="stock/detail";
        }else if(pageType.equals("update")){
            url="stock/update";
            view.setCarBoList(transportCoreService.getCarByCarName(""));
            view.setDriverBoList(transportCoreService.getDriverByDriverName(""));
        }
        return url;
    }

    /**
     * 进入添加出入库明细页面
     * @param type
     * @return
     */
    @RequestMapping("/add")
    public  String add(Model model,String type,Long srvOrderId,String srvOrderCode){
        StockDetailView view = new StockDetailView();
        if (type.equals("out")) {
            view.setInOutList(constantsCoreService.findConstantsByKey("out_detail"));
        } else if (type.equals("in")) {
            view.setInOutList(constantsCoreService.findConstantsByKey("in_detail"));
        }
        view.setTypes(type);
        view.setSrvOrderId(srvOrderId);
        view.setSrvOrderCode(srvOrderCode);
        model.addAttribute("view", view);
        return "stock/add";
    }


    /**
     * 对出入库单进行保存操作
     * @param params
     * @return
     */
    @RequestMapping("/saveInOut")
    public String saveInOut(String params){
        StockSaveVo vo= JSON.parseArray(params, StockSaveVo.class).get(0);
        if(vo.getId()  != null){
            vo.setModifyBy(sessionContext.getLoginUser().getUserId());
        }else{
            vo.setCreateBy(sessionContext.getLoginUser().getUserId());
        }
        stockCoreService.saveInOutStock(vo);
        return "redirect:/stock/list";
    }

    /**
     * 对出入库单商品进行保存操作
     * @param params
     * @return
     */
    @RequestMapping("/saveProduct")
    @ResponseBody
    public AjaxResult saveProduct(String params){
        StockSaveVo vo= JSON.parseArray(params, StockSaveVo.class).get(0);
        vo.setModifyBy(sessionContext.getLoginUser().getUserId());
        stockCoreService.saveInOutProductById(vo);
        return new AjaxResult(true,"保存成功");
    }

    /**
     * 对车牌号进行查询判断是否存在
     * @param carLicence
     * @return
     */
    @RequestMapping("/getCarLicenct")
    @ResponseBody
    public AjaxResult getCarLicenct(String carLicence){
        String carId="";
        List<ParkCarBo> parkCarBos=transportCoreService.selectCarByCarName(carLicence);
        carId=parkCarBos!=null&&parkCarBos.size()>0?parkCarBos.get(0).getId().toString():"";
        return new AjaxResult(false,carId);
    }
    /**
     * 对司机姓名进行查询判断是否存在
     * @param diverName
     * @return
     */
    @RequestMapping("/getDriverName")
    @ResponseBody
    public AjaxResult getDriverName(String diverName){

        List<ParkDriverBo> parkDriverBos= transportCoreService.selectDriverByDriverName(diverName);
        String driverId=null!=parkDriverBos&&parkDriverBos.size()>0?parkDriverBos.get(0).getId().toString():"";
        return new AjaxResult(false,driverId);
    }


    /**
     * 对司机姓名进行查询判断是否存在
     * @param id
     * @return
     */
    @RequestMapping("/repeatC")
    @ResponseBody
    public AjaxResult repeatC(Long id){
        return null;
    }
}
