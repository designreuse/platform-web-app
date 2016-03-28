package com.aladdin.platform.controller;

import cb.base.bo.query.QueryPage;
import com.aladdin.core.bo.*;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.*;
import com.aladdin.core.vo.*;
import com.aladdin.platform.bo.view.BillEditView;
import com.aladdin.platform.bo.view.BillListView;
import com.aladdin.platform.viewexcel.BillViewExcel;
import com.aladdin.platform.constans.Constants;
import cb.base.bo.query.QueryParams;
import com.aladdin.platform.result.AjaxResult;
import com.aladdin.platform.utils.StringUtils;
import com.alibaba.fastjson.JSON;
import com.wl.framework.session.context.SessionContext;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;


@Controller
@RequestMapping("/bill")
public class BillController {

    @Resource(name = "billCoreService")
    private IBillCoreService billCoreService;

    @Resource(name = "constantsCoreService")
    IConstantsCoreService constantsCoreService;

    @Resource(name = "orgCoreService")
    IOrgCoreService orgCoreService;

    @Resource(name = "userCoreService")
    IUserCoreService userCoreService;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;


    @Resource(name = "rateCoreService")
    private IRateCoreService rateCoreService;

    private static String CURRENCY_TYPE="currency_type";
    private static String BILL_PAYMENTSTATUS="bill_paymentstatus";
    private static Integer PAGE_SIZE=5;
    private static Integer INCOME_ALLSELECT=2;
    private static Integer INCOME_ALLNOSELECT=3;
    private static Integer ORG_TYPE = 2;

    @RequestMapping("/list")
    public ModelAndView list(AldBillVo aldBillVo){
        QueryPage queryPage = new QueryPage();
        if(aldBillVo.getPageIndex()==null){
            queryPage.setPageSize(PAGE_SIZE);
            aldBillVo.setPageSize(PAGE_SIZE);
            aldBillVo.setPageIndex(queryPage.getPageIndex());
        }else{
            queryPage.setPageIndex(aldBillVo.getPageIndex());
            queryPage.setPageSize(aldBillVo.getPageSize());
        }


        BillListView billListView = new BillListView();

        ModelAndView mav = new ModelAndView("bill/list");

        List<AldConstantsBo> aldConstantsBoList= constantsCoreService.findConstantsByKey(BILL_PAYMENTSTATUS);
        List<BillBo> billBoList = new ArrayList<BillBo>();
        List<BillDetailCountBo> billDetailCountBoList = new ArrayList<BillDetailCountBo>();


        AldBillVo aldBillVoTemp = new AldBillVo();
        BeanUtils.copyProperties(aldBillVo,aldBillVoTemp);



        if(aldBillVo.getIncome()!=null){
            if(aldBillVo.getIncome()==INCOME_ALLNOSELECT||aldBillVo.getIncome()==INCOME_ALLSELECT){
                aldBillVo.setIncome(null);
            }
        }
        if(aldBillVo.getContactCompany()!=null){
            if("".equals(aldBillVo.getContactCompany())){
                aldBillVo.setContactCompany(null);
            }
        }

        if(aldBillVo.getFeeName()!=null){
            if("".equals(aldBillVo.getFeeName())){
                aldBillVo.setFeeName(null);
            }
        }

        QueryParams<AldBillVo> queryParams = new QueryParams(aldBillVo,queryPage);
        Integer count = billCoreService.countBill(queryParams);
        if(count>0){
            billBoList = billCoreService.findBill(queryParams);
            for(BillBo billBo:billBoList){
                aldBillVo.setBillId(billBo.getId());
                BillDetailCountBo billDetailCountBo = billCoreService.getDetail(aldBillVo);

                //获取委托方的企业管理员
                Long entrustOrgId = billBo.getEntrustOrgId();
                if(entrustOrgId!=null){
                    QueryParams<UserQueryVo> params =new QueryParams();
                    UserQueryVo userQueryVo = new UserQueryVo();
                    userQueryVo.setIsRoot(true);
                    userQueryVo.setOrgId(entrustOrgId);

                    params.setEntity(userQueryVo);
                    List<UserBo> userBoList = userCoreService.findUser(params);
                    if(userBoList.size()>0){
                        billBo.setUserId(userBoList.get(0).getUserId());
                    }
                }

                billDetailCountBo.setBillBo(billBo);
                billDetailCountBoList.add(billDetailCountBo);
            }
        }

        billListView.setAldConstantsBoList(aldConstantsBoList);
        billListView.setBillDetailCountBoList(billDetailCountBoList);
        billListView.setRowCount(count);
        billListView.setPageIndex(aldBillVo.getPageIndex());
        billListView.setPageSize(aldBillVo.getPageSize());
        billListView.setAldBillVo(aldBillVoTemp);
        mav.addObject("billListView",billListView);
        return mav;
    }

