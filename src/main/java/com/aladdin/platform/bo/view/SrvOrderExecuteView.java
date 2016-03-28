package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.*;

import java.util.List;

/**
 * Created by Administrator on 2015/12/2.
 */
public class SrvOrderExecuteView {

    private List<SrvOrderNodeBo> srvOrderNodeBoList;

    private List<ServiceBo> srvOrderBoList;

    private SrvOrderBo srvOrderBo;

    private List<TradeOrderBo> tradeOrderBos;

    private  TradeOrderBo orderBo;

    private List<AldConstantsBo> nodeStatus;

    private List<OrgBo> orgBoList;

    private List<SrvOrderDtlBo> srvOrderDtlBos;

    private Boolean flag;

    private OrgBo orgBo;

    public List<SrvOrderNodeBo> getSrvOrderNodeBoList() {
        return srvOrderNodeBoList;
    }

    public void setSrvOrderNodeBoList(List<SrvOrderNodeBo> srvOrderNodeBoList) {
        this.srvOrderNodeBoList = srvOrderNodeBoList;
    }

    public List<ServiceBo> getSrvOrderBoList() {
        return srvOrderBoList;
    }

    public void setSrvOrderBoList(List<ServiceBo> srvOrderBoList) {
        this.srvOrderBoList = srvOrderBoList;
    }

    public SrvOrderBo getSrvOrderBo() {
        return srvOrderBo;
    }

    public void setSrvOrderBo(SrvOrderBo srvOrderBo) {
        this.srvOrderBo = srvOrderBo;
    }

    public List<TradeOrderBo> getTradeOrderBos() {
        return tradeOrderBos;
    }

    public void setTradeOrderBos(List<TradeOrderBo> tradeOrderBos) {
        this.tradeOrderBos = tradeOrderBos;
    }

    public TradeOrderBo getOrderBo() {
        return orderBo;
    }

    public void setOrderBo(TradeOrderBo orderBo) {
        this.orderBo = orderBo;
    }

    public List<AldConstantsBo> getNodeStatus() {
        return nodeStatus;
    }

    public void setNodeStatus(List<AldConstantsBo> nodeStatus) {
        this.nodeStatus = nodeStatus;
    }

    public List<OrgBo> getOrgBoList() {
        return orgBoList;
    }

    public void setOrgBoList(List<OrgBo> orgBoList) {
        this.orgBoList = orgBoList;
    }

    public List<SrvOrderDtlBo> getSrvOrderDtlBos() {
        return srvOrderDtlBos;
    }

    public void setSrvOrderDtlBos(List<SrvOrderDtlBo> srvOrderDtlBos) {
        this.srvOrderDtlBos = srvOrderDtlBos;
    }

    public Boolean getFlag() {

        return flag;
    }

    public void setFlag(Boolean flag) {
        this.flag = flag;
    }

    public OrgBo getOrgBo() {
        return orgBo;
    }

    public void setOrgBo(OrgBo orgBo) {
        this.orgBo = orgBo;
    }
}
