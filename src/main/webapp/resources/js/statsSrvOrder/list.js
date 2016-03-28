    $(function() {
        $(".mutil-table").initTable({
            url: ctx + "/statsSrvOrder/listCompany",
            columns: [
                {title: "企业", field: 'buyerOrgNameCN',align:'center'},
                {title: "个人会员", field: 'adminName',align:'center'},
                {title: "成交服务", field: 'finishSrvNumFmt',align:'center'},
                {title: "成交订单", field: 'finishNumFmt',align:'center'},
                {title: "已终止", field: 'terminalNumFmt',align:'center'},
                {title: "服务费（RMB）", field: 'orderAmountFmt',align:'center'}
            ],
            width:1140,
            queryParams: {
                startTime:$("#cstartTime").val(),
                endTime:$("#cendTime").val()
            },
            onLoadSuccess:function(data) {
                //     总计成交 983 个订单，成交量 323 个服务，服务费 23,230,000 元

                totalInquiryNum=data.stats.totalOrderNumFmt||0;
                totalOrderNum=data.stats.totalProductNumFmt||0;
                totalAmount=data.stats.totalAmountFmt||0;
                $("#companyStats").text("总计成交 "+totalInquiryNum+" 个订单，成交量 "+totalOrderNum+" 个服务，服务费"+totalAmount+"元");
                $(".mutil-table").parent().parent().parent().find(".query-page").children(".page").pagination({
                    onSelectPage: function (pageNumber, pageSize) {
                        $(".mutil-table").datagrid("reload", {
                            pageNumber: pageNumber,
                            pageSize: pageSize,
                            buyerOrgNameCN:$("#buyerOrgNameCN").val(),
                            startTime:$("#cstartTime").val(),
                            endTime:$("#cendTime").val()
                        })
                    }
                });

            }
        });
        $("#companySearch").on("click",function(){
            $('.mutil-table').datagrid('load', {
                buyerOrgNameCN:$("#buyerOrgNameCN").val(),
                startTime:$("#cstartTime").val(),
                endTime:$("#cendTime").val()
            });
        }
        );

        $(".mutil-table-2").initTable({
            url: ctx + "/statsSrvOrder/listSrvItem",
            columns: [

                    {title: "服务", field: 'srvNameCN', align:'center', width: 100},
                    {title: "成交订单", field: 'finishNumFmt', align:'center', width: 100},
                    {title: "已终止", field: 'terminalNumFmt', align:'center', width: 100},
                    {title: "服务费(RMB)", field: 'orderAmountFmt', align:'center', width: 100}
            ],
            width:1140,
            queryParams: {
                startTime:$("#istartTime").val(),
                endTime:$("#iendTime").val()
            },
            onLoadSuccess:function(data) {
                //总计成交 983 个订单，成交量 323 个服务，服务费 23,230,000 元
                totalOrderNum=data.stats.totalOrderNumFmt||0;
                totalSrvItemNum=data.stats.totalSrvItemNumFmt||0;
                totalAmount=data.stats.totalAmountFmt||0;
                $("#srvItemStats").text("总计成交 "+totalOrderNum+" 个订单，成交量 "+totalSrvItemNum+" 个服务,服务费 "+totalAmount+" 元");
            }
        });
        $("#prductSearch").on("click",function(){
            $('.mutil-table-2').datagrid('load', {
                startTime:$("#istartTime").val(),
                endTime:$("#iendTime").val(),
                srvId:$("#srvId").val()
            });
        });
        showDistribute();
        showTrend();
        $("#distributeBtn").on("click",function(){
            showDistribute();
        });
        $("#trendBtn").on("click",function(){
            showTrend();
        })


    });

    function showTrend(){
        var rspData=[];

        $.ajax({
            url: ctx + "/statsSrvOrder/trend",
            async: false,
            data: {
                startTime:$("#tstartTime").val(),
                endTime:$("#tendTime").val()
            },
            success:function(rsp){
                rspData= $.parseJSON(rsp);
            }
        });

        darwChart.init({
            chartId: "trend",//chart所在ID，必填
            chartXaxis: rspData.dateArr,//x轴数据，必填，type为pie的时候不填
            chartSeries: [
                {
                    name:'服务次数',
                    type:'bar',
                    data:rspData.srvNumArr
                },
                {
                    name:'服务费',
                    type:'line',
                    yAxisIndex: 1,
                    data:rspData.srvPriceArr
                }
            ],//y轴数据，必填
            chartYaxis: [
                {
                    type : 'value',
                    name : '数量'
                },
                {
                    type : 'value',
                    name : '价格'
                }
            ],//y轴单位，mix模式下才会有，其它模式没有
            chartType: 'mix',//chart类型，必填
            legend:['服务次数','服务费'],//顶部的分类，选填
            titleText: "",//大标题，选填
            titleSubtext:"",//小标题，选填
            chartUnit:"日期"//x轴单位，需要的时候添加，选填，type为pie的时候不填
        });

    }


    function showDistribute(){
        //ajax请求商品数量分布
        var dataNum=loadDistributeData();
        darwChart.init({
            chartId: "chartOption11",//chart所在ID，必填
            chartSeries:dataNum.rows,//y轴数据，必填
            chartType: 'pie',//chart类型，必填
            chartName: "",//y轴与提示的单位，选填，mix模式下不需要
            legend:[],//顶部的分类，选填
            titleText: "服务次数",//大标题，选填
            titleSubtext:"总计:"+dataNum.totalNum//小标题，选填
        });
        darwChart.init({
            chartId: "chartOption12",//chart所在ID，必填
            chartSeries:dataNum.dataPriceArr,//y轴数据，必填
            chartType: 'pie',//chart类型，必填
            chartName: "",//y轴与提示的单位，选填，mix模式下不需要
            legend:[],//顶部的分类，选填
            titleText: "服务费",//大标题，选填
            titleSubtext:"总计:"+dataNum.priceTotalNum+"元"//小标题，选填
        });

    }
    function loadDistributeData(){
        var data;
        $.ajax({
            url:ctx+"/statsSrvOrder/distribute",
            async:false,
            data:{
                startTime:$("#dstartTime").val(),
                endTime:$("#dendTime").val()
            },
            success:function(rsp){
                var dataArr=[];//询盘商品数量
                var totalNum=0;
                var dataPriceArr=[];//询盘商品价格
                var priceTotalNum=0;
                rsp= $.parseJSON(rsp);
                $.each( rsp.srvNum, function(i, n){
                    dataArr[i]={name: n.srvNameCN||'',value: n.orderNum||0}
                    totalNum=dataArr[i].value+totalNum;
                });
                $.each( rsp.srvAmonut, function(i, n){
                    dataPriceArr[i]={name: n.srvNameCN||'',value: n.orderAmount||0}
                    priceTotalNum=dataPriceArr[i].value+priceTotalNum;
                });
                data={rows:dataArr,totalNum:totalNum,dataPriceArr:dataPriceArr,priceTotalNum:priceTotalNum};
            },
            error:function(){
                data= {rows:0,totalNum:0};
            }
        });
        return data;
    }


