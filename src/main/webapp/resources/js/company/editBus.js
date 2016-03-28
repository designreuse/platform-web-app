
    $(function () {
        $("#compApti input").click(function(){
            if($(this).is(":checked")){
                $("#threeCombineForm").removeClass("hidden");
                $("#basicAttaForms").addClass("hidden");
                $("input[name='isThree']").val(1);
            }else{
                $("#basicAttaForms").removeClass("hidden");
                $("#threeCombineForm").addClass("hidden");
                $("input[name='isThree']").val(0);
            }
        });
    //更改公司基本信息
        validatorFrom.initValidatorFrom({
            ele: "#comBasicInfo",
            rules:  {orgNameCn:{ maxlength:100,
                                remote:{
                                    url:window.ctx+"/cmpMbr/checkOrgExists",
                                    type:"post",
                                    data:{
                                        isSelf:function(){
                                            console.info($("input[name='orgNameCnOriginal']").val());
                                            console.info($("input[name='orgNameCn']").siblings("input").val());
                                            return $("input[name='orgNameCn']").val()==$("input[name='orgNameCn']").siblings("input[name='orgNameCnOriginal']").val();
                                        }
                                    }
                             }
                     }
                    ,orgNameRu:{required:true,maxlength:100}
                    ,provId:{required:true}
                    ,cityId:{required:true}
                    ,distId:{required:true}
                    ,addrCn:{required:true,maxlength:200}
                    ,addrRu:{required:true,maxlength:200}
                    ,summaryCn:{required:true,maxlength:500}
                    ,summaryRu:{required:true,maxlength:500}
                    ,corporation:{required:true,maxlength:100}
                    ,optRegionCn:{required:true,maxlength:500}
                    ,corpRegaddrCn:{required:true,maxlength:500}
                    ,corpRegtime:'required'},

            submitType: 'submit'
        });

        //新增部门
        validatorFrom.initValidatorFrom({
            ele: "#exeDepartForm",
            rules: {deptName: 'required'},
            messages: {deptName: '请输入部门名称'},
            submitType: 'auto',
            validateDone: function (form) {
                form.submit();

            }
        });
        //删除部门
        $(".removeDepartBtn").click(function () {
            if(!confirm("确定要删除该部门吗？"))return false;
            var dpartId = $(this).children("input:hidden").val();
//            var departId=$(this).s
            $("<form ></form>").append("<input name='deptId' value='" + dpartId + "'/>").append("<input name='orgId' value='"+$("input[name='orgId']:first").val()+"'/>")
                    .attr("action", window.ctx+"/company/removeDept").submit();

        });
        //新增服务资质
        validatorFrom.initValidatorFrom({
            ele: '#addAbilityForm',
            rules: {srvAbilityName: 'required'},
            messages: {srvAbilityName: '请输入资质名称'},
            submitHandler: function (form) {
                $.ajax({
                    url: window.ctx+"/company/addSrvAbility",
                    data: {attaName: form.srvAbilityName.value, attaType: 4, orgId: $("input[name='orgId']:first").val()},
                    success: function (rsp) {
                        var data = $.parseJSON(rsp);
                        if (data.attaId) {

                            //保存成功
                            //关闭输入框
                            $("#addApti").modal("hide");
                            //添加上传文件节点  隐藏attaId
                            var htm = '<div class="col-sm-3">' +
                                    '   <div class="pad_20">' +
                                    '       <p>' + data.attaName + '</p>' +
                                    '       <div class="servapti-input text-center">' +
                                    '           <input type="file" class="btn-uploadpic mar_t10" accept=".jpg, .png, .pdf">' +
                                    '           <input type="hidden" name="attaId" value="' + data.attaId + '"/>' +
                                    '           <button type="submit" class="btn btn-primary mar_t10">上传</button>' +
                                    '       </div>' +
                                    '   </div>' +
                                    '</div>';
                            $(".formtable-cont .clear").append(htm);
                        } else {
                            //保存失败
                        }
                    },
                    error: function () {
                        alert("保存失败!!!!");
                    }
                });

            }
        });
        //服务部门配置
        $("#srvCfg").click(function () {
            var paramArr = new Array();
            $.each($("div[name='srvcfgArr']"), function () {
                var o = {};
                $.each($(this).children("input:hidden"), function () {
                    o[$(this).attr('name')] = $(this).val();
                });
                $.each($(this).children("select"), function () {
                    o[$(this).attr('name')] = $(this).val();
                });
                if(o['deptId']) {
                    paramArr.push(o);
                }
            });
            if(paramArr.length<1){
                util.alertError("服务执行部门不能为空！");
                return false;
            }
            $(this).siblings("input[type='hidden']").val(JSON.stringify(paramArr));
            $(this).closest("form").submit();
        });
//        validatorFrom.initValidatorFrom({
//            ele:'#srvCfgForm',
//            rule:{deptId:'required'},
//            submitType:'auto',
//            validateDone:function(){
//                var paramArr=new Array();
//                $.each($("#srvCfg div[name='srvcfgArr']"),function(){
//                    var o={};
//                    $.each($(this).children("input:hidden"),function(){
//                        o[$(this).attr('name')]=$(this).val();
//                    });
//                    $.each($(this).children("select"),function(){
//                        o[$(this).attr('name')]=$(this).val();
//                    });
//                    paramArr.push(o);
//                });
//                $(this).siblings("input[type='hidden']").val(JSON.stringify(paramArr));
//                $(this).closest("form").submit();
//            }
//
//        });
        //增加服务资质附件
        validatorFrom.initValidatorFrom({
            ele: "attaName",

            submitType: 'submit'
        });
        //删除服务资质附件
        $("input.fl_r").click(function () {
            var ok=confirm("确定要删除【"+$(this).parent().text().trim()+"】吗?")
            if(!ok)return false;
            $(this).closest("form[name='delForm']")
                    .append("<input name='disabled' value='true'/>").submit();
        });


        function imgOnUploadComplete($this , response){
            console.log($this);
            console.log(response);
            if(typeof (response)=='string'){
                response=JSON.parse(response);
            }
            if($this.attr("id")=="threeLic"||$this.attr("id")=="licLic"||$this.attr("id")=="saxLic"||$this.attr("id")=="orgLic"){
                // alert(response.resultData.urlPath);
                // console.log(response.resultData.urlPath);
                var $pra=$this.closest("form");
                $pra.find("input[name='attaPath']").val(response.resultData.urlPath);
                $pra.find(".changeSrvAtta").trigger("click");
            }
            if($this.attr("id")=="serviceLic"){
                var $pra=$this.closest("form");
                $pra.find("input[name='attaPath']").val(response.resultData.urlPath);
                $pra.find(".changeSrvAtta").trigger("click");
            }
        }

        imgUpload(imgOnUploadComplete);

//图片上传
        $(".addApti").on('click', function(){
            $("#addApti").modal("show");
            $("#addApti").on("shown.bs.modal", function(){
                //imgUpload(imgOnUploadComplete);
            });
        });


      /*  //上传图片
        $("img").click(function () {
            $(this).siblings("input[type='file']").trigger("click");
        });*/

      /*  $("div").delegate("input[type='file']", "change", function () {
            var id = 'fileUpload' + new Date().getTime();
            var name = $(this).attr('name');
            $(this).attr({id: id, name: "file"});
            $.ajaxFileUpload({
                url: window.ctx+"/aldUpload/uploadImg",
                secureuri: false,
                fileElementId: id,
                dataType: "json",
                success: function (data) {
                    if (data.result) {
                        var src = data.data.urlPath;
                        $("#" + id).siblings("img").attr({"src": src+"@200w_130h_1l"});
                        $("#" + id).siblings("input[name='attaPath']").val(src.replace('@.jpg',''));
                        $("#" + id).siblings("input[name='resourceCode']").val(data.data.resourceCode);
                        $("#" + id).siblings(".changeSrvAtta").trigger("click");
                    }
                }, error: function (xml, status, e) {
                    alert("上传图片失败");
                }
            });
        });*/

        $(".changeSrvAtta").click(function () {
            $(this).closest("form").submit();
        });

        //删除部门
        $("#departList").delegate(".close", "click", function () {
            var _this = $(this);
            var departId = _this.siblings("input").val();
            $.ajax({
                url: window.ctx+"/company/removeDept",
                data: {deptId: departId},
                success: function (rsp) {
                    var rsp = $.parseJSON(rsp);
                    alert(rsp.message);
                    if (rsp.rst != -1) {
                        _this.parent().remove();
                    }
                },
                error: function () {
                    alert("删除失败");
                }
            });
        })

    });

