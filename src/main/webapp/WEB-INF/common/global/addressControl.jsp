<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">

	var parent;
	function requestAddressList(addressName) {
		var post_data = 'name=' + addressName;
		$.ajax({
			type : "Post",
			url : "${ctx}/area/ajax/address", //方法所在页面和方法名
			cache : false,
			data : post_data,
			dataType : "json", //返回值类型
			complete : function(info) {

			},
			success : function(data) {
				//获取返回参数
				//codeTypeList = data['addressList'];
				//渲染数据
				renderAddressData(data);
			},
			error : function(data) {
				renderAddressError();
			}
		});
	}
	function requestAddressName(provinceCode,cityCode,areaCode){
		//直接用$.post的话，controller返回值前需要加上@ResponseBody，如果用$.ajax可以不用加
 		$.post("${ctx}/area/ajax/addressName",{'provinceCode':provinceCode,'cityCode':cityCode,'areaCode':areaCode},function(data){
			var provinceName = data['provinceName'];
			var cityName = data['cityName'];
			var areaName = data['areaName'];
			var addressName="";
			if(""!=provinceName){
				addressName+=provinceName;
			}
			if(""!=cityName){
				addressName+=" "+cityName;
			}
			if(""!=areaName){
				addressName+=" "+areaName;
			}
			return addressName;
		}); 
/* 		$.ajax({
			type : "Post",
			url : "${ctx}/area/ajax/addressName", //方法所在页面和方法名
			cache : false,
			data : {'provinceCode':provinceCode,'cityCode':cityCode,'areaCode':areaCode},
			dataType : "json", //返回值类型
			success : function(data) {
				var provinceName = data['provinceName'];
				var cityName = data['cityName'];
				var areaName = data['areaName'];
				var addressName="";
				if(""!=provinceName){
					addressName+=provinceName;
				}
				if(""!=cityName){
					addressName+=" "+cityName;
				}
				if(""!=areaName){
					addressName+=" "+areaName;
				}
				return addressName;
			},
		}); */
	}

	//渲染内容
	function renderAddressData(data) {
		$(".address-ul li").remove();
		var dataList = data['addressList'];
		if (null == dataList) {
			return;
		}
		if (dataList.length <= 0) {
			renderAddressError();
			return;
		}
		var length = dataList.length;
		for ( var i = 0; i < length; i++) {
			myobject = dataList[i];
			addressName = "";
			addressCode = "";
			if ("" != myobject.provinceName) {
				addressName += myobject.provinceName;
			}
			if ("" != myobject.cityName) {
				addressName += "-" + myobject.cityName;
			}
			if ("" != myobject.areaName) {
				addressName += "-" + myobject.areaName;
			}
			if ("" != myobject.provinceCode) {
				addressCode += myobject.provinceCode;
			}
			if ("" != myobject.cityCode) {
				addressCode += "-" + myobject.cityCode;
			}
			if ("" != myobject.areaCode) {
				addressCode += "-" + myobject.areaCode;
			}
			/*         if(""!=myobject.pinyin){
			        	addressName+=" ("+myobject.pinyin.toLowerCase()+")";
			        } */
			$(".address-ul").append("<li onclick='addressliclick(\""+addressCode+"\",\""+addressName+"\")'>" + addressName + "</li>");
		}
	}
	
	function addressliclick(addressCode,addressName){
		parent.value=addressName;
		var provinceCode="";
		var cityCode="";
		var areaCode="";
		var provinceName="";
		var cityName="";
		var areaName="";
		var addressCodeList=addressCode.split('-');
		provinceCode=addressCodeList[0];
		if(addressCodeList.length>1){
			cityCode=addressCodeList[1];
		}
		if(addressCodeList.length>2){
			areaCode=addressCodeList[2];
		}
		var addressNameList=addressName.split('-');
		provinceName=addressNameList[0];
		if(addressNameList.length>1){
			cityName=addressNameList[1];
		}
		if(addressNameList.length>2){
			areaName=addressNameList[2];
		}

		if($(parent).nextAll(".provinceName").length>0){
			$(parent).nextAll(".provinceName")[0].value=provinceName;
		}
		if($(parent).nextAll(".provinceCode").length>0){
			$(parent).nextAll(".provinceCode")[0].value=provinceCode;
		}
		if($(parent).nextAll(".cityName").length>0){
			$(parent).nextAll(".cityName")[0].value=cityName;
		}
		if($(parent).nextAll(".cityCode").length>0){
			$(parent).nextAll(".cityCode")[0].value=cityCode;
		}
		if($(parent).nextAll(".areaName").length>0){
			$(parent).nextAll(".areaName")[0].value=areaName;
		}
		if($(parent).nextAll(".areaCode").length>0){
			$(parent).nextAll(".areaCode")[0].value=areaCode;
		}
		$("#address-keyup").addClass("hide");
	}

	//错误提示
	function renderAddressError() {
		$(".address-ul li").remove();
		$(".address-ul").append("<li>对不起，没有找到匹配数据</li>");
	}

	function initAddress() {
		
		$(".address-choose").click(function(event) {
			$("#address-keyup").addClass("hide");
			//$("#addressForm")[0].reset();
			$(this).select();
			var left = $(this).offset().left;
			var top = $(this).offset().top + $(this).height();
            if($("#address-click").hasClass("hide")){
                $("#address-click").removeClass("hide").css({
                    "position" : "absolute",
                    "left" : left,
                    "top" : top
                });
            }
			event.stopPropagation();
			parent=this;
			//$("#provinceId").get(0).selectedindex=0;
			$("#provinceId")[0].options[0].selected = true;
			$("#cityId").empty();
			$("#areaId").empty();
		});
		
		$("#address-click .provinceId").change(function(){
			//文本框中填入name
			//parent.value=this.selectedOptions[0].text;
			var provinceName=$("#address-click .provinceId option:selected").text();
			parent.value=provinceName;
			//在文本框中的兄弟节点填入值
			if($(parent).nextAll(".provinceName").length>0){
				$(parent).nextAll(".provinceName")[0].value=provinceName;
			}
			//在文本框中的兄弟节点填入code
			if($(parent).nextAll(".provinceCode").length>0){
				$(parent).nextAll(".provinceCode")[0].value=this.value;
			}
			
			if($(parent).nextAll(".cityName").length>0){
				$(parent).nextAll(".cityName")[0].value="";
			}
			if($(parent).nextAll(".cityCode").length>0){
				$(parent).nextAll(".cityCode")[0].value="";
			}
			if($(parent).nextAll(".areaName").length>0){
				$(parent).nextAll(".areaName")[0].value="";
			}
			if($(parent).nextAll(".areaCode").length>0){
				$(parent).nextAll(".areaCode")[0].value="";
			}
		});
		
		$("#address-click .cityId").change(function(){
			//文本框中填入name
			var provinceName=$("#address-click .provinceId option:selected").text();
			var cityName=$("#address-click .cityId option:selected").text();
			parent.value=provinceName+"-"+cityName;
			//在文本框中的兄弟节点填入值
			if($(parent).nextAll(".cityName").length>0){
				$(parent).nextAll(".cityName")[0].value=cityName;
			}
			//在文本框中的兄弟节点填入code
			if($(parent).nextAll(".cityCode").length>0){
				$(parent).nextAll(".cityCode")[0].value=this.value;
			}
			if($(parent).nextAll(".areaName").length>0){
				$(parent).nextAll(".areaName")[0].value="";
			}
			if($(parent).nextAll(".areaCode").length>0){
				$(parent).nextAll(".areaCode")[0].value="";
			}
		});
		
		$("#address-click .areaId").change(function(){
			//文本框中填入name
			var provinceName=$("#address-click .provinceId option:selected").text();
			var cityName=$("#address-click .cityId option:selected").text();
			var areaName=$("#address-click .areaId option:selected").text();
			parent.value=provinceName+"-"+cityName+"-"+areaName;
			//在文本框中的兄弟节点填入值
			if($(parent).nextAll(".areaName").length>0){
				$(parent).nextAll(".areaName")[0].value=areaName;
			}
			//在文本框中的兄弟节点填入code
			if($(parent).nextAll(".areaCode").length>0){
				$(parent).nextAll(".areaCode")[0].value=this.value;
			}
		});
		
		$(".address-choose").keyup(function() {
			$("#address-click").addClass("hide");
			var address=parent.value;
			if(null==address||""==address){
				if($(parent).nextAll(".provinceName").length>0){
					$(parent).nextAll(".provinceName")[0].value="";
				}
				//在文本框中的兄弟节点填入code
				if($(parent).nextAll(".provinceCode").length>0){
					$(parent).nextAll(".provinceCode")[0].value="";
				}
				
				if($(parent).nextAll(".cityName").length>0){
					$(parent).nextAll(".cityName")[0].value="";
				}
				if($(parent).nextAll(".cityCode").length>0){
					$(parent).nextAll(".cityCode")[0].value="";
				}
				if($(parent).nextAll(".areaName").length>0){
					$(parent).nextAll(".areaName")[0].value="";
				}
				if($(parent).nextAll(".areaCode").length>0){
					$(parent).nextAll(".areaCode")[0].value="";
				}
				return;
			}
			requestAddressList(this.value);
			var left = $(this).offset().left;
			var top = $(this).offset().top + $(this).height();
			$("#address-keyup").removeClass("hide").css({
				"position" : "absolute",
				"left" : left,
				"top" : top
			});
		});
		
		$(".address-win").click(function(event) {
			event.stopPropagation();
		});
		
		$("html").click(function() {
			$(".address-win").addClass("hide");
		});
	}

	jQuery(document).ready(function() {
		init(0, 0, 0, 'address');
		initAddress();
	});
</script>

<!--输入时弹出窗口-->
<div id="address-keyup" class="address-win hide" style="z-index: 4001;">
	<div class="sd-bd clearfix">
		<div class="msgto fl">
			<div class="msglist address">
				<ul class="address-ul">

				</ul>
			</div>
		</div>
	</div>
</div>

<!--获得焦点的时候弹出窗口-->
<div id="address-click" class="address-win hide" style="z-index: 4000;">
	<div class="sd-bd clearfix">
		<div class="msgto fl">
			<div class="msglist address">
				<form id="addressForm" class="addressFromSelect">
					<table>
						<tr>
							<th>省份：</th>
							<td><select id="provinceId" name="province"
								class="provinceId"></select></td>
						</tr>
						<tr>
							<th>城市：</th>
							<td><select id="cityId" name="city" class="cityId"></select></td>
						</tr>
						<tr>
							<th>区县：</th>
							<td><select id="areaId" name="county" class="areaId"></select></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>