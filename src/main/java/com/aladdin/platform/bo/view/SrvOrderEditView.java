package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.*;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/11/21.
 */
public class SrvOrderEditView {

    private SrvOrderBo srvOrderBo;

    private OrgBo orgBo;

    private List<UserBo> contacts;

    private List<UserBo> customService;

    private List<SrvOrderNodeBo> srvOrderNodeBoList;

    private Map<String,Object> dtlMap;

    private List<TradeOrderBo> tradeOrderBoList;

    private TradeOrderBo tradeOrderBo;

    private List<ProvinceBo> starProvList;

    private List<CityBo> starCityList;

    private List<DistrictBo> starDistList;

    private List<ProvinceBo> endProvList;

    private List<CityBo> endCityList;

    private List<DistrictBo> endDistList;

    private List<ServiceBo> serviceBoList;

    private List<AldConstantsBo> carType;

    private List<AldConstantsBo> deliveryAddr;

    private List<AldConstantsBo> loadType;

    private List<AldConstantsBo> volumeType;

    private List<AldConstantsBo> deliveryType;

    private List<AldConstantsBo> storageType;

    private List<AldConstantsBo> costType;

    private List<AldConstantsBo> packageType;

    private List<CatalogBo> catalogList;

    private List<ParkDriverBo> parkDriverBoList;

    private List<ParkCarBo> parkCarBoList;

    private List<EntSrvStorageBo> storeListCn;

    private List<EntSrvStorageBo> storeListRu;

    private List<EntSrvStorageBo> storeListHeatCn;

    private List<EntSrvStorageBo> storeListHeatRu;

    private List<EntSrvStorageBo> storeListColdCn;

    private List<EntSrvStorageBo> storeListColdRu;

    private List<StoreBo> stockList;



    public SrvOrderBo getSrvOrderBo() {
        return srvOrderBo;
    }

    public void setSrvOrderBo(SrvOrderBo srvOrderBo) {
        this.srvOrderBo = srvOrderBo;
    }

    public List<SrvOrderNodeBo> getSrvOrderNodeBoList() {
        return srvOrderNodeBoList;
    }

    public void setSrvOrderNodeBoList(List<SrvOrderNodeBo> srvOrderNodeBoList) {
        this.srvOrderNodeBoList = srvOrderNodeBoList;
    }

    public Map<String, Object> getDtlMap() {
        return dtlMap;
    }

    public void setDtlMap(Map<String, Object> dtlMap) {
        this.dtlMap = dtlMap;
    }

    public List<TradeOrderBo> getTradeOrderBoList() {
        return tradeOrderBoList;
    }

    public void setTradeOrderBoList(List<TradeOrderBo> tradeOrderBoList) {
        this.tradeOrderBoList = tradeOrderBoList;
    }

    public TradeOrderBo getTradeOrderBo() {
        return tradeOrderBo;
    }

    public void setTradeOrderBo(TradeOrderBo tradeOrderBo) {
        this.tradeOrderBo = tradeOrderBo;
    }

    public List<ProvinceBo> getStarProvList() {
        return starProvList;
    }

    public void setStarProvList(List<ProvinceBo> starProvList) {
        this.starProvList = starProvList;
    }

    public List<CityBo> getStarCityList() {
        return starCityList;
    }

    public void setStarCityList(List<CityBo> starCityList) {
        this.starCityList = starCityList;
    }

    public List<DistrictBo> getStarDistList() {
        return starDistList;
    }

    public void setStarDistList(List<DistrictBo> starDistList) {
        this.starDistList = starDistList;
    }

    public List<ProvinceBo> getEndProvList() {
        return endProvList;
    }

    public void setEndProvList(List<ProvinceBo> endProvList) {
        this.endProvList = endProvList;
    }

    public List<CityBo> getEndCityList() {
        return endCityList;
    }

    public void setEndCityList(List<CityBo> endCityList) {
        this.endCityList = endCityList;
    }

    public List<DistrictBo> getEndDistList() {
        return endDistList;
    }

    public void setEndDistList(List<DistrictBo> endDistList) {
        this.endDistList = endDistList;
    }

    public List<ServiceBo> getServiceBoList() {
        return serviceBoList;
    }

    public void setServiceBoList(List<ServiceBo> serviceBoList) {
        this.serviceBoList = serviceBoList;
    }

