package com.aladdin.platform.controller;

/**
 * Created by Administrator on 15-7-7.
 */

import cb.base.bo.common.AjaxResult;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.*;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.IConstantsCoreService;
import com.aladdin.core.service.IStoreCoreService;
import com.aladdin.core.service.ITransportCoreService;
import com.aladdin.core.vo.*;
import com.aladdin.platform.bo.view.StorageListView;
import com.aladdin.platform.bo.view.TransportRatesListView;
import com.aladdin.platform.constans.Constants;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/logisticsAndStorage")
public class LogisticsAndStorageController {

    @Resource(name="transportCoreService")
    private ITransportCoreService transportCoreService;
    @Resource(name="constantsCoreService")
    private IConstantsCoreService constantsCoreService;
    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;
    @Resource(name="storeCoreService")
    private IStoreCoreService storeCoreService;


    /**
     * 跳转到国内国内运价管理
     * @return
     */
    @RequestMapping("/ratesCn/list")
    public ModelAndView viewRatesCnList(){
        List<AldConstantsBo> disableds = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.DISABLED);
        List<AldConstantsBo> carTypes = constantsCoreService.findConstantsByKey(Constant.transport.TRANSPORT_CAR_TYPE);
        ServiceDistrictQueryVo districtQueryVo = new ServiceDistrictQueryVo();
        districtQueryVo.setCountryId(Constant.Country.CHINA);
        districtQueryVo.setDistrictType(Constant.district.DISTRICT_TYPE_TRANSPORT);
        List<ServiceDistrictBo> districtBoList = transportCoreService.findServiceDistrict(districtQueryVo);
        TransportRatesListView transportRatesListView = new TransportRatesListView();
        transportRatesListView.setDisableds(disableds);
        transportRatesListView.setCarTypes(carTypes);
        transportRatesListView.setDistrictBoList(districtBoList);
        return new ModelAndView("logisticsPriceCN/list","transport",transportRatesListView);
    }
    /**
     * 跳转到俄境国内运价管理
     * @return
     */
    @RequestMapping("/ratesRu/list")
    public ModelAndView viewRatesRuList(){
        List<AldConstantsBo> disableds = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.DISABLED);
        List<AldConstantsBo> carTypes = constantsCoreService.findConstantsByKey(Constant.transport.TRANSPORT_CAR_TYPE);
        ServiceDistrictQueryVo districtQueryVo = new ServiceDistrictQueryVo();
        districtQueryVo.setCountryId(Constant.Country.RUB);
        districtQueryVo.setDistrictType(Constant.district.DISTRICT_TYPE_TRANSPORT);
        List<ServiceDistrictBo> districtBoList = transportCoreService.findServiceDistrict(districtQueryVo);
        TransportRatesListView transportRatesListView = new TransportRatesListView();
        transportRatesListView.setDisableds(disableds);
        transportRatesListView.setCarTypes(carTypes);
        transportRatesListView.setDistrictBoList(districtBoList);
        return new ModelAndView("logisticsPriceRUS/list","transport",transportRatesListView);
    }

    /**
     * easyUi获取国内运价列表
     * @param vo
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @RequestMapping("/ratesCnList")
    @ResponseBody
    public EasyUIDataGridBo viewList(LogisticsAutoQueryVo vo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        EasyUIDataGridBo bo = new EasyUIDataGridBo();
        QueryParams<LogisticsAutoQueryVo> queryParams = new QueryParams();
        vo.setCountryType(Constant.Country.CHINA);
        queryParams.setEntity(vo);
        Integer total=transportCoreService.countTransportPrice(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            List<LogisticsAutoBo> logisticsAutoBos = transportCoreService.findTransportPrice(queryParams);
            bo.setRows(logisticsAutoBos);
        }
        return bo;
    }
    /**
     * easyUi获取国内运价列表
     * @param vo
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @RequestMapping("/ratesRuList")
    @ResponseBody
    public EasyUIDataGridBo viewRuList(LogisticsAutoQueryVo vo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        EasyUIDataGridBo bo = new EasyUIDataGridBo();
        QueryParams<LogisticsAutoQueryVo> queryParams = new QueryParams();
        vo.setCountryType(Constant.Country.RUB);
        queryParams.setEntity(vo);
        Integer total=transportCoreService.countTransportPrice(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            List<LogisticsAutoBo> logisticsAutoBos = transportCoreService.findTransportPrice(queryParams);
            bo.setRows(logisticsAutoBos);
        }
        return bo;
    }

    /**
     * 根据路线的起止地查询路线
     * @param startAddr
     * @param endAddr
     * @return
     */
    @RequestMapping("/ajaxFindTransportByAddr")
    @ResponseBody
    public AjaxResult ajaxFindTransportByAddr(Long startAddr,Long endAddr ){
        LogisticsBo transportByAddr = transportCoreService.findTransportByAddr(startAddr, endAddr);
        AjaxResult ajaxResult = new AjaxResult();
        ajaxResult.setResultData(transportByAddr);
        return ajaxResult;
    }

    /**
     * 国内路线运价保存
     * @param vo
     * @return
     */
    @RequestMapping("/ratesCnSave")
    @ResponseBody
    public AjaxResult ratesCnSave(LogisticsAutoAddVo vo){
        if(vo.getLogisticsId() == null){
            LogisticsAddVo logisticsAddVo = new LogisticsAddVo();
            logisticsAddVo.setLogisticsNameRu(vo.getStartAddrRu() + "--" +vo.getEndAddrRu());
            logisticsAddVo.setLogisticsNameCn(vo.getStartAddrCn() + "--" + vo.getEndAddrCn());
            logisticsAddVo.setCountryType(Constant.Country.CHINA);
            logisticsAddVo.setStartAddr(vo.getStartAddr());
            logisticsAddVo.setStartCountry(vo.getStartCountry());
            logisticsAddVo.setEndAddr(vo.getEndAddr());
            logisticsAddVo.setEndCountry(vo.getEndCountry());
            logisticsAddVo.setLogisticsLength(vo.getLogisticsLength());
            logisticsAddVo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
            transportCoreService.saveLogistics(logisticsAddVo);
            LogisticsBo transportByAddr = transportCoreService.findTransportByAddr(vo.getStartAddr(), vo.getEndAddr());
            vo.setLogisticsId(transportByAddr.getLogisticsId());
        }
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        transportCoreService.saveTransportPrice(vo);
        AjaxResult ajaxResult = new AjaxResult();
        ajaxResult.setIsSuccess(true);
        return ajaxResult;
    }

    /**
     * 俄境路线运价保存
     * @param vo
     * @return
     */
    @RequestMapping("/ratesRuSave")
    @ResponseBody
    public AjaxResult ratesRuSave(LogisticsAutoAddVo vo){
        if(vo.getLogisticsId() == null){
            LogisticsAddVo logisticsAddVo = new LogisticsAddVo();
            logisticsAddVo.setLogisticsNameRu(vo.getStartAddrRu() + "--" +vo.getEndAddrRu());
            logisticsAddVo.setLogisticsNameCn(vo.getStartAddrCn() + "--" + vo.getEndAddrCn());
            logisticsAddVo.setCountryType(Constant.Country.RUB);
            logisticsAddVo.setStartAddr(vo.getStartAddr());
            logisticsAddVo.setStartCountry(vo.getStartCountry());
            logisticsAddVo.setEndAddr(vo.getEndAddr());
            logisticsAddVo.setEndCountry(vo.getEndCountry());
            logisticsAddVo.setLogisticsLength(vo.getLogisticsLength());
            logisticsAddVo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
            transportCoreService.saveLogistics(logisticsAddVo);
            LogisticsBo transportByAddr = transportCoreService.findTransportByAddr(vo.getStartAddr(), vo.getEndAddr());
            vo.setLogisticsId(transportByAddr.getLogisticsId());
        }
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        transportCoreService.saveTransportPrice(vo);
        AjaxResult ajaxResult = new AjaxResult();
        ajaxResult.setIsSuccess(true);
        return ajaxResult;
    }

    /**
     * 路线运价修改
     * @param vo
     * @return
     */
    @RequestMapping("/ratesEdit")
    @ResponseBody
    public AjaxResult ratesCnEdit(LogisticsAutoAddVo vo){
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        transportCoreService.saveTransportPrice(vo);
        AjaxResult ajaxResult = new AjaxResult();
        ajaxResult.setIsSuccess(true);
        return ajaxResult;
    }

    /**
     * 根据城市id查询城市
     * @param id
     * @return
     */
    @RequestMapping("/ajaxFindServiceDistrictById")
    @ResponseBody
    public AjaxResult ajaxFindServiceDistrictById(Long id){
        ServiceDistrictBo districtBo = transportCoreService.findServiceDistrictById(id);
        AjaxResult ajaxResult = new AjaxResult();
        ajaxResult.setResultData(districtBo);
        return ajaxResult;
    }

    /**
     * 根据运价id查询运价
     * @param id
     * @return
     */
    @RequestMapping("/ajaxFindLogisticsAutoById")
    @ResponseBody
    public AjaxResult ajaxFindLogisticsAutoById(Long id){
        LogisticsAutoBo logisticsAutoBo = transportCoreService.findLogisticsAutoById(id);
        AjaxResult ajaxResult = new AjaxResult();
        ajaxResult.setResultData(logisticsAutoBo);
        return ajaxResult;
    }

    /**
     * 修改运价状态
     * @param id
     * @param disabled
     * @return
     */
    @RequestMapping("/ajaxChangeTransportPriceDisabled")
    @ResponseBody
    public AjaxResult ajaxChangeTransportPriceDisabled(Long id ,Boolean disabled){
        transportCoreService.changeTransportPriceDisabled(id,disabled,sessionContext.getLoginUser().getUserId());
        AjaxResult ajaxResult = new AjaxResult();
        ajaxResult.setIsSuccess(true);
        return ajaxResult;
    }

    /**
     * 跳转到国内仓储列表
     * @return
     */
    @RequestMapping("/storageCn/list")
    public ModelAndView viewStorageList(){
        List<AldConstantsBo> disableds = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.DISABLED);
        List<AldConstantsBo> storages = constantsCoreService.findConstantsByKey(Constant.Storage.STORAGE_KEY);
        List<AldConstantsBo> storageUnit = constantsCoreService.findConstantsByKey(Constant.Storage.STORAGE_UNIT);
        ServiceDistrictQueryVo districtQueryVo = new ServiceDistrictQueryVo();
        districtQueryVo.setCountryId(Constant.Country.CHINA);
        districtQueryVo.setDistrictType(Constant.district.DISTRICT_TYPE_STORE);
        List<ServiceDistrictBo> districtBoList = transportCoreService.findServiceDistrict(districtQueryVo);
        StorageListView storageListView = new StorageListView();
        storageListView.setDisableds(disableds);
        storageListView.setStorages(storages);
        storageListView.setStorageUnit(storageUnit);
        storageListView.setDistrictBoList(districtBoList);
        return new ModelAndView("storageCN/list","storage",storageListView);
    }
    /**
     * 跳转到俄境仓储列表
     * @return
     */
    @RequestMapping("/storageRu/list")
    public ModelAndView viewStorageRuList(){
        List<AldConstantsBo> disableds = constantsCoreService.findConstantsByKey(Constant.newsColumns.Key.DISABLED);
        List<AldConstantsBo> storages = constantsCoreService.findConstantsByKey(Constant.Storage.STORAGE_KEY);
        List<AldConstantsBo> storageUnit = constantsCoreService.findConstantsByKey(Constant.Storage.STORAGE_UNIT);
        ServiceDistrictQueryVo districtQueryVo = new ServiceDistrictQueryVo();
        districtQueryVo.setCountryId(Constant.Country.RUB);
        districtQueryVo.setDistrictType(Constant.district.DISTRICT_TYPE_STORE);
        List<ServiceDistrictBo> districtBoList = transportCoreService.findServiceDistrict(districtQueryVo);
        StorageListView storageListView = new StorageListView();
        storageListView.setDisableds(disableds);
        storageListView.setStorages(storages);
        storageListView.setStorageUnit(storageUnit);
        storageListView.setDistrictBoList(districtBoList);
        return new ModelAndView("storageRUS/list","storage",storageListView);
    }

    /**
     * easyUi获取国内仓储列表
     * @param vo
     * @param pageNumber
     * @param pageSize
     * @return
     */    @RequestMapping("/storageCnList")
    @ResponseBody
    public EasyUIDataGridBo viewStorageCnList(EntSrvStorageQueryVo vo,
                                       @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                       @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        EasyUIDataGridBo bo = new EasyUIDataGridBo();
        QueryParams<EntSrvStorageQueryVo> queryParams = new QueryParams();
        vo.setCountryType(Constant.Country.CHINA);
        queryParams.setEntity(vo);
        Integer total=storeCoreService.countStorePrice(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            List<EntSrvStorageBo> storageBos = storeCoreService.findStorePrice(queryParams);
            bo.setRows(storageBos);
        }
        return bo;
    }
    /**
     * easyUi获取俄境仓储列表
     * @param vo
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @RequestMapping("/storageRuList")
    @ResponseBody
    public EasyUIDataGridBo viewStorageRuList(EntSrvStorageQueryVo vo,
                                       @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                       @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        EasyUIDataGridBo bo = new EasyUIDataGridBo();
        QueryParams<EntSrvStorageQueryVo> queryParams = new QueryParams();
        vo.setCountryType(Constant.Country.RUB);
        queryParams.setEntity(vo);
        Integer total=storeCoreService.countStorePrice(queryParams);
        bo.setTotal(total);
        if(total>0){
            queryParams.setQueryPageSize(pageSize);
            queryParams.setQueryPageIndex(pageNumber);
            List<EntSrvStorageBo> storageBos = storeCoreService.findStorePrice(queryParams);
            bo.setRows(storageBos);
        }
        return bo;
    }

    /**
     * 根据id查询仓库
     * @param id
     * @return
     */
    @RequestMapping("/ajaxFindStorageById")
    @ResponseBody
    public AjaxResult ajaxFindStorageById(Long id){
        EntSrvStorageBo storageBo = storeCoreService.getStorePriceById(id);
        return new AjaxResult(storageBo);
    }

    /**
     * 保存仓储价格
     * @param vo
     * @return
     */
    @RequestMapping("/storageCnSave")
    @ResponseBody
    public AjaxResult storageCnSave(EntSrvStorageAddVo vo){
        vo.setCountryType(Constant.Country.CHINA);
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        storeCoreService.saveStorePrice(vo);
        return new AjaxResult();
    }
    /**
     * 保存俄境仓储价格
     * @param vo
     * @return
     */
    @RequestMapping("/storageRuSave")
    @ResponseBody
    public AjaxResult storageRuSave(EntSrvStorageAddVo vo){
        vo.setCountryType(Constant.Country.RUB);
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        storeCoreService.saveStorePrice(vo);
        return new AjaxResult();
    }

    /**
     * 修改仓储价格
     * @return
     */
    @RequestMapping("/ajaxChangeStorageDisabled")
    @ResponseBody
    public AjaxResult ajaxChangeStorageDisabled(Long id ,Boolean disabled){
        storeCoreService.changeStorePriceDisabled(id,disabled,sessionContext.getLoginUser().getUserId());
        return new AjaxResult(true);
    }

}
