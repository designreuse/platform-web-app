package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.OrderBo;
import com.aladdin.core.bo.ServiceBo;
import com.aladdin.core.bo.UserBo;

import java.util.List;

/**
 * Created by Administrator on 2015/11/20.
 */
public class SrvOrderAddView {

    private List<UserBo> userBoList;

    private List<ServiceBo> serviceBoList;

    private Long orderId;

    private OrderBo orderBo;

    public List<UserBo> getUserBoList() {
        return userBoList;
    }

    public void setUserBoList(List<UserBo> userBoList) {
        this.userBoList = userBoList;
    }

    public List<ServiceBo> getServiceBoList() {
        return serviceBoList;
    }

    public void setServiceBoList(List<ServiceBo> serviceBoList) {
        this.serviceBoList = serviceBoList;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public OrderBo getOrderBo() {
        return orderBo;
    }

    public void setOrderBo(OrderBo orderBo) {
        this.orderBo = orderBo;
    }
}
