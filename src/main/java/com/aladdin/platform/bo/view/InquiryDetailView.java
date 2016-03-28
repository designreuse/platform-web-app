package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.InquiryDetailBo;
import com.aladdin.core.bo.OrgBo;

import java.util.List;

/**
 * Created by Administrator on 2015/12/5.
 */
public class InquiryDetailView {

    private InquiryDetailBo inquiryBo;

    private List<OrgBo> orgBo;

    public InquiryDetailBo getInquiryBo() {
        return inquiryBo;
    }

    public void setInquiryBo(InquiryDetailBo inquiryBo) {
        this.inquiryBo = inquiryBo;
    }

    public List<OrgBo> getOrgBo() {
        return orgBo;
    }

    public void setOrgBo(List<OrgBo> orgBo) {
        this.orgBo = orgBo;
    }
}
