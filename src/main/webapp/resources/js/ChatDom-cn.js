/**
 * 常量定义
 */
//收到消息时高度提示
var MESSAGE_HIGH_LIGHT_CLASS = "ct-hl";
//消息面板折叠后的样式
var CHAT_TOP_FOLD_CLASS = "chat-fold";
/*
 * 聊天Dom基本介绍
 *
 * 所有字段用${xxx}替代
 *
 * xxx可包含xxx:type:format
 *
 * type为类型，包含html, string, date，int，可不填
 * format为格式化分type表示，
 *    date为yyyy-MM-dd hh:mm:ss
 *    int为99+ 1-等，表示最多表示99，
 *    event 触发事件
 *
 * ps: format的冒号采用 html转义 &#58;
 */

/*************************************************************************
 * 聊天基本结构
 *
 * 包含 char_all
 ************************************************************************/

/* 聊天基本结构
 *
 * ${my_nickname:string} 我的昵称 可选
 * ${myavatar_url:string} 我的头像 可选
 * ${chat_status:html} 用户的在线状态，前后不允许出现别的元素
 * ${chat_lately:html} 最近聊天记录节点
 * ${user_list:html} 用户列表节点
 */
var chat_all ='<!-- S: rl-chat-widget -->\
              <div class="rl-chat-widget chat-fold">\
              <!-- chat top -->\
                <div class="chat-top">\
                    <i class="ico-msg"></i><i>${chat_status:html}</i>消息中心<strong class="unread">${ms_center_unread_total:int}</strong><i class="ico-arrow-toggle"></i>\
                </div>\
              <!-- chat center -->\
                <div class="chat-center">\
                    <!-- chat tab -->\
                    <div class="chat-tab">\
                        <a href="javascript:;"  class="lately focus" title="最近会话"><i class="ico-lately"></i>最近会话<strong class="unread">${lately_unread_total:int}</strong></a>\
                        <a href="javascript:;"  class="all-contact" title="通讯录"><i class="ico-contact"></i>通讯录</a>\
                    </div>\
                    <!-- chat tab content -->\
                    <div class="chat-tab-content">\
                        <!-- lately chat -->\
                        <div class="lately-chat">\
                            ${chat_lately:html} \
                        </div> \
                        <!-- contact book -->\
                        <div class="contact-book hide"> \
                            ${user_list:html} \
                        </div> \
                    </div> \
                </div> \
              <!-- chat footer -->\
                <div class="chat-footer">\
                    <p class="to-msg-center"><a href="" class="hide"><span class="simsun">&gt;</span> 去消息中心</a></p>\
                </div>\
              <!-- chat dialog -->\
                <div class="chat-dialog">\
                    ${chat_panel:html} \
                </div>\
              </div>';

/*************************************************************************
 * 在线状态结构
 ************************************************************************/

/**
 * 离线状态
 */
var user_offline = '<i class="ico-dot-offline" title="当前离线"></i>';

/**
 * 在线状态
 */
var user_online = '<i class="ico-dot-online" title="当前在线"></i>';

/**
 * 有新消息
 */
var user_news = '<i class="ico-dot-red" title="有新消息" >';

/*************************************************************************
 * 最近会话结构
 ************************************************************************/
/* 最近会话
 *
 * ${chat_lately_cell:html} 最近会话Cell
 */
var chat_lately = '<ul class="lclist"> \
                       ${chat_lately_cell:html} \
                     </ul>';

/* 最近会话Cell
 *
 * ${chat_date:date} 聊天时间
 * ${chat_to_name:string} 对话用户名或群名或讨论组名
 * ${chat_content:string} 聊天内容
 * ${chat_unread_num:int} 未读数
 * ${open_chat_window:event} 打开聊天窗体
 */
var chat_lately_cell = '<li onclick="${open_chat_window:event}"> \
                                <img src="${chat_to_avatar}" alt="" class="avatar" /> \
                                <p class="lctop"> \
                                    <span class="lctime">${chat_date:date:hh&#58;mm}</span>\
                                    <span class="to_name">${chat_to_name:string}</span> \
                                </p> \
                                <p class="lcdesp" > \
                                    <span class="msgdigest">${chat_content:string}</span> \
                                    <strong class="unread">${chat_unread_num:int:99+}</strong> \
                                </p> \
                            </li>';

