package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.HelpTypeBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2016/3/15.
 */
public class HelpListView {

    private List<AldConstantsBo> platTypes = new ArrayList<>();

    private List<AldConstantsBo> disableds = new ArrayList<>();

    private List<HelpTypeBo> helpTypeBoList = new ArrayList<>();

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

    public List<HelpTypeBo> getHelpTypeBoList() {
        return helpTypeBoList;
    }

    public void setHelpTypeBoList(List<HelpTypeBo> helpTypeBoList) {
        this.helpTypeBoList = helpTypeBoList;
    }
}
