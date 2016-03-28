package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.CatalogBo;
import com.aladdin.inf.po.AldCatalogEntity;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/12/1.
 */
public class SkuAddView {

    private Long shopsId;
    private String shopsName;


    List<CatalogBo> catalogIdFirstList=new ArrayList<>();

    List<AldConstantsBo> deliveryAddrList = new ArrayList<>();

    List<AldConstantsBo> unitTypeList = new ArrayList<>();

    List<AldConstantsBo> currencyTypeList = new ArrayList<>();

    List<AldConstantsBo> quoteTypeList = new ArrayList<>();

    List<AldConstantsBo> productQualityList = new ArrayList<>();

    public Long getShopsId() {
        return shopsId;
    }

    public void setShopsId(Long shopsId) {
        this.shopsId = shopsId;
    }

    public String getShopsName() {
        return shopsName;
    }

    public void setShopsName(String shopsName) {
        this.shopsName = shopsName;
    }

    public List<CatalogBo> getCatalogIdFirstList() {
        return catalogIdFirstList;
    }

    public void setCatalogIdFirstList(List<CatalogBo> catalogIdFirstList) {
        this.catalogIdFirstList = catalogIdFirstList;
    }

    public List<AldConstantsBo> getDeliveryAddrList() {
        return deliveryAddrList;
    }

    public void setDeliveryAddrList(List<AldConstantsBo> deliveryAddrList) {
        this.deliveryAddrList = deliveryAddrList;
    }

    public List<AldConstantsBo> getUnitTypeList() {
        return unitTypeList;
    }

    public void setUnitTypeList(List<AldConstantsBo> unitTypeList) {
        this.unitTypeList = unitTypeList;
    }

    public List<AldConstantsBo> getCurrencyTypeList() {
        return currencyTypeList;
    }

    public void setCurrencyTypeList(List<AldConstantsBo> currencyTypeList) {
        this.currencyTypeList = currencyTypeList;
    }

    public List<AldConstantsBo> getQuoteTypeList() {
        return quoteTypeList;
    }

    public void setQuoteTypeList(List<AldConstantsBo> quoteTypeList) {
        this.quoteTypeList = quoteTypeList;
    }

    public List<AldConstantsBo> getProductQualityList() {
        return productQualityList;
    }

    public void setProductQualityList(List<AldConstantsBo> productQualityList) {
        this.productQualityList = productQualityList;
    }
}
