package com.aladdin.platform.bo.view;

import cb.base.bo.page.PageBo;
import com.aladdin.core.bo.NewsBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by wangtaotao on 2015/12/2.
 */
public class NoticeListView extends PageBo {

    private List<NewsBo> newsBos = new ArrayList<>();


    public List<NewsBo> getNewsBos() {
        return newsBos;
    }

    public void setNewsBos(List<NewsBo> newsBos) {
        this.newsBos = newsBos;
    }
}