    @RequestMapping("/client_list")
    public ModelAndView clientList(AldBillVo aldBillVo){
        QueryPage queryPage = new QueryPage();
        if(aldBillVo.getPageIndex()==null){
            queryPage.setPageSize(PAGE_SIZE);
            aldBillVo.setPageSize(PAGE_SIZE);
            aldBillVo.setPageIndex(queryPage.getPageIndex());
        }else{
            queryPage.setPageIndex(aldBillVo.getPageIndex());
            queryPage.setPageSize(aldBillVo.getPageSize());
        }


        BillListView billListView = new BillListView();

        ModelAndView mav = new ModelAndView("bill/client_list");

        List<AldConstantsBo> aldConstantsBoList= constantsCoreService.findConstantsByKey(BILL_PAYMENTSTATUS);
        List<BillBo> billBoList = new ArrayList<BillBo>();
        List<BillDetailCountBo> billDetailCountBoList = new ArrayList<BillDetailCountBo>();


        AldBillVo aldBillVoTemp = new AldBillVo();
        BeanUtils.copyProperties(aldBillVo,aldBillVoTemp);

        Integer statusTemp = aldBillVoTemp.getStatus();
        if(statusTemp!=null){
            switch(statusTemp){
                case Constant.Bill.NOGATHER_BILL:aldBillVoTemp.setStatus(Constant.Bill.NOPAY_BILL);break;
                case Constant.Bill.GATHERED_BILL:aldBillVoTemp.setStatus(Constant.Bill.PAYED_BILL);break;
                case Constant.Bill.NOPAY_BILL:aldBillVoTemp.setStatus(Constant.Bill.NOGATHER_BILL);break;
                case Constant.Bill.PAYED_BILL:aldBillVoTemp.setStatus(Constant.Bill.GATHERED_BILL);break;
            }
        }

        if(aldBillVo.getIncome()!=null){
            if(aldBillVo.getIncome()==INCOME_ALLNOSELECT||aldBillVo.getIncome()==INCOME_ALLSELECT){
                aldBillVo.setIncome(null);
            }
        }
        aldBillVo.setIsEntrustOrg(true);
        QueryParams<AldBillVo> queryParams = new QueryParams(aldBillVo,queryPage);
        Integer count = billCoreService.countBill(queryParams);
        if(count>0){
            billBoList = billCoreService.findBill(queryParams);
            for(BillBo billBo:billBoList){
                aldBillVo.setBillId(billBo.getId());
                BillDetailCountBo billDetailCountBo = billCoreService.getDetail(aldBillVo);

                //获取委托方的企业管理员
                Long entrustOrgId = billBo.getEntrustOrgId();
                if(entrustOrgId!=null){
                    QueryParams<UserQueryVo> params =new QueryParams();
                    UserQueryVo userQueryVo = new UserQueryVo();
                    userQueryVo.setIsRoot(true);
                    userQueryVo.setOrgId(entrustOrgId);

                    params.setEntity(userQueryVo);
                    List<UserBo> userBoList = userCoreService.findUser(params);
                    if(userBoList.size()>0){
                        billBo.setUserId(userBoList.get(0).getUserId());
                    }
                }

                billDetailCountBo.setBillBo(billBo);
                billDetailCountBoList.add(billDetailCountBo);
            }
        }

        billListView.setAldConstantsBoList(aldConstantsBoList);
        billListView.setBillDetailCountBoList(billDetailCountBoList);
        billListView.setRowCount(count);
        billListView.setPageIndex(aldBillVo.getPageIndex());
        billListView.setPageSize(aldBillVo.getPageSize());
        billListView.setAldBillVo(aldBillVoTemp);
        mav.addObject("billListView",billListView);
        return mav;
    }

