package com.aladdin.platform.controller;

import com.aladdin.core.service.IUserSyncImService;
import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import com.wl.framework.login.ILoginService;
import com.wl.framework.login.exception.AppNotAuthenticateException;
import com.wl.framework.login.exception.IllegalUserStateException;
import com.wl.framework.login.exception.UnknownUsernameException;
import com.wl.framework.login.exception.WrongPasswordException;
import com.wl.framework.session.context.SessionContext;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;

@Controller
public class LoginController {
	
    private Logger logger=LoggerFactory.getLogger(LoginController.class);
    
    @Resource(name="fwSessionContext")
    private SessionContext sessionContext;
    
	@Resource(name="fwLoginService")
	private ILoginService loginService;

    @Resource(name = "captchaProducer")
    private Producer captchaProducer;

    @Resource(name = "userSyncImService")
    IUserSyncImService userSyncImService;

	@Value("#{sysConfig['base.app.code']}")
	private String appCode;

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(String username, String password,String captcha ,Model model,HttpSession session) throws IllegalUserStateException {
		try {
            if (!captcha.toUpperCase().equals(session.getAttribute(Constants.KAPTCHA_SESSION_KEY).toString().toUpperCase())){
                model.addAttribute("errorMsg", "验证码错误");
                return "login/pages/login";
            }
			loginService.login(username, password);
            String accessToken = userSyncImService.userImLogin(username, DigestUtils.md5Hex(password));
            SecurityUtils.getSubject().getSession().setAttribute("accessToken", accessToken);
		} catch (UnknownUsernameException e) {
			logger.error(e.getMessage());
            model.addAttribute("errorMsg", "您输入的用户名或密码有误");
//			model.addObject("errorMsg", "用户名不存在");
			return "login/pages/login";
		} catch (WrongPasswordException e) {
            model.addAttribute("errorMsg", "您输入的用户名或密码有误");
//   		model.addObject("errorMsg", "密码不对");
			return "login/pages/login";
		} catch (AppNotAuthenticateException e) {
            model.addAttribute("errorMsg", "无权登录");
//			model.addObject("errorMsg", "无权登录");
			return "login/pages/login";
		}catch (IllegalUserStateException e) {
            model.addAttribute("errorMsg", "无权登录");
            return "login/pages/login";
        }
		/**
		 * TODO
		 */
//		验证码
		
//		记住我
		
		/**
		 * 成功，
		 * 1、往session中插入信息
		 */
		return "redirect:/";
	}

    @RequestMapping("/validateCode")
    public ModelAndView handleRequest(
            HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        // Set to expire far in the past.
        response.setDateHeader("Expires", 0);
        // Set standard HTTP/1.1 no-cache headers.
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        // Set IE extended HTTP/1.1 no-cache headers (use addHeader).
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
        // Set standard HTTP/1.0 no-cache header.
        response.setHeader("Pragma", "no-cache");

        // return a jpeg
        response.setContentType("image/jpeg");

        // create the text for the image
        String capText = captchaProducer.createText();

        // store the text in the session
        request.getSession().setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);

        // create the image with the text
        BufferedImage bi = captchaProducer.createImage(capText);

        ServletOutputStream out = response.getOutputStream();

        // write the data out
        ImageIO.write(bi, "jpg", out);
        try {
            out.flush();
        } finally {
            out.close();
        }
        return null;
    }
	
	@RequestMapping(value="/logout",method=RequestMethod.GET)
	public String logout(){
        //清空session
        loginService.logout();
        //跳转到登录页面
		return "redirect:/login";
	}

	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String login(ModelAndView modelAndView){
        // 如果已经登录，则返回主页
//        if(sessionContext.getLoginUser()!=null){
//            return "redirect:/index";
//        }
		return "login/pages/login";
	}
    @RequestMapping("/getValidateCode")
    public @ResponseBody
    String getCaptcha(HttpServletRequest request){
        Object attr = request.getSession().getAttribute(Constants.KAPTCHA_SESSION_KEY);
        if (attr != null){
            return attr.toString();
        }else{
            return "";
        }
    }

}