    public List<AldConstantsBo> getCarType() {
        return carType;
    }

    public void setCarType(List<AldConstantsBo> carType) {
        this.carType = carType;
    }

    public List<AldConstantsBo> getDeliveryAddr() {
        return deliveryAddr;
    }

    public void setDeliveryAddr(List<AldConstantsBo> deliveryAddr) {
        this.deliveryAddr = deliveryAddr;
    }

    public List<AldConstantsBo> getLoadType() {
        return loadType;
    }

    public void setLoadType(List<AldConstantsBo> loadType) {
        this.loadType = loadType;
    }

    public List<AldConstantsBo> getVolumeType() {
        return volumeType;
    }

    public void setVolumeType(List<AldConstantsBo> volumeType) {
        this.volumeType = volumeType;
    }

    public List<AldConstantsBo> getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(List<AldConstantsBo> deliveryType) {
        this.deliveryType = deliveryType;
    }

    public List<AldConstantsBo> getStorageType() {
        return storageType;
    }

    public void setStorageType(List<AldConstantsBo> storageType) {
        this.storageType = storageType;
    }

    public OrgBo getOrgBo() {
        return orgBo;
    }

    public void setOrgBo(OrgBo orgBo) {
        this.orgBo = orgBo;
    }

    public List<UserBo> getContacts() {
        return contacts;
    }

    public void setContacts(List<UserBo> contacts) {
        this.contacts = contacts;
    }

    public List<UserBo> getCustomService() {
        return customService;
    }

    public void setCustomService(List<UserBo> customService) {
        this.customService = customService;
    }

    public List<CatalogBo> getCatalogList() {
        return catalogList;
    }

    public void setCatalogList(List<CatalogBo> catalogList) {
        this.catalogList = catalogList;
    }

    public List<AldConstantsBo> getCostType() {
        return costType;
    }

    public void setCostType(List<AldConstantsBo> costType) {
        this.costType = costType;
    }

    public List<ParkCarBo> getParkCarBoList() {
        return parkCarBoList;
    }

    public void setParkCarBoList(List<ParkCarBo> parkCarBoList) {
        this.parkCarBoList = parkCarBoList;
    }

    public List<ParkDriverBo> getParkDriverBoList() {
        return parkDriverBoList;
    }

    public void setParkDriverBoList(List<ParkDriverBo> parkDriverBoList) {
        this.parkDriverBoList = parkDriverBoList;
    }

    public List<AldConstantsBo> getPackageType() {
        return packageType;
    }

    public void setPackageType(List<AldConstantsBo> packageType) {
        this.packageType = packageType;
    }

    public List<EntSrvStorageBo> getStoreListCn() {
        return storeListCn;
    }

    public void setStoreListCn(List<EntSrvStorageBo> storeListCn) {
        this.storeListCn = storeListCn;
    }

    public List<EntSrvStorageBo> getStoreListRu() {
        return storeListRu;
    }

    public void setStoreListRu(List<EntSrvStorageBo> storeListRu) {
        this.storeListRu = storeListRu;
    }

    public List<EntSrvStorageBo> getStoreListHeatCn() {
        return storeListHeatCn;
    }

    public void setStoreListHeatCn(List<EntSrvStorageBo> storeListHeatCn) {
        this.storeListHeatCn = storeListHeatCn;
    }

    public List<EntSrvStorageBo> getStoreListHeatRu() {
        return storeListHeatRu;
    }

    public void setStoreListHeatRu(List<EntSrvStorageBo> storeListHeatRu) {
        this.storeListHeatRu = storeListHeatRu;
    }

    public List<EntSrvStorageBo> getStoreListColdCn() {
        return storeListColdCn;
    }

    public void setStoreListColdCn(List<EntSrvStorageBo> storeListColdCn) {
        this.storeListColdCn = storeListColdCn;
    }

    public List<EntSrvStorageBo> getStoreListColdRu() {
        return storeListColdRu;
    }

    public void setStoreListColdRu(List<EntSrvStorageBo> storeListColdRu) {
        this.storeListColdRu = storeListColdRu;
    }

    public List<StoreBo> getStockList() {
        return stockList;
    }

    public void setStockList(List<StoreBo> stockList) {
        this.stockList = stockList;
    }
}
