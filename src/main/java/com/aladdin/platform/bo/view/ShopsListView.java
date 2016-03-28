package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.CatalogBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/12/3.
 */
public class ShopsListView {

    //审核状态
    List<AldConstantsBo> auditStatusList = new ArrayList<>();
    //隶属关系
    List<AldConstantsBo> memberShipList = new ArrayList<>();
    //状态
    List<AldConstantsBo> statusList = new ArrayList<>();

    List<CatalogBo> catalogBos = new ArrayList<>();

    Integer status;


    public List<AldConstantsBo> getAuditStatusList() {
        return auditStatusList;
    }

    public void setAuditStatusList(List<AldConstantsBo> auditStatusList) {
        this.auditStatusList = auditStatusList;
    }

    public List<AldConstantsBo> getMemberShipList() {
        return memberShipList;
    }

    public void setMemberShipList(List<AldConstantsBo> memberShipList) {
        this.memberShipList = memberShipList;
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

    public List<CatalogBo> getCatalogBos() {
        return catalogBos;
    }

    public void setCatalogBos(List<CatalogBo> catalogBos) {
        this.catalogBos = catalogBos;
    }
}
