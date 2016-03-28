/**
 * Created by Administrator on 2015/11/27.
 */
//datepicker
$(function(){
    if ($('.timepicker').length) {
        $('.timepicker').datetimepicker({
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0
        })

        $(".datetimepicker").on("click", function () {
            position = $(this).index(".datetimepicker.dropdown-menu");
            time = $(".timepicker.date").eq(position).children(".date-show").val();
            //alert(time)
            $(".timepicker.date").eq(position).children(".get-time").val(time.substring(0, 16));
            $(".timepicker.date").eq(position).children(".date-show").val(time.substring(0, 10));
        });
    }

    $(".hide-input .form-control").blur(function(){
        $(this).next(".hide").focus();
        $(this).next(".hide").blur();
    });


    if($(".datepicker").length){
        $(".datepicker").children("input").on("focusin", function() {
            $(this).prop('readonly', true);
        });
        $(".datepicker").children("input").on("focusout", function() {
            $(this).prop('readonly', false);
        });
        var datepickerBefore = null;
        var datepickerAfter = null;
        $('.datepicker').datetimepicker({
            language:  'zh-CN',
            format: 'yyyy-MM-dd',
            weekStart: 1,
            todayBtn:  1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0
        })
            .on('changeDate', function(ev){
                var $ele = $(this).parents('.datepicker_checktime').find('.datepicker');
                var datepickerIndex = $ele.index(this);
                var datepickerBefore = $ele.eq(0).children("input").val();
                var datepickerAfter = $ele.eq(1).children("input").val();
                switch (datepickerIndex){
                    case 0:
                        $ele.eq(1).datetimepicker("setStartDate",datepickerBefore);
                        break;
                    case 1:
                        $ele.eq(0).datetimepicker("setEndDate",datepickerAfter);
                        break;
                }
                //var $dateInput = $(this).children("input");
                //$dateInput.focus();
                //$dateInput.blur();
            });
		$('.datepicker').datetimepicker().on('hide', function(ev){
			var $dateInput = $(this).children("input");
            $dateInput.blur();
		})
    };

    if($(".date-timepicker").length){
		$(".date-timepicker").children("input").on("focusin", function() {
            $(this).prop('readonly', true);
        });
        $(".date-timepicker").children("input").on("focusout", function() {
            $(this).prop('readonly', false);
        });
        $('.date-timepicker').datetimepicker({
            language:  'zh-CN',
            weekStart: 1,
            todayBtn:  1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            forceParse: 0,
            showMeridian: 1
        }).on('hide', function(ev){
			var $dateInput = $(this).children("input");
            $dateInput.blur();
		});
    }
});

$(document).ready(function(){
    $(".clear").on("click",function(){
        position = $(this).parent().parent().parent().parent().parent().index(".datetimepicker.dropdown-menu");
        $(".datepicker.date").eq(position).datetimepicker("reset");
        $(".date-timepicker.date").eq(position).datetimepicker("reset");
		$(".timepicker.date").eq(position).datetimepicker("reset");
    });
});

