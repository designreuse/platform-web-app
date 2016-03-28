/**
 * Created by Administrator on 2015/10/22.
 */
$(function(){
//      $("#bannerForm").form({
//          url:window.ctx+"/banner/insert",
//          success:function(data){
//              var result = jQuery.parseJSON(data);
//              alert(result.msg)
//          }
//      })
    })
function myformatter(date){
    var y = date.getFullYear();
    var m = date.getMonth()+1;
    var d = date.getDate();
    return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
    }

function myparser(s){
    if (!s) return new Date();
    var ss = (s.split('-'));
    var y = parseInt(ss[0],10);
    var m = parseInt(ss[1],10);
    var d = parseInt(ss[2],10);
    if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
    return new Date(y,m-1,d);
    } else {
    return new Date();
    }
    }


function reOLUploadFro(){
    $("#bannerLogoId").trigger("click");
    }
$(document).on("change","#bannerLogoId",function(){
    var $dom = $("#bannerLogoId");
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
    $("[name=logoUrl]").val(src);
    $("#bannerLogoSrc").attr('src',src);
    }else{
    alert("上传图片失败");
    }
    },error: function (xml, status, e){
    alert("上传图片失败");
    }
    });
    })

$("#submitForm").click(function(){

    if($("#appId").combobox("getValue")==""){
    alert("请选择平台");
    return;
    }
    if($("#adId").combobox("getValue")==""){
    alert("请选择广告位");
    return;
    }

    if($("#startTime").datebox('getValue')==""||$("#endTime").datebox('getValue')==""){
    alert("请选择投放时间");
    return;
    }else if($("#startTime").datebox('getValue')>$("#endTime").datebox('getValue')){
    alert("开始时间大于结束时间");
    return;
    }
    if($("#logoUrl").val()==null||$("#logoUrl").val()==""){
    alert("请选择广告LOGO");
    return;
    }
    if($("#url").val()==null||$("#url").val()==""){
    alert("请输入跳转链接");
    return;
    }

    if($("#bannerDesc").val()==null||$("#bannerDesc").val()==""){
    alert("请输入广告描述");
    return;
    }

//      $("#bannerForm").submit();
    $.ajax({
    type: "post",
    url: window.ctx+"/banner/update",
    data: {
    id:$("#bannerId").val(),
    appId:$("#appId").combobox("getValue"),
    adId:$("#adId").combobox("getValue"),
    startTime:$("#startTime").datebox('getValue'),
    endTime:$("#endTime").datebox('getValue'),
    bannerLogo:$("#logoUrl").val(),
    url:$("#url").val(),
    bannerDesc:$("#bannerDesc").val()

    },
    dataType: "json",
    success: function(data){
    if(data.result){
    alert(data.msg);
    window.location=window.ctx+"/banner/list";
    }else{
    alert(data.msg);
    }

    }
    })
    })