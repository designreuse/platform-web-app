package com.aladdin.platform.controller;

import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.DepartmentBo;
import com.aladdin.core.bo.OrgBo;
import com.aladdin.core.bo.UserBo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.*;
import com.aladdin.core.util.DateUtil;
import com.aladdin.core.vo.OrgDepartmentQueryVo;
import com.aladdin.core.vo.OrgQueryVo;
import com.aladdin.core.vo.UserQueryVo;
import com.aladdin.core.vo.UserSaveVo;
import com.aladdin.core.bo.AutoCompleteBo;
import com.aladdin.platform.bo.view.PersonalMbrView;
import com.aladdin.platform.bo.view.UserInfoView;
import com.aladdin.platform.constans.Constants;
import com.google.gson.Gson;
import com.wl.framework.session.context.SessionContext;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 王兵 on 2015/11/26.
 */
@Controller
@RequestMapping("/personalMbr")
public class PersonalMbrController {
    private String REFUSE_MSG_CN = "您的个人信息审核被拒绝，请修改后再次提交！";
    private String REFUSE_MSG_RU = "Ваша личная информация была проверена и получила отказ,просим вас внести изменения и отправить повторно.";
    private String PASS_MSG_OPEN_SHOPS = "恭喜您，您的个人信息已通过审核，快来开设商铺吧！";
    private String PASS_MSG_BUYER = "恭喜您，您的个人信息已通过审核。<br/>Поздравляю вас ,ваша личная информация уже  проверилась .";
    private String PASS_MSG_NORMAL = "恭喜您，您的个人信息已通过审核。";

    @Resource(name = "proCityDistrictService")
    private IProCityDistrictService proCityDistrictService;
    @Resource(name = "seedSmsCoreService")
    private ISeedSmsCoreService seedSmsCoreService;
    @Resource(name = "orgCoreService")
    private IOrgCoreService orgCoreService;
    @Resource(name = "constantsCoreService")
    private IConstantsCoreService constantsCoreService;
    @Resource(name = "userCoreService")
    private IUserCoreService userCoreService;

    @Resource(name = "userSyncImService")
    private IUserSyncImService userSyncImService;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @RequestMapping("/list")
    public String list(Model model,Integer status) {
        PersonalMbrView personalMbrView = new PersonalMbrView();
        personalMbrView.setStatus(status);
        personalMbrView.setStatusList(constantsCoreService.findConstantsByKey("audit_state"));
        model.addAttribute("view",personalMbrView);
        return "personalMbr/list";
    }

    @RequestMapping("/listview")
    @ResponseBody
    private EasyUIDataGridBo listview(UserQueryVo userQueryVo, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                      @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        EasyUIDataGridBo easyUIDataGridBo = new EasyUIDataGridBo();
        if (userQueryVo.getCreateTimeEnd() != null)
            userQueryVo.setCreateTimeEnd(DateUtil.getEndTimeOfDay(userQueryVo.getCreateTimeEnd()));
        QueryParams<UserQueryVo> params = new QueryParams<>();
        params.setEntity(userQueryVo);
        params.setQueryPageSize(pageSize);
        params.setQueryPageIndex(pageNumber);
        int counts = userCoreService.countUser(params);
        easyUIDataGridBo.setTotal(counts);
        if (counts > 0) {
            easyUIDataGridBo.setRows(userCoreService.findUser(params));
        }
        return easyUIDataGridBo;
    }

    @RequestMapping("/info")
    public String info(Model model, Long userId) {
        model.addAttribute("personalMbrView", this.queryMbrInfo(userId));
        return "personalMbr/info";

    }


    @RequestMapping("/testUpload")
    public String testUpload(Model model) {
        return "personalMbr/testPhotoUpload";
    }


    @RequestMapping("/edit")
    public String edit(Model model, Long userId) {
        UserInfoView userInfoView = this.queryMbrInfo(userId);
        userInfoView.setCountryList(constantsCoreService.findConstantsByKey("country_type"));
        model.addAttribute("personalMbrView", userInfoView);
        return "personalMbr/edit";
    }

