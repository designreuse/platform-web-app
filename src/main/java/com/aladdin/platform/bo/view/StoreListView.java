package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/12/24.
 */
public class StoreListView {

    List<AldConstantsBo> statusList = new ArrayList<>();

    public List<AldConstantsBo> getStatusList() {
        return statusList;
    }

    public void setStatusList(List<AldConstantsBo> statusList) {
        this.statusList = statusList;
    }
}
