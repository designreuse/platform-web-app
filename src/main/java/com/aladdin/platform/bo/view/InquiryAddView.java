package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.CatalogBo;

import java.util.List;

/**
 * Created by Administrator on 2015/12/3.
 */
public class InquiryAddView {

    private List<AldConstantsBo> deliveryAddrList;

    private List<AldConstantsBo> paywayPercentList;

    private List<AldConstantsBo> paywayLastList;

    private List<AldConstantsBo> packageType;

    private List<AldConstantsBo> effectiveDate;

    private List<AldConstantsBo> costType;

    private List<CatalogBo> catalogList;

    public List<AldConstantsBo> getDeliveryAddrList() {
        return deliveryAddrList;
    }

    public void setDeliveryAddrList(List<AldConstantsBo> deliveryAddrList) {
        this.deliveryAddrList = deliveryAddrList;
    }

    public List<AldConstantsBo> getPaywayPercentList() {
        return paywayPercentList;
    }

    public void setPaywayPercentList(List<AldConstantsBo> paywayPercentList) {
        this.paywayPercentList = paywayPercentList;
    }

    public List<AldConstantsBo> getPaywayLastList() {
        return paywayLastList;
    }

    public void setPaywayLastList(List<AldConstantsBo> paywayLastList) {
        this.paywayLastList = paywayLastList;
    }

    public List<CatalogBo> getCatalogList() {
        return catalogList;
    }

    public void setCatalogList(List<CatalogBo> catalogList) {
        this.catalogList = catalogList;
    }

    public List<AldConstantsBo> getCostType() {
        return costType;
    }

    public void setCostType(List<AldConstantsBo> costType) {
        this.costType = costType;
    }

    public List<AldConstantsBo> getPackageType() {
        return packageType;
    }

    public void setPackageType(List<AldConstantsBo> packageType) {
        this.packageType = packageType;
    }

    public List<AldConstantsBo> getEffectiveDate() {
        return effectiveDate;
    }

    public void setEffectiveDate(List<AldConstantsBo> effectiveDate) {
        this.effectiveDate = effectiveDate;
    }
}