    private UserInfoView queryMbrInfo(Long userId) {
        UserInfoView userInfoView = new UserInfoView();
        UserBo userBo = userCoreService.getUserByUserId(userId);
        userInfoView.setUserBo(userBo);
        System.out.println(new Gson().toJson(userInfoView));
        //查询所有部门
        OrgDepartmentQueryVo orgDepartmentQueryVo = new OrgDepartmentQueryVo();
        orgDepartmentQueryVo.setOrgId(userBo.getOrgId());
        userInfoView.setDepartmentList(orgCoreService.findCoreDepartment(orgDepartmentQueryVo));
        //查询公司
        OrgBo orgBo = new OrgBo();
        if (userBo.getOrgId() != null) {
            orgBo = orgCoreService.getOrgByOrgId(userBo.getOrgId());
        }
        userInfoView.setOrgBo(orgBo);
        //查询所有省份
        Long cid = userBo.getCountryId() == null ? Constant.Country.CHINA : userBo.getCountryId();
        userInfoView.setProvinceBoList(proCityDistrictService.getProvinceByCountryId(cid));
        //企业 是否是 代理商 或 服务商  com.aladdin.core.constant.Constant.Org.Identity
        if (null != orgBo && null != orgBo.getIdentityIdLists() && orgBo.getIdentityIdLists().size() > 0) {
            for (String str : orgBo.getIdentityIdLists()) {
                if (str.equals(Constant.Org.Identity.PROXY + "") || str.equals(Constant.Org.Identity.PURCHASE + "")) {
                    userInfoView.setProxyOrPurchase(true);
                    break;
                }
            }
        }
        return userInfoView;
    }

    @RequestMapping("/changMbrPwd")
    public String changeMbrPwd(Long userId, String newPassword) {
        userCoreService.updateMemPwd(userId, newPassword, sessionContext.getLoginUser().getUserId());
        return "redirect:/personalMbr/edit?userId=" + userId;
    }

    //身份证审核
    @RequestMapping("/checkIdcard")
    public String applyUserCheck(Integer statusType, @RequestParam Long userId) throws Exception {
        userCoreService.applyUserCheck(statusType, userId, sessionContext.getLoginUser().getUserId());
        UserBo userBo = userCoreService.getUserByUserId(userId);


        String webRoot = "";
        if (userBo.getRegSource().equals(Constant.User.RegisterFrom.SUPPLY) ) {
            webRoot = "supply";
        } else if (userBo.getRegSource().equals(Constant.User.RegisterFrom.PURCHASE)) {
            webRoot = "purchase";
        } else {
            webRoot = "platform";
        }
        String token = SecurityUtils.getSubject().getSession().getAttribute("accessToken").toString();
        //审核不通过 通知用户 （包含短信通知 和消息通知）
        if (statusType.equals(Constant.Audit.State.AUDIT_REFUSE) ) {
            String msg = REFUSE_MSG_CN + "<br/>" + REFUSE_MSG_RU + "<a target='_blank' href='/" + webRoot + "/user/view'>个人信息查看</a>";
            this.userSyncImService.sendSysMsgByUserId(token, userId, msg);
            this.seedSmsCoreService.seedValidateCode(userBo.getMobile(), REFUSE_MSG_CN);
        } else if (statusType .equals( Constant.Audit.Status.AUDIT_PASS)) {
            //如果是个人类型的 通过  通知用户开店铺
            if (Constant.User.RegisterFrom.SUPPLY .equals(userBo.getRegSource())  && Constant.User.OrgUserRelation.USER_ORG_STATUS_PERSON .equals( userBo.getEntUserStatus())) {
                this.userSyncImService.sendSysMsgByUserId(token, userId, PASS_MSG_OPEN_SHOPS + "<a target='_blank' href='/" + webRoot + "/shops/show'>商铺管理</a>");
            } else if (Constant.User.RegisterFrom.PURCHASE .equals( userBo.getRegSource()) && Constant.User.OrgUserRelation.USER_ORG_STATUS_PERSON .equals(userBo.getEntUserStatus()) ) {
                //【采购商】个人类型 通过 通知用户
                this.userSyncImService.sendSysMsgByUserId(token, userId, PASS_MSG_BUYER);
            } else if (userBo.getIsRoot().equals(Constant.IsRoot.YES)
                    ) {
                //如果是管理员
                OrgBo orgBo = orgCoreService.getOrgByOrgId(userBo.getOrgId());
                //且注册来源为中站 且关系为隶属 且公司已通过审核  通知开店
                if (orgBo.getOrgAdultStatus().equals(Constant.Audit.State.AUDIT_PASS)
                        && Constant.User.RegisterFrom.SUPPLY .equals(userBo.getRegSource())
                        && Constant.User.OrgUserRelation.USER_ORG_STATUS_MEMBERSHIP .equals( userBo.getEntUserStatus())
                        ) {
                    this.userSyncImService.sendSysMsgByUserId(token, userId, PASS_MSG_OPEN_SHOPS + "<a target='_blank' href='/" + webRoot + "/shops/show'>商铺管理</a>");
                } else {
                    this.userSyncImService.sendSysMsgByUserId(token, userId, PASS_MSG_NORMAL);
                }
            }else{
                this.userSyncImService.sendSysMsgByUserId(token, userId, PASS_MSG_NORMAL);
            }

        }
        return "redirect:/personalMbr/info?userId=" + userId;
    }

