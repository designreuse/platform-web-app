package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;

import java.util.List;

/**
 * Created by Administrator on 2015/11/26.
 */
public class FeedbackListView {

    private List<AldConstantsBo> feedbackTypeList;
    private List<AldConstantsBo> platTypeList;

    public List<AldConstantsBo> getFeedbackTypeList() {
        return feedbackTypeList;
    }

    public void setFeedbackTypeList(List<AldConstantsBo> feedbackTypeList) {
        this.feedbackTypeList = feedbackTypeList;
    }

    public List<AldConstantsBo> getPlatTypeList() {
        return platTypeList;
    }

    public void setPlatTypeList(List<AldConstantsBo> platTypeList) {
        this.platTypeList = platTypeList;
    }
}
