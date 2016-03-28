package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.ParkDriverBo;

import java.util.List;

/**
 * Created by zhaohu on 2015/11/18.
 */
public class ParkDriverUpdateView {
    private List<AldConstantsBo> countrymobile;
    private ParkDriverBo driverBo;

    public ParkDriverBo getDriverBo() {
        return driverBo;
    }

    public void setDriverBo(ParkDriverBo driverBo) {
        this.driverBo = driverBo;
    }

    public List<AldConstantsBo> getCountrymobile() {
        return countrymobile;
    }

    public void setCountrymobile(List<AldConstantsBo> countrymobile) {
        this.countrymobile = countrymobile;
    }
}
