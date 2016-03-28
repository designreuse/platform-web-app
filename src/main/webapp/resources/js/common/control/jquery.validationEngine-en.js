(function($){
    $.fn.validationEngineLanguage = function(){
    };
    $.validationEngineLanguage = {
        newLang: function(){
            $.validationEngineLanguage.allRules = {
                "required": { // Add your regex rules here, you can take telephone as an example
                    "regex": "none",
                    "alertText": "* 此为必填字段！",
                    "alertTextCheckboxMultiple": "* Please select an option",
                    "alertTextCheckboxe": "* 当前复选框必选！",
                    "alertTextDateRange": "* Both date range fields are required"
                },
                "requiredInFunction": { 
                    "func": function(field, rules, i, options){
                        return (field.val() == "test") ? true : false;
                    },
                    "alertText": "* Field must equal test"
                },
                "dateRange": {
                    "regex": "none",
                    "alertText": "* 无效的",
                    "alertText2": "日期范围！"
                },
                "dateTimeRange": {
                    "regex": "none",
                    "alertText": "* 无效的 ",
                    "alertText2": "时间范围！"
                },
                "minSize": {
                    "regex": "none",
                    "alertText": "* 至少允许 ",
                    "alertText2": " 字符！"
                },
                "maxSize": {
                    "regex": "none",
                    "alertText": "* 最多允许 ",
                    "alertText2": " 字符！"
                },
            	"groupRequired": {
                    "regex": "none",
                    "alertText": "* 你必须填写以下领域之一",
                    "alertTextCheckboxMultiple": "* Please select an option",
                    "alertTextCheckboxe": "* This checkbox is required"
                },
                "min": {
                    "regex": "none",
                    "alertText": "* 最小值为 "
                },
                "max": {
                    "regex": "none",
                    "alertText": "* 最大值为 "
                },
                "past": {
                    "regex": "none",
                    "alertText": "* Date prior to "
                },
                "future": {
                    "regex": "none",
                    "alertText": "* Date past "
                },	
                "maxCheckbox": {
                    "regex": "none",
                    "alertText": "* 最多允许选择 ",
                    "alertText2": " 复选框！"
                },
                "minCheckbox": {
                    "regex": "none",
                    "alertText": "* 至少选择 ",
                    "alertText2": " 复选框！"
                },
                "equals": {
                    "regex": "none",
                    "alertText": "* 当前字段不能比较！"
                },
                "creditCard": {
                    "regex": "none",
                    "alertText": "* 无效的信用卡号码"
                },
                "phone": {
                    // credit: jquery.h5validate.js / orefalo
                    //"regex": /^([\+][0-9]{1,3}([ \.\-])?)?([\(][0-9]{1,6}[\)])?([0-9 \.\-]{1,32})(([A-Za-z \:]{1,11})?[0-9]{1,4}?)$/,
                	"regex": /^1[3|4|5|8|7][0-9]\d{4,8}$/,
                    "alertText": "* 无效的手机号码！"
                },
                "telphone": {
                    // credit: jquery.h5validate.js / orefalo
                    //"regex": /^([\+][0-9]{1,3}([ \.\-])?)?([\(][0-9]{1,6}[\)])?([0-9 \.\-]{1,32})(([A-Za-z \:]{1,11})?[0-9]{1,4}?)$/,
                	"regex": /^(-|[0-9])*$/,
                    "alertText": "* 无效的手机号码！"
                },
                "email": {
                    // HTML5 compatible email regex ( http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#    e-mail-state-%28type=email%29 )
                    "regex": /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
                    "alertText": "* 无效的邮箱地址！"
                },
                "fullname": {
                    "regex":/^([a-zA-Z]+[\'\,\.\-]?[a-zA-Z ]*)+[ ]([a-zA-Z]+[\'\,\.\-]?[a-zA-Z ]+)+$/,
                    "alertText":"* 必须是第一个和最后一个名称"
                },
                "zip": {
                    "regex":/^\d{0,8}$/,
                    "alertText":"* 无效邮政编码"
                },
                "integer": {
                    "regex": /^[\-\+]?\d+$/,
                    "alertText": "* 不是一个合法的整数！"
                },
                "number": {
                    // Number, including positive, negative, and floating decimal. credit: orefalo
                    "regex": /^[\-\+]?((([0-9]{1,3})([,][0-9]{3})*)|([0-9]+))?([\.]([0-9]+))?$/,
                    "alertText": "* 无效的浮点数"
                },
                "date": {                    
                    //	Check if date is valid by leap year
			  "func": function (field) {
					var pattern = new RegExp(/^(\d{4})[\/\-\.](0?[1-9]|1[012])[\/\-\.](0?[1-9]|[12][0-9]|3[01])$/);
					var match = pattern.exec(field.val());
					if (match == null)
					   return false;
	
					var year = match[1];
					var month = match[2]*1;
					var day = match[3]*1;					
					var date = new Date(year, month - 1, day); // because months starts from 0.
	
					return (date.getFullYear() == year && date.getMonth() == (month - 1) && date.getDate() == day);
				},                		
			   "alertText": "* Invalid date, must be in YYYY-MM-DD format"
                },
                "ipv4": {
                    "regex": /^((([01]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))[.]){3}(([0-1]?[0-9]{1,2})|(2[0-4][0-9])|(25[0-5]))$/,
                    "alertText": "* Invalid IP address"
                },
                "url": {
                    "regex": /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i,
                    "alertText": "* 无效的URL, 必须以http/https/ftp等开头"
                },
                "onlyNumberSp": {
                    "regex": /^[0-9\ ]+$/,
                    "alertText": "* 只能输入数字"
                },
                "onlyLetterSp": {
                    "regex": /^[a-zA-Z\ \']+$/,
                    "alertText": "* 只允许字母"
                },
                "onlyLetterNumber": {
                    "regex": /^[0-9a-zA-Z]+$/,
                    "alertText": "* No special characters allowed"
                },
                // --- CUSTOM RULES -- Those are specific to the demos, they can be removed or changed to your likings
                "ajaxUserCall": {
                    "url": "ajaxValidateFieldUser",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=eric",
                    "alertText": "* This user is already taken",
                    "alertTextLoad": "* Validating, please wait"
                },
				"ajaxUserCallPhp": {
                    "url": "phpajax/ajaxValidateFieldUser.php",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=eric",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* This username is available",
                    "alertText": "* This user is already taken",
                    "alertTextLoad": "* Validating, please wait"
                },
                   //验证计量单位编码
				"ajaxMeasureunitCall": {
                    "url": window.ctx+"/measureunit/onlyUnitNo",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=entity.unitCode",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* 当前的值可用！",
                    "alertText": "* 对不起，该值已经存在！",
                    "alertTextLoad": "* Validating, please wait..."
                },   //验证个人身份证
				"ajaxIdentityCall": {
                    "url": window.ctx+"/certManage/onlyIdentity",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=idcertificate",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* 当前的值可用！",
                    "alertText": "* 对不起，该值已经存在！",
                    "alertTextLoad": "* Validating, please wait..."
                },
                "ajaxLicenceCall": {
                	"url": window.ctx+"/certManage/onlyCode?target=licence",
                	// you may want to pass extra data on the ajax call
                	"extraData": "name=licencertificate",
                	// if you provide an "alertTextOk", it will show as a green prompt when the field validates
                	"alertTextOk": "* 当前的值可用！",
                	"alertText": "* 对不起，该值已经存在！",
                	"alertTextLoad": "* Validating, please wait..."
                },
                "ajaxTaxRegCertificateCall": {
                	"url": window.ctx+"/certManage/onlyCode?target=taxRegCertificate",
                	// you may want to pass extra data on the ajax call
                	"extraData": "name=taxcertificate",
                	// if you provide an "alertTextOk", it will show as a green prompt when the field validates
                	"alertTextOk": "* 当前的值可用！",
                	"alertText": "* 对不起，该值已经存在！",
                	"alertTextLoad": "* Validating, please wait..."
                },
                "ajaxOrgCodeCertificateCall": {
                	"url": window.ctx+"/certManage/onlyCode?target=orgCodeCertificate",
                	// you may want to pass extra data on the ajax call
                	"extraData": "name=orgcertificate",
                	// if you provide an "alertTextOk", it will show as a green prompt when the field validates
                	"alertTextOk": "* 当前的值可用！",
                	"alertText": "* 对不起，该值已经存在！",
                	"alertTextLoad": "* Validating, please wait..."
                },
                "ajaxDriverLicenseCall": {
                	"url": window.ctx+"/truckOwnerCert/onlyCode?target=driverLicense",
                	// you may want to pass extra data on the ajax call
                	"extraData": "name=driverLicense",
                	// if you provide an "alertTextOk", it will show as a green prompt when the field validates
                	"alertTextOk": "* 当前的值可用！",
                	"alertText": "* 对不起，该值已经存在！",
                	"alertTextLoad": "* Validating, please wait..."
                },
                "ajaxQualificationLicenseCall": {
                    "url": window.ctx+"/truckOwnerCert/onlyCode?target=qualificationLicense",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=qualificationLicense",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* 当前的值可用！",
                    "alertText": "* 对不起，该值已经存在！",
                    "alertTextLoad": "* Validating, please wait..."
                },
                "ajaxHzQualificationLicenseCall": {
                    "url": window.ctx+"/truckOwnerCert/onlyCode?target=hzQualificationLicense",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=hzQualificationLicense",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* 当前的值可用！",
                    "alertText": "* 对不起，该值已经存在！",
                    "alertTextLoad": "* Validating, please wait..."
                },
                "ajaxTruckLicenseNoCall": {
                	"url": window.ctx+"/truckCert/onlyCode?target=truckLicenseNo",
                	// you may want to pass extra data on the ajax call
                	"extraData": "name=truckLicenseNo",
                	// if you provide an "alertTextOk", it will show as a green prompt when the field validates
                	"alertTextOk": "* 当前的值可用！",
                	"alertText": "* 对不起，该值已经存在！",
                	"alertTextLoad": "* Validating, please wait..."
                },
                "ajaxDrivingLicenseNoCall": {
                	"url": window.ctx+"/truckCert/onlyCode?target=drivingLicenseNo",
                	// you may want to pass extra data on the ajax call
                	"extraData": "name=drivingLicenseNo",
                	// if you provide an "alertTextOk", it will show as a green prompt when the field validates
                	"alertTextOk": "* 当前的值可用！",
                	"alertText": "* 对不起，该值已经存在！",
                	"alertTextLoad": "* Validating, please wait..."
                },
                "ajaxOperateLicenseNoCall": {
                	"url": window.ctx+"/truckCert/onlyCode?target=operateLicenseNo",
                	// you may want to pass extra data on the ajax call
                	"extraData": "name=operateLicenseNo",
                	// if you provide an "alertTextOk", it will show as a green prompt when the field validates
                	"alertTextOk": "* 当前的值可用！",
                	"alertText": "* 对不起，该值已经存在！",
                	"alertTextLoad": "* Validating, please wait..."
                },

                //验证行业编码
				"ajaxIndustryCodeCall": {
                    "url": window.ctx+"/industry/onlyCode",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=entity.code",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* 当前的值可用！",
                    "alertText": "* 对不起，该值已经存在！",
                    "alertTextLoad": "* Validating, please wait..."
                },
              //验证个人诚信等级唯一性
				"ajaxCreditLevelCall": {
                    "url": window.ctx+"/creditLevelValue/onlyLevel",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=entity.level",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* 当前的值可用！",
                    "alertText": "* 对不起，该值已经存在！",
                    "alertTextLoad": "* Validating, please wait..."
                },
              //验证组织诚信等级唯一性
				"ajaxOrgCreditLevelCall": {
                    "url": window.ctx+"/creditLevelValueOrg/onlyLevel",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=entity.level",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* 当前的值可用！",
                    "alertText": "* 对不起，该值已经存在！",
                    "alertTextLoad": "* Validating, please wait..."
                },
                //验证危险品编码
				"ajaxHzCodeCall": {
                    "url": window.ctx+"/hzCode/onlyCode",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=entity.hzCode",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* 当前的值可用！",
                    "alertText": "* 对不起，该值已经存在！",
                    "alertTextLoad": "* Validating, please wait..."
                },
                //验证标准业务编码类型编码
				"ajaxTypeCodeCall": {
                    "url": window.ctx+"/codeType/onlyCode",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=entity.typeCode",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* 当前的值可用！",
                    "alertText": "* 对不起，该值已经存在！",
                    "alertTextLoad": "* Validating, please wait..."
                },
                //验证标准业务编码，编码是否唯一
				"ajaxCodeCall": {
                    "url": window.ctx+"/code/onlyCode",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=entity.code",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* 当前的值可用！",
                    "alertText": "* 对不起，该值已经存在！",
                    "alertTextLoad": "* Validating, please wait..."
                },
                //验证认证体系编码，编码是否唯一
				"ajaxCertSystemCodeCall": {
                    "url": window.ctx+"/certSystem/onlyCode",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=entity.systemCode",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* 当前的值可用！",
                    "alertText": "* 对不起，该值已经存在！",
                    "alertTextLoad": "* Validating, please wait..."
                },
                   //验证计量单位编码
				"ajaTruckBrandCodeCall": {
                    "url": window.ctx+"/truckBrand/validationCodeExact",
                    // you may want to pass extra data on the ajax call
                    "extraData": "name=entity.code",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* 当前的值可用！",
                    "alertText": "* 对不起，该值已经存在！",
                    "alertTextLoad": "* Validating, please wait..."
                },
                "ajaxNameCall": {
                    // remote json service location
                    "url": "ajaxValidateFieldName",
                    // error
                    "alertText": "* This name is already taken",
                    // if you provide an "alertTextOk", it will show as a green prompt when the field validates
                    "alertTextOk": "* This name is available",
                    // speaks by itself
                    "alertTextLoad": "* Validating, please wait"
                },
				 "ajaxNameCallPhp": {
	                    // remote json service location
	                    "url": "phpajax/ajaxValidateFieldName.php",
	                    // error
	                    "alertText": "* This name is already taken",
	                    // speaks by itself
	                    "alertTextLoad": "* Validating, please wait"
	                },
                "validate2fields": {
                    "alertText": "* Please input HELLO",
                     "alertText1": "* 此为必选字段！",
                     "alertText2": "* 该值已经存在！",
                     "alertText3": "* 当前值有效！"
                },
	            //tls warning:homegrown not fielded 
                "dateFormat":{
                    "regex": /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(?:(?:0?[1-9]|1[0-2])(\/|-)(?:0?[1-9]|1\d|2[0-8]))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(0?2(\/|-)29)(\/|-)(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\d\d)?(?:0[48]|[2468][048]|[13579][26]))$/,
                    "alertText": "* Invalid Date"
                },
                //tls warning:homegrown not fielded 
				"dateTimeFormat": {
	                "regex": /^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1}$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^((1[012]|0?[1-9]){1}\/(0?[1-9]|[12][0-9]|3[01]){1}\/\d{2,4}\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1})$/,
                    "alertText": "* Invalid Date or Date Format",
                    "alertText2": "Expected Format: ",
                    "alertText3": "mm/dd/yyyy hh:mm:ss AM|PM or ", 
                    "alertText4": "yyyy-mm-dd hh:mm:ss AM|PM"
	            },
	            //身份证
	            "isIdCardNo":{
	            	// "regex1": /^\d{15}|(\d{17}(\d|x|X))$/,
	            	// "regex1": /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/,
	            	// "regex2": /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/,
	            	 "regex1": /^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/,
	            	 "regex2": /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X|x)$/,
	            	 "alertText":"请输入有效的身份证号！",
	            	 "alertText1":"* 身份证字段必填！"
	               },
	            //驾驶证
	            "isDriverNo":{
	            	"regex1": /^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/,
	            	"regex2": /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X|x)$/,
	            	"alertText":"请输入有效的驾驶证号！",
	            	"alertText1":"* 驾驶证号字段必填！"
	            }
                };
        }
    };
    $.validationEngineLanguage.newLang();
    
})(jQuery);  
//对当前的form表单进行验证
jQuery(document).ready(function(){
	 var formId=$("form").attr("id");
	 jQuery("#"+formId).validationEngine();
});