    @RequestMapping("/edit/{billId}")
    public ModelAndView edit(@PathVariable(value = "billId") Long billId){
        ModelAndView mav = new ModelAndView("bill/edit");
        BillBo billBo = billCoreService.getBill(billId);
        BillDetailCountBo billDetailCountBo = billCoreService.getDetailByBillId(billId);
        List<AldConstantsBo> aldConstantsBoList= constantsCoreService.findConstantsByKey(CURRENCY_TYPE);

        List<BillDetailBo> list = billDetailCountBo.getBillDetailBoList();
        EasyUIDataGridBo easyUIDataGridBo = new EasyUIDataGridBo();
        easyUIDataGridBo.setRows(list);
        easyUIDataGridBo.setTotal(list.size());

        Double usdRate = rateCoreService.getRate(Constant.Currency.Name.USD_NAME,Constant.Currency.Name.CNY_NAME);
        Double rubRate = rateCoreService.getRate(Constant.Currency.Name.RUB_NAME,Constant.Currency.Name.CNY_NAME);
        RateBo rateBo=new RateBo();
        rateBo.setRubRate(rubRate);
        rateBo.setUsdRate(usdRate);

        //获取委托方的企业管理员
        Long entrustOrgId = billBo.getEntrustOrgId();
        if(entrustOrgId!=null){
            QueryParams<UserQueryVo> params =new QueryParams();
            UserQueryVo userQueryVo = new UserQueryVo();
            userQueryVo.setIsRoot(true);
            userQueryVo.setOrgId(entrustOrgId);

            params.setEntity(userQueryVo);
            List<UserBo> userBoList = userCoreService.findUser(params);
            if(userBoList.size()>0){
                billBo.setUserId(userBoList.get(0).getUserId());
            }
        }

        BillEditView billEditView = new BillEditView();

        billEditView.setBillBo(billBo);
        billEditView.setBillDetailCountBo(billDetailCountBo);
        billEditView.setEasyUIDataGridBo(easyUIDataGridBo);
        billEditView.setAldConstantsBoList(aldConstantsBoList);
        billEditView.setRateBo(rateBo);
        mav.addObject("billEditView",billEditView);

        return mav;
    }

    /**
     *获取币种
     * @return
     */
    @RequestMapping(value = "/getCurrencyType")
    @ResponseBody
    public cb.base.bo.common.AjaxResult getQuoteType(Long skuId) {
        cb.base.bo.common.AjaxResult ajaxResult = new cb.base.bo.common.AjaxResult();
        List<AldConstantsBo> quoteTypeList =  constantsCoreService.findConstantsByKey(CURRENCY_TYPE);
        ajaxResult.setIsSuccess(true);
        ajaxResult.setResultData(quoteTypeList);
        return ajaxResult;
    }

    @RequestMapping("/viewList")
    @ResponseBody
    public EasyUIDataGridBo viewList(AldBillVo aldBillVo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize){
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        QueryParams<AldBillVo> queryParams = new QueryParams();
        queryParams.setEntity(aldBillVo);
        Integer total = billCoreService.countBill(queryParams);
        bo.setTotal(total);
        if(total>0){
            QueryPage queryPage=new QueryPage();
            queryPage.setPageSize(pageSize);
            queryPage.setPageIndex(pageNumber);
            queryParams.setQueryPage(queryPage);
            bo.setRows(billCoreService.findBill(queryParams));
        }

        return bo;
    }

    @RequestMapping("/detail/{billId}")
    @ResponseBody
    public EasyUIDataGridBo detail(Integer income,Integer status,
                                   @PathVariable(value = "billId") Long billId){
        AldBillVo aldBillVo = new AldBillVo();
        EasyUIDataGridBo bo = new EasyUIDataGridBo();

        if(income!=null){
            aldBillVo.setIncome(income);
        }
        if(status!=null){
            aldBillVo.setStatus(status);
        }
        aldBillVo.setBillId(billId);
        BillDetailCountBo billDetailCountBo = billCoreService.findDetail(aldBillVo);
        List<BillDetailBo> list = billDetailCountBo.getBillDetailBoList();
        bo.setRows(list);
        bo.setTotal(list.size());
        return bo;
    }


    @RequestMapping("/updateBillStatus/{id}")
    @ResponseBody
    public AjaxResult updateBillStatus(@PathVariable(value = "id") Long id,Integer isLock){

        int count = billCoreService.countBillDetailNoLocking(id);

        if(count<=0){
            AldBillVo aldBillVo = new AldBillVo();
            aldBillVo.setId(id);
            aldBillVo.setIsLock(isLock);
            aldBillVo.setModifyBy(sessionContext.getLoginUser().getUserId());
            billCoreService.saveBill(aldBillVo);
            return new AjaxResult(true,"修改成功");
        }else{
            return new AjaxResult(false,"有未付或未收的账单明细");
        }
    }

