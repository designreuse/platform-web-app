//头部的显示下拉
$(".dLabel").on('mouseenter', function(){
    var $parentLi = $(this).parents(".dropdown");
    $parentLi.addClass("open");
    $(this).next( ".dropdown-menu").on('mouseleave', function(){
        $parentLi.removeClass('open');
    });
});
var state = true;
$(".dLabel").on('mouseleave', function(){
    var $parentLi = $(this).parents(".dropdown");
    $(this).next( ".dropdown-menu").on('mouseenter', function(){
        state = true;
    });
    state = false;
    function setState(){
        if(!state){
            $parentLi.removeClass('open');
        }
        else{
            $parentLi.addClass('open');
        }
    }
    setTimeout(setState, 100);
});
//左侧折叠
$(".icon-state").on('click', function(){
    var $this = $(this);
    if($this.hasClass("icon-state--arrow_down")||$this.hasClass("icon-state--arrow_up")){
        var parent = $this.parents(".site_my_classify_list");
        parent.find("ul").slideToggle();
        $this.toggleClass("icon-state--arrow_down, icon-state--arrow_up");
    }
});
//datepicker
if($(".datepicker").length){
    $('.datepicker').datepicker({
        language: 'zh-CN',
        format: 'yyyy-mm-dd',
        minView: "month",
        autoclose: true,
        todayHighlight: true,
        clearBtn: true
    })
    .on('changeDate', function(ev){
        var datepickerIndex = $(".datepicker").index(this);
        var datepickerBefore = $(".datepicker").eq(0).children("input").val();
        var datepickerAfter = $(".datepicker").eq(1).children("input").val();
        switch (datepickerIndex){
            case 0:
                $(".datepicker").eq(1).datepicker("setStartDate",datepickerBefore);
            break;
            case 1:
                $(".datepicker").eq(0).datepicker("setEndDate",datepickerAfter);
            break;
        }
    });
}
//formtable
if($(".formtable-list").length||$(".form-group").length){
    var minWidth = null;
    $(".formtable-list,.form-group").each(function(){
        var $this = $(this);
        //var listHeight = $this.outerHeight();
        //$this.find(".col-lg-8").outerHeight(listHeight);
        var listWeight = $this.find(".col-lg-4").outerWidth();
        if(minWidth == null){
            minWidth = listWeight ;
        }
    });
    $(".formtable-list,.form-group").find(".col-lg-12").children(".col-lg-2").outerWidth(minWidth- 1);
}
//pic-tooltip
if($(".pic-tooltip").length){
    var toolTipHtml ='<div class="modal fade" id="pic-tooltip">'+
       '<div class="modal-dialog">'+
        '<div class="modal-content clearfix">'+
        '<button type="button" class="close" data-dismiss="modal" aria-label="Close">'+
        '<span aria-hidden="true">&times;</span></button>'+
        '<img src="" alt=""/></div></div></div>';
    $("body").append(toolTipHtml);
    $(".pic-tooltip").on("click", function(){
        var $this = $(this);
        var imgSrc = $this.data("url");
        var modlaImg = $("#pic-tooltip").find("img");
        modlaImg.attr("src", imgSrc);
        $("#pic-tooltip").modal("show");
    });
}

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
        }
    }
})();