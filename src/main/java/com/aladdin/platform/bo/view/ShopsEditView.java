package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.*;
import com.aladdin.core.po.AldShopsAdEntity;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/12/7.
 */
public class ShopsEditView {

    ShopsBo shopsBo=new ShopsBo();

    List<UserBo> userBoList=new ArrayList<>();//商铺所属企业下的所有用户会员

    List<AdultLogBo> adultLogBoList =new ArrayList<>() ;//审核记录列表

    List<AldConstantsBo> styleModelList = new ArrayList<>();//配色风格

    List<ShopsAdBo> shopsAd = new ArrayList<>();//广告

    List<ShopsAdBo> shopsAdApp = new ArrayList<>();//app广告

    List<CatalogBo> catalogBos = new ArrayList<>();

    public ShopsBo getShopsBo() {
        return shopsBo;
    }

    public void setShopsBo(ShopsBo shopsBo) {
        this.shopsBo = shopsBo;
    }

    public List<UserBo> getUserBoList() {
        return userBoList;
    }

    public void setUserBoList(List<UserBo> userBoList) {
        this.userBoList = userBoList;
    }


    public List<AdultLogBo> getAdultLogBoList() {
        return adultLogBoList;
    }

    public void setAdultLogBoList(List<AdultLogBo> adultLogBoList) {
        this.adultLogBoList = adultLogBoList;
    }


    public List<AldConstantsBo> getStyleModelList() {
        return styleModelList;
    }

    public void setStyleModelList(List<AldConstantsBo> styleModelList) {
        this.styleModelList = styleModelList;
    }

    public List<ShopsAdBo> getShopsAd() {
        return shopsAd;
    }

    public void setShopsAd(List<ShopsAdBo> shopsAd) {
        this.shopsAd = shopsAd;
    }

    public List<ShopsAdBo> getShopsAdApp() {
        return shopsAdApp;
    }

    public void setShopsAdApp(List<ShopsAdBo> shopsAdApp) {
        this.shopsAdApp = shopsAdApp;
    }

    public List<CatalogBo> getCatalogBos() {
        return catalogBos;
    }

    public void setCatalogBos(List<CatalogBo> catalogBos) {
        this.catalogBos = catalogBos;
    }
}
