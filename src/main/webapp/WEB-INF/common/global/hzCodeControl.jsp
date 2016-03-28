

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${ctx}/resources/lib/jquery-1.9.1.min.js"></script>
<script src="${ctx}/resources/js/common/control/goodsControl.js"></script>
<script type="text/javascript">
 	jQuery(document).ready(function(){
 		loadHzCodeControl();
		SelectGoods();
 	});
 </script>
<!--获得焦点的时候弹出窗口-->
<div class="goods-win hide" style="z-index:1000;">
  <div class="sd-bd clearfix">
    <div class="msgto fl">
 
      <div class="msglist">
        <dl class="mlist" id="mlist">
        </dl>
      </div>
    </div>
  </div>
</div>
 
	