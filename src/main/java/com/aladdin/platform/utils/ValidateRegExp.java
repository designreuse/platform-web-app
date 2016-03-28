package com.aladdin.platform.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ValidateRegExp {
	//手机号校验
	public static boolean isMobileNO(String mobiles){  
		//Pattern p = Pattern.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");  
		Pattern p = Pattern.compile("^1[3|4|5|8|7][0-9]\\d{4,8}$");  
		Matcher m = p.matcher(mobiles);  
		return m.matches();
	} 
	//用户名校验
	public static boolean isloginAccount(String loginAccount){  
		Pattern p = Pattern.compile("^([a-z]|[A-Z]|[0-9]|[_]|[\\u4e00-\\u9fa5])+$");  
		Matcher m = p.matcher(loginAccount);  
		return m.matches();
	} 
}
