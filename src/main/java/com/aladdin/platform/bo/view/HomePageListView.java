package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/12/9.
 */
public class HomePageListView {

    List<OrgBo> orgList = new ArrayList<>();
    List<UserBo> userList = new ArrayList<>();
    List<ShopsFindBo> shopsList = new ArrayList<>();
    List<SkuFindBo> skuList = new ArrayList<>();
    List<SrvOrderBo> srvOrderList = new ArrayList<>();
    List<NewsBo> newsBoList = new ArrayList<>();

    public List<OrgBo> getOrgList() {
        return orgList;
    }

    public void setOrgList(List<OrgBo> orgList) {
        this.orgList = orgList;
    }

    public List<UserBo> getUserList() {
        return userList;
    }

    public void setUserList(List<UserBo> userList) {
        this.userList = userList;
    }

    public List<ShopsFindBo> getShopsList() {
        return shopsList;
    }

    public void setShopsList(List<ShopsFindBo> shopsList) {
        this.shopsList = shopsList;
    }

    public List<SkuFindBo> getSkuList() {
        return skuList;
    }

    public void setSkuList(List<SkuFindBo> skuList) {
        this.skuList = skuList;
    }

    public List<SrvOrderBo> getSrvOrderList() {
        return srvOrderList;
    }

    public void setSrvOrderList(List<SrvOrderBo> srvOrderList) {
        this.srvOrderList = srvOrderList;
    }

    public List<NewsBo> getNewsBoList() {
        return newsBoList;
    }

    public void setNewsBoList(List<NewsBo> newsBoList) {
        this.newsBoList = newsBoList;
    }
}
