
    $(function(){
        jQuery.validator.addMethod("pwdCheck", function(value, element) {
              return this.optional(element) || /^[\u0391-\uFFE5\w]{6,20}$/.test(value);
        }, "请输入6~20位数字、字母或字符");
        validatorFrom.initValidatorFrom({
            ele:"#changPwdForm",
            submitType:'submit',
            rules: {oldPassword: 'required',
                newPassword:{
                    required:true,
                    pwdCheck:true

                },
                password_again:{
                    equalTo: "#againPwd"
                }
            },
            messages:{oldPassword:'旧密码必输',newPassword:"新密码必输"}


        });



    });
