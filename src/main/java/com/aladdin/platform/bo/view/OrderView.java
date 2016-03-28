package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/11/12.
 */
public class OrderView {

    private OrderBo orderBo;

    private OrgBo orgBo;

    private Integer count;

    private List<UserBo> buyUserList = new ArrayList<>();

    private List<UserBo> saleUserList = new ArrayList<>();

    private List<AldConstantsBo> deliveryAddrList;

    private List<AldConstantsBo> paywayPercent;

    private List<AldConstantsBo> finalPayType;

    private List<AldConstantsBo> packageType;

    private List<TradeOrderBo> srvOrderList;

    private SrvOrderBo srvOrderBo;

    public OrderBo getOrderBo() {
        return orderBo;
    }

    public void setOrderBo(OrderBo orderBo) {
        this.orderBo = orderBo;
    }

    public List<UserBo> getBuyUserList() {
        return buyUserList;
    }

    public void setBuyUserList(List<UserBo> buyUserList) {
        this.buyUserList = buyUserList;
    }

    public List<UserBo> getSaleUserList() {
        return saleUserList;
    }

    public void setSaleUserList(List<UserBo> saleUserList) {
        this.saleUserList = saleUserList;
    }

    public List<AldConstantsBo> getDeliveryAddrList() {
        return deliveryAddrList;
    }

    public void setDeliveryAddrList(List<AldConstantsBo> deliveryAddrList) {
        this.deliveryAddrList = deliveryAddrList;
    }

    public List<AldConstantsBo> getPaywayPercent() {
        return paywayPercent;
    }

    public void setPaywayPercent(List<AldConstantsBo> paywayPercent) {
        this.paywayPercent = paywayPercent;
    }

    public List<AldConstantsBo> getFinalPayType() {
        return finalPayType;
    }

    public void setFinalPayType(List<AldConstantsBo> finalPayType) {
        this.finalPayType = finalPayType;
    }

    public List<TradeOrderBo> getSrvOrderList() {
        return srvOrderList;
    }

    public void setSrvOrderList(List<TradeOrderBo> srvOrderList) {
        this.srvOrderList = srvOrderList;
    }

    public SrvOrderBo getSrvOrderBo() {
        return srvOrderBo;
    }

    public void setSrvOrderBo(SrvOrderBo srvOrderBo) {
        this.srvOrderBo = srvOrderBo;
    }

    public OrgBo getOrgBo() {
        return orgBo;
    }

    public void setOrgBo(OrgBo orgBo) {
        this.orgBo = orgBo;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public List<AldConstantsBo> getPackageType() {
        return packageType;
    }

    public void setPackageType(List<AldConstantsBo> packageType) {
        this.packageType = packageType;
    }
}
