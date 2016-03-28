$(function () {

    $("#checkBtn").on("click",function(){
        $('#trade_edit--check').modal('show');
    })

    $("#cancelBtn").on("click",function(){
        $('#trade_edit--cancel').modal('show');
    })




    $("#checkInvoicingBtn").on("click",function(){
        var id=$("#invoiceId").val();
        $.ajax({
            url : window.ctx+'/invoice/updateStatus',
            data : {
                id:id,
                invoiceStatus:2
            },
            dataType:"json",
            success:function(data){
                $('#trade_edit--check').hide();
                alert("开票成功");
                window.location.href=window.ctx+'/invoice/edit/'+id;
            },
            error:function(data){
                alert("服务器出现错误");
            }
        })
    });


    $("#checkCancelInvoicingBtn").on("click",function(){
        $.ajax({
            url : window.ctx+'/invoice/updateStatus',
            data : {
                id:$("#invoiceId").val(),
                invoiceStatus:3
            },
            dataType:"json",
            success:function(data){
                $('#trade_edit--check').hide();
                alert("修改成功");
                window.location.href=window.ctx+'/invoice/edit/'+$("#invoiceId").val();
            },
            error:function(data){
                alert("服务器出现错误");
            }
        })
    });






})