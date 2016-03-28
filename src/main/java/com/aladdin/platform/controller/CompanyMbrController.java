package com.aladdin.platform.controller;

import cb.base.bo.common.AjaxResult;
import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.*;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.*;
import com.aladdin.core.util.DateUtil;
import com.aladdin.core.vo.*;
import com.aladdin.platform.bo.view.CmpMbrView;
import com.aladdin.platform.bo.view.CompanyInfoView;
import com.aladdin.platform.constans.Constants;
import com.google.gson.Gson;
import com.wl.framework.session.context.SessionContext;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/11/25.
 */
@Controller
@RequestMapping("/cmpMbr")
public class CompanyMbrController {
    private static final String ORG_BUYER_MSG = "恭喜您，您的企业信息已通过审核。<br/>Поздравляю вас ,ваша информация о компании уже  проверилась .";
    private static final String ORG_REFUSE_MSG_CN = "您的企业信息审核被拒绝，请修改后再次提交！";
    private static final String ORG_REFUSE_MSG_RU = "Ваша информация о компании была проверена и удалена,просим вас внести изменения и отправить повторно.";
    private static final String ORG_PASS_NORMAL = "恭喜您，您的企业信息已通过审核。";
    private static final String ORG_PASS_OPNE_SHOPS = "恭喜您，您的企业信息已通过审核，快来开设商铺吧！";
    private static final String ORG_ATTACH_NUPASS="您的企业【${attaName}】审核被拒绝，请重新上传后再次提交！Ваша информация о компания【${attaName}】 была проверена и получила отказ,просим вас заново закачать файл,и повторно отправить.";
    @Resource(name = "constantsCoreService")
    private IConstantsCoreService constantsCoreService;
    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;
    @Resource(name = "orgCoreService")
    private IOrgCoreService orgCoreService;
    @Resource(name = "proCityDistrictService")
    private IProCityDistrictService proCityDistrictService;
    @Resource(name = "srvOrderCoreService")
    private ISrvOrderCoreService srvOrderCoreService;
    @Resource(name = "adultLogCoreService")
    private IAdultLogCoreService adultLogCoreService;
    @Resource(name = "userCoreService")
    private IUserCoreService userCoreService;


    @Resource(name = "userSyncImService")
    private IUserSyncImService userSyncImService;
    @Resource(name = "seedSmsCoreService")
    private ISeedSmsCoreService seedSmsCoreService;




    @RequestMapping("/list")
    public ModelAndView list(Integer status) {
        ModelAndView modelAndView = new ModelAndView("cmpMbr/list");
        CmpMbrView cmpMbrView = new CmpMbrView();
        cmpMbrView.setStatus(status);
        cmpMbrView.setStatusList(constantsCoreService.findConstantsByKey("audit_state"));
        modelAndView.addObject("view",cmpMbrView);
        return modelAndView;
    }

    @RequestMapping("/listview")
    @ResponseBody
    public EasyUIDataGridBo listview(OrgQueryVo orgQueryVo,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                     @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        EasyUIDataGridBo easyUIDataGridBo = new EasyUIDataGridBo();
        QueryParams<OrgQueryVo> params = new QueryParams<>();
        if (orgQueryVo.getCreateTimeEnd() != null)
            orgQueryVo.setCreateTimeEnd(DateUtil.getEndTimeOfDay(orgQueryVo.getCreateTimeEnd()));
        params.setEntity(orgQueryVo);
        params.setQueryPageSize(pageSize);
        params.setQueryPageIndex(pageNumber);
        int counts = orgCoreService.countOrg(params);
        easyUIDataGridBo.setTotal(counts);
        if (counts > 0) {
            easyUIDataGridBo.setRows(orgCoreService.findOrg(params));
        }
        return easyUIDataGridBo;
    }

    @RequestMapping("/info")
    public String info(Model model, Long orgId) {

        CompanyInfoView companyInfoView = this.queryCompanyInfo(orgId);
        model.addAttribute("companyInfo", companyInfoView);
        System.out.println(new Gson().toJson(model));
        return "cmpMbr/info";
    }

