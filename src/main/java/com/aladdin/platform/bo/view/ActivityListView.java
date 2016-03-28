package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 王涛涛 on 2015/11/18.
 */
public class ActivityListView {

    private List<AldConstantsBo> platTypes = new ArrayList<>();

    private List<AldConstantsBo> disableds = new ArrayList<>();


    public List<AldConstantsBo> getPlatTypes() {
        return platTypes;
    }

    public void setPlatTypes(List<AldConstantsBo> platTypes) {
        this.platTypes = platTypes;
    }

    public List<AldConstantsBo> getDisableds() {
        return disableds;
    }

    public void setDisableds(List<AldConstantsBo> disableds) {
        this.disableds = disableds;
    }
}
