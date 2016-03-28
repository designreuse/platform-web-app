package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.HelpCenterBo;
import com.aladdin.core.bo.HelpTypeBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2016/3/15.
 */
public class HelpAddView {

    private List<AldConstantsBo> platTypes = new ArrayList<>();

    private HelpCenterBo helpCenterBo;

    private List<HelpTypeBo> helpTypeBoList = new ArrayList<>();

    public List<HelpTypeBo> getHelpTypeBoList() {
        return helpTypeBoList;
    }

    public void setHelpTypeBoList(List<HelpTypeBo> helpTypeBoList) {
        this.helpTypeBoList = helpTypeBoList;
    }

    public List<AldConstantsBo> getPlatTypes() {
        return platTypes;
    }

    public void setPlatTypes(List<AldConstantsBo> platTypes) {
        this.platTypes = platTypes;
    }

    public HelpCenterBo getHelpCenterBo() {
        return helpCenterBo;
    }

    public void setHelpCenterBo(HelpCenterBo helpCenterBo) {
        this.helpCenterBo = helpCenterBo;
    }
}
