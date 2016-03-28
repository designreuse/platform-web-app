var easyUiTable = (function(){
    return{
        initTable: function(option){//初始化配置
          return $('#easyUi_table').datagrid({
          url: option.url,
          view:option.view,
          title: option.title,
          width: option.width || '100%',
          height: option.height || 'auto',
          nowrap: option.nowrap || false,
          striped:option.striped || 'true',
          showHeader:option.showHeader || true,
          showFooter:option.showFooter || true,
          wnumbers:option.wnumbers || true,
          collapsible:option.collapsible || true,
          singleSelect:option.singleSelect,
          selectOnCheck:option.selectOnCheck || true,
          checkOnSelect:option.checkOnSelect,
          toolbar:'#queryParam',
          fitColumns: option.fitColumns || false,
          footer:'#queryPage',
          pageSize:option.pageSize ||10,
          onClickCell:option.onClickCell,
          onClickRow:option.onClickRow,
          onSelect:option.onSelect,
          detailFormatter:option.detailFormatter,
          onExpandRow:option.onExpandRow,
          onLoadSuccess:function(data){
              $("#page").pagination({
                  total:data.total,
                  onSelectPage: option.onSelectPage
              });
              var headerTds = $(".datagrid-view2 .datagrid-header-inner table tr:first-child").children();
              var bodyTds = $(".datagrid-view2 .datagrid-body table tr:first-child").children();
//              var totalWidth = null;
              if(option.callback){
                  option.callback();
              }
              //$(".datagrid-view2 .datagrid-btable").addClass("table table-bordered table-hover");
              if($(".datagrid-view2 .datagrid-btable  tr").hasClass('.bootstrap-switch')){
                  var bodyTrHeight = $(".datagrid-view2 .datagrid-btable  tr").outerHeight();
                  var bodythHeight = $(".datagrid-view2 .datagrid-header").outerHeight();
                  var bodyTrLength = $(".datagrid-view2 .datagrid-btable  tr").length;
                  var bodyTableHeight = bodyTrHeight*bodyTrLength;
                  var bodyDatagridHeight = bodyTableHeight + bodythHeight;
                  $(".datagrid-view2 .datagrid-body").css("height", bodyTableHeight);
                  $(".datagrid-view").css("height", bodyDatagridHeight);
              }
              var headerTds = $(".datagrid-view2 .datagrid-header-inner table tr:first-child").children();
              var bodyTds = $(".datagrid-view2 .datagrid-body table tr:first-child").children();
//              var totalWidth = null;
              bodyTds.each(function (i, obj) {
                  var headerTd = $(headerTds.get(i));
                  var bodyTd = $(bodyTds.get(i));
                  $("div:first-child", headerTds.get(i)).css("text-align", "center");
                  var bodyTdWidth = bodyTd.outerWidth();
                  var headerTdWidth = headerTd.outerWidth();
                  var setWidth = null;
                  if(bodyTdWidth < headerTdWidth ){
                      setWidth = headerTdWidth;
                  }
                  else{
                      setWidth = bodyTdWidth;
                  }
                  // totalWidth += setWidth;
                  headerTd.outerWidth(setWidth);
              });

          },
          columns:[
              option.columns
          ]
      });
        }
    }
})();
$.fn.initTable=function(option){//初始化配置
    var $this = $(this),
        //$toolbar = $this.parent().parent().parent().children(".query-param"),
        $footer = $this.parent().parent().parent().find(".query-page");
    $(this).datagrid({
                queryParams:option.queryParams||{},
                url: option.url,
                view:option.view,
                title: option.title,
                width: option.width || '100%',
                height: option.height || 'auto',
                nowrap: option.nowrap || false,
                striped:option.striped || 'true',
                showHeader:option.showHeader || true,
                showFooter:option.showFooter || true,
                wnumbers:option.wnumbers || true,
                collapsible:option.collapsible || true,
                singleSelect:option.singleSelect,
                selectOnCheck:option.selectOnCheck || true,
                checkOnSelect:option.checkOnSelect,
                //toolbar: $toolbar,
                fitColumns: option.fitColumns || false,
                footer: $footer,
                pageSize:option.pageSize ||10,
                onClickCell:option.onClickCell,
                onClickRow:option.onClickRow,
                onSelect:option.onSelect,
                detailFormatter:option.detailFormatter,
                onExpandRow:option.onExpandRow,
                onLoadSuccess:function(data){
                    $footer.children(".page").pagination({
                        total:data.total,
                        onSelectPage: option.onSelectPage
                    });
                    var headerTds = $(".datagrid-view2 .datagrid-header-inner table tr:first-child").children();
                    var bodyTds = $(".datagrid-view2 .datagrid-body table tr:first-child").children();
//              var totalWidth = null;
                    if(option.callback){
                        option.callback();
                    }
                    //$(".datagrid-view2 .datagrid-btable").addClass("table table-bordered table-hover");
                    if($(".datagrid-view2 .datagrid-btable  tr").hasClass('.bootstrap-switch')){
                        var bodyTrHeight = $(".datagrid-view2 .datagrid-btable  tr").outerHeight();
                        var bodythHeight = $(".datagrid-view2 .datagrid-header").outerHeight();
                        var bodyTrLength = $(".datagrid-view2 .datagrid-btable  tr").length;
                        var bodyTableHeight = bodyTrHeight*bodyTrLength;
                        var bodyDatagridHeight = bodyTableHeight + bodythHeight;
                        $(".datagrid-view2 .datagrid-body").css("height", bodyTableHeight);
                        $(".datagrid-view").css("height", bodyDatagridHeight);
                    }
                    var headerTds = $(".datagrid-view2 .datagrid-header-inner table tr:first-child").children();
                    var bodyTds = $(".datagrid-view2 .datagrid-body table tr:first-child").children();
//              var totalWidth = null;
                    bodyTds.each(function (i, obj) {
                        var headerTd = $(headerTds.get(i));
                        var bodyTd = $(bodyTds.get(i));
                        $("div:first-child", headerTds.get(i)).css("text-align", "center");
                        var bodyTdWidth = bodyTd.outerWidth();
                        var headerTdWidth = headerTd.outerWidth();
                        var setWidth = null;
                        if(bodyTdWidth < headerTdWidth ){
                            setWidth = headerTdWidth;
                        }
                        else{
                            setWidth = bodyTdWidth;
                        }
                        // totalWidth += setWidth;
                        headerTd.outerWidth(setWidth);
                    });
                    option.onLoadSuccess(data);
                },
                columns:[
                    option.columns
                ]


            })
}