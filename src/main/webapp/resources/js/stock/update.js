$(function() {


    $("#goDetails").on("click",function(){
        goDetail();
    })

    $("#goDetail").on("click",function(){
        goDetail();
    })

    function goDetail(){
        var id = $("#ids").val();
        var types = $("#ioType").val();
        var type;
        if(types == 2){
            type="in";
        }else if(types == 1){
            type = "out";
        }

        var url = window.ctx+"/stock/detail?pageType=detail&id="+id+"&type="+type;
        window.location.href= url;
    }

    $(".add-car").click(function() {
    $(this).parent().parent().prev().append('<div class="formtable-list"><div class="col-xs-6"><label class="col-md-4 formtable-list-require">车牌号码：</label><div class="col-md-8"><input type="text" class="form-control" name="carLicence"></div></div><div class="col-xs-6"><label class="col-md-4 formtable-list-require">司机姓名：</label><div class="col-md-8"><div class="form-inline"><div class="form-group"><input type="text" class="form-control" name="driverName"><span class="icon icon-del visible" onclick="javascript: $(this).parent().parent().parent().parent().parent().remove()"></span></div></div></div></div></div>')
})


    var ioType=$("#ioType").val()==2?'入':'出';
    var option = {
        ele: "#form1",
        submitType: "auto",//提交的方法post或者submit或者auto
        rules: {
            dates:{
                required: true,
                dateISO: true
            },
            manager:{
                required: true
            }

        },
        messages:{
            dates:{
                required:"日期不能为空"
            },
            manager:{
                required:"库管员不能为空"
            }
        },
        validateDone: function(form){
            saveInOut()
        }
    }
    var option2 = {
        ele: "#form2",
        submitType: "auto",//提交的方法post或者submit或者auto
        rules: {
            ioNums:{
                required: true,
                number :true
            },
            grossWeight:{
                required: true,
                number :true
            },
            tare:{
                required: true,
                number :true
            },
            netWeight:{
                required: true,
                number :true
            },
            carLicence:{
                required: true,
                minlength:7,
                isCarLicence:true
            },
            driverName:{
                required: true,
                isDriverName:true
            }
        },

        messages:{
            ioNums:{
                required:ioType+"库不能为空且只能是数字"
            },
            grossWeight:{
                required:"毛重不能为空且只能是数字"
            },
            tare:{
                required:"皮重不能为空且只能是数字"
            },
            netWeight:{
                required:"净重不能为空且只能是数字"
            },
            carLicence:{
                required:"车牌号不能为空"
            },
            driverName:{
                required:"司机姓名不能为空"
            }
        },
        validateDone: function(form){
            saveInOut()
        }
    }

    validatorFrom.initValidatorFrom(option);
    validatorFrom.initValidatorFrom(option2);

});

var i=1;

//触发file的点击事件
function reOLUploadFro() {
    $("#stockLogoUrl").trigger("click");
}
//file点击后会选择修改文件,当文件改变时触发
$(document).on("change", "#stockLogoUrl", function () {
    var $dom = $("#stockLogoUrl");
    var id = $dom.attr("id");
    if (!/\.(gif|jpg|jpeg|png|bmp|GIF|JPG|PNG|BMP|JPEG)$/.test($dom.val())) {
        alert('"错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp格式图像!"');
        return false;
    }
    if ($dom.get(0).files[0].size > 1024 * 1024 * 5) {
        alert('不能上传超过5M的文件，您上传的文件过大，请重新上传！');
        $dom.val(null);
        return false;
    }
    $.ajaxFileUpload({
        url: window.ctx + "/aldUpload/uploadImg",
        secureuri: false,
        fileElementId: id,
        dataType: "json",
        success: function (data) {
            if (data.result) {
                var src = data.data.urlPath;
                var resourceCode = data.data.resourceCode;
                $("#resourcesCode").val(resourceCode)
                $("[name=stockLogo]").val(src);
                $("#stockSrc").attr('src', src);
            } else {
                alert("上传图片失败");
            }
        }, error: function (xml, status, e) {
            alert("上传图片失败");
        }
    });
})


