package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.*;
import com.aladdin.core.po.AldOrgServiceEntity;
import com.aladdin.core.po.CoreDepartmentEntity;
import com.aladdin.inf.po.AldCityEntity;
import com.aladdin.inf.po.AldDistrictEntity;
import com.aladdin.inf.po.AldProvinceEntity;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/11/19.
 */
public class CompanyInfoView {
    //企业基本信息
    private OrgBo orgBo;
//    是否三证合一
    private boolean threeCombine;

    private List<AldOrgServiceBo> aldOrgServiceEntityList;
    private List<AldProvinceEntity> aldProvinceEntityList;
    private List<DistrictBo> distList;
    private List<CityBo> cityList;
    private List<ProvinceBo> provList;
    private List<AldConstantsBo> countryList;
    private List<DepartmentBo> departList;

    //企业服务资质 附件表
    private List<OrgAttachmentBo> srvAbilitys;
    //公司附件
    private Map<String, OrgAttachmentBo> companyAbility;
    //企业服务
    private List<ServiceBo> serviceBoList;
    //三证合一 附件
    private List<OrgAttachmentBo> threeCompanyAbility;
    //企业审核记录
    private List<AdultLogBo> adultLogList;
    //附件审核记录
    private List<AdultLogBo> attaAdultLogList;
    //企业身份
    private List<IdentityBo> identityBoList;

    // 所有服务项
    private List<ServiceBo> allServiceBoList;
    //出口行业
    private List<IndustryBo> exportIndustryList;
    //进口行业
    private List<IndustryBo> entryIndustryList;
    //企业所有行业（包含出口进口）
    private List<OrgIndustryBo> orgIndustryBoList;
    //企业出口行业
    private List<OrgIndustryBo> orgExportIndustry;
     //企业进口行业
    private List<OrgIndustryBo> orgEntryIndustry;

    public void setOrgBo(OrgBo orgBo) {
        this.orgBo = orgBo;
    }

    public OrgBo getOrgBo() {
        return orgBo;
    }

    public List<AldOrgServiceBo> getAldOrgServiceEntityList() {
        return aldOrgServiceEntityList;
    }

    public void setAldOrgServiceEntityList(List<AldOrgServiceBo> aldOrgServiceEntityList) {
        this.aldOrgServiceEntityList = aldOrgServiceEntityList;
    }

    public void setAldProvinceEntityList(List<AldProvinceEntity> aldProvinceEntityList) {
        this.aldProvinceEntityList = aldProvinceEntityList;
    }

    public List<AldProvinceEntity> getAldProvinceEntityList() {
        return aldProvinceEntityList;
    }

    public void setDistList(List<DistrictBo> distList) {
        this.distList = distList;
    }

    public List<DistrictBo> getDistList() {
        return distList;
    }

    public void setCityList(List<CityBo> cityList) {
        this.cityList = cityList;
    }

    public List<CityBo> getCityList() {
        return cityList;
    }

    public void setProvList(List<ProvinceBo> provList) {
        this.provList = provList;
    }

    public List<ProvinceBo> getProvList() {
        return provList;
    }

    public void setCountryList(List<AldConstantsBo> countryList) {
        this.countryList = countryList;
    }

    public List<AldConstantsBo> getCountryList() {
        return countryList;
    }

    public void setDepartList(List<DepartmentBo> departList) {
        this.departList = departList;
    }

    public List<DepartmentBo> getDepartList() {
        return departList;
    }


    public boolean isThreeCombine() {
        return threeCombine;
    }

    public void setThreeCombine(boolean threeCombine) {
        this.threeCombine = threeCombine;
    }

    public void setSrvAbilitys(List<OrgAttachmentBo> srvAbilitys) {
        this.srvAbilitys = srvAbilitys;
    }

    public List<OrgAttachmentBo> getSrvAbilitys() {
        return srvAbilitys;
    }

    public void setCompanyAbility(Map<String, OrgAttachmentBo> companyAbility) {
        this.companyAbility = companyAbility;
    }

    public Map<String, OrgAttachmentBo> getCompanyAbility() {
        return companyAbility;
    }

    public void setServiceBoList(List<ServiceBo> serviceBoList) {
        this.serviceBoList = serviceBoList;
    }

    public List<ServiceBo> getServiceBoList() {
        return serviceBoList;
    }

    public void setThreeCompanyAbility(List<OrgAttachmentBo> threeCompanyAbility) {
        this.threeCompanyAbility = threeCompanyAbility;
    }

    public List<OrgAttachmentBo> getThreeCompanyAbility() {
        return threeCompanyAbility;
    }

    public void setAdultLogList(List<AdultLogBo> adultLogList) {
        this.adultLogList = adultLogList;
    }

    public List<AdultLogBo> getAdultLogList() {
        return adultLogList;
    }

    public void setAttaAdultLogList(List<AdultLogBo> attaAdultLogList) {
        this.attaAdultLogList = attaAdultLogList;
    }

    public List<AdultLogBo> getAttaAdultLogList() {
        return attaAdultLogList;
    }

    public void setIdentityBoList(List<IdentityBo> identityBoList) {
        this.identityBoList = identityBoList;
    }

    public List<IdentityBo> getIdentityBoList() {
        return identityBoList;
    }

    public void setAllServiceBoList(List<ServiceBo> allServiceBoList) {
        this.allServiceBoList = allServiceBoList;
    }

    public List<ServiceBo> getAllServiceBoList() {
        return allServiceBoList;
    }

    public List<IndustryBo> getExportIndustryList() {
        return exportIndustryList;
    }

    public void setExportIndustryList(List<IndustryBo> exportIndustryList) {
        this.exportIndustryList = exportIndustryList;
    }

    public List<IndustryBo> getEntryIndustryList() {
        return entryIndustryList;
    }

    public void setEntryIndustryList(List<IndustryBo> entryIndustryList) {
        this.entryIndustryList = entryIndustryList;
    }

    public void setOrgIndustryBoList(List<OrgIndustryBo> orgIndustryBoList) {
        this.orgIndustryBoList = orgIndustryBoList;
    }

    public List<OrgIndustryBo> getOrgIndustryBoList() {
        return orgIndustryBoList;
    }

    public void setOrgExportIndustry(List<OrgIndustryBo> orgExportIndustry) {
        this.orgExportIndustry = orgExportIndustry;
    }

    public List<OrgIndustryBo> getOrgExportIndustry() {
        return orgExportIndustry;
    }

    public void setOrgEntryIndustry(List<OrgIndustryBo> orgEntryIndustry) {
        this.orgEntryIndustry = orgEntryIndustry;
    }

    public List<OrgIndustryBo> getOrgEntryIndustry() {
        return orgEntryIndustry;
    }
}
