

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${ctx}/resources/js/common/control/goodsControl.js"></script>
<script type="text/javascript">
 	jQuery(document).ready(function(){
		loadGoodsControl();
		SelectGoods();
 	});
 </script>
<!--获得焦点的时候弹出窗口-->
<div class="goods-win hide" style="z-index:1000;">
  <div class="sd-bd clearfix">
    <div class="msgto fl">
 
      <div class="msglist">
        <dl class="mlist" id="mlist">
          <dt class="lv1 lvshow"><span class="ftbold">煤炭及制品</span></dt>
          <dd class="lv2">
            <p><label for="" class="ckname">焦炭</label></p>
            <p><label for="" class="ckname">原煤</label></p>
            <p><label for="" class="ckname">原煤</label></p>
          </dd>
           <dt class="lv1 lvshow"><span class="ftbold">石油、天然气及制品</span></dt>
          <dd class="lv2">
            <p><label for="" class="ckname">焦炭</label></p>
            <p><label for="" class="ckname">原煤</label></p>
            <p><label for="" class="ckname">原煤</label></p>
          </dd>
        </dl>
      </div>
    </div>
  </div>
</div>
 
	