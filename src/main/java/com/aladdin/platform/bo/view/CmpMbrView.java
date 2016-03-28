package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;

import java.util.List;

/**
 * Created by Administrator on 2016/1/26.
 */
public class CmpMbrView {

    private List<AldConstantsBo> statusList;

    private Integer status;

    public List<AldConstantsBo> getStatusList() {
        return statusList;
    }

    public void setStatusList(List<AldConstantsBo> statusList) {
        this.statusList = statusList;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
