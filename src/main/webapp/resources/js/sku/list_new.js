/*
 条件查询
 */
$("#againSet").click(function(){
    $("#skuName").val("");
    $("#catalogIdFirst").val("");
    $("#catalogIdSecond").val("");
    $("#catalogId").val("");
    $("#orgName").val("");
    $("#skuStatus").val("");
    $("#shopsName").val("");
    $("#releaseTimeStart").val("");
    $("#releaseTimeEnd").val("");
    $("#nature").val("");
    $("#isOffline").val("");

    $("#search").click();
})

/*$("#allSelectBtn").click(function(){
    var flag = $("#allSelectBtn").prop("checked")
    if(flag==true){
        var rows = $("#easyUi_table").datagrid("getRows");
        for(var i=0;i<rows.length;i++)
        {

            var row = rows[i];
            //获取每一行的数据
            var node = $("#datagrid-row-r1-2-"+i).find("input[name='skuId']");
            if(node){
                var nodeFlag = $("#datagrid-row-r1-2-"+i).find("input[name='skuId']").prop("checked");
                if(!nodeFlag){
                    $("#datagrid-row-r1-2-"+i).find("input[name='skuId']").click();

                }
            }

        }
    }else{
        var rows = $("#easyUi_table").datagrid("getRows");
        for(var i=0;i<rows.length;i++)
        {

            var row = rows[i];
            //获取每一行的数据
            var node = $("#datagrid-row-r1-2-"+i).find("input[name='skuId']");
            if(node){
                var nodeFlag = $("#datagrid-row-r1-2-"+i).find("input[name='skuId']").prop("checked");
                if(nodeFlag){
                    $("#datagrid-row-r1-2-"+i).find("input[name='skuId']").click();
                }
            }

        }
    }

})*/
$('#check').click(function(){
    var checkedItems = $('#easyUi_table').datagrid('getChecked');
    var skuIds = [];
    $.each(checkedItems, function(index, item){
        skuIds.push(item.skuId);
    });

    $.ajax({
            url: window.ctx+"/sku/checkSkuProduct",
            type: "post",
            data: {skuIds: skuIds.join(",")},
            dataType: "json",
            success: function (data) {
                alert("审核成功");
                $("#search").click();
                $("#allSelectBtn").removeProp("checked");
            }
        }
    );
});

$("#search").click(function(){


    var skuName = $("#skuName").val();
//    var hscode= $("#hscode").val();
    var catalogIdFirst = $("#catalogIdFirst").find("option:selected").val();
    var catalogIdSecond = $("#catalogIdSecond").find("option:selected").val();
    var catalogId = $("#catalogId").find("option:selected").val();
    var orgName = $("#orgName").val();
    var shopsName = $("#shopsName").val();

    var releaseTimeStart = $("#releaseTimeStart").val();
    var releaseTimeEnd = $("#releaseTimeEnd").val();

    var nature = $("#nature").find("option:selected").val();
    var natureText = $("#nature").find("option:selected").text();

    var isHot;
    var isHomepage;
    var isSales;
    if(natureText=="俄站首页热销商品"){
        isHomepage=1;
    }else if(natureText=="店铺热门商品"){
        isHot=1;
    }else if(natureText=="店铺促销"){
        isSales=1;
    }

    var isOffline= $("#isOffline").find("option:selected").val();
    var skuStatus= $("#skuStatus").find("option:selected").val();
//    var disabled= $("#disabled").find("option:selected").val();
    if(isOffline=="0"){
        isOffline="0"
    }else if(isOffline=="1"){
        isOffline="1";
    }

    $('#easyUi_table').datagrid({
        url:window.ctx+'/sku/skuList',
        queryParams:{
            skuName: skuName,//商品名称
//        hscode:hscode,
            catalogIdFirst: catalogIdFirst,
            catalogIdSecond: catalogIdSecond,
            catalogId: catalogId,
            orgName: orgName,
            shopsName: shopsName,
            releaseTimeStart: releaseTimeStart,
            releaseTimeEnd: releaseTimeEnd,
            isHomepage: isHomepage,
            isHot: isHot,
            isSales: isSales,
            isOffline: isOffline,
            skuStatus: skuStatus
        }
    });


})

$(function(){

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
            return false
        }
    });


