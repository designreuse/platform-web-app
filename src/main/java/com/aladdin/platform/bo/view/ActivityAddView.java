package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.ActivityBo;
import com.aladdin.core.bo.AldConstantsBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 王涛涛 on 2015/11/18.
 */
public class ActivityAddView {

    private List<AldConstantsBo> platTypes = new ArrayList<>();

    private ActivityBo activityBo;


    public ActivityBo getActivityBo() {
        return activityBo;
    }

    public void setActivityBo(ActivityBo activityBo) {
        this.activityBo = activityBo;
    }

    public List<AldConstantsBo> getPlatTypes() {
        return platTypes;
    }

    public void setPlatTypes(List<AldConstantsBo> platTypes) {
        this.platTypes = platTypes;
    }
}