/*************************************************************************
 * 用户列表结构（包含群结构）
 ************************************************************************/

/* 用户列表
 *
 * ${chat_lately_cell:html} 最近会话Cell
 */
var user_list = '<ul class="cblist"> \
                       ${user_list_cell} \
                   </ul>';

/* 用户列表Cell
 *
 * ${friend_group_name:string} 最近会话Cell
 * ${user_list_people_cell} 用户列表好友列表cell
 * ${num} 好友或群数目
 */
var user_list_cell = '<li class="group rl-fold"> \
                            <span class="groupname"> \
                                <i class="ico-drop"></i>\
                                <span>${friend_group_name:string}</span> \
                                <span class="total">${num:int}</span>\
                            </span> \
                            <ul class="people"> \
                                ${user_list_people_cell:html} \
                            </ul> \
                         </li>';


/**
 * 用户列表
 *
 * ${avatar:string} 用户或群头像
 * ${name:string} 用户名或群名字
 * ${description:string} 用户签名或群描述
 */
var user_list_people_cell = '<li onclick="${open_chat_window:event}"> \
                                    <img class="avatar" src="${avatar:string}" alt=""  /> \
                                    <p class="lctop">${name:string}</p> \
                                    <p class="lcdesp"><span class="msgdigest hide">${description:string}</span> \
                                    </p> \
                                 </li>';

/*************************************************************************
 * 聊天对话框结构
 ************************************************************************/
/**
 * 聊天对话框
 *
 * ${chat_panel_tab:html} 聊天tab （可选）
 * ${chat_panel_title:html} 聊天标题
 * ${chat_panel_content:html} 聊天内容
 * ${chat_panel_saying:html} 聊天输入区域
 */

var chat_panel = '<div class="chat-item"> \
                            <span class="chat-with"> \
                                ${chat_panel_tab:html}\
                            </span>\
                            <div class="chat-content"> \
                                <div class="chat-tit clearfix"> \
                                    ${chat_panel_title:html} \
                                </div> \
                                <div class="content-show"> \
                                    ${chat_panel_conversation:html}\
                                </div> \
                            <div class="content-saying"> \
                                ${chat_panel_saying:html} \
                            </div>\
                     </div>';

/**
 * ${opposite_nickname:string} 聊天对方的名称
 *
 */
var chat_tab = '<i class="ico-dot-online" title="当前在线"></i> \
                 <span>${opposite_nickname:string}</span> \
               <i class="ico-close" title="关闭"></i>';

/**
 * 聊天窗体标题
 *
 * ${nickname:string} 聊天窗体标题
 */
var chat_panel_title = '<span class="chat-with">您当前正与<span class="chat-to-name">${nickname:string}</span>会话中</span> \
                            <span class="chat-opr"> \
                            <i class="ico-min" title="最小化"></i>\
                            <i class="ico-close" title="关闭"></i>\
                           </span>';


/**
 * 聊天窗体内容中的查看更多
 * ${data_page_index}
 */
var chat_panel_content_more = '<em class="msg-more" data-page-index="${data_page_index}" onclick="${get_more_record:event}">查看更多</em>';


var chat_panel_conversation = '<div class="conversation">\
                                    <p class="load-more">\
                                             ${chat_panel_content_more:html}\
                                    </p>\
                                    <ul class="msg-list"> \
                                        ${chat_panel_content_cell:html} \
                                    </ul>\
                                  </div>';
/**
 * 自己的聊天Cell
 *
 * ${avatar:string} 自己的头像
 * ${name:string} 自己的名字
 * ${content_element:string} 自己说的内容
 */
var chat_panel_content_cell_myself = '<li class="myself"> \
                                            <img src="${avatar:string}" alt="" class="msg-avatar"> \
                                            <div class="msg-box"> \
                                                <p class="msg-hd"><span class="msg-by">${name:string}</span><span class="msg-sending-time">${send_time:date:yyyy-MM-dd&#160;hh&#58;mm&#58;ss}</span></p>\
                                                <pre>${content_element}</pre> \
                                            </div> \
                                           </li>';

