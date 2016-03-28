package com.aladdin.platform.controller;

import cb.base.bo.query.QueryParams;
import com.aladdin.core.bo.DepartmentBo;
import com.aladdin.core.bo.UserBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.IOrgCoreService;
import com.aladdin.core.service.IProCityDistrictService;
import com.aladdin.core.service.IUserCoreService;
import com.aladdin.core.util.DateUtil;
import com.aladdin.core.vo.OrgDepartmentQueryVo;
import com.aladdin.core.vo.UserQueryVo;
import com.aladdin.core.bo.easyUIBo.EasyUIDataGridBo;
import com.aladdin.core.vo.UserSaveVo;
import com.aladdin.platform.bo.view.UserInfoView;
import com.aladdin.platform.constans.Constants;
import com.google.gson.Gson;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2015/11/24.
 */
@Controller
@RequestMapping("/empMgr")
public class EmpMgrController {
    @Resource(name = "proCityDistrictService")
    private IProCityDistrictService proCityDistrictService;
    @Resource(name = "orgCoreService")
    private IOrgCoreService orgCoreService;
    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;
    @Resource(name = "userCoreService")
    private IUserCoreService userCoreService;

    @RequestMapping("/list")
    public String list(Model model) {
        //查询所有部门
        OrgDepartmentQueryVo orgDepartmentQueryVo = new OrgDepartmentQueryVo();
        orgDepartmentQueryVo.setOrgId(sessionContext.getLoginUser().getOrgId());
        List<DepartmentBo> departmentBoList = orgCoreService.findCoreDepartment(orgDepartmentQueryVo);
        model.addAttribute("departmentBoList", departmentBoList);
        return "empMgr/list";
    }

    @RequestMapping("/listEmp")
    @ResponseBody
    public EasyUIDataGridBo listEmp(UserQueryVo userQueryVo, @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_NO) Integer pageNumber,
                                    @RequestParam(required = false, defaultValue = Constants.DEFAULT_LIST_PAGE_SIZE) Integer pageSize) {
        System.out.println(new Gson().toJson(userQueryVo) + "员工管理参数");
        if(userQueryVo.getCreateTimeStart()!=null)userQueryVo.setCreateTimeStart(DateUtil.getEndTimeOfDay(userQueryVo.getCreateTimeStart()));
        //userQueryVo
        userQueryVo.setUserOrgId(sessionContext.getLoginUser().getOrgId());
        QueryParams<UserQueryVo> queryParams = new QueryParams();
        queryParams.setEntity(userQueryVo);
        queryParams.setQueryPageIndex(pageNumber);
        queryParams.setQueryPageSize(pageSize);
        EasyUIDataGridBo easyUIDataGridBo = new EasyUIDataGridBo();
        Integer counts = userCoreService.countUser(queryParams);
        easyUIDataGridBo.setTotal(counts);
        if (counts > 0) {
            easyUIDataGridBo.setRows(userCoreService.findUser(queryParams));
        }
        return easyUIDataGridBo;
    }


    //员工信息编辑
    @RequestMapping("/edit")
    public String edit(Model model, Long userId) {
        model.addAttribute("userInfo", this.queryUserInfo(userId));
        return "empMgr/edit";
    }

    //员工信息编辑
    @RequestMapping("/add")
    public String addUser(Model model) {
        UserInfoView userInfoView=this.queryUserInfo(sessionContext.getLoginUser().getUserId());
        UserBo userBo=new UserBo();
        UserBo currUserBo = userInfoView.getUserBo();
        userBo.setOrgId(userInfoView.getUserBo().getOrgId());
        userBo.setOrgName(currUserBo!=null&&currUserBo.getCountryId().equals(Constant.Country.RUB)?currUserBo.getOrgNameRu():currUserBo.getOrgNameRu());
        userBo.setCountryId(userInfoView.getUserBo().getCountryId());
        userInfoView.setUserBo(userBo);
        model.addAttribute("userInfo",userInfoView );
        return "empMgr/add";
    }



    @RequestMapping("/saveUser")
    public String saveUser(UserSaveVo userSaveVo) {
        userSaveVo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        //默认手机号为登录账户
        userSaveVo.setRegSource(Constant.User.RegisterFrom.PLATFORM);
        userSaveVo.setLoginAccount(userSaveVo.getMobile());
        userSaveVo.setCurrentUserType(Constant.User.OptType.EMPLOYEE_ORG);
        Long userId=this.userCoreService.saveUser(userSaveVo);
        return "redirect:/empMgr/info?userId="+userId;
    }

    //员工信息查看
    @RequestMapping("/info")
    public String info(Model model, @RequestParam Long userId) {
        model.addAttribute("userInfo", this.queryUserInfo(userId));
        return "empMgr/info";
    }

    @RequestMapping("/changeMbrStatus")
    public String changeStatus(@RequestParam Long userId, @RequestParam Integer accountState) {
        userCoreService.changeCoreUserStatus(userId, accountState, sessionContext.getLoginUser().getUserId());
        return "redirect:/empMgr/edit?userId=" + userId;
    }

    private UserInfoView queryUserInfo(Long userId) {
        UserInfoView userInfoView = new UserInfoView();
        UserBo userBo = userCoreService.getUserByUserId(userId);
        userInfoView.setUserBo(userBo);
        System.out.println(new Gson().toJson(userInfoView));
        //查询所有部门
        OrgDepartmentQueryVo orgDepartmentQueryVo = new OrgDepartmentQueryVo();
        orgDepartmentQueryVo.setOrgId(userBo.getOrgId());
        userInfoView.setDepartmentList(orgCoreService.findCoreDepartment(orgDepartmentQueryVo));
        //查询所有省份
        Long cid = userBo.getCountryId() == null ? Constant.Country.CHINA : userBo.getCountryId();
        userInfoView.setProvinceBoList(proCityDistrictService.getProvinceByCountryId(cid));
        return userInfoView;
    }
}
