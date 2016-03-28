package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wangtaotao on 2015/12/1.
 */
public class ProductAddView {

    private List<AldConstantsBo> unitTypes = new ArrayList<>();

    private List<CatalogBo> catalogBos = new ArrayList<>();

    private ProductBo productBo;

    private List<PropertyBo> propertyBos = new ArrayList<>();

    private List<CatalogBo> secondCatalogList = new ArrayList<>();

    private List<CatalogBo> thirdCatalogList = new ArrayList<>();

    private List<CatalogPropertyBo> catalogPropertyBos = new ArrayList<>();

    private ProductPropertyBo productProperty;


    public List<AldConstantsBo> getUnitTypes() {
        return unitTypes;
    }

    public void setUnitTypes(List<AldConstantsBo> unitTypes) {
        this.unitTypes = unitTypes;
    }

    public List<CatalogBo> getCatalogBos() {
        return catalogBos;
    }

    public void setCatalogBos(List<CatalogBo> catalogBos) {
        this.catalogBos = catalogBos;
    }

    public ProductBo getProductBo() {
        return productBo;
    }

    public void setProductBo(ProductBo productBo) {
        this.productBo = productBo;
    }

    public List<PropertyBo> getPropertyBos() {
        return propertyBos;
    }

    public void setPropertyBos(List<PropertyBo> propertyBos) {
        this.propertyBos = propertyBos;
    }

    public List<CatalogBo> getSecondCatalogList() {
        return secondCatalogList;
    }

    public void setSecondCatalogList(List<CatalogBo> secondCatalogList) {
        this.secondCatalogList = secondCatalogList;
    }

    public List<CatalogBo> getThirdCatalogList() {
        return thirdCatalogList;
    }

    public void setThirdCatalogList(List<CatalogBo> thirdCatalogList) {
        this.thirdCatalogList = thirdCatalogList;
    }

    public List<CatalogPropertyBo> getCatalogPropertyBos() {
        return catalogPropertyBos;
    }

    public void setCatalogPropertyBos(List<CatalogPropertyBo> catalogPropertyBos) {
        this.catalogPropertyBos = catalogPropertyBos;
    }

    public ProductPropertyBo getProductProperty() {
        return productProperty;
    }

    public void setProductProperty(ProductPropertyBo productProperty) {
        this.productProperty = productProperty;
    }
}
