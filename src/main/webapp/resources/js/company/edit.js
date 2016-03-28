/**
 * Created by Administrator on 2015/11/23.
 */
$(".servapti-pic .close").click(function(){
    $(this).parent().parent().append('<div class="servapti-input text-center"><input type="file" class="btn-uploadpic mar_t10" accept=".jpg, .png, .pdf"><button type="submit" class="btn btn-primary mar_t10">上传</button></div>');
    $(this).parent().remove();
})
$(function(){
    //地址三级联动
    var provSelect = $("#provinceId");
    var citySelect = $("#cityId");
    var distSelect = $("#districtId");
    $("#countryId").change(function(){
        loadAddress("/address/province/"+$(this).val(), provSelect);
        provSelect.children().first().siblings().remove();
        citySelect.children().first().siblings().remove();
        distSelect.children().first().siblings().remove();

    });
    if ("" === $("#provSelect").val()) {
        loadAddress("/address/province/1", provSelect);
        citySelect.children().first().siblings().remove();
        distSelect.children().first().siblings().remove();
    }
    provSelect.on("change", function () {
        var provId = provSelect.val();
        if (provId) {
            distSelect.children().first().siblings().remove();
            loadAddress("/address/city/" + provId, citySelect);
        } else {
            citySelect.children().first().siblings().remove();
            distSelect.children().first().siblings().remove();
        }
    });
    citySelect.on("change", function () {
        var cityId = citySelect.val();
        if (cityId) {
            loadAddress("/address/district/" + cityId, distSelect);
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
})