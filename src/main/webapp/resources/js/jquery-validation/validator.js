
$(function(){
    var option = {
        ele: ".cmxform",
        rules: {
            password: "required",
            confirm_password:{
                required: true,
                equalTo: "#password"
            },
            domain: {
                required: true,
                domain: true
            },
            number: "required",
            username:{
                required: true,
                minlength: 3
            },
            username1:{
                required:true,
                maxlength: 5
            }
        },
        messages:{
            username:{
                required: "亲，用户名不能为空",
                minlength: jQuery.validator.format("亲，用户名不能小于{0}个字符")
            },
            domain:{
                //domain: "aaa"
            }
        },
        submitHandler: function(form){
            alert("done");
            console.log(form);
        }
    };
    $("#submit").on('click', function(){
        $("#commentForm").append('<div class="form-group">'+
            '<label for="num">password (required)</label>'+
            '<input id="num" type="password" class="form-control" name="number">'+
            '</div>');
    });
    validatorFrom.initValidatorFrom(option);
});