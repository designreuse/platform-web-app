$(function() {
//
    var submit = $("#submitForm");
   function saveStore(){
        var store={};
        var warehouseName= $("#warehouseName").val();
        var id= $("#id").val();
        var parkId = $("#parkId").val();
        var orgId = $("#orgId").val();
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        var userName = $("input[name='userName']");
        var contacts = $("input[name='contacts']");

       var userNameOther = $("input[name='userNameOther']");
       var contactsOther = $("input[name='contactsOther']");


        var WarehouseManagerVo=new Array();

        if(!warehouseName){
           // $("#swarehouseName").html("<font color='red'>仓库名不能为空</font>");
            return;
        }
        $("#swarehouseName").html('');
        if(!parkId){
            //$("#sparkId").html("<font color='red'>请选择园区</font>");
            return;
        }
        $("#sparkId").html('');
        if(!orgId){
           // $("#sorgId").html("<font color='red'>请输入委托方</font>");
            return;
        }
        $("#sorgId").html('');
        if(!startDate || !endDate){
           // $("#sdate").html("<font color='red'>时间不能为空</font>");
            return;
        }
        if(toDate(startDate)>toDate(endDate)){
            //$("#sdate").html("<font color='red'>开始时间不能大于截止时间</font>");
            return ;
        };
//        var suserName = $("span[name='suserName']");
//        var scontacts = $("span[name='scontacts']");

        var mobile = /^0?1[3|4|5|8][0-9]\d{8}$/;
        for(var i=0;i<userName.length;i++){
            var usernames=userName[i].value;
            var contactss=contacts[i].value;
            var vo={}
            vo.userName = usernames;
            vo.contacts = contactss;
            WarehouseManagerVo[i] = vo;
        }

       for(var i=0;i<userNameOther.length;i++){
           var usernamesOther=userNameOther[i].value;
           var contactssOther=contactsOther[i].value;
           var voOhter={}
           if(usernamesOther!=""||contactssOther!=""){
               voOhter.userName = usernamesOther;
               voOhter.contacts = contactssOther;
               WarehouseManagerVo[WarehouseManagerVo.length] = voOhter;
           }

       }


        store.id = id;
        store.warehouseName = warehouseName  ;
        store.parkId = parkId ;
        store.orgId =  orgId;
        store.startDate = startDate ;
        store.endDate = endDate ;
        store.WarehouseManagerVo = WarehouseManagerVo ;
        $.ajax({
            url: window.ctx + "/store/save",
            type: "post",
            data: {"params":"["+JSON.stringify(store)+"]"} ,
            dataType: "json",
            success: function () {
                window.location.href=window.ctx+"/store/list";
            }, error: function () {
                alert("保存失败！")
            }
        });
    }

    $('#addManag').click(function() {
        $('#manag').append('<div class="formtable-list"><div class="col-md-6"><label class="col-md-4 formtable-list-default">库管员：</label><div class="col-md-8"><input class="form-control" type="text" name="userNameOther"></div></div><div class="col-md-6"><label class="col-md-4">库管员手机号：</label><div class="col-md-8"><div class="form-inline"><div class="form-group"><input class="form-control" type="text" name="contactsOther"></div><button type="button" class="close mar_t10" onclick="javascript: $(this).parent().parent().parent().parent().remove();"><span aria-hidden="true">×</span></button></div></div></div></div>')
    })

    function toDate(str){
        var sd=str.split("-");
        return new Date(sd[0],sd[1],sd[2]);
    }

    $("#dealingsOrgEdit").blur(function(){
        if($(this).val()==""){
            $( "#orgId").val("");
        }
    })

    $("#dealingsOrgEdit").autocomplete({
            source:window.ctx+"/store/OrgName",
            minLength: 1,
            autoFocus:true,
            select:function(e, ui) {
                $( "#orgId").val(ui.item.id);
            },
            response:function(e, ui) {
                $( "#orgId").val("");
            }
        }
    );



    var option = {
        ele: "#form1",
        submitType: "auto",
        rules: {
            warehouseName: {
                required: true
            },
            parkId: {
                required: true
            },
            startDate:{
                required: true
            },
            endDate:{
                required: true
            },
            userName:{
                required: true
            },
            contacts:{
                isMobile :true
            },
            contactsOther:{
                isMobile :true
            },
            dealingsOrgEdit:{
                required: true
            }
        },
        messages:{
            warehouseName: {
                required: "仓库名不能为空"
            },
            parkId: {
                required: "请选择园区"
            },
            dealingsOrgEdit:{
                required:"请输入委托方"
            },
            startDate:{
                required:"请选择开始时间"
            },
            endDate:{
                required:"请选择截止时间"
            },
            userName:{
                required:"请输入库管员姓名"
            },
            contacts:{
                required:"联系方式不正确"
            },
            contactsOther:{
                required:"联系方式不正确"
            }
        },
        validateDone: function(form){
            $("#submitForm").attr("disabled","disabled")
            saveStore()
        }

    }

    validatorFrom.initValidatorFrom(option);
})







