package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.ServiceDistrictBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wangtaotao on 2015/11/23.
 */
public class TransportRatesListView {

    private List<AldConstantsBo> disableds = new ArrayList<>();

    private List<AldConstantsBo> carTypes = new ArrayList<>();

    private List<ServiceDistrictBo> districtBoList = new ArrayList<>();


    public List<ServiceDistrictBo> getDistrictBoList() {
        return districtBoList;
    }

    public void setDistrictBoList(List<ServiceDistrictBo> districtBoList) {
        this.districtBoList = districtBoList;
    }

    public List<AldConstantsBo> getDisableds() {
        return disableds;
    }

    public void setDisableds(List<AldConstantsBo> disableds) {
        this.disableds = disableds;
    }

    public List<AldConstantsBo> getCarTypes() {
        return carTypes;
    }

    public void setCarTypes(List<AldConstantsBo> carTypes) {
        this.carTypes = carTypes;
    }
}
