    $(function() {
        /**
        *买方企业统计表
         */
        $(".mutil-table").initTable({
            url: ctx + "/statsTradeOrder/listBuyer",
            columns: [
                    {title: "企业(买方)", field: 'buyerOrgNameCN',align:'center',width:'130px'},
                    {title: "个人会员", field: 'adminName',align:'center',width:'110px'},
                    {title: "成交商品", field: 'orderProductNumFmt',align:'center',width:'60px'},
                    {title: "成交订单", field: 'orderNumFmt',align:'center',width:'60px'},
                    {title: "成交量", field: 'orderTotalNumFmt',align:'center',width:'60px'},
                    {title: "总金额（RMB）", field: 'totalAmountFmt',align:'center',width:'100px'}
            ],
            width:1140,
            queryParams: {
                startTime:$("#buyerStartTime").val(),
                endTime:$("#buyerEndTime").val()
            },
            onLoadSuccess:function(data) {
                formatedAmount=data.stats.totalAmountFmt||0;
                totalCounts=data.stats.totalProductNumFmt||0;
                totalOrderNum=data.stats.totalOrderNumFmt||0;
                $("#buyerStats").text("总计成交 "+totalOrderNum+"个订单，成交量"+totalCounts+"条，总金额"+formatedAmount+"元");
                $(".mutil-table").parent().parent().parent().find(".query-page").children(".page").pagination({
                    total: data.total,
                    onSelectPage: function (pageNumber, pageSize) {
                        $('.mutil-table').datagrid("reload", {
                            pageNumber: pageNumber,
                            pageSize: pageSize,
                            startTime:$("#buyerStartTime").val(),
                            endTime:$("#buyerEndTime").val(),
                            buyerOrgNameCN:$("#buyerOrgNameCN").val()
                        })
                    }
                });

            }
        });
        $("#buyerSearch").on("click",function(){
            $('.mutil-table').datagrid('load', {
                startTime:$("#buyerStartTime").val(),
                endTime:$("#buyerEndTime").val(),
                buyerOrgNameCN:$("#buyerOrgNameCN").val()
            });
        });

        /**
        *商铺统计表
         */
        $(".mutil-table-2").initTable({
            url: ctx + "/statsTradeOrder/listSaler",
            columns: [
                    {title: "企业（卖方）", field: 'salerOrgNameCN',align:'center',width:'130px'},
                    {title: "商铺", field: 'shopsNameCN',align:'center',width:'110px'},
                    {title: "成交商品", field: 'orderProductNumFmt',align:'center',width:'60px'},
                    {title: "成交订单", field: 'orderNumFmt',align:'center',width:'60px'},
                    {title: "成交量", field: 'orderTotalNumFmt',align:'center',width:'60px'},
                    {title: "总金额（RMB）", field: 'totalAmountFmt',align:'center',width:'100px'}
            ],
            width:1140,
            queryParams: {
                startTime:$("#salerStartTime").val(),
                endTime:$("#salerEndTime").val()
            },
            onLoadSuccess:function(data) {
                //companyStats 总计询盘 983 条，成功 323 条（31%）totalInquiryNum
                formatedAmount=data.stats.totalAmountFmt||0;
                totalCounts=data.stats.totalProductNumFmt||0;
                totalOrderNum=data.stats.totalOrderNumFmt||0;
                $("#salerStats").text("总计成交"+totalOrderNum+"个订单，成交量"+totalCounts+"条，总金额"+formatedAmount+"元");
                $(".mutil-table-2").parent().parent().parent().find(".query-page").children(".page").pagination({
                    total: data.total,
                    onSelectPage: function (pageNumber, pageSize) {
                        $('.mutil-table-2').datagrid("reload", {
                            pageNumber: pageNumber,
                            pageSize: pageSize,
                            startTime:$("#salerStartTime").val(),
                            endTime:$("#salerEndTime").val(),
                            salerOrgNameCN:$("#salerOrgNameCN").val(),
                            shopsNameCN:$("#shopsNameCN").val()
                        })
                    }
                });

            }
        });
        $("#salerSearch").on("click",function(){
            $('.mutil-table-2').datagrid('load', {
                startTime:$("#salerStartTime").val(),
                endTime:$("#salerEndTime").val(),
                salerOrgNameCN:$("#salerOrgNameCN").val(),
                shopsNameCN:$("#shopsNameCN").val()
            });
        });

        /**
        *商品统计表
         */
        $(".mutil-table-3").initTable({
            url: ctx + "/statsTradeOrder/listProduct",
            columns: [
                    {title: "商品", field: 'skuNameCN', width: 100,align:'center',
                        formatter: function (value, row, index) {
                            return value?value:row.skuId;
                        }
                    },
                    {title: "三级品类", field: 'catalog3NameCN', width: 100,align:'center'},
                    {title: "标准商品", field: 'productNameCN', width: 100,align:'center'},
                    {title: "订单数", field: 'orderNumFmt', width: 100,align:'center'},
                    {title: "最低价</br>（RMB）", field: 'minPriceFmt', width: 100,align:'center'},
                    {title: "最高价</br>（RMB）", field: 'maxPriceFmt', width: 100,align:'center'},
                    {title: "成交均价</br>（RMB）", field: 'avgPriceFmt',width: 100,align:'center' },
                    {title: "总金额</br>（RMB）", field: 'totalPriceFmt',width: 100,align:'center'}
            ],
            queryParams: {
                startTime:$("#pstartTime").val(),
                endTime:$("#pendTime").val()
            },
            width:1140,
            onLoadSuccess:function(data) {
                formatedAmount=data.stats.totalAmountFmt||0;
                totalCounts=data.stats.totalProductNumFmt||0;
                totalOrderNum=data.stats.totalOrderNumFmt||0;
                $("#productStats").text("总计成交"+totalOrderNum+"个订单，成交量"+totalCounts+"条，总金额"+formatedAmount+"元");

                $(".mutil-table-3").parent().parent().parent().find(".query-page").children(".page").pagination({
                    total: data.total,
                    onSelectPage: function (pageNumber, pageSize) {
                        $('.mutil-table-3').datagrid("reload", {
                            pageNumber: pageNumber,
                            pageSize: pageSize,
                            startTime:$("#pstartTime").val(),
                            endTime:$("#pendTime").val(),
                            catalog1Id:$("#catalog1Id").val(),
                            catalog2Id:$("#catalog2Id").val(),
                            catalog3Id:$("#catalog3Id").val(),
                            productId:$("#productId").val()
                        })
                    }
                });
            }
        });
        $("#productSearch").on("click",function(){
            $('.mutil-table-3').datagrid('load', {
                startTime:$("#pstartTime").val(),
                endTime:$("#pendTime").val(),
                catalog1Id:$("#catalog1Id").val(),
                catalog2Id:$("#catalog2Id").val(),
                catalog3Id:$("#catalog3Id").val(),
                productId:$("#productId").val()
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
            url: ctx + "/statsTradeOrder/trend",
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
            chartId: "trendTradeOrder",//chart所在ID，必填
            chartXaxis: rspData.dateArr,//x轴数据，必填，type为pie的时候不填
            chartSeries: [
                {
                    name:'成交量',
                    type:'bar',
                    data:rspData.tradeOrderNumArr
                },
                {
                    name:'成交额',
                    type:'line',
                    yAxisIndex: 1,
                    data:rspData.tradeOrderPriceArr
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
            legend:['成交量','成交额'],//顶部的分类，选填
            titleText: "",//大标题，选填
            titleSubtext:"",//小标题，选填
            chartUnit:"日期"//x轴单位，需要的时候添加，选填，type为pie的时候不填
        });

    }


    function showDistribute(){
        //ajax请求商品数量分布
        var dataNum=loadDistributeData();
        darwChart.init({
            chartId: "chartNum",//chart所在ID，必填
            chartSeries:dataNum.rows,//y轴数据，必填
            chartType: 'pie',//chart类型，必填
            chartName: "",//y轴与提示的单位，选填，mix模式下不需要
            legend:[],//顶部的分类，选填
            titleText: "成交量",//大标题，选填
            titleSubtext:"总计:"+dataNum.totalNum//小标题，选填
        });
        darwChart.init({
            chartId: "chartAmount",//chart所在ID，必填
            chartSeries:dataNum.dataPriceArr,//y轴数据，必填
            chartType: 'pie',//chart类型，必填
            chartName: "",//y轴与提示的单位，选填，mix模式下不需要
            legend:[],//顶部的分类，选填
            titleText: "成交额",//大标题，选填
            titleSubtext:"总计:"+dataNum.priceTotalNum+"元"//小标题，选填
        });

    }
    function loadDistributeData(){
        var data;
        $.ajax({
            url:ctx+"/statsTradeOrder/distribute",
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
                $.each( rsp.productNum, function(i, n){
                    dataArr[i]={name: n.catalog3NameCN||'',value: n.finishNum||0}
                    totalNum=dataArr[i].value+totalNum;
                });
                var reg=0;
                $.each( rsp.productAmonut, function(i, n){
                    if(n) {
                        dataPriceArr[reg] = {name: n.catalog3NameCN || '', value: n.totalPrice || 0}
                        priceTotalNum = dataPriceArr[reg].value + priceTotalNum;
                        reg++;
                    }
                });
                data={rows:dataArr,totalNum:rsp.dealNum,dataPriceArr:dataPriceArr,priceTotalNum:rsp.dealAmount};
            },
            error:function(){
                data= {rows:0,totalNum:0};
            }
        });
        return data;
    }


    function loadCatalogList(url,target){
        cleanOption(target);
        $.get(url,function(data){
            data.forEach(function(d){
                target.append($("<option/>").val(d.catalogId).text(d.catalogNameCn));
            });
        },"json");
    }
    //清除select下除了第一个之外的option
    function cleanOption(target){
        target.children().first().siblings().remove();
    }

    //加载二级产品分类
    function loadCs2(s){
        loadCatalogList(window.ctx+"/catalog/subCatalog?catalogId="+$(s).val(),$(s).next());
        cleanOption($(s).next());
        cleanOption($(s).next().next());
        cleanOption($(s).next().next().next());
    }
    //加载三级产品分类
    function loadCs3(s){
        cleanOption($(s).next());
        cleanOption($(s).next().next());
        loadCatalogList(window.ctx+"/catalog/subCatalog?catalogId="+$(s).val(),$(s).next());
    }

    //加载产品列表
    function loadPro(s) {
        var target = $(s).next();
        cleanOption(target);
        $.get(window.ctx + "/catalog/getProduct?catalogId=" + $(s).val(), function (data) {
            data.forEach(function (d) {
                console.log(d)
                $("<option/>")
                    .val(d.productId)
                    .text(d.productNameCn)
                    .attr("data-hscode", d.hscode)
                    .attr("data-logoUrl", d.logoUrl)
                    .appendTo(target);
            });
        }, "json");
    }
