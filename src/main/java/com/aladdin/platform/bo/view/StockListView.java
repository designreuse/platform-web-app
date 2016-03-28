package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.CatalogBo;

import java.util.List;

/**
 * Created by zhaohu on 2015/11/18.
 */
public class StockListView {
    private List<CatalogBo> level;
    private  Long  warehouseId;

    public Long getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(Long warehouseId) {
        this.warehouseId = warehouseId;
    }

    public List<CatalogBo> getLevel() {
        return level;
    }

    public void setLevel(List<CatalogBo> level) {
        this.level = level;
    }
}