    @RequestMapping("/edit")
    public String edit(Model model, @RequestParam Long orgId) {
        CompanyInfoView companyInfoView = this.queryCompanyInfo(orgId);
        //查询所有行业
        companyInfoView.setExportIndustryList(orgCoreService.findIndustry(Constant.Org.OptType.BUY));//进口
        companyInfoView.setEntryIndustryList(orgCoreService.findIndustry(Constant.Org.OptType.SALE));//出口
        model.addAttribute("companyInfo", companyInfoView);
        return "cmpMbr/edit";
    }

    //公司审核
    @RequestMapping("/checkOrg")
    public String checkOrg(Model model, @RequestParam Long orgId, @RequestParam Integer adultAction, @RequestParam String adultContent) {
        Long curUser = sessionContext.getLoginUser().getUserId();
        //根据用户ID 查询公司基本信息
        orgCoreService.changeOrgStatus(orgId, adultAction, adultContent, curUser);
        //查询企业管理员
        OrgBo orgBo = orgCoreService.getOrgByOrgId(orgId);
        UserQueryVo userQueryVo = new UserQueryVo();
        userQueryVo.setOrgId(orgId);
        userQueryVo.setIsRoot(true);
        QueryParams<UserQueryVo> queryParams = new QueryParams<>();
        queryParams.setEntity(userQueryVo);
        List<UserBo> orgAdmins = userCoreService.findUser(queryParams);

        String token = SecurityUtils.getSubject().getSession().getAttribute("accessToken").toString();
        try {
            if (null != orgAdmins) {
                String webRoot = "";
                if (orgBo.getIdentityIdLists() != null && orgBo.getIdentityIdLists().size() == 1 && orgBo.getIdentityIdLists().get(0).equals(Constant.Org.Identity.PURCHASE.toString())) {
                    webRoot = "purchase";
                } else if(orgBo.getIdentityIdLists() != null && orgBo.getIdentityIdLists().size() == 1 && orgBo.getIdentityIdLists().get(0).equals(Constant.Org.Identity.SUPPLY_ADMIN.toString())) {
                    webRoot = "supply";
                }else{
                    webRoot = "platform";
                }
                //审核拒绝
                if (adultAction .equals(Constant.Org.AdultAction.REFUSE) ) {
                    for (UserBo userBo : orgAdmins) {
                        userSyncImService.sendSysMsgByUserId(token, userBo.getUserId(), ORG_REFUSE_MSG_CN + "<br/>" + ORG_REFUSE_MSG_RU + "<a target='_blank' href='/"+webRoot+"/org/view'>企业信息查看</a>");
                        this.seedSmsCoreService.seedValidateCode(userBo.getMobile(), ORG_REFUSE_MSG_CN);
                    }
                } else if (adultAction .equals(Constant.Org.AdultAction.PASS) ) {
                    //供应商 企业审核通过
                    if (webRoot.equals("supply")) {
                        for (UserBo userBo : orgAdmins) {
                            if (userBo.getStatusType().equals(Constant.Audit.State.AUDIT_PASS) ) {
                                userSyncImService.sendSysMsgByUserId(token, userBo.getUserId(), ORG_PASS_OPNE_SHOPS + "<a target='_blank' href='/supply/shops/show'>商铺管理</a>");
                            } else {
                                userSyncImService.sendSysMsgByUserId(token, userBo.getUserId(), ORG_PASS_NORMAL);
                            }
                        }
                    } else if (webRoot.equals("purchase")) {
                        //采购商
                        for (UserBo userBo : orgAdmins) {
                            userSyncImService.sendSysMsgByUserId(token, userBo.getUserId(), ORG_BUYER_MSG);
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("消息发送失败");
        }
        return "redirect:/cmpMbr/info?orgId=" + orgId;
    }

    //附件审核
    @RequestMapping("/checkAtta")
    public String checkAtta(Model model, OrgAttachmentSaveVo orgAttachmentSaveVo) {
        Long curUser = sessionContext.getLoginUser().getUserId();
        orgAttachmentSaveVo.setCurrentUserId(curUser);
        orgCoreService.checkOrgAttachment(orgAttachmentSaveVo);
        if(!orgAttachmentSaveVo.getAttaStatusAction()){
            //获取该企业的管理员
            Long orgId=orgAttachmentSaveVo.getOrgId();
            OrgBo orgBo = orgCoreService.getOrgByOrgId(orgId);
            UserQueryVo userQueryVo = new UserQueryVo();
            userQueryVo.setOrgId(orgId);
            userQueryVo.setIsRoot(true);
            QueryParams<UserQueryVo> queryParams = new QueryParams<>();
            queryParams.setEntity(userQueryVo);
            List<UserBo> orgAdmins = userCoreService.findUser(queryParams);
            String token = SecurityUtils.getSubject().getSession().getAttribute("accessToken").toString();
            String webRoot = "";
            if (orgBo.getIdentityIdLists() != null && orgBo.getIdentityIdLists().size() == 1 && orgBo.getIdentityIdLists().get(0).equals(Constant.Org.Identity.PURCHASE.toString())) {
                webRoot = "purchase";
            } else if(orgBo.getIdentityIdLists() != null && orgBo.getIdentityIdLists().size() == 1 && orgBo.getIdentityIdLists().get(0).equals(Constant.Org.Identity.SUPPLY_ADMIN.toString())) {
                webRoot = "supply";
            }else{
                webRoot = "platform";
            }
            try {
                if(orgAdmins!=null){
                    for(UserBo userBo:orgAdmins){
                        userSyncImService.sendSysMsgByUserId(token, userBo.getUserId(), ORG_ATTACH_NUPASS.replaceAll("\\$\\{attaName\\}",orgAttachmentSaveVo.getAttaName())+"<a target='_blank' href='/"+webRoot+"/org/view'>企业信息查看</a>");
                    }
                }
            } catch (Exception e) {
                System.out.println("消息发送失败");
            }
        }
        return "redirect:/cmpMbr/info?orgId=" + orgAttachmentSaveVo.getOrgId();
    }

    //修改企业附件信息
    @RequestMapping("/saveAttach")
    public String addSrvAbility(OrgAttachmentSaveVo vo, Integer isThree) {
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        vo.setCurrentUserType(Constant.User.OptType.PLATFORM_PERSON);
        orgCoreService.saveOrgAttachment(vo);
        OrgSaveVo orgSaveVo = new OrgSaveVo();
        orgSaveVo.setId(vo.getOrgId());
        orgSaveVo.setIsThree(isThree);
        orgSaveVo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        orgCoreService.saveOrgBaseInfo(orgSaveVo);
        return "redirect:/cmpMbr/edit?orgId=" + vo.getOrgId();
    }

    @RequestMapping("/changeUseable")
    public String useable(Long orgId, Boolean disabled) {
        Long optUserId = sessionContext.getLoginUser().getUserId();
        orgCoreService.deleteOrgBaseInfoByOrgId(orgId, disabled, optUserId);
        return "redirect:/cmpMbr/info?orgId=" + orgId;
    }


    //修改企业基本信息
    @RequestMapping("/updateComBasicInfo")
    public String updateComBasicInfo(OrgSaveVo orgSaveVo) {
        orgSaveVo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        orgSaveVo.setCurrentUserType(Constant.User.OptType.PLATFORM_PERSON);//运营人员
        orgSaveVo.setRegSource(Constant.User.RegisterFrom.PLATFORM);
        orgSaveVo.setOrgType(Constant.Org.Type.COMPANY);
        orgCoreService.saveOrgBaseInfo(orgSaveVo, orgSaveVo.getIdentities());//修改企业身份
        return "redirect:/cmpMbr/edit?orgId=" + orgSaveVo.getId();
    }

    //添加企业基本信息
    @RequestMapping("/addMbr")
    @ResponseBody
    public AjaxResult add(OrgSaveVo orgSaveVo) {
        orgSaveVo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        orgSaveVo.setCurrentUserType(Constant.User.OptType.PLATFORM_PERSON);//运营人员
        if (orgSaveVo.getCountryType().intValue() == Constant.User.Country.CHINA)
            orgSaveVo.setRegSource(Constant.User.RegisterFrom.SUPPLY);
        else
            orgSaveVo.setRegSource(Constant.User.RegisterFrom.PURCHASE);
        orgSaveVo.setOrgType(Constant.Org.Type.COMPANY);
        Long userId = orgCoreService.saveOrgBaseInfo(orgSaveVo, orgSaveVo.getIdentities());//修改企业身份
        return new AjaxResult(userId);
    }

    //修改企业行业
    @RequestMapping("/saveOrgIndustry")
    public String saveOrgIndustry(@RequestParam Long orgId, @RequestParam(required = false) List<Long> buyIndustryIds, @RequestParam(required = false) List<Long> saleIndustryIds) {
        Long optUserId = sessionContext.getLoginUser().getUserId();
        if (buyIndustryIds != null && buyIndustryIds.size() == 0 && saleIndustryIds != null && saleIndustryIds.size() == 0)
            return "redirect:/cmpMbr/edit?orgId=" + orgId;
        if (buyIndustryIds == null) {
            buyIndustryIds = new ArrayList<>();
        }
        if (saleIndustryIds == null) {
            saleIndustryIds = new ArrayList<>();
        }
        orgCoreService.saveOrgIndustry(orgId, buyIndustryIds, saleIndustryIds, optUserId);
        return "redirect:/cmpMbr/edit?orgId=" + orgId;
    }

    //修改服务范围
    @RequestMapping("/saveOrgSrv")
    public String saveOrgSrv(@RequestParam Long orgId, @RequestParam List<Long> serviceIds) {
        if(serviceIds!=null&&serviceIds.size()>0){
            Long optUserId = sessionContext.getLoginUser().getUserId();
            orgCoreService.saveOrgSrv(orgId, serviceIds, optUserId);
        }
        return "redirect:/cmpMbr/edit?orgId=" + orgId;
    }


    @RequestMapping("/add")
    public String addPage(Model model) {
        CompanyInfoView companyInfoView = new CompanyInfoView();
        companyInfoView.setCountryList(constantsCoreService.findConstantsByKey("country_type"));
        model.addAttribute("companyInfo", companyInfoView);
        List<IdentityBo> identityBoList = orgCoreService.findIdentity();
        companyInfoView.setIdentityBoList(identityBoList);
        return "cmpMbr/add";
    }

    @RequestMapping("/checkRelate")
    public String edit(Long orgId, Long userId, Integer actionCode, Integer regSource) {
        Long optUserId = sessionContext.getLoginUser().getUserId();
        orgCoreService.changeOrgAndEmployee(orgId, userId, actionCode, optUserId, regSource);
        return "redirect:/personalMbr/edit?userId=" + userId;
    }

    @RequestMapping("/checkOrgExists")
    @ResponseBody
    public Boolean checkOrgExists(String orgNameCn,Boolean isSelf) {
        if(isSelf)return true;
        Boolean flag = orgCoreService.checkOrgNameForOrg(orgNameCn);
        return !flag;
    }


    private CompanyInfoView queryCompanyInfo(Long id) {
        CompanyInfoView companyInfoView = new CompanyInfoView();
        //根据企业ID 查询企业所有附件
        OrgQueryVo queryVo = new OrgQueryVo();
        queryVo.setId(id);
        OrgBo orgBo = orgCoreService.getOrgByOrgId(id);
        if (orgBo.getIsThree() == null) orgBo.setIsThree(0);
        companyInfoView.setOrgBo(orgBo);
        OrgAttachmentQueryVo orgAttachmentQueryVo = new OrgAttachmentQueryVo();
        orgAttachmentQueryVo.setOrgId(id);
        orgAttachmentQueryVo.setDisabled(false);
        //查询企业所有服务资质 附件
        orgAttachmentQueryVo.setAttaType(Constant.Org.AttachmentType.SERVICE_APTITUDE);
        List<OrgAttachmentBo> srvAbilitys = orgCoreService.findOrgAttachment(orgAttachmentQueryVo);
        companyInfoView.setSrvAbilitys(srvAbilitys);
        //查询企业所有 企业资质附件
        //查询是否三证合一
        orgAttachmentQueryVo.setAttaType(Constant.Org.AttachmentType.THREE_LICENSES);

        boolean isThree = orgBo.getIsThree() == null || orgBo.getIsThree() == 0 ? false : true;
        List<OrgAttachmentBo> threeCombine = isThree ? orgCoreService.findOrgAttachment(orgAttachmentQueryVo) : new ArrayList<OrgAttachmentBo>();
        companyInfoView.setThreeCombine(threeCombine.size() > 0);
        companyInfoView.setThreeCompanyAbility(threeCombine);
        if (!isThree) {
            Map<String, OrgAttachmentBo> map = new HashMap<>();
            List<OrgAttachmentBo> listLicenceCode = orgCoreService.findOrgAttachment(id, Constant.Org.AttachmentType.LICENSE_CODE);
            map.put("LICENSE_CODE", listLicenceCode.size() > 0 ? listLicenceCode.get(0) : null);
            List<OrgAttachmentBo> listOrgCode = orgCoreService.findOrgAttachment(id, Constant.Org.AttachmentType.ORGANIZE_CODE);
            map.put("ORGANIZE_CODE", listOrgCode.size() > 0 ? listOrgCode.get(0) : null);
            List<OrgAttachmentBo> listSax = orgCoreService.findOrgAttachment(id, Constant.Org.AttachmentType.SAX_LICENSE);
            map.put("SAX_LICENSE", listSax.size() > 0 ? listSax.get(0) : null);
            companyInfoView.setCompanyAbility(map);
            if (map.get("LICENSE_CODE") == null && map.get("ORGANIZE_CODE") == null && map.get("SAX_LICENSE") == null) {
                companyInfoView.setThreeCombine(true);
            }
        }

        //查询企业服务信息
        OrgServiceQueryVo orgServiceQueryVo = new OrgServiceQueryVo();
        orgServiceQueryVo.setOrgId(id);
        List<AldOrgServiceBo> aldOrgServiceEntityList = orgCoreService.findOrgSrv(orgServiceQueryVo);
        companyInfoView.setAldOrgServiceEntityList(aldOrgServiceEntityList);
        //
        List<ServiceBo> allServiceBoList = srvOrderCoreService.findService();
        companyInfoView.setAllServiceBoList(allServiceBoList);

        OrgDepartmentQueryVo orgDepartmentQueryVo = new OrgDepartmentQueryVo();
        orgDepartmentQueryVo.setOrgId(orgBo.getId());
        companyInfoView.setDepartList(orgCoreService.findCoreDepartment(orgDepartmentQueryVo));
        //根据企业ID 查询企业所有节点
        List<ServiceBo> serviceBoList = srvOrderCoreService.findNodeBoByOrgId(id);//
        companyInfoView.setServiceBoList(serviceBoList);
        //地址三级级联
        companyInfoView.setCountryList(constantsCoreService.findConstantsByKey("country_type"));
        Long countryType = orgBo.getCountryType();
        companyInfoView.setProvList(proCityDistrictService.getProvinceByCountryId(countryType == null ? Constant.Country.CHINA : countryType));
        companyInfoView.setCityList(proCityDistrictService.getCityByProvinceId(orgBo.getProvId()));
        companyInfoView.setDistList(proCityDistrictService.getDistrictByCityId(orgBo.getCityId()));
        //查询企业审核日志
        AdultQueryLogVo adultQueryLogVo = new AdultQueryLogVo();
        adultQueryLogVo.setApplyType(Constant.AdultLog.AdultType.COMPANY_INFO);
        adultQueryLogVo.setDynamicId(id);
        companyInfoView.setAdultLogList(adultLogCoreService.findAdultLog(adultQueryLogVo));
        //查询企业附件审核日志
        adultQueryLogVo.setApplyType(Constant.AdultLog.AdultType.COMPANY_ATTACHMENT);
        companyInfoView.setAttaAdultLogList(adultLogCoreService.findOrgAdultLog(id));
        //查询所有企业身份
        List<IdentityBo> identityBoList = orgCoreService.findIdentity();
        companyInfoView.setIdentityBoList(identityBoList);
        //查询企业行业
        List<OrgIndustryBo> orgIndustryBoList = orgCoreService.findOrgIndustryByOrgId(id);
        companyInfoView.setOrgIndustryBoList(orgIndustryBoList);
        //出口行业
        List<OrgIndustryBo> orgExportIndustry = orgCoreService.findOrgIndustryByOrgId(id, Constant.Org.OptType.SALE);
        companyInfoView.setOrgExportIndustry(orgExportIndustry);
        //进口行业
        List<OrgIndustryBo> orgEntryIndustry = orgCoreService.findOrgIndustryByOrgId(id, Constant.Org.OptType.BUY);
        companyInfoView.setOrgEntryIndustry(orgEntryIndustry);


        return companyInfoView;
    }


}
