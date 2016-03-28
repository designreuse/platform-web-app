<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">

	//车型控件
	function loadTruckmodelControl() {
		jQuery.post(window.ctx + "/goodsTruckmodel/control", truckmodelControlCallBack);
	}

	function truckmodelControlCallBack(data) {
		jQuery("#truckmodelList dt").remove();
		jQuery("#truckmodelList dd").remove();
		var truckmodelMap=data['truckmodelMap'];
		var truckmodelStr = "";
		for(var key in truckmodelMap){
			var truckmodelParent=key;
			var truckmodelList=truckmodelMap[key];
			truckmodelStr += '<dt class="lv1 lvshow br"><span class="ftbold">' + truckmodelParent + '</span></dt>';
			truckmodelStr += '<dd class="lv2">';
			for (var j = 0; j < truckmodelList.length; j++) {
				var truckmodel = truckmodelList[j];
				truckmodelStr += '<p><label for="'+truckmodel.id+'" class="tmname">'+ truckmodel.truckModelName + '</label></p>';
			}
			truckmodelStr += '</dd>';
		}

		jQuery("#truckmodelList").append(truckmodelStr);
		lv1tm();
		selectTruckmodel();
	}

	function lv1tm() {
		$("#truckmodelList dt").click(function() {
			//获取最新的数据
			if ($(this).hasClass("lvshow")) {
				
				$(this).removeClass("lvshow");
				$(this).next(".lv2").addClass("hide");
				
			} else {
				$(this).addClass("lvshow");
				$(this).next(".lv2").removeClass("hide");
			}
		});
	}

	var selectTruckmodel = function() {
		$(".truckmodel-choose").click(function() {
			var left = $(this).offset().left;
			var top = $(this).offset().top + 5;
			$(".truckmodel-win").removeClass("hide").css({
				"position" : "absolute",
				"left" : left,
				"top" : top
			});
		});

		$(".truckmodel-win").hover(

		function() {
			$(this).removeClass("hide");
		}, function() {
			$(this).addClass("hide");
		});
		
		$(".truckmodel-choose").blur(function() {

			$(".lv2 .tmname").click(function() {
				$(".truckmodel-choose").val($(this).text());
				$(".truckmodel-chooseId").val($(this).attr("for"));
				$(".truckmodel-win").addClass("hide");
			});
			//获取浏览器在页面上的位置
		});

	}

	jQuery(document).ready(function() {
		loadTruckmodelControl();
		selectTruckmodel();
	});
</script>
<!--获得焦点的时候弹出窗口-->
<div class="truckmodel-win hide" style="z-index:1000;">
  <div class="sd-bd clearfix">
    <div class="msgto fl">
 
      <div class="msglist">
        <dl class="mlist" id="truckmodelList">
          <dt class="lv1 lvshow"><span class="ftbold">普通半挂车</span></dt>
          <dd class="lv2">
            <p><label for="" class="tmname">高栏半挂车</label></p>
            <p><label for="" class="tmname">低栏半挂车</label></p>
          </dd>
          <dt class="lv1 lvshow"><span class="ftbold">特种半挂车</span></dt>
          <dd class="lv2">
            <p><label for="" class="tmname">罐式特种半挂车</label></p>
            <p><label for="" class="tmname">罐式特种半挂车</label></p>
          </dd>
        </dl>
      </div>
    </div>
  </div>
</div>