package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.CatalogBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/11/30.
 */
public class SkuListView {
    List<AldConstantsBo> statusList = new ArrayList<>();
    List<AldConstantsBo> natureList = new ArrayList<>();
    List<AldConstantsBo> isOfflineList = new ArrayList<>();
    List<AldConstantsBo> skuStatusList = new ArrayList<>();
    List<CatalogBo> catalogIdFirstList =new ArrayList<>();
    Integer status;

    public List<AldConstantsBo> getStatusList() {
        return statusList;
    }

    public void setStatusList(List<AldConstantsBo> statusList) {
        this.statusList = statusList;
    }

    public List<AldConstantsBo> getNatureList() {
        return natureList;
    }

    public void setNatureList(List<AldConstantsBo> natureList) {
        this.natureList = natureList;
    }

    public List<AldConstantsBo> getIsOfflineList() {
        return isOfflineList;
    }

    public void setIsOfflineList(List<AldConstantsBo> isOfflineList) {
        this.isOfflineList = isOfflineList;
    }

    public List<AldConstantsBo> getSkuStatusList() {
        return skuStatusList;
    }

    public void setSkuStatusList(List<AldConstantsBo> skuStatusList) {
        this.skuStatusList = skuStatusList;
    }


    public List<CatalogBo> getCatalogIdFirstList() {
        return catalogIdFirstList;
    }

    public void setCatalogIdFirstList(List<CatalogBo> catalogIdFirstList) {
        this.catalogIdFirstList = catalogIdFirstList;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
