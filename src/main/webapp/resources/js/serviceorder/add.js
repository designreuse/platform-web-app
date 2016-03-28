$("#orgNameInput").on("keyup",function(){
    var keyword = $(this).val();
    var orgSelect = $("#orgSelect");
    if(keyword){
        $.get("${ctx}/enterprise/orgName/"+keyword,function(data){
            orgSelect.children().remove();
            data.forEach(function(d){
                $("<option/>").val(d.id).text(d.orgNameCn).appendTo(orgSelect);
            });
            if(data.length){
                orgSelect.show();
                $("#orgSelect").removeAttr("disabled");
            }else{
                orgSelect.val("").hide();
                $("#orgSelect").removeAttr("disabled");
            }
        },"json");
    }else{
        orgSelect.val("").hide();
        $("#orgSelect").removeAttr("disabled");
    }
});