$(function() {

    if($("#srvOrderId").val()){getProductList($("#srvOrderId").val())}
    $("#srOrder").autocomplete({
            source:window.ctx+"/stock/serOrderName",
            minLength: 1,
            autoFocus:true,
            select:function(e, ui) {
                //alert(ui.item.id)
                $( "#srOrderId").val(ui.item.id);
                getProductList(ui.item.id);
            }
        }
    );
    function getProductList(srvOrderId){
        $.ajax({
            url: window.ctx + '/stock/productList?srvOrderId='+srvOrderId,
            dataType: "json",
            success:
                function (msg) {
                    console.log(msg.data.list);
                    var orgName = msg.data.bo.countryType==2? msg.data.bo.orgNameRu:msg.data.bo.orgNameCn;
                    $("#dealingsOrgEdit").val(orgName);
                    $("#orgId").val(msg.data.bo.orgId);
                    var data = msg.data.list;
                    var html = "";
                    var ioType=$("#ioType").val()== 'out'?'出':'入';
                    for(var i=0;i<data.length;i++){
                        var re = data[i];
                        var productId=re.productId||"";
                        html=html+"<div class='product' id='product"+i+"' >									     ";
                        html=html+"        <div class='formtable-list'>						     ";
                        html=html+"            <div class='col-xs-6'>						     ";
                        html=html+"                <div class='col-xs-4 text-right label-cont'>			     ";
                        html=html+"                    <img src='"+re.photoUrl+"' width='80' height='80' alt=''>    <input type='hidden' value='"+re.photoUrl+"' name='logoUrl'> <input type='hidden' value='"+re.tradeOrderId+"' name='tradeId'> ";
                        html=html+"                </div>							     ";
                        html=html+"                <div class='col-xs-8 label-cont pad_l20'>				     ";
                        html=html+"                    <p style='margin-left: 10px;font-weight:300 '><br/>							     ";
                        html=html+"                          "+re.productName+"<br/>"+re.catalogNameCn+"<br/>HS CODE:"+re.hscode+"	 <input type='hidden' value='"+re.productName+"' name='productName'>	 <input type='hidden' value='"+productId+"' name='productId'>		     ";
                        html=html+"                    </p>							     ";
                        html=html+"                </div>							     ";
                        html=html+"            </div>								     ";
                        html=html+"            <div class='col-xs-6'>						     ";
                        html=html+"                <label class='col-md-4 formtable-list-require'>品类:</label><div class='col-md-8 label-cont'>"+re.catalogNameFirstCn+","+re.catalogNameSecondCn+","+re.catalogNameCn+"</div>";
                        html=html+"                <label class='col-md-4 formtable-list-require'>"+ioType+"库数量：</label> ";
                        html=html+"                <div class='col-md-8'>					     ";
                        html=html+"                    <div class='form-inline'>				     ";
                        html=html+"                        <div class='form-group'>				     ";
                        html=html+"                            <input type='text' class='form-control' name='ioNums'> 件	     ";
                        html=html+"                        </div>						     ";
                        html=html+"                    </div>							     ";
                        html=html+"                </div>							     ";
                        html=html+"            </div>								     ";
                        html=html+"        </div>								     ";
                        html=html+"        <div class='formtable-list'>						     ";
                        html=html+"            <div class='col-xs-6'>						     ";
                        html=html+"                <label class='col-md-4 formtable-list-require'>毛重：</label>     ";
                        html=html+"                <div class='col-md-8'>					     ";
                        html=html+"                    <div class='form-inline'>				     ";
                        html=html+"                        <div class='form-group'>				     ";
                        html=html+"                            <input type='text' class='form-control' name='grossWeight'> 吨	     ";
                        html=html+"                        </div>						     ";
                        html=html+"                    </div>							     ";
                        html=html+"                </div>							     ";
                        html=html+"            </div>								     ";
                        html=html+"            <div class='col-xs-6'>						     ";
                        html=html+"                <label class='col-md-4 formtable-list-require'>皮重：</label>     ";
                        html=html+"                <div class='col-md-8'>					     ";
                        html=html+"                    <div class='form-inline'>				     ";
                        html=html+"                        <div class='form-group'>				     ";
                        html=html+"                            <input type='text' class='form-control' name='tare'> 吨	     ";
                        html=html+"                        </div>						     ";
                        html=html+"                    </div>							     ";
                        html=html+"                </div>							     ";
                        html=html+"            </div>								     ";
                        html=html+"        </div>								     ";
                        html=html+"        <div class='formtable-list'>						     ";
                        html=html+"            <div class='col-xs-6'>						     ";
                        html=html+"                <label class='col-md-4 formtable-list-require'>净重：</label>     ";
                        html=html+"                <div class='col-md-8'>					     ";
                        html=html+"                    <div class='form-inline'>				     ";
                        html=html+"                        <div class='form-group'>				     ";
                        html=html+"                            <input type='text' class='form-control' name='netWeight'> 吨	     ";
                        html=html+"                        </div>						     ";
                        html=html+"                    </div>							     ";
                        html=html+"                </div>							     ";
                        html=html+"            </div>								     ";
                        html=html+"            <div class='col-xs-6'>						     ";
                        html=html+"                <label class='col-md-4'>装卸组：</label>			     ";
                        html=html+"                <div class='col-md-8'>					     ";
                        html=html+"                    <input type='text' class='form-control' name='stevedoring'>			     ";
                        html=html+"                </div>							     ";
                        html=html+"            </div>								     ";
                        html=html+"        </div>								     ";
                        html=html+"       <div class='formtable-list'> ";
                        html=html+"      <div class='col-xs-6'> ";
                        html=html+"       <label class='col-md-4 formtable-list-require'>车牌号码：</label> ";
                        html=html+"       <div class='col-md-8'> ";
                        html=html+"           <input type='text' class='form-control' name='carLicence'> ";
                        html=html+"           <input type='hidden' class='form-control' name='carId'> ";
                        html=html+"           </div> ";
                        html=html+"        </div> ";
                        html=html+"       <div class='col-xs-6'> ";
                        html=html+"           <label class='col-md-4 formtable-list-require'>司机姓名：</label> ";
                        html=html+"            <div class='col-md-8'> ";
                        html=html+"               <input type='text' class='form-control' name='driverName'> ";
                        html=html+"               <input type='hidden' class='form-control' name='driverId'> ";
                        html=html+"               </div> ";
                        html=html+"           </div> ";
                        html=html+"       </div> ";
                        html=html+"       <div class='formtable-list'> ";
                        html=html+"           <div class='col-xs-4 col-md-offset-2 pad_10'> ";
                        html=html+"               <a href='javascript:void()' class='add-car'><span class='icon icon-add'></span>继续添加车辆</a> ";
                        html=html+"          </div> ";
                        html=html+"       </div> ";
                        html=html+"    </div>									     ";
                        //     if(i < data.length){
                        html=html+"    <div class='formtable-list'>";
                        html=html+"    <div class='col-xs-12 label-cont'>";
                        html=html+"    &nbsp; ";
                        html=html+"    </div> ";
                        html=html+"    </div> ";
                        //    }
                    }
                    $("#productInfo").html("");
                    $("#productInfo").append(html)
                }
        })
    }
    $(document).on("click",".add-car",function() {
        $(this).parent().parent().before('<div class="formtable-list"><div class="col-xs-6"><label class="col-md-4 formtable-list-require">车牌号码：</label><div class="col-md-8"><input type="text" class="form-control" name="carLicence"></div></div><div class="col-xs-6"><label class="col-md-4 formtable-list-require">司机姓名：</label><div class="col-md-8"><div class="form-inline"><div class="form-group"><input type="text" class="form-control" name="driverName"><span class="icon icon-del visible" onclick="javascript: $(this).parent().parent().parent().parent().parent().remove()"></span></div></div></div></div></div>')
    })


    $("#warehouse").autocomplete({
            source:window.ctx+"/stock/storeName",
            minLength: 1,
            autoFocus:true,
            select:function(e, ui) {
                $( "#warehouseId").val(ui.item.id);
            }
        }
    );

    $("#manager").autocomplete({
            source:window.ctx+"/stock/managerName",
            minLength: 1,
            autoFocus:true,
            select:function(e, ui) {
                $( "#managerId").val(ui.item.id);
            }
        }
    );


    $("#warehouse").autocomplete({
            source:window.ctx+"/stock/storeName",
            minLength: 1,
            autoFocus:true,
            select:function(e, ui) {
                $( "#warehouseId").val(ui.item.id);
            }
        }
    );

    $("#manager").autocomplete({
            source:window.ctx+"/stock/managerName",
            minLength: 1,
            autoFocus:true,
            select:function(e, ui) {
                $( "#managerId").val(ui.item.id);
            }
        }
    );

    $("#dealingsOrgEdit").autocomplete({
            source:window.ctx+"/store/OrgName",
            minLength: 1,
            autoFocus:true,
            select:function(e, ui) {
                $( "#orgId").val(ui.item.id);
            }
        }
    );


    var ioType=$("#ioType").val()== 'out'?'出':'入';
    var option = {
        ele: "#form1",
        submitType: "auto",//提交的方法post或者submit或者auto
        rules: {
            srOrder: {
                required: true
            },
            warehouse: {
                required: true
            },
            dates:{
                required: true
            },
            manager:{
                required: true
            },
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
            srOrder: {
                required: "请选择服务订单号"
            },
            warehouse: {
                required: "请选择仓库"
            },
            dates:{
                required:"日期不能为空"
            },
            manager:{
                required:"请选择库管员"
            },
            ioNums:{
                required:ioType+"库不能为空"
            },
            grossWeight:{
                required:"毛重不能为空"
            },
            tare:{
                required:"皮重不能为空"
            },
            netWeight:{
                required:"净重不能为空"
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
})

//触发file的点击事件
function reOLUploadFro(){
    $("#stockLogoUrl").trigger("click");
}
//file点击后会选择修改文件,当文件改变时触发
$(document).on("change","#stockLogoUrl",function() {
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


function notFindManager(){
    var ware = $("#warehouseId").val();
   if(!ware){
       util.alertError("必须先输入仓库名称！！");
       return
   }
    window.open(window.ctx+"/store/detail?id="+ware,"_blank")
   // window.location.href=window.ctx+"/store/detail?id="+ware;
};
//
function saveInOut(){
    var flag=false;
    var stock={};
    var srOrder =$("#srOrder").val();
    var srOrderId =$("#srOrderId").val();
    var warehouseId =$("#warehouseId").val();
    var ioDetailType =$("#ioDetailType").val();
    var ioType =$("#ioType").val();
    if(ioType == 'out'){
        ioType = 1;
    }else if(ioType == 'in'){
        ioType = 2;
    }
    var dates =$("#dates").val();
    var orgId =$("#orgId").val();
    var manager =$("#manager").val();
    var stockLogo =$("#stockLogo").val();
    var marks =$("#marks").val();

    stock.srvOrderCode = srOrder;
    stock.srvOrderId = srOrderId;
    stock.warehouseId = warehouseId;
    stock.ioType = ioType;
    stock.ioDetailType = ioDetailType;
    stock.ioDate = dates;
    stock.orgId = orgId;
    stock.warehouseManager = manager;
    stock.voucherLogo = stockLogo;
    stock. marks = marks;
    var productVo =new Array();
    $("#productInfo").find(".product").each(function(i,div){
        console.log(div);
        var products={} ;
        var ioNums = $("input[name='ioNums']",div).val();
        var logoUrl = $("input[name='logoUrl']",div).val();
        var tradeId = $("input[name='tradeId']",div).val();
        var productName = $("input[name='productName']",div).val();
        var productId = $("input[name='productId']",div).val()||"";
        var grossWeight = $("input[name='grossWeight']",div).val();
        var tare = $("input[name='tare']",div).val();
        var netWeight = $("input[name='netWeight']",div).val();
        var stevedoring = $("input[name='stevedoring']",div).val();
        products.ioNums = ioNums ;
        products.tradeId =  tradeId;
        products.photoUrl = logoUrl ;
        products.productId =  productId;
        products.netWeight =  netWeight;
        products.grossWeight =  grossWeight;
        products.tare =  tare;
        products.stevedoring = stevedoring ;
        if(!productId){
            flag=true;
            return false;
        }
        var car=$("input[name='carLicence']",div);
        var driver=$("input[name='driverName']",div)
        var carBo =new Array();
        var driverBo =new Array();

        for(var j=0 ;j< car.length  ; j++){
            var cars = {};
            var drivers = {};
            console.log($(car[j]).val())
            cars.carLicence = $(car[j]).val();
            cars.carId = $(car[j]).next("input").val();
            drivers.driverName =$(driver[j]).val();
            drivers.driverId =$(driver[j]).next("input").val();
            carBo[j]=cars;
            driverBo[j]=drivers;
        }
        products.stockProductDriverVoList = driverBo;
        products.stockProductCarVoList =carBo ;
        productVo[i] = products;

    });
    for(var i=0;i<productVo.length;i++){
       if(!productVo[i].productId){
           flag=true;
           break;
       }
    }
    if(flag||productVo.length==0){
        alert("数据错误！请联系管理员")
       // window.location.href=window.ctx+"/stock/list";
        return false;
    }
    if (!$(".popover").length) {
        stock.stockProductVoList = productVo;
        console.log(stock);
        var smtForm = $("#addStockDtlForm");
        $("input", smtForm).val("[" + JSON.stringify(stock) + "]");
        smtForm.submit();
        alert("保存成功！！！！");
    }
}

