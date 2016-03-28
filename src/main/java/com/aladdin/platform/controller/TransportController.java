package com.aladdin.platform.controller;

import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.*;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.service.IConstantsCoreService;
import com.aladdin.core.service.IProCityDistrictService;
import com.aladdin.core.service.ITransportCoreService;
import com.aladdin.core.vo.*;
import com.aladdin.platform.bo.view.*;
import com.aladdin.platform.constans.Constants;
import com.aladdin.platform.result.AjaxResult;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.Collections;


/**
 * Created by zhaohu on 2015/11/11.
 */
@Controller
@RequestMapping("/transport")
public class TransportController {

    @Resource (name = "transportCoreService")
    private ITransportCoreService transportCoreService;
    @Resource (name = "constantsCoreService")
    private IConstantsCoreService constantsCoreService;
    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;
    @Resource(name = "proCityDistrictService")
    private IProCityDistrictService proCityDistrictService;
    /**
     *进入车辆信息页面
     * @param
     * @return
     */
    @RequestMapping("/listCar")
    public String viewList(Model model){
        //国家列表
        ParkCarListView view=new ParkCarListView();
        view.setAldConstantsBoList(constantsCoreService.findConstantsByKey("country_type"));
        model.addAttribute("view", view);
        return "transport/carList";
    }
    /**
     *按照条件查询车辆信息
     * @param
     * @return
     */
    @RequestMapping("/carList")
    @ResponseBody
    public EasyUIDataGridBo carList(ParkCarQueryVo carVo, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                    @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<ParkCarQueryVo> queryParams = new QueryParams();
        queryParams.setEntity(carVo);
        Integer total=transportCoreService.countCar(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            bo.setRows(transportCoreService.findCar(queryParams));
        }else{
            bo.setRows(Collections.emptyList());
        }
        return bo;
    }
    /**
     *按改变车辆状态
     * @param
     * @return
     */
    @RequestMapping("/changeCarStatus")
    @ResponseBody
    public AjaxResult changeCarStatus(boolean disabled,Long id){
        ParkCarSaveVo vo=new ParkCarSaveVo();
        vo.setDisabled(!disabled);
        vo.setId(id);
        vo.setModifyBy(sessionContext.getLoginUser().getUserId());
        transportCoreService.saveCar(vo);
        return new AjaxResult(true,"状态更改成功");
    }
    /**
     *进入增加车辆页面
     * @param
     * @return
     */
    @RequestMapping("/carInsert")
    public String carInsert(Model model) {
        //增加国家，省份，城市，地区等默认信息

        ParkCarUpdateView view=new ParkCarUpdateView();
        view.setCountryList(constantsCoreService.findConstantsByKey("country_type"));
        view.setProvList(proCityDistrictService.getProvinceByCountryId(1L));
        model.addAttribute("view", view);
        return "transport/addCar";
    }
    @RequestMapping("/getProCityDistrict")
    public String getProCityDistrict(Model model,String type) {
        //增加国家，省份，城市，地区等默认信息
        return "transport/updateCar";
    }
    /**
     *编辑车辆信息
     * @param
     * @return
     */
    @RequestMapping(value = "/saveCar")
    @ResponseBody
    public AjaxResult saveCar(ParkCarSaveVo vo,Model model){
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        transportCoreService.saveCar(vo);
        return new AjaxResult();
    }
    /**
     *按照ID查询车辆信息
     * @param
     * @return
     */
    @RequestMapping("/detailCar")
    public String detailCar(Model model,Long id,String type){
        ParkCarBo bo=transportCoreService.getCarById(id);
        ParkCarUpdateView view=new ParkCarUpdateView();
        view.setCarBo(bo);
        view.setCountryList(constantsCoreService.findConstantsByKey("country_type"));
        view.setProvList(proCityDistrictService.getProvinceByCountryId(Long.parseLong(bo.getCountryId().toString())));
        view.setCityList(proCityDistrictService.getCityByProvinceId(bo.getProvinceId()));
        view.setDistList(proCityDistrictService.getDistrictByCityId(bo.getCityId()));
        model.addAttribute("view", view);

        String url="";
        if (type.equals("detail")){
            url="transport/detailCar";
        }else if (type.equals("update")){
            url="transport/updateCar";

        }
        return url;
    }
    /**
     *进入司机管理页面
     * @param
     * @return
     */
    @RequestMapping("listDriver")
    public String listDriver(Model model){
        //国家列表
        ParkDriverListView view=new ParkDriverListView();
        view.setCountryList( constantsCoreService.findConstantsByKey("country_type"));
        model.addAttribute("view", view);
        return "transport/driverList";
    }
    /**
     *按照条件查询司机信息
     * @param
     * @return
     */
    @RequestMapping("/driverList")
    @ResponseBody
    public EasyUIDataGridBo driverList(ParkDriverQueryVo driverVo, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                       @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();
        QueryParams<ParkDriverQueryVo> queryParams = new QueryParams();
        queryParams.setEntity(driverVo);
        Integer total=transportCoreService.countDriver(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            bo.setRows(transportCoreService.findDriver(queryParams));
        }else{
            bo.setRows(Collections.emptyList());
        }
        return bo;
    }
    /**
     *进入车辆增加页面
     * @param
     * @return
     */
    @RequestMapping("driverAdd")
    public String driverAdd(Model model){
        ParkDriverUpdateView view=new ParkDriverUpdateView();
        view.setCountrymobile(constantsCoreService.findConstantsByKey("country_mobile"));
        model.addAttribute("view", view);

        return "transport/addDriver";
    }

    /**
     * 动态获取国家号信息
     */
    @RequestMapping("/getCountryMemo")
    @ResponseBody
    public AjaxResult getCountryMemo(String value){
        AldConstantsBo bo=constantsCoreService.getConstantsBo("country_mobile",value);
        return new AjaxResult(true,bo.getConstMemo());
    }

    /*
    *保存或者修改
     */
    @RequestMapping( "/saveDriver")
    @ResponseBody
    public AjaxResult saveDriver(ParkDriverSaveVo vo,Model model){
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        transportCoreService.saveDriver(vo);
        //国家列表
        return new AjaxResult();
    }
    /**
     *按照ID查询车辆信息
     * @param
     * @return
     */
    @RequestMapping("/detailDriver")
    public String detailDriver(Model model,Long id,String type){
        ParkDriverUpdateView view=new ParkDriverUpdateView();
        view.setCountrymobile(constantsCoreService.findConstantsByKey("country_mobile"));
        view.setDriverBo(transportCoreService.getDriverById(id));
        model.addAttribute("view", view);
        String url="";
        if (type.equals("detail")){
            url="transport/detailDriver";
        }else if (type.equals("update")){
            url="transport/updateDriver";

        }
        return url;
    }

}