package com.aladdin.platform.bo.view;

import cb.base.bo.page.PageBo;
import com.aladdin.core.bo.AldConstantsBo;
import com.aladdin.core.bo.BillDetailCountBo;
import com.aladdin.core.vo.AldBillVo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/11/23.
 */
public class BillListView extends PageBo {


    List<AldConstantsBo> aldConstantsBoList;//支付状态的常亮

    List<BillDetailCountBo> billDetailCountBoList=new ArrayList<BillDetailCountBo>();

    AldBillVo aldBillVo=new AldBillVo();

    public List<AldConstantsBo> getAldConstantsBoList() {
        return aldConstantsBoList;
    }

    public void setAldConstantsBoList(List<AldConstantsBo> aldConstantsBoList) {
        this.aldConstantsBoList = aldConstantsBoList;
    }

    public List<BillDetailCountBo> getBillDetailCountBoList() {
        return billDetailCountBoList;
    }

    public void setBillDetailCountBoList(List<BillDetailCountBo> billDetailCountBoList) {
        this.billDetailCountBoList = billDetailCountBoList;
    }

    public AldBillVo getAldBillVo() {
        return aldBillVo;
    }

    public void setAldBillVo(AldBillVo aldBillVo) {
        this.aldBillVo = aldBillVo;
    }
}
