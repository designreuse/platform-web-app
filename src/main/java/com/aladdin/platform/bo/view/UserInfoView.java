package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.*;

import java.util.List;

/**
 * Created by Administrator on 2015/11/24.
 */
public class UserInfoView {
    private UserBo userBo;
    private List<DepartmentBo> departmentList;
    private List<ProvinceBo> provinceBoList;
    private OrgBo orgBo;
    //企业为代理商、服务商
    private boolean proxyOrPurchase=false;
    private List<AldConstantsBo> countryList;

    public void setUserBo(UserBo userBo) {
        this.userBo = userBo;
    }

    public UserBo getUserBo() {
        return userBo;
    }

    public void setDepartmentList(List<DepartmentBo> departmentList) {
        this.departmentList = departmentList;
    }

    public List<DepartmentBo> getDepartmentList() {
        return departmentList;
    }

    public void setProvinceBoList(List<ProvinceBo> provinceBoList) {
        this.provinceBoList = provinceBoList;
    }

    public List<ProvinceBo> getProvinceBoList() {
        return provinceBoList;
    }

    public void setOrgBo(OrgBo orgBo) {
        this.orgBo = orgBo;
    }

    public OrgBo getOrgBo() {
        return orgBo;
    }

    public void setProxyOrPurchase(boolean proxyOrPurchase) {
        this.proxyOrPurchase = proxyOrPurchase;
    }

    public boolean isProxyOrPurchase() {
        return proxyOrPurchase;
    }

    public void setCountryList(List<AldConstantsBo> countryList) {
        this.countryList = countryList;
    }

    public List<AldConstantsBo> getCountryList() {
        return countryList;
    }
}
