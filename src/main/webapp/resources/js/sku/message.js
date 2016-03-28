/*
 条件查询
 */

var answerClickFlag = false;
var obj=null;//选择的回复时的对象

$(document).keypress(function(e) {
    // 回车键事件
    if(e.which == 13) {
        jQuery("#search").click();
        return false
    }
});


$("#againSet").click(function(){
    $("#productName").val("");
    $("#consultReplyContent").val("");
    $("#consultType").val("");
    $("#shopsName").val("");
    $("#consultUserName").val("");
    $("#startDate").val("");
    $("#endDate").val("");
    $("#consultStatus").val("");

    $("#search").click();
})


function delete1(id){
    if(confirm("确认删除这条回复信息？")){
        $.ajax({
            type:"POST",
            url: window.ctx + "/sku/deleteReplyMessage",
            dataType:"JSON",
            data:{
                id:id
            },
            success: function () {
                alert("删除回复成功！");
                $("#antworten").modal('hide');

                var productName = $("#productName").val();
                var consultReplyContent = $("#consultReplyContent").val();
                var consultType = $("#consultType").find('option:selected').val();
                var shopsName = $("#shopsName").val();
                var consultUserName = $("#consultUserName").val();
                var startDate = $("#startDate").val();
                var endDate = $("#endDate").val();
                var consultStatus = $("#consultStatus").find('option:selected').val();

                $('#easyUi_table').datagrid('reload',{
                    productName:productName,
                    consultReplyContent:consultReplyContent,
                    consultType:consultType,
                    shopsName:shopsName,
                    consultUserName:consultUserName,
                    startDate:startDate,
                    endDate:endDate,
                    consultStatus:consultStatus
                })

            }, error: function () {
                alert("删除回复失败，服务器出现错误");
            }
        });
    }
}

function deleteMessage(id){
    if(confirm("确认删除这条留言信息？")){
        $.ajax({
            type:"POST",
            url: window.ctx + "/sku/deleteMessage",
            dataType:"JSON",
            data:{
                id:id
            },
            success: function () {
                alert("删除留言成功！");
                $("#antworten").modal('hide');

                var productName = $("#productName").val();
                var consultReplyContent = $("#consultReplyContent").val();
                var consultType = $("#consultType").find('option:selected').val();
                var shopsName = $("#shopsName").val();
                var consultUserName = $("#consultUserName").val();
                var startDate = $("#startDate").val();
                var endDate = $("#endDate").val();
                var consultStatus = $("#consultStatus").find('option:selected').val();

                $('#easyUi_table').datagrid('reload',{
                    productName:productName,
                    consultReplyContent:consultReplyContent,
                    consultType:consultType,
                    shopsName:shopsName,
                    consultUserName:consultUserName,
                    startDate:startDate,
                    endDate:endDate,
                    consultStatus:consultStatus
                })

            }, error: function () {
                alert("删除留言失败，服务器出现错误");
            }
        });
    }
}


function modifyFlag(){
    answerClickFlag=true
}
function answerClick(){
//    alert(obj);
    answerClickFlag=false;
    var str="【"+obj.consultTypeNameCn+"】"+obj.consultContent;
    $("#answerDiv").html(str);
    $("#answerArea").val("");
//    if(obj.replyType==1){
//        $("#platForm").attr("checked",'checked');
//    }else if(obj.replyType==2){
//        $("#business").attr("checked",'checked');
//    }else {
//        $("#platForm").attr("checked",'checked');
//    }
    $("#antworten").modal('show');
}

$("#search").click(function(){
    var productName = $("#productName").val();
    var consultReplyContent = $("#consultReplyContent").val();
    var consultType = $("#consultType").find('option:selected').val();
    var shopsName = $("#shopsName").val();
    var consultUserName = $("#consultUserName").val();
    var startDate = $("#startDate").val();
    var endDate = $("#endDate").val();
    var consultStatus = $("#consultStatus").find('option:selected').val();

    $('#easyUi_table').datagrid('reload',{
        productName:productName,
        consultReplyContent:consultReplyContent,
        consultType:consultType,
        shopsName:shopsName,
        consultUserName:consultUserName,
        startDate:startDate,
        endDate:endDate,
        consultStatus:consultStatus
    })


})



