    $(function() {

        $(document).keypress(function(e) {
            // 回车键事件
            if(e.which == 13) {
                jQuery("#search").click();
                return false
            }
        });

        var easyUiTableParam = {
            url: window.ctx + '/tradeEval/listview',

            showFooter: true,
            callback: function () {
                $('[data-toggle="popover"]').popover();
            },
            columns: [
                {
                    field: "orderCode",
                    title: '订单编号',
                    align: 'center',
                    width: '180px',
                    formatter: function (value, row, index) {
                    return "<a href='"+window.ctx+"/order/"+row.orderId+"/edit'>"+value+"</a>";
                }
                },
                {field: 'buyerFirstName', title: '买方', align: 'center',width:'110px',
                    formatter: function (value, row, index) {
                        var buyerOrgName = row.buyerOrgName || "";
                        var buyerFirstName=row.buyerFirstName||"";
                        if(row.buyerEntStatus&&row.buyerEntStatus==2)
                            return  buyerFirstName;
                        var isAddBr=buyerOrgName?"<br/>":"";
                        return buyerOrgName + isAddBr + buyerFirstName;
                    }
                },
                {field: 'salerOrgName', title: '卖方', align: 'center',width:'120px',
                    formatter: function (value, row, index) {

                        var salerOrgName = row.salerOrgName||"" ;
                        var shopsNameCn=row.shopsNameCn||"";
                        var salerUserNameCN=row.salerUserNameCN||"";
                        if(row.salerEntStatus&&row.buyerEntStatus==2)
                            return  salerUserNameCN;
                        var isAddBr1=salerOrgName?"<br/>":"";
                        var isAddBr2=shopsNameCn?"<br/>":"";
                        return salerOrgName+isAddBr1+shopsNameCn +isAddBr2+salerUserNameCN ;
                    }
                },
                {field: 'productNameCN', title: '商品', align: 'center',width:'100px',
                    formatter: function (value, row, index) {
                        return value + row.purchareNum +  row.unit;
                    }
                },
                {field: 'buyerContent', title: '买方评价', align: 'center',width:'80px',

                    formatter: function (value, row, index) {
                        var level = "差评";
                        var color='poor';
                        var buyerContent=row.buyerContent||"";
                        if (row.buyerLevel) {
                            if (row.buyerLevel == 1) {
                                level = "好评"
                                color='praise';
                            } else if (row.buyerLevel == 2) {
                                level = "中评"
                                color='general';
                            }else{
                                level="差评";
                                color="poor";
                            }
                            return '<i class="icon_all icon_all--'+color+'" data-container="body" data-toggle="popover" data-placement="left" title="买方评价" data-trigger="hover" data-content="' + buyerContent + '"></i>' + level;
                        }else{
                            return "未评价"
                        }
                    }
                },
                {
                    field: 'salerContent',
                    title: '卖方评价',
                    align: 'center',
                    width:'80px',
                    formatter: function (value, row, index) {
                        var level = "差评";
                        var color='poor';
                        var salerContent=row.salerContent||"";
                        if (row.salerLevel) {
                            if (row.salerLevel == 1) {
                                level = "好评";
                                color='praise';
                            } else if (row.salerLevel == 2) {
                                level = "中评";
                                color='general';
                            }else{
                                level="差评";
                                color="poor";
                            }
                            return '<i class="icon_all icon_all--'+color+'" data-container="body" data-toggle="popover" data-placement="left" title="卖方评价" data-trigger="hover" data-content="' + salerContent + '"></i>' + level;
                        }else{
                            return "未评价"
                        }

                    }
                }
            ],
            onSelectPage: function (pageNumber, pageSize) {
                $('#easyUi_table').datagrid("reload", {
                    pageNumber: pageNumber,
                    pageSize: pageSize,
                    orderCode:$("#orderCode").val(),
                    buyerOrgCN:$("#buyerOrgCN").val(),
                    salerOrgCN:$("#salerOrgCN").val(),
                    shopsNameCn: $("#shopsNameCn").val(),
                    level:$('#level').val()
                })
            }
        };
        easyUiTable.initTable(easyUiTableParam);


    });
    $("#search").on("click", function () {
        $('#easyUi_table').datagrid('load', {
            orderCode:$("#orderCode").val(),
            buyerOrgCN:$("#buyerOrgCN").val(),
            salerOrgCN:$("#salerOrgCN").val(),
            shopsNameCn: $("#shopsNameCn").val(),
            level:$('#level').val()
        });

    });

    $("button:contains('重置')").on('click',function(){
        $("#userMgrform")[0].reset();
        $('#easyUi_table').datagrid('load',{});
    })


