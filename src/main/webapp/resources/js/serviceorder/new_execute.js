/**
 * Created by Administrator on 2015/11/16.
 */
$(function () {

    $(document).on('click', '.modal-form-del .icon-del', function(){
        $(this).parent().remove()
    });

    $("#nodeStatus").on("change",function(){
        if($(this).val()==2){
            $("#actualDate").val(new Date().Format("yyyy-MM-dd"))
        }
    })


    //设置表格初始化配置属性
    var easyUiTableParam = {
        url: window.ctx + '/serviceOrder/srvOrderNodeList?srvOrderId='+$("#srvOrderId").val(),
        columns: [{
            field: "srvNameCn",
            title: '基本服务',
            align: 'center',
            width: "60px"
        },
            {
                field: 'srvOrgNameCn',
                title: '服务商',
                align: 'center',
                width: "127px"
            },
            {
                field: 'nodeNameCn',
                title: '操作环节',
                align: 'center',
                width: "80px"
            },
            {
                field: 'statusNameCn',
                title: '状态',
                align: 'center',
                width: "60px"
            },
            {
                field: 'counts',
                title: '附件',
                align: 'center',
                width: "40px",
                formatter: function (value, row, index) {
                    if (value > 0) {
                        return '<a href="#" data-toggle="modal" onclick="clickAtta('+row.id+')" data-target="#checkAtta">查看</a>'
                    } else {
                        return ""
                    }
                }
            },
            {
                field: 'deptName',
                title: '操作角色',
                align: 'center',
                width: "60px"
            },
            {
                field: 'actualDate',
                title: '环节完成时间',
                align: 'center',
                width: "100px",
                formatter: function (value, row, index) {
                    if (value) {
                        return new Date(value).Format("yyyy-MM-dd");
                    }
                    else {
                        return ""
                    }
                }
            },
            {
                field: 'planDate',
                title: '服务计划完成时间',
                align: 'center',
                width: "120px",
                formatter: function (value, row, index) {
                    if (value) {
                        return new Date(value).Format("yyyy-MM-dd");
                    }
                    else {
                        return ""
                    }
                }
            },
            {
                field: 'id',
                title: '操作',
                align: 'center',
                width: "70px",
                formatter: function (value, row, index) {
                    if(row.status !=2){
                        return '<button onclick="executeOrder('+value+',&quot'+row.nodeNameCn+'&quot,'+row.status+')" class="btn btn-primary" data-toggle="modal" data-target="#comply">执行</buttonon>'
                    }else {
                        return ""
                    }
                }
            }
        ],
        onSelectPage: function (pageNumber, pageSize) {
            $('#easyUi_table').datagrid("reload",
                {
                    srvOrderId:$("#srvOrderId").val(),
                    serviceId:$("#nodeSearchService").val(),
                    status:$("#nodeSearchStatus").val(),
                    srvOrgId:$("#org").val(),
                    deptId:$("#dept").val(),
                    pageNumber: pageNumber,
                    pageSize: pageSize
                })
        }
    };

    $("#search").on("click",function(){
        $('#easyUi_table').datagrid('load',{
            srvOrderId:$("#srvOrderId").val(),
            serviceId:$("#nodeSearchService").val(),
            status:$("#nodeSearchStatus").val(),
            srvOrgId:$("#org").val(),
            deptId:$("#dept").val()
        });
    })

    //初始化加载表格
    easyUiTable.initTable(easyUiTableParam);
    $(window).resize(function () {
        easyUiTable.initTable(easyUiTableParam);
    });


    //选择贸易订单
    $("#selTradeOrder").on("change", function () {
        $.ajax({
            url: window.ctx + "/serviceOrder/getOrder/" + $("#selTradeOrder").val(),
            type: "get",
            success: function (data) {
                $("#orderDetail").empty();
                $("#orderDetail").append(data);
            }

        })
    });


    $('[data-toggle="tooltip"]').tooltip()



    $("#org").on("change",function(){
        $.ajax({
            url:window.ctx+"/serviceOrder/findDeptBymOrgId",
            type:"post",
            data:{
                orgId:$("#org").val()
            },
            dataType:"json",
            success:function(data){
                $("#dept").children().remove();
                $("#dept").append("<optoion value=''>全部</optoion>")
                data.data.forEach(function(d){
                    $("<option/>").val(d.id).text(d.deptName).appendTo($("#dept"))
                })
            }
        })
    })

    $("#srvOrderDtlService").on("change",function(){
        $.ajax({
            url:window.ctx+"/serviceOrder/findOrgByServiceId",
            type:"post",
            data:{
                serviceId:$("#srvOrderDtlService").val()
            },
            dataType:"json",
            success:function(data){
                $("#executeOrg").children().remove();
                data.data.forEach(function(d){
                    $("<option/>").val(d.id).text(d.orgNameCn).appendTo($("#executeOrg"))
                })
            }
        })
    })


    $(document).on("change","#attaId",function(){
        if(!$("#attaName").val()){
            alert("输入文件名称")
            return false;
        }
        var skuImgSize = $("#atta").children("div").length;
        if(skuImgSize > 4){
            alert("最多上传5张图片")
            return false;
        }
        var $dom = $(this);
        var id=$dom.attr("id");
        if (!/\.(gif|jpg|jpeg|png|bmp|GIF|JPG|PNG|BMP|JPEG)$/.test($dom.val())) {
            alert('"错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp格式图像!"');
            return false;
        }
        if ($dom.get(0).files[0].size > 1024 * 1024 * 5){
            alert('不能上传超过5M的文件，您上传的文件过大，请重新上传！');
            $dom.val(null);
            return false;
        }
        $.ajaxFileUpload({
            url:window.ctx+'/aldUpload/uploadImg',
            secureuri:false,
            fileElementId:id,
            dataType:"json",
            success: function(data){
                var result =(data.data.urlPath).split('.').pop().toLowerCase();
                if(data.result){
                    var str=""
                    str+='<div class="col-xs-6 col-xs-offset-3">'
                    str+= $("#attaName").val()
                    str+='<input type="hidden" value='+data.data.urlPath+' name="nodeAttaPath">'
                    str+='<input type="hidden" value='+$("#attaName").val()+' name="nodeAttaName">'
                    str+='<input type="hidden" value='+result+' name="nodeAttaType">'
                    str+='<a href="javascript: void(0)" class="icon icon-del visible pull-right"></a>'
                    str+='</div>'
                    $("#atta").append(str);
                }else{
                    alert("上传图片失败");
                }
            },error: function (xml, status, e){
                alert("上传图片失败");
            }
        });
    });

    var execute = {
        ele: "#execute",
        submitType: "post",
        postUrl:window.ctx+"/serviceOrder/detil",
        rules: {
            srvOrgId: {
                required:true
            },
            serviceId: "required",
            finishDate:"required"
        },
        message: {
            srvOrgId: {
                required: "服务公司不能为空"
            },
            serviceId: {
                required: "服务不能为空"
            },
            finishDate:{
                required:"计划时间不能为空"
            }
        },
        postDone: function (data) {
            alert(data.msg)
            location.reload()
        }
    }
    validatorFrom.initValidatorFrom(execute);

    var executeNode = {
        ele: "#executeNode",
        submitType: "auto",
        rules: {
            actulDate: {
                required:function(){
                    return ($("#nodeStatus")==2)
                }
            },
            status: "required",
        },
        message: {
            status: {
                required: "状态不能为空"
            },
            actulDate:{
                required:"实际完成时间不能为空"
            }
        },
        validateDone: function (form) {
            var json= []
            $("#atta").find($(".col-xs-6")).each(function(i,n){
                console.log($(this))
                var atta={}
                atta.attaPath=$(this).find($("input[name=nodeAttaPath]")).val();
                atta.attaName=$(this).find($("input[name=nodeAttaName]")).val();
                atta.fileType=$(this).find($("input[name=nodeAttaType]")).val();
                json.push(atta)
            })
            $("#attaJson").val(JSON.stringify(json))
            $.ajax({
                url:window.ctx+"/serviceOrder/executeSave",
                type:"post",
                dataType:"json",
                data:$("#executeNode").serialize(),
                success:function(data){
                    alert(data.msg)
                    location.reload()
                }
            })
        }
    }
    validatorFrom.initValidatorFrom(executeNode);

})