    @RequestMapping("/settlement")
     @ResponseBody
     public AjaxResult settlement(AldBillDetailVo aldBillDetailVo){
        Long user = sessionContext.getLoginUser().getUserId();
        aldBillDetailVo.setSettlementDate(new Date());
        aldBillDetailVo.setModifyBy(user);
        aldBillDetailVo.setUserId(user);
        billCoreService.saveBillDetail(aldBillDetailVo);
        return new AjaxResult(true,"计算成功");
    }


    @RequestMapping("/modifyRemarks")
    @ResponseBody
    public AjaxResult modifyRemarks(AldBillDetailVo aldBillDetailVo){
        if(aldBillDetailVo.getRemarks()==null){
            aldBillDetailVo.setRemarks("");
        }
        aldBillDetailVo.setModifyBy(sessionContext.getLoginUser().getUserId());
        aldBillDetailVo.setModifyBy(sessionContext.getLoginUser().getUserId());
        aldBillDetailVo.setUserId(sessionContext.getLoginUser().getUserId());
        billCoreService.saveBillDetail(aldBillDetailVo);

        return new AjaxResult(true,"修改成功");
    }


    @RequestMapping("/modifyBillDetail")
    @ResponseBody
    public AjaxResult modifyBillDetail(AldBillDetailVo aldBillDetailVo){

        aldBillDetailVo.setModifyBy(sessionContext.getLoginUser().getUserId());
        aldBillDetailVo.setUserId(sessionContext.getLoginUser().getUserId());
        billCoreService.saveBillDetail(aldBillDetailVo);
        return new AjaxResult(true,"删除成功");
    }

    @RequestMapping("/deleteBillDetail/{id}")
    @ResponseBody
    public AjaxResult deleteBillDetail(@PathVariable(value = "id") Long id){
        billCoreService.deleteBillDetail(id);
        return new AjaxResult(true,"删除成功");
    }

    @RequestMapping("/insertBillDetail")
    @ResponseBody
    public AjaxResult insertBillDetail(String jsonStr){

        List<AldBillDetailInsertVo> aldBillDetailInsertVoList = JSON.parseArray(jsonStr, AldBillDetailInsertVo.class);

        List<AldBillDetailVo>   aldBillDetailVoList = new ArrayList<AldBillDetailVo>();

        for(AldBillDetailInsertVo aldBillDetailInsertVo:aldBillDetailInsertVoList){
            AldBillDetailVo aldBillDetailVo = new AldBillDetailVo();
            aldBillDetailVo.setBillId(aldBillDetailInsertVo.getBillId());
            aldBillDetailVo.setDealingsOrgId(aldBillDetailInsertVo.getDealingsOrgId());
            aldBillDetailVo.setFeeId(aldBillDetailInsertVo.getFeeId());
            aldBillDetailVo.setPaymentStatus(aldBillDetailInsertVo.getPaymentStatus());
            aldBillDetailVo.setCost(aldBillDetailInsertVo.getCost());
            aldBillDetailVo.setCostType(aldBillDetailInsertVo.getCostType());

            aldBillDetailVo.setCreateBy(sessionContext.getLoginUser().getUserId());
            aldBillDetailVo.setUserId(sessionContext.getLoginUser().getUserId());

            if(aldBillDetailInsertVo.getRate()!=null&&!"".equals(aldBillDetailInsertVo.getRate())){
                aldBillDetailVo.setRate(aldBillDetailInsertVo.getRate());
            }else{
                aldBillDetailVo.setRate(1.0);
            }
            aldBillDetailVoList.add(aldBillDetailVo);
        }

        billCoreService.saveBillDetailBatch(aldBillDetailVoList);
        return new AjaxResult(true,"删除成功");
    }

