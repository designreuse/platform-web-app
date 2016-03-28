//JPage 分页组件
;
(function ($, window, document, undefined) {
    //定义JPage构造函数
    var JPage = function (ele, opt) {
        this.$element = ele,
        this.defaults = {
            renderTo : "",
            pageIndex : this.$element.attr("jpage-index"),
            pageSize : this.$element.attr("jpage-size"),
            rowCount : this.$element.attr("jpage-count"),
            nextPageName : "下一页",
            prePageName : "上一页",
            jumpBtName:"确定",
            totalName:"共",
            jumpGotoName:"跳转到",
            pageName:"页",
            pageDivClass : "",
            pageUlClass : "",
            paramData : "",
            submitType : "ajax",
            dataUrl : "",
            submitCheck:true,
            pageFormID: "",
            pageBack : function(data){

            }
        }
        if (this.defaults.renderTo != "") {
            this.$element = $("#" + this.defaults.renderTo);
        }
        this.options = $.extend({}, this.defaults, opt),

        //创建分页Html逻辑
        this.createPageBar = function () {
            var pageIndex = this.options.pageIndex;
            var pageSize = this.options.pageSize;
            var rowCount = this.options.rowCount;

            if (pageIndex==""){
                pageIndex=1;
            }
            if (pageSize==""){
                pageSize=10;
            }
            if (rowCount==""){
                rowCount=0;
            }

            if (pageSize <= 0) {
                pageSize = 10;
            }
            var totalPage = (rowCount / pageSize);
            if (rowCount % pageSize > 0) {
                totalPage++;
            }
            totalPage = Math.floor(totalPage)
            if (totalPage<pageIndex){
                pageIndex=totalPage;
            }

            var iBegin = Math.max(1, pageIndex - 2);
            var iEnd = Math.min(iBegin + 4, totalPage);
            iBegin= Math.min(iEnd -4, iBegin);

            var html = "";
            html += "<div class='" + this.options.pageDivClass + "'>";
            html += "<ul class='" + this.options.pageUlClass + "'>";
            html += "<li>";
            if (pageIndex != 1) {
                var iPre = pageIndex * 1 - 1;
                html += "<a href='javascript:' pIdx='" + iPre + "' aria-label='Previous'>";
                html += "    <span>" + this.options.prePageName + "</span>";
                html += "</a>";
            }else {
                html += "<span>" + this.options.prePageName + "</span>";
            }
            html += "</li>";

            if (iBegin > 1) {
                html += "<li><span>...</span></li>";
            }

            for (var i = iBegin; i <= iEnd; i++) {
                if (pageIndex == i) {
                    html += "<li><span>" + i + "</span></li>";
                }
                else {
                    html += "<li><a href='javascript:'  pIdx='" + i + "' >" + i + "</a></li>";
                }
            }

            if (iEnd < totalPage) {
                html += "<li><span>...</span></li>";
            }

            if (pageIndex < totalPage) {
                var iNext = pageIndex * 1 + 1;
                html += "<li><a href='javascript:' pIdx='" + iNext + "'  aria-label='Next'>";
                html += this.options.nextPageName + "</a></li>";
            }else{
                html += "<li><span>" + this.options.nextPageName + "</span></li>";
            }

            html += "</ul>";
            html += "<ul>";
            html += this.options.totalName+ totalPage +this.options.pageName+"  "+this.options.jumpGotoName+"<input id='jumpPageIndex' value='"+ pageIndex +"'>";
            html += this.options.pageName+"  <input type='button' id='btJump' value='"+this.options.jumpBtName+"'>";
            html += "</ul>";
            html += "</div>";

            if(this.options.submitType == "form"){
                html += this.createPageParaHidden();
            }
            return html;
        }

        //数据提交
        this.getData = function (submitType){
            if (this.options.submitCheck) {
                if (this.options.submitType == "form") {
                    this.PostSubmit();
                }
                else {
                    this.AjaxSubmit();
                }
            }
        }

        //Ajax方式提交
        this.AjaxSubmit = function(){
            var that=this;
            $.ajax({
                url: this.options.dataUrl,
                type: 'post',
                dataType: 'json',
                data: {
                    "pageIndex": this.options.pageIndex,
                    "pageSize": this.options.pageSize,
                    "paramData": this.options.paramData
                },
                async: false,
                success: function (data) {
                    if (typeof(data)!="object"){
                        data=JSON.parse(data);
                    }
                    that.options.pageBack(data);
                },
                error: function(){

                }
            });
        }

        //Post方式提交
        this.PostSubmit = function () {
            $("#" + this.options.pageFormID).submit();
        }

        //创建postHidden标签
        this.createPageParaHidden=function(){
            var html="";
            html+="<input type='hidden' id='pageIndex' name='pageIndex' value='" + this.options.pageIndex +"'>";
            html+="<input type='hidden' id='pageSize' name='pageSize' value='" + this.options.pageSize +"'>";
            return html;
        }
    }


    //定义JPage的方法
    JPage.prototype = {
        Init: function () {

            var that = this;

            this.$element.html(this.createPageBar());

            this.$element.on('keydown', '#jumpPageIndex', function(){
                if(event.keyCode==13){
                    var iPageIndex=$(this).val();
                    if (isNaN(iPageIndex)){
                        iPageIndex=1;
                    }
                    that.options.pageIndex = parseInt(iPageIndex);
                    that.$element.html(that.createPageBar());
                    that.goPage();
                    return false;
                };
            });

            this.$element.on('click', '#btJump', function() {
                var iPageIndex=$("#jumpPageIndex").val();
                if (isNaN(iPageIndex)){
                    iPageIndex=1;
                }
                that.options.pageIndex = parseInt(iPageIndex);
                that.$element.html(that.createPageBar());
                that.goPage();
            });

            this.$element.on('click', 'a', function(){
                that.options.pageIndex = parseInt($(this).attr("pIdx"));
                that.$element.html(that.createPageBar());
                that.goPage();
            });

            return this.$element;
        },
        goPage: function () {
            this.getData(this.options.submitType);
        }
    }


    //在插件中使用JPage对象
    $.fn.SetPageComponent = function (options) {
        //创建JPage的实体
        var jpage = new JPage(this, options);
        //调用其方法
        return jpage.Init();


    }
})(jQuery, window, document);