function executeOrder(nodeId,nodeName,status){
    $("#nodeName").text(nodeName);
    $("#nodeStatus").val(status);
    $("#nodeId").val(nodeId);
    $("#atta").empty()
    $.ajax({
        url:window.ctx+"/serviceOrder/getNodeByNodeId",
        type:"post",
        dataType:"json",
        data:{
            nodeId:nodeId
        },
        success:function(data){
            data.data.forEach(function(d){
               var str=''
                str+='<div class="col-xs-6 col-xs-offset-3">'
                str+= d.attaName
                str+='<input type="hidden" value='+d.attaPath+' name="nodeAttaPath">'
                str+='<input type="hidden" value='+d.attaName+' name="nodeAttaName">'
                str+='<input type="hidden" value='+d.fileType+' name="nodeAttaType">'
                str+='<a href="javascript: void(0)" class="icon icon-del visible pull-right"></a>'
                str+='</div>'
                $("#atta").append(str)
            })
        }
    })
}


function changeStatus(srvOrderId,status){
    if(confirm("是否确认执行完成？")){
        $.ajax({
            url:window.ctx+"/serviceOrder/changeStatus",
            type:"post",
            data:{
                srvOrderId:srvOrderId,
                status:status
            },
            dataType:"json",
            success:function(data){
                location.href = window.ctx+"/serviceOrder/list"
            }
        })
    }
}

function clickAtta(nodeId){
    $.ajax({
        url:window.ctx+"/serviceOrder/getAtta",
        dataType:"json",
        type:"post",
        data:{
            nodeId:nodeId
        },
        success:function(data){
            var str=""
            data.data.forEach(function(d){
                str+='<div class="col-xs-6">';
                str+='<a target="_blank" href="'+ d.attaPath+'"><img src="'+ d.attaPath+'" class="img-responsive dis_inb" alt=""></a>';
                str+='<p>'+ d.attaName+'</p></div>'
            })
            $("#attaRow").empty()
            $("#attaRow").append(str)
        }
    })
}