package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AdLocationBo;
import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.BannerBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 王涛涛 on 2015/11/17.
 */
public class BannerAddView {

    private List<AldConstantsBo> platTypes = new ArrayList<>();

    private List<AdLocationBo> adLocations = new ArrayList<>();

    private BannerBo bannerBo;


    public BannerBo getBannerBo() {
        return bannerBo;
    }

    public void setBannerBo(BannerBo bannerBo) {
        this.bannerBo = bannerBo;
    }

    public List<AldConstantsBo> getPlatTypes() {
        return platTypes;
    }

    public void setPlatTypes(List<AldConstantsBo> platTypes) {
        this.platTypes = platTypes;
    }

    public List<AdLocationBo> getAdLocations() {
        return adLocations;
    }

    public void setAdLocations(List<AdLocationBo> adLocations) {
        this.adLocations = adLocations;
    }
}
