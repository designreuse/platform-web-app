var billId;

/*var jpage = $("#pageComponent").SetPageComponent({
    pageIndex : $("#pageIndex").val(),    //当前页码
    pageSize :  $("#pageSize").val(),      //每页条数
    rowCount :  $("#rowCount").val(),      //数据总数
    pageFormID : "billListForm"      //表单id
});*/

function unlockEditRow(id){
    billId=id;
    $("#bill_lock").modal('show');
}

function lockEditRow(id){
    billId=id;
    $("#bill_unlock").modal('show');
}

$("#againSet").click(function(){
    $("#selectKey").val("0");
    $("#keyWord").val("");

    $("#positive").attr("checked",false);
    $("#negative").attr("checked",false);
    $("#skuStatus").val("");
    $("#shopsName").val("");
    $("#status").val("");

    $("#search").click();
})
$(function () {



//        $(".icon_all--lock").on('click', function(){
//            $("#bill_lock").modal('show');
//        });
    $('[data-toggle="popover"]').popover();

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
            return false;
        }
    });

    $("#search").click(function(){
        var selectKey=$('#selectKey').val();
        var orgName;
        var srvOrderCode;
        var feeName;
//        var contactCompany;
        var income;
        var status;
        var keyWord = $('#keyWord').val();
        switch (selectKey){
            case '0':{
                if(keyWord!=null&&keyWord!=""){
                    orgName=keyWord;
                }
                break;
            }
            case '1':{if(keyWord!=null&&keyWord!=""){srvOrderCode=keyWord;}break;}
            case '2':{if(keyWord!=null&&keyWord!=""){feeName=keyWord;}break;}
        }
        if(document.getElementById("positive").checked&&!document.getElementById("negative").checked){
            income=1;
        }
        if(!document.getElementById("positive").checked&&document.getElementById("negative").checked){
            income=0;
        }

        if(document.getElementById("positive").checked&&document.getElementById("negative").checked){
            income=2;
        }
        if(!document.getElementById("positive").checked&&!document.getElementById("negative").checked){
            income=3;
        }

        var statusVal= $("#status").val();
        switch(statusVal){
            case '0':status=2;break;
            case '1':status=3;break;
            case '2':status=0;break;
            case '3':status=1;break;
        }

        $("input[name='orgName']").val(orgName);
        $("input[name='srvOrderCode']").val(srvOrderCode);
        $("input[name='feeName']").val(feeName);
//        $("input[name='contactCompany']").val(contactCompany);
        $("input[name='income']").val(income);
        $("input[name='status']").val(status);
        $("input[name='selectKey']").val(selectKey);
        jpage.PageInit();
        $("#billListForm").submit();
    })



    $("#lockBtn").on('click', function(){
        var id = billId;
//        window.location.href=window.ctx+'/bill/lockBill?'+id;
        $.ajax({
            url:window.ctx+'/bill/updateBillStatus/'+id,
            data:{
                isLock:1
            },
            dataType: "json",
            success:function(data){
                $("#bill_unlock").modal('hide');
                var msg1=data.result;
                if(!msg1){
                    alert(data.msg);
                }else{
                    alert(data.msg);
                    $("#search").click();
                }

            },
            error:function(){
                alert("服务器出现错误！");
            }
        })
    });


    $("#unLockBtn").on('click', function(){
        var id = billId;
//        window.location.href=window.ctx+'/bill/unLockBill?'+id;
        $.ajax({
            url:window.ctx+'/bill/updateBillStatus/'+id,
            data:{
                isLock:0
            },
            dataType: "json",
            success:function(data){
                $("#bill_lock").modal('hide');
                var msg1=data.result;
                if(!msg1){
                    alert(data.msg);
                }else{
                    alert(data.msg);
                    $("#search").click();
                }
            },
            error:function(){
                alert("服务器出现错误！");
            }
        })
    });





})