    /**
     *获取费用名称的列表
     * @param request
     * @return
     */
    @RequestMapping("/getFeeName")
    @ResponseBody
    public List getFeeName(HttpServletRequest request){
        String param=  request.getParameter("term").toString();
        List<SrvOrderFeeBo> srvOrderFeeBoList=new ArrayList<>();
        if (!StringUtils.isEmpty(param))
        {

            srvOrderFeeBoList=billCoreService.findFeeName(param);
        }
        List<AutoCompleteBo> lstAuto=new ArrayList<>();

        if (srvOrderFeeBoList.size()>0)
        {
            for(SrvOrderFeeBo x : srvOrderFeeBoList) {
                AutoCompleteBo auto=new AutoCompleteBo();
                auto.setId(x.getId().toString());
                auto.setLabel(x.getFeeitem());
                auto.setValue(x.getFeeitem());
                auto.setAnotherValue(x.getServiceName());
                lstAuto.add(auto);
            }
        }
        return lstAuto;

    }


    /**
     * Created by Administrator on 2015/8/20.
     * 获取企业名称列表 AutoComplete
     */
    @RequestMapping("/getOrgName")
    @ResponseBody
    public List getOrgName(HttpServletRequest request){
        String param=  request.getParameter("term").toString();
        List<AutoCompleteBo> lstAuto=new ArrayList<>();
        if (!StringUtils.isEmpty(param)){
            lstAuto = orgCoreService.findOrgSingle(param);

        }

        return lstAuto;
    }

    @RequestMapping(value = "/export/{billId}", method = { RequestMethod.GET })
    public ModelAndView exportExcel(@PathVariable(value = "billId") Long billId) throws Exception {
//        List<ErrorLogBo> errorLogs = errorLogMongoService.queryByPage(errorLog,0,500);
        BillDetailCountBo billDetailCountBo = billCoreService.getDetailByBillId(billId);
        BillBo billBo = billCoreService.getBill(billId);
        billDetailCountBo.setBillBo(billBo);
//        List<BillDetailBo> billDetailBoList = billDetailCountBo.getBillDetailBoList();
        BillViewExcel billViewExcel = new BillViewExcel();
        Map<String,Object> map = new HashMap<String,Object>();
        List<String> headList = getHeadList();
        map.put("object",billDetailCountBo);
        map.put("headList",headList);
        map.put("headSheet","对账单");
        return new ModelAndView(billViewExcel, map);
    }

    /*
    * 获取EXCLE标题
    * @return
    */
    private List<String> getHeadList(){
        List<String> headList = new ArrayList<String>();
        headList.add("结算时间");
        headList.add("资金流向");
        headList.add("往来公司");
        headList.add("所属服务");
        headList.add("费用名称");
        headList.add("外币金额");
        headList.add("币种");
        headList.add("汇率");
        headList.add("金额");
        return headList;
    }


    @RequestMapping("/viewEditBySrvId/{srvOrderId}")
    public ModelAndView viewEditBySrvId(@PathVariable(value = "srvOrderId") Long srvOrderId){
        ModelAndView mav = new ModelAndView("bill/edit");
        Long userId = sessionContext.getLoginUser().getUserId();
        BillBo billBo = billCoreService.selectBillBySrvOrderId(srvOrderId,userId);
        Long billId = billBo.getId();
        BillDetailCountBo billDetailCountBo = billCoreService.getDetailByBillId(billId);
        List<AldConstantsBo> aldConstantsBoList= constantsCoreService.findConstantsByKey(CURRENCY_TYPE);

        List<BillDetailBo> list = billDetailCountBo.getBillDetailBoList();
        EasyUIDataGridBo easyUIDataGridBo = new EasyUIDataGridBo();
        easyUIDataGridBo.setRows(list);
        easyUIDataGridBo.setTotal(list.size());

        Double usdRate = rateCoreService.getRate(Constant.Currency.Name.USD_NAME,Constant.Currency.Name.CNY_NAME);
        Double rubRate = rateCoreService.getRate(Constant.Currency.Name.RUB_NAME,Constant.Currency.Name.CNY_NAME);
        RateBo rateBo=new RateBo();
        rateBo.setRubRate(rubRate);
        rateBo.setUsdRate(usdRate);

        BillEditView billEditView = new BillEditView();

        billEditView.setBillBo(billBo);
        billEditView.setBillDetailCountBo(billDetailCountBo);
        billEditView.setEasyUIDataGridBo(easyUIDataGridBo);
        billEditView.setAldConstantsBoList(aldConstantsBoList);
        billEditView.setRateBo(rateBo);
        mav.addObject("billEditView",billEditView);

        return mav;
    }

}