var util = (function(){
    return{
        alertError: function(msg){
            notyfy({
                text: msg,
                type: 'error',
                dismissQueue: true,
                layout: 'top',
                timeout: 1000,
                buttons: false
            });
        },
        alertOk: function(msg){
            notyfy({
                text: msg,
                type: 'success',
                dismissQueue: true,
                layout: 'top',
                timeout: 1500,
                buttons: false
            });
        },
        popover: function(ele, mes ,state){
            var _popover;
            _popover = ele.popover({
                trigger: "manual",
                placement: "bottom",
                content: mes,
                template: "<div class=\"popover\"><div class=\"arrow\"></div><div class=\"popover-inner\"><div class=\"popover-content\"><p></p></div></div></div>"
            });
            _popover.data("bs.popover").options.content = mes;
            if(state == "show"){
                return ele.popover("show");
            }
            else{
                return ele.popover("hide");
            }
        },
        imgBox: function($ele){
            //console.log($ele);
            //console.log($ele.find(".img-box"));
            $ele.find(".img-box").each(function () {
                var $this = $(this);
                var imgType = $this.data("type");
                var eleWidth = $this.width();
                var eleHeight = null;
                if (imgType == "same") {
                    eleHeight = eleWidth;
                }
                else {
                    eleHeight = $this.height();
                }
                $this.css("height", eleHeight);
                var $img = $this.children("img");
                var imgSrc = $img.data("original");
                $img.src = imgSrc;
                $img.on('load', function () {
                    var imgWidth = $img.width();
                    var imgHeight = $img.height();
                    //图片宽度大于等于容器宽度，图片高度大于宽度
                    if ((imgWidth >= eleWidth) && (imgHeight > imgWidth)) {
                        var imgWidthSet = (imgWidth * imgWidth) / imgHeight;
                        $img.css("height", eleHeight);
                        $img.css("width", imgWidthSet);
                        var marL = (eleWidth - imgWidthSet) / 2;
                        $img.css('margin-left', marL + 'px');
                    }
                    //图片宽度大于等于容器宽度，图片高度小于宽度
                    if ((imgWidth >= eleWidth) && (imgHeight < imgWidth)) {
                        var padT = (eleHeight - imgHeight) / 2;
                        $img.css('padding-top', padT + 'px');
                    }
                    //图片高度大于容器高度，图片宽度小于容器宽度
                    if ((imgHeight > eleHeight) && (imgHeight > imgWidth)) {
                        var imgWidthSet = (imgWidth * eleHeight) / imgHeight;
                        $img.css("width", imgWidthSet);
                        $img.css("height", eleHeight);
                        var marL = (eleWidth - imgWidthSet) / 2;
                        $img.css('margin-left', marL + 'px');
                    }

                    //图片高度小于容器高度，图片宽度小于容器宽度
                    if ((imgHeight < eleWidth) && (imgWidth < eleWidth)) {
                        var marL = (eleWidth - imgWidth) / 2;
                        var padT = (eleHeight - imgHeight) / 2;
                        $img.css('margin-left', marL + 'px');
                        $img.css('padding-top', padT + 'px');
                    }
                });
            });
        }

    }
})();


/**
 * 将数值四舍五入后格式化.
 *
 * @param num 数值(Number或者String)
 * @param cent 要保留的小数位(Number)
 * @param isThousand 是否需要千分位 0:不需要,1:需要(数值类型);
 * @return 格式的字符串,如'1,234,567.45'
 * @type String
 */
function formatNumber(num,cent,isThousand) {
    num = num.toString().replace(/\$|\,/g,'');

// 检查传入数值为数值类型
    if(isNaN(num))
        num = "0";

// 获取符号(正/负数)
    sign = (num == (num = Math.abs(num)));

    num = Math.floor(num*Math.pow(10,cent)+0.50000000001);  // 把指定的小数位先转换成整数.多余的小数位四舍五入
    cents = num%Math.pow(10,cent);              // 求出小数位数值
    num = Math.floor(num/Math.pow(10,cent)).toString();   // 求出整数位数值
    cents = cents.toString();               // 把小数位转换成字符串,以便求小数位长度

// 补足小数位到指定的位数
    while(cents.length<cent)
        cents = "0" + cents;

    if(isThousand) {
        // 对整数部分进行千分位格式化.
        for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
            num = num.substring(0,num.length-(4*i+3))+','+ num.substring(num.length-(4*i+3));
    }

    if (cent > 0)
        return (((sign)?'':'-') + num + '.' + cents);
    else
        return (((sign)?'':'-') + num);
}

function CurrentDateAddDay(n){
    var s, d, t, t2;
    t = new Date().getTime();
    t2 = n * 1000 * 3600 * 24;
    t+= t2;
    d = new Date(t);
    s = d.getUTCFullYear() + "-";
    s += ("00"+(d.getUTCMonth()+1)).slice(-2) + "-";
    s += ("00"+d.getUTCDate()).slice(-2);
    return s;
}

//$(document).on("click", "*", function (event) {
//    if($(".hide-textare").length>0) {
//        if (!$(this).is(".edui-container")&!$(this).hasClass("hide-textare")&!$(this).parent().hasClass("hide-textare")&!$(this).is("input")&!$(this).is("select")&!$(this).is("textarea")&!$(this).is("a")&!$(this).is("button")) {
//            $("#myEditor").focus();
//            $("#myEditor").blur();
//        }
//        event.stopPropagation();
//    }
//})

$.fn.newcheck = function(){
    $(this).click(function(){
        var $input = $("input").parent().not($(".date")).children("input");
        $input.focus();
        $input.blur();
        //$(".popover").prev().focus();
        //跳到最後一個未填框處
        $($(".popover").get(0)).parent().children("input.form-control").focus();
        //跳到第一個未填框處
    })
}

function getImgTag(url,width,height){
    var sear=new RegExp('@');
    if(sear.test(url)){
        url=url+"_"
    }else {
        url=url+"@"
    }
    var retUrl=url + width + "w_"+ height+"h_1l";
   // alert(retUrl);
    return retUrl;
}