/**
 * 对方的聊天Cell
 *
 * ${avatar:string} 对方的头像
 * ${name:string} 对方的名字
 * ${send_time:date}消息时间
 * ${content_element:string} 对方说的内容
 */
var chat_panel_content_cell_others = '<li> \
                                            <img src="${avatar:string}" alt="" class="msg-avatar"> \
                                            <div class="msg-box"> \
                                             <p class="msg-hd"><span class="msg-by">${name:string}</span><span class="msg-sending-time">${send_time:date:yyyy-MM-dd&#160;hh&#58;mm&#58;ss}</span></p>\
                                                <pre>${content_element}</pre> \
                                            </div> \
                                          </li>';

/**
 * 聊天文本内容部分
 *
 * ${send_status_cell:string} 发送状态
 * ${text_content:string} 文本内容
 */
var chat_panel_content_cell_string_ele = '${send_status_cell}${text_content:string}';

/**
 * 聊天图片内容部分
 *
 *  ${image_url:string} 图片url
 *  ${send_status_cell:string} 发送状态
 */
var chat_panel_content_cell_image_ele = '${send_status_cell}\
                                              <img src="${image_url:string}">';


/**
 * 发送成功内容
 *
 *  ${send_status} 发送状态占位符
 */
var chat_panel_content_cell_send_loading = '<i title="发送中" onclick="${resend_msg:event}" class="ico-loading" >${send_status:string}</i>';

/**
 * 发送失败内容
 *
 *  ${send_status} 发送状态占位符
 */
var chat_panel_content_cell_send_fail = '<i title="发送失败" onclick="${resend_msg:event}" class="ico-fail" >${send_status:string}</i>';

/**
 * 发送输入框
 *
 * ${send_msg:event:click} 发送信息
 * ${chat_emoji_container:html} emoji容器位置html
 * ${input_content} 输入控件
 */
var chat_panel_saying = '<div class="input-content"> \
                                <div class="msg-area" contenteditable="true">${input_content}</div> \
                            </div> \
                            <div class="opr-content clearfix"> \
                                <div class="toolbar"> \
                                    <a href class="send-emoji" title="发送表情"><i class="ico-emoji"></i></a>\
                                    <a href="javascript:;" class="send-img" title="发送图片"><input type="file" accept="image/*" name="" id="" class="transparent" onchange="${chat_upload_image:event:change}"><i class="ico-img"></i></a>\
                                    <div class="emoji-wrap hide"> \
                                        ${chat_emoji_container:html} \
                                    </div> \
                                </div> \
                                <a href="javascript:;" class="sendmsg" onclick="${send_msg:event:click}" title="您也可以按Enter键发送消息">发送</a> \
                            </div>';

/*************************************************************************
 * Emoji 部分结构
 ************************************************************************/
/**
 * 聊天emoji容器
 * <div class="emobox"> \
 <div class="emolist"> \
 <img src="../img/emoji/tuzki/21.gif" alt="" title="扭脖子">
 </div>
 </div>
 * ${emoji_table:html} 表情集合
 */
var chat_emoji_container = '<div class="emobox">\
                                  <div class="emo">\
                                      <div class="emo-split">\
                                        ${emoji_table:html}\
                                      </div>\
                                  </div>\
                              </div>';

/**
 * emoji cell
 *
 * ${emoji_select:event} 单击表情动作事件
 */
var emoji_ele = '<a  href="javascript:;" onclick="${emoji_select:event}"></a>';

/**
 * emoji 图片
 *
 */
var emoji_image = '<img />';


/*****************************************************************************************
 * 待办事项结构
 ******************************************************************************************/
/**
 *
 * @type {string}
 */
