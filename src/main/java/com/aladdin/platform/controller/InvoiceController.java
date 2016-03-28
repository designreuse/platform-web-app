package com.aladdin.platform.controller;

import cb.base.bo.query.QueryPage;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.*;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.service.*;
import com.aladdin.core.util.DateUtil;
import com.aladdin.core.vo.*;
import com.aladdin.platform.bo.view.InvoiceEditView;
import com.aladdin.platform.bo.view.InvoiceListView;
import com.aladdin.platform.constans.Constants;
import com.aladdin.platform.result.AjaxResult;
import com.aladdin.platform.utils.StringUtils;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping("/invoice")
public class InvoiceController {

    @Resource(name = "constantsCoreService")
    IConstantsCoreService constantsCoreService;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @Resource(name = "orgCoreService")
    IOrgCoreService orgCoreService;

    @Resource(name = "invoiceCoreService")
    IInvoiceCoreService invoiceCoreService;

    private static String INVOICE_STATUS = "invoice_status";
    private static String INVOICE_TYPE="invoice_type";

    @RequestMapping("/list")
    public ModelAndView list(){
        ModelAndView mav = new ModelAndView("invoice/list");

        List<AldConstantsBo> aldConstantsBoList = constantsCoreService.findConstantsByKey(INVOICE_STATUS);

        InvoiceListView invoiceListView = new InvoiceListView();
        invoiceListView.setStatusList(aldConstantsBoList);

        mav.addObject("invoiceListView",invoiceListView);

        return mav;
    }

    @RequestMapping("/viewList")
    @ResponseBody
    public EasyUIDataGridBo viewList(InvoiceVo invoiceVo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<InvoiceVo> queryParams = new QueryParams();

        queryParams.setEntity(invoiceVo);

        Date endDate=queryParams.getEntity().getEndTime();
        if(endDate!=null){
            Date  date = DateUtil.moveDay(endDate, 1);
            queryParams.getEntity().setEndTime(date);
        }

        Integer total = invoiceCoreService.countInvoice(queryParams);
        bo.setTotal(total);
        if(total>0){
            QueryPage queryPage=new QueryPage();
            queryPage.setPageSize(pageSize);
            queryPage.setPageIndex(pageNumber);
            queryParams.setQueryPage(queryPage);
            bo.setRows(invoiceCoreService.findInvoice(queryParams));
        }

        return bo;
    }


    /**
     *
     * @param param
     * @return
     */
    @RequestMapping("/getOrgName")
    @ResponseBody
    public List getOrgName(String param){
        List<OrgBo> orgBoLlist=new ArrayList<>();
        if (!StringUtils.isEmpty(param))
        {
            OrgQueryVo vo = new OrgQueryVo();
            vo.setOrgName(param);
            orgBoLlist=orgCoreService.findOrg(vo);
        }
        List<AutoCompleteBo> lstAuto=new ArrayList<>();

        if (orgBoLlist.size()>0)
        {
            for(OrgBo x : orgBoLlist) {
                AutoCompleteBo auto=new AutoCompleteBo();
                auto.setId(x.getId().toString());
                auto.setLabel(x.getOrgNameCn());
                auto.setValue(x.getOrgNameCn());
                lstAuto.add(auto);
            }
        }
        return lstAuto;

    }

    /**
     *
     * @param param
     * @return
     */
    @RequestMapping("/getInvoiceTitle")
    @ResponseBody
    public List getInvoiceTitle(String param){
        List<InvoiceTitleBo> invoiceTitleBoList=new ArrayList<>();
        if (!StringUtils.isEmpty(param))
        {
            OrgQueryVo vo = new OrgQueryVo();
            vo.setOrgName(param);
            invoiceTitleBoList=invoiceCoreService.findInvoiceTitleByStr(param);
        }
        List<AutoCompleteBo> lstAuto=new ArrayList<>();

        if (invoiceTitleBoList.size()>0)
        {
            for(InvoiceTitleBo x : invoiceTitleBoList) {
                AutoCompleteBo auto=new AutoCompleteBo();
                auto.setId(x.getId().toString());
                auto.setLabel(x.getOrgFullName());
                auto.setValue(x.getOrgFullName());
                lstAuto.add(auto);
            }
        }
        return lstAuto;

    }


    /**
     *发票编辑
     * @param id
     * @return
     */
    @RequestMapping("/edit/{id}")
    public ModelAndView edit(@PathVariable(value = "id") Long id){
        ModelAndView mav = new ModelAndView("invoice/edit");

        double totalPriceAllInvoices=0.00;
        InvoiceBasicBo invoiceBasicBo = invoiceCoreService.getInvoiceById(id);
        List<InvoiceDetailBo> invoiceDetailBoList = invoiceCoreService.findInvoiceDetailByInvId(id);
        for(InvoiceDetailBo invoiceDetailBo:invoiceDetailBoList){
            Double totalPrice = invoiceDetailBo.getTotalPrice();
            if(totalPrice!=null){
                totalPriceAllInvoices+=totalPrice.doubleValue();
            }
        }
        invoiceBasicBo.setTotalPriceAllInvoices(totalPriceAllInvoices);

        InvoiceTitleBo invoiceTitleBo = invoiceCoreService.getInvoiceTitleByInvId(id);
        Integer invoiceStatus = invoiceBasicBo.getInvoiceStatus();
        if(invoiceStatus!=null){
            AldConstantsBo aldConstantsBo = constantsCoreService.getConstantsBo(INVOICE_STATUS,invoiceStatus+"");
            String constName = aldConstantsBo.getConstName();
            invoiceBasicBo.setInvoiceStatusText(constName);
        }
        Integer invoiceType = invoiceBasicBo.getInvoiceType();
        if(invoiceType!=null){
            AldConstantsBo aldConstantsBo = constantsCoreService.getConstantsBo(INVOICE_TYPE,invoiceType+"");
            String constName = aldConstantsBo.getConstName();
            invoiceBasicBo.setInvoiceTypeText(constName);
        }

        InvoiceEditView invoiceEditView =new InvoiceEditView();
        invoiceEditView.setInvoiceBasicBo(invoiceBasicBo);
        invoiceEditView.setInvoiceTitleBo(invoiceTitleBo);
        invoiceEditView.setInvoiceDetailBoList(invoiceDetailBoList);

        mav.addObject("view",invoiceEditView);
        return mav;
    }


    /**
     * 修改发票的状态
     * @param invoiceVo
     * @return
     */
    @RequestMapping("/updateStatus")
    @ResponseBody
    public AjaxResult updateStatus(InvoiceVo invoiceVo){
        invoiceVo.setModifyBy(sessionContext.getLoginUser().getUserId());
        invoiceCoreService.saveInvoice(invoiceVo);
        return new AjaxResult(true,"修改成功");
    }


}
