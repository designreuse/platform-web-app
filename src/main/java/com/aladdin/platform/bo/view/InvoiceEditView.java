package com.aladdin.platform.bo.view;

import com.aladdin.core.bo.InvoiceBasicBo;
import com.aladdin.core.bo.InvoiceDetailBo;
import com.aladdin.core.bo.InvoiceTitleBo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2015/11/25.
 */
public class InvoiceEditView {

    List<InvoiceDetailBo> invoiceDetailBoList =new ArrayList<InvoiceDetailBo>();

    InvoiceBasicBo invoiceBasicBo;

    InvoiceTitleBo invoiceTitleBo;

    public List<InvoiceDetailBo> getInvoiceDetailBoList() {
        return invoiceDetailBoList;
    }

    public void setInvoiceDetailBoList(List<InvoiceDetailBo> invoiceDetailBoList) {
        this.invoiceDetailBoList = invoiceDetailBoList;
    }

    public InvoiceBasicBo getInvoiceBasicBo() {
        return invoiceBasicBo;
    }

    public void setInvoiceBasicBo(InvoiceBasicBo invoiceBasicBo) {
        this.invoiceBasicBo = invoiceBasicBo;
    }

    public InvoiceTitleBo getInvoiceTitleBo() {
        return invoiceTitleBo;
    }

    public void setInvoiceTitleBo(InvoiceTitleBo invoiceTitleBo) {
        this.invoiceTitleBo = invoiceTitleBo;
    }
}
