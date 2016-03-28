/**
 * Created by Administrator on 2016/2/23.
 */
$(function(){
    //保存
    var orderSave = {
        ele: "#keywordForm",
        submitType: "auto",
        rules: {
            locationKey: {
                required: true
            },
            titleCn: {
                required: function (e) {
                    if ($("#appId").val() == 3) {
                        return true
                    } else {
                        return false
                    }
                }

            },
            titleRu: {
                required: function (e) {
                    if ($("#appId").val() == 5) {
                        return true
                    } else {
                        return false
                    }
                }
            },
            keywordCn: {
                required: function (e) {
                    if ($("#appId").val() == 3) {
                        return true
                    } else {
                        return false
                    }
                }

            },
            keywordRu: {
                required: function (e) {
                    if ($("#appId").val() == 5) {
                        return true
                    } else {
                        return false
                    }
                }

            },
            descCn: {
                required: function (e) {
                    if ($("#appId").val() == 3) {
                        return true
                    } else {
                        return false
                    }
                }

            },
            descRu: {
                required: function (e) {
                    if ($("#appId").val() == 5) {
                        return true
                    } else {
                        return false
                    }
                }

            }
        },
        messages: {
            locationKey: {
                required: "位置编号不能为空"
            },
            titleCn: {
                required: "标题（中文）不能为空"
            },
            titleRu: {
                required: "标题（俄文）不能为空"
            },
            keywordCn: {
                required: "关键字（中文）不能为空"
            },
            keywordRu: {
                required: "关键字（俄文）不能为空"
            },
            descCn: {
                required: "描述（中文）不能为空"
            },
            descRu: {
                required: "描述（俄文）不能为空"
            }
        },
        validateDone: function (form) {
            $.ajax({
                url: window.ctx + "/keyword/edit",
                type: "post",
                dataType: "json",
                data: $("#keywordForm").serialize(),
                success: function (data) {
                    alert(data.resultData)
                    location.href = window.ctx+"/keyword/list"
                }
            })
        }
    }
    validatorFrom.initValidatorFrom(orderSave);
})

$("#appId").on("change",function(){
    if($(this).val() ==3 || $(this).val() ==2){
        $(".cn").addClass("formtable-list-require")
        $(".ru").removeClass("formtable-list-require")
    }else{
        $(".ru").addClass("formtable-list-require")
        $(".cn").removeClass("formtable-list-require")
    }
})