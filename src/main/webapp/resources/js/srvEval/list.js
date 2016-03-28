    $(function() {

        $(document).keypress(function(e) {
            // 回车键事件
            if(e.which == 13) {
                jQuery("#search").click();
                return false
            }
        });
        easyUiTable.initTable({
            url: window.ctx + '/srvEval/listview',
            showFooter: true,
            //callback: function () {
            //    $('[data-toggle="popover"]').popover();
            //},
            columns: [
                {
                    field: "srvOrderCode",
                    title: '订单编号',
                    align: 'center',
                    width:'170px',
                    formatter: function (value, row, index) {
                        value=value||"";
                        return "<a href='"+window.ctx+"/serviceOrder/"+row.srvOrderId+"/edit'>"+value+"</a>";
                    }

                },
                {field: 'wtsOrgNameCN', title: '委托方', align: 'center',width:'150px',
                    formatter: function (value, row, index) {
                        var wtsUserName=row.wtsUserName||"";
                        var fwsOrgNameCN=value||"";
                        return fwsOrgNameCN+"<br/>"+wtsUserName;
                    }

                },
                {field: 'fwsOrgNameCN', title: '服务商', align: 'center',width:'190px'
                },
                {field: 'srvName', title: '服务', align: 'center',width:'150px'
                },
                {field: 'level', title: '评价', align: 'center',width:'120px',

                    formatter: function (value, row, index) {
                        var level = row.level||0;
                        var content=row.content||"";
                        var evalTime=new Date(row.createTime).Format("yyyy-MM-dd");
                        var stars='';
                        for(var i=0;i<level;i++){
                            stars+='<span class="icon icon-star-yellow"></span>';
                        }
                        var htm='<div class="serv-eval-cont" style="display: none">'+
                                '       <div class="star-header">'+
                                '           服务评价'+stars+
                                '       </div>'+
                                '       <p class="star-body">'+content+
                                '       </p>'+
                                '       <p class="star-footer">'+row.wtsUserName+"&nbsp;"+evalTime+
                                '       </p>'+
                                '</div>';
                        var wrap='<div class="serv-eval" data-toggle="popover" data-trigger="hover" data-placement="left" data-original-title="" title="">'+stars+htm+'</div>';
                        return wrap;
                    }
                }, {field: 'createTime', title: '评价时间', align: 'center',width:'150px',
                    formatter:function(value,row,index){
                        return new Date(value).Format("yyyy-MM-dd");
                    }
                }
            ],

            onSelectPage: function (pageNumber, pageSize) {
                $('#easyUi_table').datagrid("reload", {
                    pageNumber: pageNumber,
                    pageSize: pageSize,
                    srvOrderCode:$("#srvOrderCode").val(),
                    wtsOrgNameCN:$("#wtsOrgNameCN").val(),
                    fwsOrgNameCN:$("#fwsOrgNameCN").val(),
                    level:$('#level').val()
                })
            }
        });

        $("#search").on("click", function () {
            $('#easyUi_table').datagrid('load', {
                srvOrderCode:$("#srvOrderCode").val(),
                wtsOrgNameCN:$("#wtsOrgNameCN").val(),
                fwsOrgNameCN:$("#fwsOrgNameCN").val(),
                level:$('#level').val()

            });
        });


        $(window).on('mouseover', function() {
            $(".serv-eval").popover({
                placement: 'left',
                container: 'body',
                html: true,
                content: function () {
                    return $(this).children('.serv-eval-cont').html();
                }
            });
        });


    });


    $("button:contains('重置')").on('click',function(){
        $(this).closest("form")[0].reset();
        $('#easyUi_table').datagrid('load',{});
    });