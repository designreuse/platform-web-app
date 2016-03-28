

    $(function(){
        validatorFrom.initValidatorFrom({
            ele: "#checkForm",
            rules:{adultContent:'required'},
            submitType: 'submit'
        });
        $("#orgCheckbtn").click(function(){
            $("#checkForm").attr({action:window.ctx+'/cmpMbr/checkOrg',flag:1});
        });
        $("button[name='attaCheck']").click(function(){
            $("#checkForm").attr({action:window.ctx+'/cmpMbr/checkAtta',flag:2});
            $("#checkForm input[name='attaId']").val($(this).attr("attaId"));
            $("#checkForm input[name='attaName']").val($(this).attr("attaName"));
        });
        $("button:contains('通过')").click(function (){
            var formObj=$(this).closest("form");
            if(formObj.attr("flag")==1){
                $("input[name='adultAction'][value='1']").attr({checked:"checked"});
            }else{
                $("input[name='attaStatusAction'][value='1']").attr({checked:"checked"});
            }
        });
        $("button:contains('拒绝')").click(function (){
            var formObj=$(this).closest("form");
            if(formObj.attr("flag")==1){
                $("input[name='adultAction'][value='2']").attr({checked:"checked"});
            }else{
                $("input[name='attaStatusAction'][value='0']").attr({checked:"checked"});
            }
        });


    });

function openUrl(data){
    window.open(data.src.split("@")[0])
}