package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xujingkai on 2015/12/8.
 */
public class SkuMessageView {

    List<AldConstantsBo> consultStatusList = new ArrayList<>();

    List<AldConstantsBo> consultTypeList =new ArrayList<>();


    public List<AldConstantsBo> getConsultStatusList() {
        return consultStatusList;
    }

    public void setConsultStatusList(List<AldConstantsBo> consultStatusList) {
        this.consultStatusList = consultStatusList;
    }

    public List<AldConstantsBo> getConsultTypeList() {
        return consultTypeList;
    }

    public void setConsultTypeList(List<AldConstantsBo> consultTypeList) {
        this.consultTypeList = consultTypeList;
    }
}
