package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.CatalogBo;
import com.aladdin.core.bo.CatalogPropertyBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/12/3.
 */
public class CatalogEditView {

    private CatalogBo catalogBo;

    private List<CatalogPropertyBo> propertyBos = new ArrayList<>();

    private List<AldConstantsBo> levels = new ArrayList<>();


    public List<CatalogPropertyBo> getPropertyBos() {
        return propertyBos;
    }

    public void setPropertyBos(List<CatalogPropertyBo> propertyBos) {
        this.propertyBos = propertyBos;
    }

    public List<AldConstantsBo> getLevels() {
        return levels;
    }

    public void setLevels(List<AldConstantsBo> levels) {
        this.levels = levels;
    }

    public CatalogBo getCatalogBo() {
        return catalogBo;
    }

    public void setCatalogBo(CatalogBo catalogBo) {
        this.catalogBo = catalogBo;
    }
}
