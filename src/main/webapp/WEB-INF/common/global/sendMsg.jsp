<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--大弹窗版块 -->
<script src="${ctx}/resources/lib/jquery-1.9.1.min.js"></script>
	<script src="${ctx}/resources/js/common/options.js"></script>
    <script src="${ctx}/resources/js/message.js"></script>
    <script type="text/javascript">
    	jQuery(document).ready(function(){
    		Options();
			Pop();
			SameClose();
    	});
    </script>
<div class="showdialog dialog hide" id="sendMsgDiv">
	<div class="sd-hd">
		<h2 class="sdtit">发送消息</h2>
		<a href="javascript:;" class="close br3 cancelSendMsg" title="点击关闭窗口">X</a>
	</div>
	<div class="sd-bd clearfix">
		<div class="msgto fl">
			<div class="msgsearch">
				<select class="msselect" id="searchType">
					<option value="company">公司</option>
					<option value="contactPerson">联系人</option>
				</select> <input type="text" id="searchText" class="txtbox" value="" />
				<input type="hidden" id="orgId" class="txtbox" value="" />
				<input type="button" class="btn-blue searchTrueName" value="搜索">
			</div>
			<div class="msglist">
				<dl class="mlist" style="width: 300px;">
					<ul id="contactPersonUl">
					</ul>
				</dl>
			</div>
		</div>
		<div class="msginfo fr">
			<div class="msgtype">
				消息类型： <input type="radio" name="messageType"
					class="message_immediate" value="js" checked="checked" /> <label for="msginstant">即时消息</label>
				<input type="radio" name="messageType" class="message_phone"
					value="sj" /> <label for="msgmobile">手机短信</label>
			</div>
			<div class="msgcont">
				<input type="hidden" id="addresseeGroup" /> <input type="hidden"
					id="addresseePhoneGroup" />
				<table class="msgtbl">
					<tr>
						<th>收件人：</th>
						<td><input class="txtbox" value="" type="text" id="addressee"
							readonly="readonly" width="300px;" /></td>
					</tr>
					<tr>
						<th>内容：</th>
						<td><textarea name="" id="content" cols="30" rows="10"
								class="txtbox multibox" placeholder="请输入发送内容……"></textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<p class="fmnoti cl"></p>
		<p class="fmbtm">
			<span class="cancel btn-a-white"><a class="cancelSendMsg"
				href="javascript:;" title="取消">取消</a></span><span
				class="confirm btn-a-blue"><a class="sendMsgClass"
				href="javascript:;" title="发送">发送</a></span>
		</p>
	</div>
	</div>