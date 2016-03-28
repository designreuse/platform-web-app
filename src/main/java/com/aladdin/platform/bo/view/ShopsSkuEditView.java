package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.*;

import java.util.List;

/**
 * Created by Administrator on 2015/12/2.
 */
public class ShopsSkuEditView {


    // sku
    private SkuBo skuBo;
    // sku对应的标准商品属性Bo
    private ProductPropertyBo productPropertyBo;
    // 取得一级品类列表
    List<CatalogBo> catalogIdFirstList;
    // 取得二级品类列表
    List<CatalogBo> catalogIdSecondList;
    // 取得三级品类列表
    List<CatalogBo> catalogIdList;
    // 取得标准商品列表
    List<ProductBo> productBoList;
    // 交货地列表
    List<AldConstantsBo> deliveryAddrList;
    // 币种列表
    List<AldConstantsBo> currencyTypeList;
    // 报价方式列表
    List<AldConstantsBo> quoteTypeList;


    public SkuBo getSkuBo() {
        return skuBo;
    }

    public void setSkuBo(SkuBo skuBo) {
        this.skuBo = skuBo;
    }

    public ProductPropertyBo getProductPropertyBo() {
        return productPropertyBo;
    }

    public void setProductPropertyBo(ProductPropertyBo productPropertyBo) {
        this.productPropertyBo = productPropertyBo;
    }

    public List<CatalogBo> getCatalogIdFirstList() {
        return catalogIdFirstList;
    }

    public void setCatalogIdFirstList(List<CatalogBo> catalogIdFirstList) {
        this.catalogIdFirstList = catalogIdFirstList;
    }

    public List<CatalogBo> getCatalogIdSecondList() {
        return catalogIdSecondList;
    }

    public void setCatalogIdSecondList(List<CatalogBo> catalogIdSecondList) {
        this.catalogIdSecondList = catalogIdSecondList;
    }

    public List<CatalogBo> getCatalogIdList() {
        return catalogIdList;
    }

    public void setCatalogIdList(List<CatalogBo> catalogIdList) {
        this.catalogIdList = catalogIdList;
    }

    public List<ProductBo> getProductBoList() {
        return productBoList;
    }

    public void setProductBoList(List<ProductBo> productBoList) {
        this.productBoList = productBoList;
    }

    public List<AldConstantsBo> getDeliveryAddrList() {
        return deliveryAddrList;
    }

    public void setDeliveryAddrList(List<AldConstantsBo> deliveryAddrList) {
        this.deliveryAddrList = deliveryAddrList;
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
}
