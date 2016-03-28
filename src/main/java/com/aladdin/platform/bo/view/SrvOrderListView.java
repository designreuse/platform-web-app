package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.ServiceBo;

import java.util.List;

/**
 * Created by Administrator on 2015/11/21.
 */
public class SrvOrderListView {

    private List<ServiceBo>  serviceList;

    private List<AldConstantsBo> statusList;

    private Integer status;

    public List<ServiceBo> getServiceList() {
        return serviceList;
    }

    public void setServiceList(List<ServiceBo> serviceList) {
        this.serviceList = serviceList;
    }

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
