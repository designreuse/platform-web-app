package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.*;
import com.aladdin.inf.po.AldCityEntity;
import com.aladdin.inf.po.AldDistrictEntity;
import com.aladdin.inf.po.AldProvinceEntity;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhaohu on 2015/11/18.
 */
public class ParkCarUpdateView {
    private List<AldConstantsBo> countryList = new ArrayList<>();

    private List<ProvinceBo> provList= new ArrayList<>();

    private List<CityBo> cityList = new ArrayList<>();

    private List<DistrictBo> distList = new ArrayList<>();

    private ParkCarBo carBo;

    public List<AldConstantsBo> getCountryList() {
        return countryList;
    }

    public void setCountryList(List<AldConstantsBo> countryList) {
        this.countryList = countryList;
    }

    public List<ProvinceBo> getProvList() {
        return provList;
    }

    public void setProvList(List<ProvinceBo> provList) {
        this.provList = provList;
    }

    public List<CityBo> getCityList() {
        return cityList;
    }

    public void setCityList(List<CityBo> cityList) {
        this.cityList = cityList;
    }

    public List<DistrictBo> getDistList() {
        return distList;
    }

    public void setDistList(List<DistrictBo> distList) {
        this.distList = distList;
    }

    public ParkCarBo getCarBo() {
        return carBo;
    }

    public void setCarBo(ParkCarBo carBo) {
        this.carBo = carBo;
    }
}
