  $(function() {
        $(".mutil-table").initTable({
            url: ctx + "/statsInquiry/listCompany",
            columns: [
                    {title: "  企业  ", field: 'buyerOrgName',align:'center',width:'130px'},
                    {title: "个人会员", field: 'adminName',align:'center',width:'110px'},
                    {title: "  询盘条数  ", field: 'inquiryNumFmt',align:'center',width:'60px'},
                    {title: "  回盘条数  ", field: 'backNumFmt',align:'center',width:'60px'},
                    {title: "  成交条数  ", field: 'orderNumFmt',align:'center',width:'60px'},
                    {title: "  成交率  ", field: '   ',align:'center',width:'60px',
                        formatter: function (value, row, index) {
                            var rate = Math.round(row.orderNum /row.inquiryNum*100*100)/100||0;
                            return rate+"%";
                        }
                    }
            ],
            width:1140,
            queryParams: {
                startTime:$("#cstartTime").val(),
                endTime:$("#cendTime").val()
            },
            onLoadSuccess:function(data) {
                //companyStats 总计询盘 983 条，成功 323 条（31%）totalInquiryNum
                var percent=Math.round(data.stats.totalOrderNum/data.stats.totalInquiryNum*100*100)/100||0;
                totalInquiryNum=data.stats.totalInquiryNumFmt||0;
                totalOrderNum=data.stats.totalOrderNumFmt||0;
                $("#companyStats").text("总计询盘 "+totalInquiryNum+" 条，成功 "+totalOrderNum+" 条（"+percent+"%）");
                $(".mutil-table").parent().parent().parent().find(".query-page").children(".page").pagination({
                    onSelectPage: function (pageNumber, pageSize) {
                        $('.mutil-table').datagrid("reload", {
                            pageNumber: pageNumber,
                            pageSize: pageSize,
                            buyerOrgName:$("#buyerCompanyName").val(),
                            startTime:$("#cstartTime").val(),
                            endTime:$("#cendTime").val()
                        })
                    }
                });

            }
        });

        $("#companySearch").on("click",function(){
            $('.mutil-table').datagrid('load', {
                buyerOrgName:$("#buyerCompanyName").val(),
                startTime:$("#cstartTime").val(),
                endTime:$("#cendTime").val()
            });
        });
        $(".mutil-table-2").initTable({
            url: ctx + "/statsInquiry/listProduct",
            columns: [
                    {title: "商品", field: 'skuNameCN', width: 100,
                        formatter: function (value, row, index) {
                            return row.skuNameCN?row.skuNameCN:row.skuId;
                        }
                    },
                    {title: "三级品类", field: 'catalog3NameCN', width: 100,align:'center'},
                    {title: "标准商品", field: 'productNameCN', width: 100,align:'center'},
                    {title: "询盘条数", field: 'inquiryNumFmt', width: 100,align:'center'},
                    {title: "回盘条数", field: 'backNumFmt', width: 100,align:'center'},
                    {title: "成交条数", field: 'orderNumFmt', width: 100,align:'center'},
                    {title: "成交率", field: 'data.backNum',width: 100,align:'center',
                        formatter: function (value, row, index) {
                            var rate = Math.round(row.orderNum /row.inquiryNum*100*100)/100||0;
                            return rate+"%";
                        }
                    }
            ],
            queryParams: {
                startTime:$("#pstartTime").val(),
                endTime:$("#pendTime").val()
            },
            width:1140,

            onLoadSuccess:function(data) {
                var percent=Math.round(data.stats.totalOrderNum/data.stats.totalInquiryNum*100*100)/100||0;
                totalInquiryNum=data.stats.totalInquiryNum||0;
                totalOrderNum=data.stats.totalOrderNum||0;
                totalInquiryNumFmt=data.stats.totalInquiryNumFmt||0;
                totalOrderNumFmt=data.stats.totalOrderNumFmt||0;
                $("#productStats").text("总计询盘 "+totalInquiryNumFmt+" 条，成功 "+totalOrderNumFmt+" 条（"+percent+"%）");

                $(".mutil-table-2").parent().parent().parent().find(".query-page").children(".page").pagination({
                    onSelectPage: function (pageNumber, pageSize) {
                        $('.mutil-table-2').datagrid("reload", {
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
        $("#prductSearch").on("click",function(){
            $('.mutil-table-2').datagrid('load', {
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
            url: ctx + "/statsInquiry/trend",
            async: false,
            data: {
                startTime:$("#tstartTime").val(),
                endTime:$("#tendTime").val()
            },
            success:function(rsp){
                rspData= $.parseJSON(rsp);
            }
        });
        //询盘走势
        darwChart.init({
            chartId: "trend",//chart所在ID，必填
            chartXaxis: rspData.dateArr,//x轴数据，必填，type为pie的时候不填
            chartSeries: [
                {
                    name:'询盘商品数量',
                    type:'bar',
                    data:rspData.inquiryNumArr
                },
                {
                    name:'询盘商品金额',
                    type:'line',
                    yAxisIndex: 1,
                    data:rspData.inquiryPriceArr
                }
            ],//y轴数据，必填
            chartYaxis: [
                {
                    type : 'value',
                    name : '数量'
                },
                {
                    type : 'value',
                    name : '金额'
                }
            ],//y轴单位，mix模式下才会有，其它模式没有
            chartType: 'mix',//chart类型，必填
            legend:['询盘商品数量','询盘商品金额'],//顶部的分类，选填
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
            titleText: "询盘商品数量",//大标题，选填
            titleSubtext:"总计:"+dataNum.totalNum//小标题，选填
        });
        darwChart.init({
            chartId: "chartOption12",//chart所在ID，必填
            chartSeries:dataNum.dataPriceArr,//y轴数据，必填
            chartType: 'pie',//chart类型，必填
            chartName: "",//y轴与提示的单位，选填，mix模式下不需要
            legend:[],//顶部的分类，选填
            titleText: "询盘商品金额",//大标题，选填
            titleSubtext:"总计:"+dataNum.priceTotalNum+"元"//小标题，选填
        });

    }
    function loadDistributeData(){
        var data;
        $.ajax({
            url:window.ctx+"/statsInquiry/distribute",
            async:false,
            data:{
                startTime:$("#dstartTime").val(),
                endTime:$("#dendTime").val()
            },
            success:function(rspdata){
                var rsp= $.parseJSON(rspdata);
                var dataArr=[];//询盘商品数量
                var totalNum=rsp.totalNum;
                var dataPriceArr=[];//询盘商品价格
                var priceTotalNum=rsp.priceTotalNum;
                $.each( rsp.productNum, function(i, n){
                     dataArr[i]={name: n.catalog3NameCN||'',value: n.inquiryNum||0}

                });
                $.each( rsp.productAmonut, function(i, n){
                     dataPriceArr[i]={name: n.catalog3NameCN||'',value: n.perCatalogAmount}

                });
                data={rows:dataArr,totalNum:totalNum,dataPriceArr:dataPriceArr,priceTotalNum:priceTotalNum};
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



