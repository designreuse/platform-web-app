package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhaohu on 2015/11/23.
 */
public class StockDetailView {
    private StockBo stockBo;

    private List<AldConstantsBo> inOutList = new ArrayList<>();

    private List<WarehouseManagerBo> warehouseManagerBoList = new ArrayList<>();

    private List<StoreBo>  storeBoList = new ArrayList<>();
    //判断是出库还是入库
    private String types;
    //获取车辆的集合
    private List<ParkCarBo> carBoList = new ArrayList<>();
    //获取司机的集合
    private List<ParkDriverBo> driverBoList = new ArrayList<>();
    private Long srvOrderId;
    private String srvOrderCode;


    public List<ParkCarBo> getCarBoList() {
        return carBoList;
    }

    public void setCarBoList(List<ParkCarBo> carBoList) {
        this.carBoList = carBoList;
    }

    public List<ParkDriverBo> getDriverBoList() {
        return driverBoList;
    }

    public void setDriverBoList(List<ParkDriverBo> driverBoList) {
        this.driverBoList = driverBoList;
    }

    public String getTypes() {
        return types;
    }

    public void setTypes(String types) {
        this.types = types;
    }

    public List<StoreBo> getStoreBoList() {
        return storeBoList;
    }

    public void setStoreBoList(List<StoreBo> storeBoList) {
        this.storeBoList = storeBoList;
    }

    public StockBo getStockBo() {
        return stockBo;
    }

    public void setStockBo(StockBo stockBo) {
        this.stockBo = stockBo;
    }

    public List<AldConstantsBo> getInOutList() {
        return inOutList;
    }

    public void setInOutList(List<AldConstantsBo> inOutList) {
        this.inOutList = inOutList;
    }

    public List<WarehouseManagerBo> getWarehouseManagerBoList() {
        return warehouseManagerBoList;
    }

    public void setWarehouseManagerBoList(List<WarehouseManagerBo> warehouseManagerBoList) {
        this.warehouseManagerBoList = warehouseManagerBoList;
    }

    public void setSrvOrderId(Long srvOrderId) {
        this.srvOrderId = srvOrderId;
    }

    public Long getSrvOrderId() {
        return srvOrderId;
    }


    public void setSrvOrderCode(String srvOrderCode) {
        this.srvOrderCode = srvOrderCode;
    }

    public String getSrvOrderCode() {
        return srvOrderCode;
    }
}