//    $("#skuName").val("");
//    $("#catalogIdFirst").val("");
//    $("#catalogIdSecond").val("");
//    $("#catalogId").val("");
//    $("#orgName").val("");
//    $("#skuStatus").val("");
//    $("#shopsName").val("");
//    $("#releaseTimeStart").val("");
//    $("#releaseTimeEnd").val("");
//    $("#nature").val("");
//    $("#isOffline").val("");


    // 取得下一级品类
    function getChildCatalog(parentid,level,obj){
        var url = window.ctx+"/catalog/subCatalog";
        if (parentid==""){
            parentid=-1;
        }
        $.ajax({
            url:url,
            type:"post",
            data:{
                catalogId:parentid
            },
            async:false,
            success:function(data){
                var data = $.parseJSON(data);
                var catalog1= '<option value="" selected>一级分类</option>';
                var catalog2= '<option value="" selected>二级分类</option>';
                var catalog3= '<option value="" selected>三级分类</option>';
                if(data.length > 0) {
                    var html="";
                    if (level==1){
                        $("#catalogIdSecond").empty();
                        $("#catalogId").empty();
                        $("#catalogId").append(catalog3);
                        $("#catalogIdSecond").append(catalog2);
                    } else if (level==2) {
                        $("#catalogId").empty();
                        $("#catalogId").append(catalog3);
                    }
                    for(var i = 0 ; i < data.length ; i++){
                        html += '<option value="' + data[i]["catalogId"] + '">' + data[i]["catalogNameCn"]+ '</option>';
                    }
                    console.log(html);
                    obj.append(html);
                }else{
                    if (level==1){
                        $("#catalogId").empty();
                        $("#catalogIdSecond").empty();
                        $("#catalogId").append(catalog3);
                        $("#catalogIdSecond").append(catalog2);
                    } else if (level==2) {
                        $("#catalogId").empty();
                        $("#catalogId").append(catalog3);
                    }
                }
            }
        });
    }


    $("#catalogIdFirst").on("change",function() {
        var catalogId = $("#catalogIdFirst").val();
        getChildCatalog(catalogId,1,$("#catalogIdSecond"));
    });
    $("#catalogIdSecond").on("change",function() {
        var catalogId = $("#catalogIdSecond").val();
        getChildCatalog(catalogId,2,$("#catalogId"));

    });

    /*定义easyUITable的相关参数*/
    var easyUiTableParam = {
        url:window.ctx+"/sku/skuList?skuStatus="+$("#skuStatus").val(),
        fitColumns:true,
        singleSelect: false,
        selectOnCheck: true,
        checkOnSelect: false,
        /*onClickRow:function(rowIndex,rowData){
            var skuId=rowData['skuId'];
            window.location.href=window.ctx+"/sku/edit/"+skuId;
        },*/
        onSelectPage:function(pageNumber,pageSize){
            var skuName = $("#skuName").val();
//            var hscode= $("#hscode").val();
            var catalogIdFirst = $("#catalogIdFirst").find("option:selected").val();
            var catalogIdSecond = $("#catalogIdSecond").find("option:selected").val();
            var catalogId = $("#catalogId").find("option:selected").val();
            var orgName = $("#orgName").val();
            var shopsName = $("#shopsName").val();

            var releaseTimeStart = $("#releaseTimeStart").val();
            var releaseTimeEnd = $("#releaseTimeEnd").val();

            var nature = $("#nature").find("option:selected").val();
            var natureText = $("#nature").find("option:selected").text();

            var isHot;
            var isHomepage;
            var isSales;
            if(natureText=="俄站首页热销商品"){
                isHomepage=1;
            }else if(natureText=="店铺热门商品"){
                isHot=1;
            }else if(natureText=="店铺促销"){
                isSales=1;
            }

            var isOffline= $("#isOffline").find("option:selected").val();
            var skuStatus= $("#skuStatus").find("option:selected").val();

            //将全选的复选框初始化
            $("#allSelectBtn").attr("checked",false);



            $('#easyUi_table').datagrid('reload',{
                pageNumber:pageNumber,
                pageSize:pageSize,
                skuName:skuName,//商品名称
//                hscode:hscode,
                catalogIdFirst:catalogIdFirst,
                catalogIdSecond:catalogIdSecond,
                catalogId:catalogId,
                orgName:orgName,
                shopsName:shopsName,
                releaseTimeStart:releaseTimeStart,
                releaseTimeEnd:releaseTimeEnd,
                isHomepage:isHomepage,
                isHot:isHot,
                isSales:isSales,
                isOffline:isOffline,
                skuStatus:skuStatus
            });

        },
        columns:[
            {   field:'skuId',
                checkbox:true
                /*,
                formatter: function(value,row,index){
                    if(row.skuStatus=="1"||row.skuStatus=="3"){
                        return ""
                    }
                }*/

            },
            {
                field:'priceCostTypeStr',
                hidden:true
            },
//            {
//                field:'skuStatus',
//                hidden:true
//            },
            {
                field:'skuUnitCn',
                hidden:true
            },
            {
                field:'skuNameCn',
                title:'商品名称',
                width:"110px",
                align:'center',
                formatter: function(value,row,index){
                    var skuId=row['skuId'];
                    return '<a href="'+window.ctx+'/sku/edit/'+skuId+'">'+value+'</a>';
                }},
            {
                field:'skuPriceBoList',
                title:'报价',
                align:'center',
                width:"150px",
                formatter: function(value,row,index){
                    var skuPriceBoList =value;
                    var str='';

                    for(var i=0;i<skuPriceBoList.length;i++){
                        var costType='';
                        var costTypeTemp =skuPriceBoList[i].costType;
                        switch (costTypeTemp){
                            case 1:costType='美元';break;
                            case 2:costType='卢布';break;
                            case 3:costType='元';break;
                        }
                        if(skuPriceBoList[i].priceType==1){
                            str+=">="+skuPriceBoList[i].oq+"  "+skuPriceBoList[i].priceStart+costType+"/"+row.skuUnitCn+'<br/>';
                        }else if(skuPriceBoList[i].priceType==2){
                            str+=">="+skuPriceBoList[i].oq+"  "+skuPriceBoList[i].priceStart+'~'+skuPriceBoList[i].priceEnd+costType+"/"+row.skuUnitCn+'<br/>';
                        }else if(skuPriceBoList[i].priceType==3){
                            str+=">="+skuPriceBoList[i].oq+"  议价"+'<br/>';
                        }
                    }
                    return str;
                }
            },
            {
                field:'shopsNameCn',
                title:'商铺名称',
                align:'center',
                width:"110px"
            },
            {
                field:'orgNameCn',
                title:'公司名称',
                align:'center',
                width:"100px"
            },
            {
                field:'isOffline',
                title:'上/下架',
                align:'center',
                width:"70px",
                formatter: function(value,row,index){
                    if(value ==0){
                        return "上架";
                    }else{
                        return "下架";
                    }
                }},
            {
                field:'skuStatus',
                title:'审核',
                align:'center',
                width:"70px",
                formatter: function(value,row,index){
//                    switch (value)
//                    {
//                        case 1:
//                            return "待初审";
//                            break;
//                        case 2:
//                            return "审核通过";
//                            break;
//                        case 3:
//                            return "待审核";
//                            break;
//                        case 4:
//                            return "审核拒绝";
//                    }
                    if(value==1){
                        return "待初审";
                    }else if(value==2){
                        return "已审核";
                    }else if(value==3){
                        return "待审核";
                    }else if(value==4){
                        return "审核未通过";
                    }
                }
            },
            {
                field:'createTime',
                title:'发布时间',
                align:'center',
                width:"90px",
                formatter:function(value,row,index){
                    return new Date(value).Format("yyyy-MM-dd")
                        +"<br/>"
                        +new Date(value).Format("hh:mm");
                }},
            {
                field:'validityDate',
                title:'有效期',
                align:'center',
                width:"90px",
                formatter:function(value,row,index){
                    return new Date(value).Format("yyyy-MM-dd")
                        +"<br/>"
                        +new Date(value).Format("hh:mm");
                }}
        ]

    }
    $(window).resize(function(){
        easyUiTable.initTable(easyUiTableParam);
    });
    /*easyUI初始化表*/
    easyUiTable.initTable(easyUiTableParam);

    /*隐藏活动id不显示*/
//    $("#easyUi_table").datagrid('hideColumn', 'id');

});








