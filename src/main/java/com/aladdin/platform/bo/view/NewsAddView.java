package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.NewsBo;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by 王涛涛 on 2015/11/16.
 */
public class NewsAddView {

    private List<AldConstantsBo> platTypes = new ArrayList<>();

    private List<AldConstantsBo> newsTypes = new ArrayList<>();

    private NewsBo newsBo;

    private Date date;

    public List<AldConstantsBo> getPlatTypes() {
        return platTypes;
    }

    public void setPlatTypes(List<AldConstantsBo> platTypes) {
        this.platTypes = platTypes;
    }

    public List<AldConstantsBo> getNewsTypes() {
        return newsTypes;
    }

    public void setNewsTypes(List<AldConstantsBo> newsTypes) {
        this.newsTypes = newsTypes;
    }

    public NewsBo getNewsBo() {
        return newsBo;
    }

    public void setNewsBo(NewsBo newsBo) {
        this.newsBo = newsBo;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