var todo_panel = '<div class="chat-item">\
                        <span class="chat-with"><i class="ico-dot-online" title="当前在线"></i>待办事项<i class="ico-close" title="关闭"></i></span>\
                        <!-- chat content -->\
                        <div class="chat-content">\
                            <div class="chat-tit clearfix">\
                                <span class="chat-with">待办事项</span>\
                                <span class="chat-opr">\
                                    <i class="ico-min" title="最小化"></i><i class="ico-close" title="关闭"></i>\
                                </span>\
                            </div>\
                            <div class="content-show official-content">\
                                ${todo_panel_conversation:html}\
                            </div>\
                        </div>\
                    </div>';

var todo_panel_conversation = '<div class="conversation">\
                                        ${todo_item:html}\
                                  </div>';
/**
 * 代码事项基础结构
 *
 * ${todo_title:string} 待办事项标题
 * ${todo_date:date:yyyy-MM-dd hh&#58;mm&#58;ss} 时间
 * ${todo_content:html} 内容
 * ${todo_operation:html} 操作区域
 */
var todo_item = '<div class="todo-list">\
                    <p class="todo-hd">\
                        <span class="todo-type">${todo_title:string}</span>\
                        <span class="time fr">${todo_date:date:yyyy-MM-ddhh&#58;mm&#58;ss}</span>\
                    </p>\
                    <p class="todo-bd">\
                        ${todo_content:html}\
                    </p>\
                    <p class="todo-ft">\
                        ${todo_operation:html}\
                    </p>\
                  </div>';

/**
 * 代码事项处理结果
 *
 * ${result_name:string} 操作处理结果
 */
var todo_result = '<span class="todo-result">${result_name:string}</span>';

/**
 * 代码事项按钮容器
 *
 * ${todo_button_set:html} 操作按钮集合
 */
var todo_buttons = '<span class="buttons">${todo_button_set:html}</span>';

/**
 * 代码事项按钮
 *
 * ${action_name:string} 按钮显示名字
 * ${todo_action:event} 按钮点击事件
 */
var todo_button = '<a href="javascript:;" class="btn-agree" onclick="${todo_action:event}">${action_name:string}</a>';

/**********************************************************************************************************************
 *                                                消息提醒结构
 *********************************************************************************************************************/

var notice_panel = '<div class="chat-item">\
                        <span class="chat-with"><i class="ico-dot-online" title="当前在线"></i>消息提醒<i class="ico-close" title="关闭"></i></span>\
                        <!-- chat content -->\
                        <div class="chat-content">\
                            <div class="chat-tit clearfix">\
                                <span class="chat-with">消息提醒</span>\
                                <span class="chat-opr">\
                                    <i class="ico-min" title="最小化"></i><i class="ico-close" title="关闭"></i>\
                                </span>\
                            </div>\
                            <div class="content-show official-content">\
                               ${notice_panel_conversation:html}\
                            </div>\
                        </div>\
                     </div>';

var notice_panel_conversation = '<div class="conversation">\
                                        <p class="load-more">\
                                           ${chat_panel_content_more:html}\
                                        </p>\
                                        <ul class="msg-list"> \
                                           ${chat_panel_content_cell:html} \
                                        </ul>\
                                      </div>';

/**
 * 消息提醒的聊天Cell
 *
 * ${avatar:string} 消息提醒的头像
 * ${name:string} 消息提醒的名字
 * ${send_time:date} 消息时间
 * ${content_element:string} 消息提醒说的内容
 */
var notice_all = '<li> \
                        <img src="${avatar:string}" alt="" class="msg-avatar"> \
                        <div class="msg-box"> \
                            <p class="msg-hd"><span class="msg-by">${name:string}</span><span class="msg-sending-time">${send_time:date:yyyy-MM-dd&#160;hh&#58;mm&#58;ss}</span></p>\
                            <pre>${content_element}</pre> \
                        </div> \
                      </li>';


//=================================================================================

/**
 *
 *  ${error_data:string} 错误数据信息
 */
var chat_error_desc = '<p class="error-desc">\
                           <em>${error_data:string}</em>\
                          </p>';

//===================================================================================
/**
 * 翻译控件
 */
var translate_href = '<i class="ico-translate" title="click me to translate this sentence!" onclick="${translate_content:event}"></i>';

var trans_result = '<p class="translated">${translate_dst:string}</p>';