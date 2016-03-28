package com.aladdin.platform.utils;

public class Const {
	//审核模块  :首先判断哪个按钮触发时间 1：验证通过，2：验证不通过 ,3:驳回
	public static final String VALIDATEOK="1";
	public static final String VALIDATENO="2";
	public static final String VALIDATEREJECT="3";
	//定义常量
	/**
	 *  对证件进行审核
	 *  营业执照	bizLicence	    1
			 组织机构代码证	orgCodeCert	2
			 税务登记证	taxRegCert	    3
			 个人身份证	identity	    4
			 驾驶证	driverLicense	5
			 车辆照片	truckImage	    6
			 行驶证	drivingLicense	7
			 运营许可证	operateLicense	8
			 运输从业资格证	qualificationLicense	9
			 道路
			 以下为枚举
	         BIZLICENCE(1, "营业执照"),
	         ORGCODECERT(2, "组织机构代码证"),
	         TAXREGCERT(3, "税务登记证"), 
	         IDENTITY(4, "个人身份证"),
	         DRIVERLICENSE(5, "驾驶证"), 
	         TRUCKIMAGE(6, "车辆照片"),
	         DRIVINGLICENSE(7, "行驶证"),
	         OPERATELICENSE(8, "运营许可证");
	 */
	public  static final String PAPER_TYPE_BIZLICENCE_INT="1";
	public  static final String PAPER_TYPE_ORGCODECERT_INT="2";
	public  static final String PAPER_TYPE_TAXREGCERT_INT="3";
	public  static final String PAPER_TYPE_IDENTITY_INT="4";
	public  static final String PAPER_TYPE_DRIVERLICENSE_INT="5";
	public  static final String PAPER_TYPE_TRUCKIMAGE_INT="6";
	public  static final String PAPER_TYPE_DRIVINGLICENSE_INT="7";
	public  static final String PAPER_TYPE_OPERATELICENSE_INT="8";
	public  static final String PAPER_TYPE_QUALIFICATIONLICENSE_INT="9";
    public static final String  PAPER_TYPE_INSURE_INT = "10";

	/**
	 * （营业执照、组织机构代码证、税务登记证、个人身份证、驾驶证、车辆照片、行驶证、运营许可证、运输从业资格证
	 */
	public  static final String PAPER_TYPE_BIZLICENCE="营业执照";
	public  static final String PAPER_TYPE_ORGCODECERT="组织机构代码证";
	public  static final String PAPER_TYPE_TAXREGCERT="税务登记证";
	public  static final String PAPER_TYPE_IDENTITY="个人身份证";
	public  static final String PAPER_TYPE_DRIVERLICENSE="驾驶证";
	public  static final String PAPER_TYPE_TRUCKIMAGE="车辆照片";
	public  static final String PAPER_TYPE_DRIVINGLICENSE="行驶证";
	public  static final String PAPER_TYPE_OPERATELICENSE="运营许可证";
	public  static final String PAPER_TYPE_QUALIFICATIONLICENSE="运输从业资格证";
	public  static final String PAPER_TYPE_INSURE="车辆保险";
	public  static final String PAPER_TYPE_JD_DRIVING="机动车行驶证";
	public  static final String PAPER_TYPE_ROAD_OPERTION="道路运输证";
	

	//审核管理模块 :（排序） sortType:1,审核对象升序，2，申请时间降序，3：受理完成时间降序,4:条件查询
	public static final String CERTOBJECTASC="1";
	public static final String CERTAPPLYDESC="2";
	public static final String CERTHANDLERDESC="3";
	public static final String CERTSEACH="4";

	//地区模块：排序：判断前台传来的操作类型：1：地区 代码升序。2：地区拼音升序，3：查询
	public static final String REGIONCODE="1";
	public static final String REGIONTRANSCRIPTION="2";
	public static final String REGIONSEACH="3";
	
	//认证体系模块：排序：判断前台传来的操作类型：1-默认查询
	public static final String LICENSEDEFINE_DEFAULT="1";
	public static final String LICENSEDEFINE_NAME_SORT="2";//证件定义名称排序
	public static final String CERTSYSTEM_DEFAULT="1";
	public static final String CERTSYSTEM_CODE_SORT="2";//认证体系编码排序
	public static final String CERTSYSTEM_NAME_SORT="3";//认证体系名称排序
	public static final String ORG_TYPE_DEFAULT="1";
	public static final String ORGTYPE_NAME_SORT="2";//组织分类名称排序


	////货源管理模块：排序：判断前台传来的操作类型：1，货源发布方降序。2：创建时间升序
	public  static final String FREIGHTORGNAMEDESC="1";
	public  static final String FREIGHTCREATETIMEASC="2";
	
	//运单管理排序字段常量值
	public static final String ORDERRELATORFH="1";
	public static final String ORDERRELATORSH="2";
	public static final String ORDERCREATETIME="3";
	
	/*默认
	审核对象↑
	审核时间↓
	受理完成时间↓
	 */

	public static final String ORG_DEFAULT="default";
	public static final String ORG_CERT_OBJECT="certObject";
	public static final String ORG_CERT_TIME="certTime";
	public static final String ORG_CERT_FINISH_TIME="CertFinishTime";


	public static final String MESSAGE_ORG_SUCCEED="尊敬的【用户姓名】，您好！您的公司认证申请已通过审核。";
	public static final String MESSAGE_ORG_FAILURE="尊敬的【用户姓名】，您好！您的公司认证申请未通过审核。原因：【未通过原因备注】，请重新提交相关证件申请认证。";
	public static final String MESSAGE_SHIPPER_USER_SUCCEED="尊敬的【用户姓名】，您好！您的个人认证申请已通过审核。";
	public static final String MESSAGE_SHIPPER_USER_FAILURE="尊敬的【用户姓名】，您好！您的个人认证申请未通过审核。原因：【未通过原因备注】，请重新提交相关证件申请认证。";
	public static final String MESSAGE_TRUCK_SUCCEED="尊敬的【用户姓名】，您好！您的车辆认证申请已通过审核。";
	public static final String MESSAGE_TRUCK_FAILURE="尊敬的【用户姓名】，您好！您的车辆认证申请未通过审核。原因：【未通过原因备注】，请重新提交相关证件申请认证。";
	public static final String MESSAGE_CERT_VALUE="您好，您的车主信息：";
	public static final Long SYSTEM_USER = 99999L;
	public static final String MESSAGE_SUCCESS_STATUS = "即时，短信消息发送成功！";
	public static final String MESSAGE_FAILE_STATUS = "即时，短信消息发送失败！";
	
	public static final String MESSAGE_TRUCKOWNER_MSG_SUCCESS="尊敬的【用户姓名】您好！您的司机认证申请已通过审核。";
	public static final String MESSAGE_TRUCKOWNER_MSG_FAILURE="尊敬的【用户姓名】您好！您的司机认证申请未通过审核。原因：【未通过原因备注】，请重新提交相关证件申请认证。";
	public static final String MESSAGE_TRUCKOWNER_MSG_FAILURE_NOREMARK="尊敬的【用户姓名】您好！您的司机认证申请未通过审核,请重新提交相关证件申请认证。";
	
}
