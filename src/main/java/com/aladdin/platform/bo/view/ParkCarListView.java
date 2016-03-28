package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.inf.po.AldProvinceEntity;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by zhaohu on 2015/11/18.
 */
public class ParkCarListView {
   private List<AldConstantsBo> aldConstantsBoList = new ArrayList<>();

    public List<AldConstantsBo> getAldConstantsBoList() {
        return aldConstantsBoList;
    }

    public void setAldConstantsBoList(List<AldConstantsBo> aldConstantsBoList) {
        this.aldConstantsBoList = aldConstantsBoList;
    }
}
