/**
 * Created by Administrator on 2015/10/20.
 */
   /* $(function(){
        $("#productForm").form({
            url:window.ctx+"/product/edit",
            success:function(data){
                var result = jQuery.parseJSON(data)
                alert(result.msg)
            }
        })
      });*/
//触发file的点击事件
function reOLUploadFro(){
    $("#activityLogoUrl").trigger("click");
}
//file点击后会选择修改文件,当文件改变时触发
$(document).on("change","#activityLogoUrl",function(){
    var $dom = $("#activityLogoUrl");
    var id=$dom.attr("id");
    if (!/\.(gif|jpg|jpeg|png|bmp|GIF|JPG|PNG|BMP|JPEG)$/.test($dom.val())) {
        util.alertError('"错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp格式图像!"');
        return false;
    }
    if ($dom.get(0).files[0].size > 1024 * 1024 * 5){
        util.alertError('不能上传超过5M的文件，您上传的文件过大，请重新上传！');
        $dom.val(null);
        return false;
    }
    $.ajaxFileUpload({
        url:window.ctx+"/aldUpload/uploadImg",
        secureuri:false,
        fileElementId:id,
        dataType:"json",
        success: function(data){
            if(data.result){
                console.log(data.data)
                var src= data.data.urlPath;
                var resourceCode= data.data.resourceCode;
                $("#resourcesCode").val(resourceCode)
                $("[name=activityLogo]").val(src);
                $("#activitySrc").attr('src',src);
            }else{
                util.alertError("上传图片失败");
            }
        },error: function (xml, status, e){
            util.alertError("上传图片失败");
        }
    });
})


$(function(){


    /*定义easyUITable的相关参数*/
    var easyUiTableParam = {
        url: window.ctx+'/activity/activityMemberList',
        title:'活动报名',
        onSelectPage:function(pageNumber,pageSize){
            $('#easyUi_table').datagrid("reload",
                {
                    pageNumber:pageNumber,
                    pageSize:pageSize
                })
        },
        columns:[
            {field:'userName',title:'姓名',width:80},
            {field:'orgName',title:'企业',width:120},
            {field:'mobile',title:'手机',width:120},
            {field:'joinNumber',title:'参加人数',width:120,align:'right'},
            {field:'joinNumber',title:'报名人数',width:80,align:'right'},
            {field:'appName',title:'报名来源',width:80,align:'right'},
            {field:'createTimeView',title:'报名时间',width:60,align:'right'}
        ]
    }
    /*easyUI初始化表*/
    easyUiTable.initTable(easyUiTableParam);
    /*回显图片*/
    var activityLogo=$("#activityLogo").val();
    if(activityLogo.length > 0){
        $("#activitySrc").attr("src",activityLogo);
    }
})



