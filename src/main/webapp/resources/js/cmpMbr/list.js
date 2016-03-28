
    $(function () {
        var easyUiTableParam={
            fit :true,
            url: window.ctx + '/cmpMbr/listview?orgAdultStatus='+$("#disabled").val(),
            showFooter: true,
            callback: function () {
                $('[data-toggle="popover"]').popover();
            },
            columns: [
                {
                    field: "orgNameCn",
                    title: '公司名称',
                    align: 'center',
                    width:"150px",
                    formatter: function (value, row, index) {
                        var orgNameRu=row.orgNameRu||"";
                        var orgNameCn=row.orgNameCn||"";
                        //如果企业国别是
                        if(row.countryType&&row.countryType==2) {
                            return "<a href='" + ctx + "/cmpMbr/info?orgId=" + row.id + "'>" + orgNameRu + "</a>";
                        }
                        return "<a href='" + ctx + "/cmpMbr/info?orgId=" + row.id + "'>" + orgNameCn + "</a>";
                    }
                },
                {field: 'identityNameList', title: '企业身份', align: 'center',width:'150px'},
                {field: 'orgAdultStatus', title: '审核', align: 'center', width:"50px",
                    formatter: function (value, row, index) {
                        var check='';
                        if(value){
                            if(value==1) check='待初审';
                            else if(value==2)check='已通过';
                            else if(value==3)check='待审核';
                            else if(value==4)check='已拒绝';
                        }
                    return check;
                    }
                },
                {field: 'disabled', title: '状态', align: 'center',width:"50px",
                    formatter: function (value, row, index) {
                        return value == 0 ? '可用' : '停用';
                    }
                },
                {field: 'createTime', title: '创建时间', align: 'center',width:"80px",
                    formatter:function(value, row, index){
                        return value?new Date(value).Format("yyyy-MM-dd"):'';
                    }
                },
                {field:'操作', title: '操作', align: 'center',width:"100px",
                    formatter: function (value, row, index) {
                        var orgId=row.id||"";
                        if(row.orgAdultStatus===1 || row.orgAdultStatus===3 )
                        return "<a href='"+window.ctx+"/cmpMbr/info?orgId="+orgId+"'>审核</a>";
                        else return "";
                    }
                }

            ],
            onSelectPage: function (pageNumber, pageSize) {
                var params = $("#cmpMgrform").serializeObject();
                params.pageNumber = pageNumber;
                params.pageSize = pageSize;
                $('#easyUi_table').datagrid("reload", params)
            }
        };

        $(window).resize(function(){
            easyUiTable.initTable(easyUiTableParam);
        });
        easyUiTable.initTable(easyUiTableParam);

        $("#search").on("click", function () {
            var formObj=$("#cmpMgrform").serializeObject();
            $('#easyUi_table').datagrid({
                url:window.ctx + '/cmpMbr/listview',
                queryParams:formObj
            });
        })

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


    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
            return false
        }
    });
