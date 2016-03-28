package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AdLocationBo;
import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.SpecialAdBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by 王涛涛 on 2015/11/17.
 */
public class BannerListView {

    private List<AldConstantsBo> platTypes = new ArrayList<>();

    private List<AldConstantsBo> disableds = new ArrayList<>();

    private List<AdLocationBo> adLocations = new ArrayList<>();

    private List<SpecialAdBo> specialAdCn = new ArrayList<>();

    private List<SpecialAdBo> specialAdRu = new ArrayList<>();

    public List<SpecialAdBo> getSpecialAdCn() {
        return specialAdCn;
    }

    public void setSpecialAdCn(List<SpecialAdBo> specialAdCn) {
        this.specialAdCn = specialAdCn;
    }

    public List<SpecialAdBo> getSpecialAdRu() {
        return specialAdRu;
    }

    public void setSpecialAdRu(List<SpecialAdBo> specialAdRu) {
        this.specialAdRu = specialAdRu;
    }

    public List<AldConstantsBo> getPlatTypes() {
        return platTypes;
    }

    public void setPlatTypes(List<AldConstantsBo> platTypes) {
        this.platTypes = platTypes;
    }

    public List<AldConstantsBo> getDisableds() {
        return disableds;
    }

    public void setDisableds(List<AldConstantsBo> disableds) {
        this.disableds = disableds;
    }

    public List<AdLocationBo> getAdLocations() {
        return adLocations;
    }

    public void setAdLocations(List<AdLocationBo> adLocations) {
        this.adLocations = adLocations;
    }
}
