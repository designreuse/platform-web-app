package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.StoreBo;

import java.util.List;

/**
 * Created by zhaohu on 2015/11/18.
 */
public class StoreEditView {
    private StoreBo storeBo;

    private List<AldConstantsBo> parkList;

    public StoreBo getStoreBo() {
        return storeBo;
    }

    public void setStoreBo(StoreBo storeBo) {
        this.storeBo = storeBo;
    }

    public List<AldConstantsBo> getParkList() {
        return parkList;
    }

    public void setParkList(List<AldConstantsBo> parkList) {
        this.parkList = parkList;
    }
}
