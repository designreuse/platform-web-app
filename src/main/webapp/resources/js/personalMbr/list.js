$(function () {


    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
            return false
        }
    });
    easyUiTable.initTable({
        width:1140,
        url: window.ctx + '/personalMbr/listview?statusType='+$("#statusType").val(),
        showFooter: true,
        callback: function () {
            $('[data-toggle="popover"]').popover();
        },
        columns: [
            {
                field: "userNameCn",
                title: '姓名',
                align: 'center',
                formatter: function (value, row, index) {
                    var val=value||"";
                    if(row.regSource&&(row.regSource==7||row.regSource==5))
                        val=row.userNameFirst||"";
                    return "<a href='" + ctx + "/personalMbr/info?userId=" + row.userId + "'>" + val.split(",").join(" ") + "</a>";
                }
            },
            {
                field: "orgNameCn",
                title: '公司名称',
                align: 'center',
                formatter: function (value, row, index) {
                    var val=value||"";
                    if(row.entUserStatus&&row.entUserStatus==2)
                        return "";
                    if(row.regSource==5)
                        val=row.orgNameRu||"";
                    return "<a href='" + ctx + "/cmpMbr/info?orgId=" + row.orgId + "'>" + val + "</a>";
                }
            },
            {field: 'mobile', title: '联系方式', align: 'center',
                formatter: function (value, row, index) {
                    var mobile=value||"";
                    var email=row.email||"";
                    return "<a href='" + ctx + "/personalMbr/info?userId=" + row.userId + "'>" + mobile+"</br>"+email + "</a>";
                }
            },
            {field: 'regSource', title: '注册来源', align: 'center',
                formatter: function (value, row, index) {
                    if(value==5)
                        return "俄站";
                    if(value==3)
                        return "中站";
                    if(value==2)
                        return "运营平台";
                }},
            {field: 'statusType', title: '审核', align: 'center',
                formatter: function (value, row, index) {
                    if(value==1)
                        return "待初审";
                    if(value==2)
                        return "已通过";
                    if(value==3)
                        return "待审核";
                    if(value==4)
                        return "已拒绝";
                }
            },
            {field: 'entUserStatus', title: '隶属关系', align: 'center',
                formatter: function (value, row, index) {
                    return value === 1 ? '隶属' : '个人';
                }
            },
            {field: 'accountState', title: '状态', align: 'center',
                formatter: function (value, row, index) {
                    if(value==1)
                        return "可用";
                    if(value==2)
                        return "停用";

                    return "";
                }
            },
            {field: 'createTime', title: '创建时间', align: 'center',
                formatter:function(value, row, index){
                    return value?new Date(value).Format("yyyy-MM-dd"):'';
                }
            }
        ],
        onSelectPage: function (pageNumber, pageSize) {
            var params = $("#personalMbrform").serializeObject();
            params.pageNumber = pageNumber;
            params.pageSize = pageSize;
            $('#easyUi_table').datagrid("reload", params)
        }
    });
    $("#search").on("click", function () {
        $('#easyUi_table').datagrid({
                url: window.ctx + '/personalMbr/listview',
                queryParams:$("#personalMbrform").serializeObject()
            }
        );
    });
    $("button:contains('清空')").click(function(){
        $(this).closest("form").reset();
    })

});
$.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else if(this.value){
            o[this.name] = this.value || '';
        }
    });
    return o;
};
