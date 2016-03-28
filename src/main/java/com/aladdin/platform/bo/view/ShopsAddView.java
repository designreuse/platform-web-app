package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.CatalogBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xujingkai on 2016/1/11.
 */
public class ShopsAddView {

    //配色风格
    List<AldConstantsBo> styleModelList = new ArrayList<>();

    List<CatalogBo> catalogs = new ArrayList<>();

    public List<AldConstantsBo> getStyleModelList() {
        return styleModelList;
    }

    public void setStyleModelList(List<AldConstantsBo> styleModelList) {
        this.styleModelList = styleModelList;
    }

    public List<CatalogBo> getCatalogs() {
        return catalogs;
    }

    public void setCatalogs(List<CatalogBo> catalogs) {
        this.catalogs = catalogs;
    }
}