    @RequestMapping("/checkMobileExists")
    @ResponseBody
    public Boolean checkMobileExists(String mobile, @RequestParam(required = true) Boolean isSelf) {
        if (isSelf) return isSelf;
        return userCoreService.getUserIdByLoginName(mobile) == null;
    }

    @RequestMapping("/getOrgName")
    @ResponseBody
    public List<AutoCompleteBo> getOrgName(String term,Integer regSource, @RequestParam(value = "identityIdList[]", required = false) List<Long> identityIdList) {
        List<OrgBo> orgBoLlist = new ArrayList<>();
        if (!StringUtils.isEmpty(term)) {
            OrgQueryVo vo = new OrgQueryVo();
            if(regSource.equals(Constant.User.RegisterFrom.PURCHASE)){
                vo.setCountryType(Constant.Service.CountryType.COUNTRY_TYPE_RU.longValue());
            }else {
                vo.setCountryType(Constant.Service.CountryType.COUNTRY_TYPE_CN.longValue());
            }
            vo.setOrgName(term);
            if (null != identityIdList && identityIdList.size() > 0) vo.setIdentityIdList(identityIdList);
            orgBoLlist = orgCoreService.getOrgByOrgNameForPlatForm(term);
        }
        List<AutoCompleteBo> lstAuto = new ArrayList<>();

        if (orgBoLlist.size() > 0) {
            for (OrgBo x : orgBoLlist) {
                AutoCompleteBo auto = new AutoCompleteBo();
                auto.setId(x.getId().toString());
                auto.setLabel(x.getOrgNameCn());
                auto.setValue(x.getOrgNameCn());
                if(Constant.User.RegisterFrom.PURCHASE.equals(regSource)){
                    auto.setLabel(x.getOrgNameRu());
                    auto.setValue(x.getOrgNameRu());
                }
                String otherValue = "0";
                OrgBo orgBo=orgCoreService.getOrgByOrgId(x.getId());

                for (String str : orgBo.getIdentityIdLists()) {
                    if (str.equals(Constant.Org.Identity.PROXY + "") || str.equals(Constant.Org.Identity.LOGISTICS + "")) {
                        otherValue = "1";
                        OrgDepartmentQueryVo orgDepartmentQueryVo = new OrgDepartmentQueryVo();
                        orgDepartmentQueryVo.setOrgId(x.getId());
                        List<DepartmentBo> departmentBoList = orgCoreService.findCoreDepartment(orgDepartmentQueryVo);
                        auto.setDepartmentBoList(departmentBoList);
                        break;
                    }
                }
                auto.setOtherValue(otherValue);
                lstAuto.add(auto);
            }
        }
        return lstAuto;
    }

    //保存用户
    @RequestMapping("/saveUser")
    public String save(UserSaveVo vo) {
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        vo.setCurrentUserType(Constant.User.OptType.PLATFORM_PERSON);
        this.userCoreService.saveUser(vo);
        //如果是隶属 并且是管理员 企业身份是供应商 通知 开店铺
        return "redirect:/personalMbr/info?userId=" + vo.getUserId();
    }

    @RequestMapping("/changeMbrStatus")
    public String changeStatus(@RequestParam Long userId, @RequestParam Integer accountState) {
        userCoreService.changeCoreUserStatus(userId, accountState, sessionContext.getLoginUser().getUserId());
        return "redirect:/personalMbr/edit?userId=" + userId;
    }

    //解除隶属关系
    @RequestMapping("/free")
    //Long orgId,Long userId,Integer actionCode,Long optUserId,Integer regSource
    public String freeRelate(@RequestParam Long orgId, @RequestParam Long userId, @RequestParam Integer reSource) {
        orgCoreService.changeOrgAndEmployee(orgId, userId, Constant.Org.EmployeeRelationCheck.OUT_RELATION, sessionContext.getLoginUser().getUserId(), reSource);
        return "redirect:/personalMbr/list";
    }

    //添加用户
    @RequestMapping("addPage")
    public String addPage(Model model) {
        UserInfoView userInfoView = new UserInfoView();
        userInfoView.setCountryList(constantsCoreService.findConstantsByKey("country_type"));
        model.addAttribute("personalMbrView", userInfoView);
        return "personalMbr/add";
    }


    //添加用户
    @RequestMapping("/addNewUser")
    public String save(Model model, UserSaveVo vo) {
        vo.setLoginAccount(vo.getMobile());
        if (vo.getRegSource() == Constant.User.RegisterFrom.PURCHASE) vo.setLoginAccount(vo.getEmail());
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        vo.setCurrentUserType(Constant.User.OptType.PLATFORM_PERSON);
        vo.setLoginStep(Constant.User.LoginStep.userSelf);
        Long userId = userCoreService.saveUserPlatForm(vo);

        return "redirect:/personalMbr/info?userId=" + userId;
    }


}
