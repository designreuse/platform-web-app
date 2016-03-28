package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.ServiceDistrictBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wangtaotao on 2015/11/26.
 */
public class StorageListView {

    private List<AldConstantsBo> disableds = new ArrayList<>();

    private List<AldConstantsBo> storages = new ArrayList<>();

    private List<ServiceDistrictBo> districtBoList = new ArrayList<>();

    private List<AldConstantsBo> storageUnit = new ArrayList<>();

    public List<AldConstantsBo> getStorageUnit() {
        return storageUnit;
    }

    public void setStorageUnit(List<AldConstantsBo> storageUnit) {
        this.storageUnit = storageUnit;
    }

    public List<AldConstantsBo> getDisableds() {
        return disableds;
    }

    public void setDisableds(List<AldConstantsBo> disableds) {
        this.disableds = disableds;
    }

    public List<AldConstantsBo> getStorages() {
        return storages;
    }

    public void setStorages(List<AldConstantsBo> storages) {
        this.storages = storages;
    }

    public List<ServiceDistrictBo> getDistrictBoList() {
        return districtBoList;
    }

    public void setDistrictBoList(List<ServiceDistrictBo> districtBoList) {
        this.districtBoList = districtBoList;
    }
}
