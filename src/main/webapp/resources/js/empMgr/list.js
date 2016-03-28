$(function() {

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
        }
    });

    easyUiTableParam={
        url: window.ctx + '/empMgr/listEmp',
        showFooter: true,
        callback: function () {
            $('[data-toggle="popover"]').popover();
        },
        columns: [
            {
                field: "userNameCn",
                title: '姓名(中文)',
                align: 'center',formatter:function(value, row, index){
                   return "<a href='"+window.ctx+"/empMgr/info?userId="+row.userId+"'>"+ (value?value:'')+"</a>";
                }
            },
            {field: 'sex', title: '性别', align: 'center',
                formatter: function (value, row, index) {
                    var sexDes='女';
                   if(value===0){
                       sexDes='保密'
                   }else if(value===1){
                       sexDes='男'
                   }
                    return sexDes;
                }
            },
            {field: 'mobile', title: '手机号', align: 'center'},
            {field: 'email', title: '邮箱', align: 'center'},
            {field: 'isRoot', title: '管理员', align: 'center',width:'50px',
                formatter: function (value, row, index) {
                    return value!=0?'是':'否';
                 }
            },
            {
                field: 'deptName',
                title: '服务执行部门',
                align: 'center'
            },
            {field: 'statusType', title: '身份验证', align: 'center',
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
                formatter: function (value, row, index) {
                return value?new Date(value).Format("yyyy-MM-dd"):'';
            }}

        ],
        onSelectPage: function (pageNumber, pageSize) {
            var params=$("#userMgrform").serializeObject();
            params.pageNumber=pageNumber;
            params.pageSize=pageSize;
            $('#easyUi_table').datagrid("reload",params)
        }
    };
    $("#search").on("click", function () {
        $('#easyUi_table').datagrid('load', $("#userMgrform").serializeObject());
    });
    $(window).resize(function(){
        easyUiTable.initTable(easyUiTableParam);
    });
    easyUiTable.initTable(easyUiTableParam);

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

function reset(){
    $("#userMgrform")[0].reset();
    $('#easyUi_table').datagrid("reload",{})
}