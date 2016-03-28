var validatorFrom = (function(){
    return{
        initValidatorFrom: function(option){//初始化配置
            var _this = this;
            return $(option.ele).validate({
                validClass: "success",
                //onkeyup: true,
                onfocusout: function(element){
                     this.element( element );
                },
                showErrors: function(errorMap, errorList) {
                    $.each(this.successList, function(index, value) {
                        $(value).removeClass("error").addClass("success");
                        return $(value).popover("hide");
                    });
                    return $.each(errorList, function(index, value) {
                        $(value.element).removeClass("success").addClass("error");
                        var _popover;
                        _popover = $(value.element).popover({
                            trigger: "manual",
                            placement: "bottom",
                            content: value.message,
                            template: "<div class=\"popover\"><div class=\"arrow\"></div><div class=\"popover-inner\"><div class=\"popover-content\"><p></p></div></div></div>"
                        });
                        _popover.data("bs.popover").options.content = value.message;
                        return $(value.element).popover("show");
                    });
                },
                rules: option.rules,
                messages: option.messages,
                submitHandler: function(form) {//验证完成进行提交
                    switch (option.submitType){
                        case "submit":
                            _this.onValidatorFormSubmit(form);
                        break;
                        case "post":
                            _this.onValidatorFormPost(option);
                            break;
                        case "auto":
                            option.validateDone(form);
                        break;
                    }


                }
            });
        },
        onValidatorFormSubmit: function(form){//提交from
            form.submit();
        },
        onValidatorFormPost: function(option){
            $.post( option.postUrl, $(option.ele).serialize(),function( data ) {
                    option.postDone(data);
                },"json")
        }
    }
})();