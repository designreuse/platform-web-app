package com.aladdin.platform.controller;


import com.aladdin.core.bo.CityBo;
import com.aladdin.core.bo.DistrictBo;
import com.aladdin.core.bo.ProvinceBo;
import com.aladdin.core.service.IProCityDistrictService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 宋亚周 on 15-7-27.
 */
@Controller
@RequestMapping("/address")
public class AddressController {

    @Resource(name = "proCityDistrictService")
    private IProCityDistrictService proCityDistrictService;

    /**
     * 根据国家Id获取省列表
     * @param countryId 国家ID
     * @return
     */
    @RequestMapping("/province/{countryId}")
    @ResponseBody
    public List<ProvinceBo> selectProvinceByCountryId(@PathVariable Long countryId){
        //根据国家获取省
        return proCityDistrictService.getProvinceByCountryId(countryId);
    }

    /**
     * 根据省ID获取市列表
     * @param provinceId 省Id
     * @return
     */
    @RequestMapping("/city/{provinceId}")
    @ResponseBody
    public List<CityBo> selectCityByProvinceId(@PathVariable Long provinceId){
        return proCityDistrictService.getCityByProvinceId(provinceId);
    }

    /**
     * 根据市Id获取区列表
     * @param cityId 城市Id
     * @return
     */
    @RequestMapping("/district/{cityId}")
    @ResponseBody
    public List<DistrictBo> selectDistrictByCityId(@PathVariable Long cityId){
        return proCityDistrictService.getDistrictByCityId(cityId);
    }

}
