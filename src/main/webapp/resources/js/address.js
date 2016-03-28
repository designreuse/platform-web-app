//异步加载地址
function loadAddress(url,target){
    $.get(window.ctx+url,function(data){
        target.children().first().siblings().remove();
        data.forEach(function(d,i) {
            target.append($("<option></option>").val(d.id).text(d.cnname));
        });
        if(data.length>0){
            target.show();
        }
    },"json");
}