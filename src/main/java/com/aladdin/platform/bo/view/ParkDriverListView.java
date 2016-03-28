package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhaohu on 2015/11/18.
 */
public class ParkDriverListView {
    private List<AldConstantsBo> countryList = new ArrayList<>();

    public List<AldConstantsBo> getCountryList() {
        return countryList;
    }

    public void setCountryList(List<AldConstantsBo> countryList) {
        this.countryList = countryList;
    }
}
