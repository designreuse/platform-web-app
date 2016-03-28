package com.aladdin.platform.controller;

import com.aladdin.core.bo.UserBo;
import com.aladdin.core.constant.Constant;
import com.aladdin.core.service.IOrgCoreService;
import com.aladdin.core.service.IProCityDistrictService;
import com.aladdin.core.service.IUserCoreService;
import com.aladdin.core.vo.OrgDepartmentQueryVo;
import com.aladdin.core.vo.UserSaveVo;
import com.aladdin.platform.bo.view.UserInfoView;
import com.google.gson.Gson;
import com.wl.framework.session.context.SessionContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by Administrator on 2015/11/24.
 */
@Controller
@RequestMapping("/userInfo")
public class UserInfoController {
    @Resource(name = "userCoreService")
    private IUserCoreService userCoreService;

    @Resource(name = "orgCoreService")
    private IOrgCoreService orgCoreService;

    @Resource(name = "proCityDistrictService")
    private IProCityDistrictService proCityDistrictService;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @RequestMapping("/info")
    public String info(Model model, @RequestParam(required = false) Long userId) {
        if (userId == null) userId = sessionContext.getLoginUser().getUserId();
        model.addAttribute("personalMbrView", queryMbrInfo(userId));
        return "userInfo/info";
    }

    @RequestMapping("/edit")
    public String edit(Model model, @RequestParam(required = false) Long userId, @RequestParam(required = false) Integer flag) {

        userId = userId == null ? sessionContext.getLoginUser().getUserId() : userId;

        UserInfoView userInfoView = queryMbrInfo(userId);
        if (null != flag && flag == -1) {//新增
            userInfoView.setUserBo(null);
        }
        model.addAttribute("personalMbrView", userInfoView);
        return "userInfo/edit";
    }


    @RequestMapping("/commitPwd")
    public String changePwd(Model model, @RequestParam(required = true) String newPassword, @RequestParam(required = true) String oldPassword) {
        Long userId = sessionContext.getLoginUser().getUserId();
        Long rtn = userCoreService.updateMemPwd(userId, newPassword, oldPassword);
        if (rtn == null) {
            model.addAttribute("message", "修改密码失败");
            model.addAttribute("rst", "-1");
        } else {
            model.addAttribute("message", "修改密码成功");
            model.addAttribute("rst", "1");
        }
        return "userInfo/changePwd";
    }


    @RequestMapping("/changePwd")
    public String changePwdPage() {
        return "userInfo/changePwd";
    }

    @RequestMapping("/save")
    public String save(UserSaveVo vo) {
        vo.setCurrentUserId(sessionContext.getLoginUser().getUserId());
        this.userCoreService.saveUser(vo);

        return "redirect:/userInfo/info";
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
        //查询所有省份
        Long cid = userBo.getCountryId() == null ? Constant.Country.CHINA : userBo.getCountryId();
        userInfoView.setProvinceBoList(proCityDistrictService.getProvinceByCountryId(cid));
        return userInfoView;
    }

}
