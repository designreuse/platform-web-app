$(function() {

    //地址三级联动
    var provSelect = $("#provinceId");
    var countrySelect = $("#countryId");
    var citySelect = $("#cityId");
    var distSelect = $("#districtId");

    if("" === $("#provSelect").val()){

//        citySelect.hide();
//        distSelect.hide();
        loadAddress("/address/province/1",provSelect);
    }

    if("" === $("#distSelect").val()){
//        distSelect.hide();
    }

    countrySelect.on("change",function(){
        var countryId = countrySelect.val();
        if(countryId && countryId !=""){
            citySelect.children().first().siblings().remove();
            distSelect.children().first().siblings().remove();
            loadAddress("/address/province/"+countryId,provSelect);
        }else{
            citySelect.children().first().siblings().remove();
            distSelect.children().first().siblings().remove();
        }
    });

    provSelect.on("change",function(){
        var provId = provSelect.val();
        if(provId){
            distSelect.children().first().siblings().remove();
            loadAddress("/address/city/"+provId,citySelect);
        }else{
            citySelect.children().first().siblings().remove();
            distSelect.children().first().siblings().remove();
        }
    });
    citySelect.on("change",function(){
        var cityId = citySelect.val();
        if(cityId){
            loadAddress("/address/district/"+cityId,distSelect);
        }
    });

    function loadAddress(url,target){
        $.get(window.ctx+url,function(data){
            target.children().first().siblings().remove();
            data.forEach(function(d) {
                target.append($("<option></option>").val(d.id).text(d.cnname+"("+ d.enname+")"));
            });
            if(data.length>0){
                target.show();
            }
        },"json");
    }


    var option = {
        ele: "#form1",
        submitType: "auto",
        rules: {
            carLicence: {
                required: true,
                minlength:7
            },
            carType: {
                required: true
            },
            carCapacity:{
                required: true,
                number:true
            },
            districtId:{
                required:true
            }
        },
        messages:{
            carLicence: {
                required: "车牌号不能为空",
                minlength:"长度大于7"
            },
            carType: {
                required: "请选择车辆类型"
            },
            carCapacity:{
                required:"载重量不能为空且只能是数字"
            },
            districtId:{
                required:"请选择常驻地"
            }
        },
        validateDone:function(form){
            $("#submitCar").attr("disabled","disabled")
            $.ajax({
                url:window.ctx+"/transport/saveCar",
                dataType:"json",
                type:"post",
                data:$("#form1").serialize(),
                success:function(data){
                    location.href=window.ctx+"/transport/listCar"
                }
            })
        }
    }

    validatorFrom.initValidatorFrom(option);

})

function update(){
    window.location.href=window.ctx+"/transport/detailCar?type=update&id="+$("#ids").val();
}

function changeCarStauts(id,disabled) {
    if(disabled==false){
        if(confirm("是否确认停用该车辆？")){
            $.ajax({
                url: window.ctx + '/transport/changeCarStatus?id=' + id+"&disabled="+disabled,
                success: function (msg) {
                    window.location.href=window.ctx+"/transport/detailCar?type=detail&id="+$("#ids").val();
                }
            })
        }
    }else{
        if(confirm("是否确认启用该车辆？")){
            $.ajax({
                url: window.ctx + '/transport/changeCarStatus?id=' + id+"&disabled="+disabled,
                success: function (msg) {
                    window.location.href=window.ctx+"/transport/detailCar?type=detail&id="+$("#ids").val();
                }
            })
        }
    }

}


