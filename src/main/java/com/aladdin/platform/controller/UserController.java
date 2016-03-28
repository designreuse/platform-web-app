package com.aladdin.platform.controller;

/**
 * Created by Administrator on 15-7-7.
 */

import com.aladdin.inf.constant.UserOrgConstant;
import com.aladdin.inf.po.AldUserEntity;
import com.aladdin.inf.service.IAdultInfService;
import com.aladdin.inf.service.IMemberInfService;
import com.aladdin.inf.vo.InfAdultVo;
import com.aladdin.inf.vo.InfUserVo;
import com.aladdin.platform.constans.Constants;
import com.aladdin.platform.result.AjaxResult;
import com.wl.framework.session.context.SessionContext;
import com.wl.framework.session.domain.LoginUser;
import com.wl.ms.client.IMessageRemoteService;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.util.*;

@Controller
@RequestMapping("/user")
public class UserController {

    private final static String COMMENTSTAR="【神灯速贸】您正在验证手机号码，验证码为";
    private final static String COMMENTEND="，请尽快提交。";
    private final static int USERTYPT=0;
    private final static int anchored =1;

    @Resource(name = "messageRemoteService")
    private IMessageRemoteService messageRemoteService;

    @Resource(name = "fwSessionContext")
    private SessionContext sessionContext;

    @RequestMapping(value = "/add",method = RequestMethod.GET)
    public String viewAdd(AldUserEntity entity,Model model){
        return "user/edit";
    }

    @RequestMapping(value = "/sendCode",method = RequestMethod.POST)
    @ResponseBody
    public Boolean sendCode(@RequestParam(value = "mobile", required = false) String mobile){
        Random random = new Random();
        String token = random.nextInt(899999) + 100000 + "";//生成100000-999999之间随机数
        // 为用户发送验证码信息
        try {
            sessionContext.setAttribute(mobile, token);
            messageRemoteService.sendSMS(mobile, COMMENTSTAR + token + COMMENTEND);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }



    @RequestMapping("/reset/validCode")
    @ResponseBody
    public Boolean validCode(String mobile,String validCode) {
        return validCode.equals(sessionContext.getAttribute(mobile));
    }

}
