//JPage 分页组件

function pageInit(){

}

;
(function ($, window, document, undefined) {
    //定义JPage构造函数
    var JPage = function (ele, opt) {
        this.$element = ele;
        this.defaults = {
            renderTo: "",
            pageIndex: this.$element.attr("jpage-index"),
            pageSize: this.$element.attr("jpage-size"),
            rowCount: this.$element.attr("jpage-count"),
            nextPageName: "下一页",
            prePageName: "上一页",
            jumpBtName: "确定",
            totalName: "共",
            jumpGotoName: "跳转到",
            pageName: "页",
            pageDivClass: "",
            pageUlClass: "",
            paramData: "",
            submitType: "form",
            dataUrl: "",
            submitCheck: true,
            pageFormID: this.$element.attr("jpage-form"),
            pageBack: function (data) {
            }
        };
        if (this.defaults.renderTo != "") {
            this.$element = $("#" + this.defaults.renderTo);
        }

        this.options = $.extend({}, this.defaults, opt);

        //创建分页Html逻辑
        this.createPageBar = function () {
            var pageIndex = this.options.pageIndex;
            var pageSize = this.options.pageSize;
            var rowCount = this.options.rowCount;

            if (pageIndex == "") {
                pageIndex = 1;
            }
            if (pageSize == "") {
                pageSize = 10;
            }
            if (rowCount == "") {
                rowCount = 0;
            }

            if (pageSize < 1) {
                pageSize = 10;
            }
            var totalPage = (rowCount / pageSize);
            if (rowCount % pageSize > 0) {
                totalPage++;
            }
            totalPage = Math.floor(totalPage);
            if (totalPage < pageIndex) {
                pageIndex = totalPage;
            }

            var iBegin = Math.max(1, pageIndex - 2);
            var iEnd = Math.min(iBegin + 4, totalPage);
            iBegin = Math.max(iEnd - 4, iBegin);

            var html = "";
            //html += "<div class='" + this.options.pageDivClass + "'>";
            html += "<ul>";
            if (pageIndex != 1) {
                var iPre = pageIndex * 1 - 1;
                html += "<li>";
                html += "<a href='javascript:' pIdx='" + iPre + "'>";
                html += "" + this.options.prePageName + "";
                html += "</a>";
            } else {
                html += "<li  class='disabled'>";
                html += "<a href='javascript:'>";
                html += "" + this.options.prePageName + "";
                html += "</a>";
            }
            html += "</li>";
            if (iBegin > 1) {
                html += "<li  class='disabled'>";
                html += "<a href='javascript:'>";
                html += "...";
                html += "</a>";
                html += "</li>";
            }

            for (var i = iBegin; i <= iEnd; i++) {
                if (pageIndex == i) {
                    html += "<li class='active'>";
                    html += "<a href='javascript:'>";
                    html += "" + i + "";
                    html += "</a>";
                    html += "</li>";
                }
                else {
                    html += "<li>";
                    html += "<a href='javascript:' pIdx='" + i + "'>";
                    html += "" + i + "";
                    html += "</a>";
                    html += "</li>";
                    //html += "<li><a href='javascript:'  pIdx='" + i + "' >" + i + "</a></li>";
                }
            }

            if (iEnd < totalPage) {
                html += "<li class='disabled'>";
                html += "<a href='javascript:'>";
                html += "...";
                html += "</a>";
                html += "</li>";
                //html += "<li><span>...</span></li>";
            }

            if (pageIndex < totalPage) {
                var iNext = pageIndex * 1 + 1;
                //html += "<li><a href='javascript:' pIdx='" + iNext + "'  aria-label='Next'>";
                //html += this.options.nextPageName + "</a></li>";
                html += "<li>";
                html += "<a href='javascript:' pIdx='" + iNext + "'>";
                html += "" + this.options.nextPageName + "";
                html += "</a>";
                html += "</li>";

            } else {
                //html += "<li><span>" + this.options.nextPageName + "</span></li>";
                html += "<li class='disabled'>";
                html += "<a href='javascript:'>";
                html += "" + this.options.nextPageName + "";
                html += "</a>";
                html += "</li>";
            }

            html += "</ul>";
            html += "<div class='pagination_go dis_inb'>";
            html += this.options.totalName + totalPage + this.options.pageName + "  " + this.options.jumpGotoName + "&nbsp;<input id='jumpPageIndex'  class='form-control' value='" + pageIndex + "'>&nbsp;";
            html += this.options.pageName + "  <button class='btn btn-primary mar_l--10' id='btJump'>" + this.options.jumpBtName + "</button>";
            html += "</div>";

            return html;
        };

        //数据提交
        this.getData = function (submitType) {
            if (this.options.submitCheck) {
                if (this.options.submitType == "form") {
                    this.PostSubmit();
                }
                else {
                    this.AjaxSubmit();
                }
            }
        };

        //Ajax方式提交
        this.AjaxSubmit = function () {
            var that = this;
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
                    if (typeof(data) != "object") {
                        data = JSON.parse(data);
                    }
                    that.options.pageBack(data);
                },
                error: function () {

                }
            });
        };

        //Post方式提交
        this.PostSubmit = function () {
            $("#" + this.options.pageFormID).submit();
        };

        //创建postHidden标签
        this.createPageParaHidden = function () {
            var html = "";
            html += "<input type='hidden' id='pageIndex' name='pageIndex' value='" + this.options.pageIndex + "'>";
            html += "<input type='hidden' id='pageSize' name='pageSize' value='" + this.options.pageSize + "'>";
            $("#" + this.options.pageFormID).append(html);
        }
    };


    //定义JPage的方法
    JPage.prototype = {
        Init: function () {
            var that = this;
            this.$element.html(this.createPageBar());
            if (this.options.submitType == "form") {
                this.createPageParaHidden();
            }
            this.$element.on('keydown', '#jumpPageIndex', function () {
                if (event.keyCode == 13) {
                    var iPageIndex = $(this).val();
                    if (isNaN(iPageIndex)) {
                        iPageIndex = 1;
                    }
                    if ($.trim(iPageIndex)==""){
                        iPageIndex = 1;
                    }
                    that.options.pageIndex = parseInt(iPageIndex);
                    if (that.options.submitType == "form") {
                        $("#pageIndex").val(that.options.pageIndex);
                    } else {
                        that.$element.html(that.createPageBar());
                    }
                    that.goPage();
                    return false;
                }
            });

            this.$element.on('click', '#btJump', function () {
                var iPageIndex = $("#jumpPageIndex").val();
                if (isNaN(iPageIndex)) {
                    iPageIndex = 1;
                }
                if ($.trim(iPageIndex)==""){
                    iPageIndex = 1;
                }
                that.options.pageIndex = parseInt(iPageIndex);
                if (that.options.submitType == "form") {
                    $("#pageIndex").val(that.options.pageIndex);
                } else {
                    that.$element.html(that.createPageBar());
                }
                that.goPage();
            });

            var li = $("li[class != active][class != disabled]", this.$element);
            $("a", li).on('click', function () {
                that.options.pageIndex = parseInt($(this).attr("pIdx"));
                if (that.options.submitType == "form") {
                    $("#pageIndex").val(that.options.pageIndex);
                } else {
                    that.$element.html(that.createPageBar());
                }
                that.goPage();
            });

            return this.$element;
        },
        goPage: function () {
            this.getData(this.options.submitType);
        },
        PageInit:function(){
            var that = this;
            this.$element.html(this.createPageBar());
            if (this.options.submitType == "form") {
                $("#pageIndex").val(1);
            }else{
                that.options.pageIndex = 1;
            }
        }
    };


    //在插件中使用JPage对象
    $.fn.SetPageComponent = function (options) {
        //创建JPage的实体
        var jpage = new JPage(this, options);
        jpage.Init();
        return jpage;

    }
})(jQuery, window, document);