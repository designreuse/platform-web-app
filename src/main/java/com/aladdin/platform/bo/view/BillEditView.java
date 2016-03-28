package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.BillBo;
import com.aladdin.core.bo.BillDetailCountBo;
import com.aladdin.core.bo.RateBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;

import java.util.List;

/**
 * Created by Administrator on 2015/11/16.
 */
public class BillEditView {
    private EasyUIDataGridBo easyUIDataGridBo;
    private BillBo billBo;
    RateBo rateBo;
    private BillDetailCountBo billDetailCountBo;

    private List<AldConstantsBo> aldConstantsBoList;

    public EasyUIDataGridBo getEasyUIDataGridBo() {
        return easyUIDataGridBo;
    }

    public void setEasyUIDataGridBo(EasyUIDataGridBo easyUIDataGridBo) {
        this.easyUIDataGridBo = easyUIDataGridBo;
    }

    public BillBo getBillBo() {
        return billBo;
    }

    public void setBillBo(BillBo billBo) {
        this.billBo = billBo;
    }

    public BillDetailCountBo getBillDetailCountBo() {
        return billDetailCountBo;
    }

    public void setBillDetailCountBo(BillDetailCountBo billDetailCountBo) {
        this.billDetailCountBo = billDetailCountBo;
    }

    public List<AldConstantsBo> getAldConstantsBoList() {
        return aldConstantsBoList;
    }

    public void setAldConstantsBoList(List<AldConstantsBo> aldConstantsBoList) {
        this.aldConstantsBoList = aldConstantsBoList;
    }

    public RateBo getRateBo() {
        return rateBo;
    }

    public void setRateBo(RateBo rateBo) {
        this.rateBo = rateBo;
    }
}