$(function(){
    $("#answerBtn").on("click",function(){
        var id = obj.id;
        var replyContent = $("#answerArea").val();
        var replyType = $(":radio[name='antIden']:checked").val();

        $.ajax({
            type:"POST",
            url: window.ctx + "/sku/answer",
            dataType:"JSON",
            data:{
                id:id,
                replyContent:replyContent,
                replyType:replyType
            },
            success: function () {
                alert("回复成功！");
                $("#antworten").modal('hide');


                var productName = $("#productName").val();
                var consultReplyContent = $("#consultReplyContent").val();
                var consultType = $("#consultType").find('option:selected').val();
                var shopsName = $("#shopsName").val();
                var consultUserName = $("#consultUserName").val();
                var startDate = $("#startDate").val();
                var endDate = $("#endDate").val();
                var consultStatus = $("#consultStatus").find('option:selected').val();

                $('#easyUi_table').datagrid('reload',{
                    productName:productName,
                    consultReplyContent:consultReplyContent,
                    consultType:consultType,
                    shopsName:shopsName,
                    consultUserName:consultUserName,
                    startDate:startDate,
                    endDate:endDate,
                    consultStatus:consultStatus
                })
                obj=null;
            }, error: function () {
                obj=null;
                alert("回复失败，服务器出现错误");
            }
        });
    })

    /*定义easyUITable的相关参数*/
    var easyUiTableParam ={
        url:window.ctx+"/sku/messageList",
        fitColumns:true,
        onClickRow:function(rowIndex,rowData){
            obj=null;
            obj={
                consultTypeNameCn:rowData['consultTypeNameCn'],
                consultContent:rowData['consultContent'],
                replyType:rowData['replyType'],
                id:rowData['id']
            }

            if(answerClickFlag){
                answerClick();
            }
        },
        onSelectPage:function(pageNumber,pageSize){
            var productName = $("#productName").val();
            var consultReplyContent = $("#consultReplyContent").val();
            var consultType = $("#consultType").find('option:selected').val();
            var shopsName = $("#shopsName").val();
            var consultUserName = $("#consultUserName").val();
            var startDate = $("#startDate").val();
            var endDate = $("#endDate").val();
            var consultStatus = $("#consultStatus").find('option:selected').val();

            $('#easyUi_table').datagrid('reload',{
                pageNumber:pageNumber,
                pageSize:pageSize,
                productName:productName,
                consultReplyContent:consultReplyContent,
                consultType:consultType,
                shopsName:shopsName,
                consultUserName:consultUserName,
                startDate:startDate,
                endDate:endDate,
                consultStatus:consultStatus
            })

        },
        columns:[
            {   field:'id',
                hidden:true
            },
            {   field:'skuId',
                title:"SKU ID",
                align:'center',
                width:"55px"
            },
            {
                field:'catalogNameCn',
                hidden:true
            },
            {
                field:'productNameCn',
                hidden:true
            },
            {
                field:'skuNameCn',
                title:'SKU标题',
                align:'center',
                width:"180px",
                formatter: function(value,row,index){
                    var str = "";
                    str += value;
                    str += "</br>"+row['catalogNameCn']+">"+row['productNameCn'];
                    return '<a href="/purchase/sku/detail/'+row['skuId']+'" target="_blank">'+str+'<a>';
                }

            },
            {   field:'shopsNameCn',
                title:'商铺名称',
                align:'center',
                width:"120px"
            },
            {
                field:'userNameCn',
                hidden:true
            },
            {
                field:'userNameRu',
                title:'咨询人',
                align:'center',
                width:"70px",
                formatter: function(value,row,index){
                    if(value==null){
                        if(row.userNameCn == null){
                            return "匿名";
                        }
                        return row['userNameCn'];
                    }else{
                        return value;
                    }

                }
            },
            {
                field:'consultTypeNameCn',
                title:'咨询类型',
                align:'center',
                width:"60px"
            },
            {
                field:'consultTime',
                hidden:true
            },
            {
                field:'replyContent',
                hidden:true
            },
            {
                field:'replyType',
                hidden:true
            },
            {
                field:'consultContent',
                title:'Q/A',
                width:"200px",
                align:'center',
                formatter: function(value,row,index){
                    var str = "";
                    var replyType = row['replyType'];




                    if(replyType==1){
                        replyType="平台";
                    }else if(replyType==2){
                        replyType="商家";
                    }else{
                        replyType="";
                    }
                    str +="Q："+value+"("+new Date(row['consultTime']).Format("yyyy-MM-dd hh:mm")+")"+"</br>";
                    str +="A：";
                    var str2="";
                    var replyContent = row['replyContent'];
                    if(replyContent==null||replyContent==""){
                        str2 += '<a href="#" onclick="modifyFlag()">'+"【回复】"+'</a>';
                    }else{
                        str2 +="【"+replyType+"回复】"+row['replyContent']+'<a href="#" onclick="delete1('+row['id']+')">'+"【删除】"+'</a>';
                    }

                    str += str2;
                    return str;
                }
            },
            {
                field:'consultStatus',
                title:'状态',
                align:'center',
                width:"70px",
                formatter: function(value,row,index){
                 if(value ==1){
                 return "未回复";
                 }else if(value ==2){
                 return "已回复";
                 }
                 }
            },
            {
                field:'disabled',
                title:'操作',
                align:'center',
                width:"70px",
                /*formatter:function(value,row,index){
                    return new Date(value).Format("yyyy-MM-dd hh:mm");
                }*/
                formatter: function(value,row,index){
                    if(value ==0){
                        return '<a href="#" onclick="deleteMessage('+row['id']+')">'+"【删除】"+'</a>';

                    }else if(value ==1){
                        return "已删除";
                    }
                }
            }

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