$("#notFindManager").on("click", function () {
    var ware = $("#warehouseId").val();
    if (!ware) {
        util.alertError("必须先输入仓库名称！！");
        return
    }
    window.open(window.ctx + "/store/detail?id=" + ware, "_blank")
    // window.location.href=window.ctx+"/store/detail?id="+ware;
})

$("#manager").autocomplete({
        source:window.ctx+"/stock/managerName",
        minLength: 1,
        autoFocus:true,
        select:function(e, ui) {
            $( "#managerId").val(ui.item.id);
        }
    }
);





//$("#saveInOut").on("click", function () {
//    saveInOut();
//})




function saveInOut(){
    var stock={};
    var detailType =$("#detailType").val();
    var dates =$("#dates").val();
    var manager =$("#manager").val();
    var stockLogo =$("#stockLogo").val();
    var marks =$("#marks").val();
    var id =$("#ids").val();
    stock.id = id;
    stock.ioDetailType = detailType;
    stock.ioDate = dates;
    stock.warehouseManager = manager;
    stock.voucherLogo = stockLogo;
    stock. marks = marks;
    var types = $("#ioType").val();
    var type;
    if(types == 2){
        type="in";
    }else if(types == 1){
        type = "out";
    }
    $.ajax({
        url: window.ctx + "/stock/saveInOut",
        type: "post",
        data: {"params":"["+JSON.stringify(stock)+"]"} ,
        dataType: "json",
        success: function () {
            var url = window.ctx+"/stock/detail?pageType=update&id="+id+"&type="+type;
            window.location.href= url;
        }, error: function () {
            alert("保存失败！")
        }
    });
}

$("#repeatC").on("click", function () {
    var id =$("#ids").val();
//    $.ajax({
//        url: window.ctx + "/stock/saveProduct",
//        type: "post",
//        data: {"params":"["+JSON.stringify(stock)+"]"} ,
//        dataType: "json",
//        success: function () {
//            var url = window.ctx+"/stock/detail?pageType=update&id="+id+"&type="+type;
//            window.location.href= url;
//        }, error: function () {
//            alert("保存失败！")
//        }
//    });
})


function saveProduct(){
    var stock={};
    var productVo =new Array();
    var flags=true;
    $("#form2").find(".product").each(function(i,div){
        console.log(div)
        var products={} ;
        var ioNums = $("input[name='ioNums']",div).val();
        var productId = $("input[name='productId']",div).val();
        var grossWeight = $("input[name='grossWeight']",div).val();
        var tare = $("input[name='tare']",div).val();
        var netWeight = $("input[name='netWeight']",div).val();
        var stevedoring = $("input[name='stevedoring']",div).val();
        products.ioNums = ioNums ;
        products.stockId =  productId;
        products.netWeight =  netWeight;
        products.grossWeight =  grossWeight;
        products.tare =  tare;
        products.stevedoring = stevedoring ;

        var car=$("input[name='carLicence']",div);
        var driver=$("input[name='driverName']",div);

        var carBo =new Array();
        var driverBo =new Array();

        for(var j=0 ;j< car.length  ; j++){
            var cars = {};
            var drivers = {};
            cars.carLicence = $(car[j]).val();
            drivers.driverName =$(driver[j]).val();
            carBo[j]=cars;
            driverBo[j]=drivers;
        }

        products.stockProductDriverVoList = driverBo;
        products.stockProductCarVoList =carBo ;
        productVo[i] = products;

    });
    stock.stockProductVoList=productVo;
   // console.log(stock);
    var id =$("#ids").val();
    var types = $("#ioType").val();
    var type;
    if(types == 2){
        type="in";
    }else if(types == 1){
        type = "out";
    }
    $.ajax({
        url: window.ctx + "/stock/saveProduct",
        type: "post",
        data: {"params":"["+JSON.stringify(stock)+"]"} ,
        dataType: "json",
        success: function () {
            var url = window.ctx+"/stock/detail?pageType=update&id="+id+"&type="+type;
            window.location.href= url;
        }
    });
}
