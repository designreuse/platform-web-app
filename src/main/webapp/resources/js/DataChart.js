var darwChart = (function () {
    return {
        init: function (option) {
            var _this = this;
            _this.configCharts();
            _this.getOption(option);
        },
        configCharts: function () {
            require.config({
                paths: {
                    echarts: '../resources/library/echarts/js'
                }
            });
        },
        getOption: function (option) {
            var _this = this;
            switch (option.chartType){
                case 'pie':
                    _this.drawPie(option);
                    break;
                case 'line':
                case 'bar':
                    _this.drawLineBar(option);
                    break;
                case 'mix':
                    _this.drawMix(option);
                    break;
            }
        },
        hideLoading: function(){

        },
        drawLineBar: function (option) {
            var chartOption = option;
            require(['echarts', 'echarts/chart/line', 'echarts/chart/bar'], function (ec) {
                var myChart = ec.init(document.getElementById(chartOption.chartId),'macarons');
                myChart.showLoading({
                    text: '正在努力的加载数据中...',
                    effect: 'bubble',
                    textStyle: {
                        fontSize: 22
                    }
                });
                var option = {
                    title : {
                        text: chartOption.titleText,
                        subtext: chartOption.titleSubtext,
                        x:'center'
                    },
                    tooltip: {
                        trigger: 'item'
                    },
                    legend:{
                        data:chartOption.legend
                    },
                    toolbox: {
                        show: true,
                        feature: {
                            mark: { show: false },
                            dataView: { show: false, readOnly: false },
                            magicType: { show: true, type: ['line', 'bar'] },
                            restore: { show: true },
                            saveAsImage: { show: true }
                        }
                    },
                    xAxis: [
                        {
                            type: 'category',
                            name: chartOption.chartUnit,
                            data: chartOption.chartXaxis,
                            axisLabel: {
                                show: true,
                                interval: 'auto',    // {number}
                                //rotate: 45,
                                //margin: 8,
                                formatter: '{value}'
                            }
                        }
                    ],
                    yAxis: [
                        {
                            type: 'value',
                            name: chartOption.chartName,
                            axisLabel: {
                                formatter: '{value}'
                            }
                        }
                    ],
                    series: [
                        {
                            name: chartOption.chartName,
                            type: chartOption.chartType,
                            data: chartOption.chartSeries
                            //markPoint: {
                            //    data: [
                            //        { type: 'max', name: '最大值' },
                            //        { type: 'min', name: '最小值' }
                            //    ]
                            //},
                            //markLine: {
                            //    data: [
                            //        { type: 'average', name: '平均值' }
                            //    ]
                            //}
                        }
                    ]
                };
                chartOption.loadDone = true;
                if (chartOption.loadDone) {
                    myChart.hideLoading();
                    myChart.setOption(option);
                    chartOption.loadDone = false;
                }
            });
        },
        drawPie: function (option) {
            var chartOption = option;
            require(['echarts', 'echarts/chart/pie', 'echarts/chart/funnel'], function (ec) {
                var myChart = ec.init(document.getElementById(chartOption.chartId),'macarons');
                myChart.showLoading({
                    text: '正在努力的加载数据中...',
                    effect: 'bubble',
                    textStyle: {
                        fontSize: 22
                    }
                });
                option = {
                    title : {
                        text: chartOption.titleText,
                        subtext: chartOption.titleSubtext,
                        x:'center'
                    },
                    tooltip : {
                        trigger: 'item',
                        formatter: "{a} <br/>{b} : {c} ({d}%)"
                    },
                    legend: {
                        orient : 'vertical',
                        x : 'left',
                        data:chartOption.legend
                    },
                    toolbox: {
                        show : true,
                        feature : {
                            dataView : {show: false, readOnly: false},
                            magicType : {
                                show: true,
                                type: ['pie', 'funnel'],
                                option: {
                                    funnel: {
                                        x: '25%',
                                        width: '50%',
                                        funnelAlign: 'left',
                                        max: 1548
                                    }
                                }
                            },
                            restore : {show: true},
                            saveAsImage : {show: true}
                        }
                    },
                    series : [
                        {
                            name:chartOption.chartName,
                            type:chartOption.chartType,
                            radius : '55%',
                            center: ['50%', '60%'],
                            itemStyle : {
                                normal : {
                                    label : {
                                        position : 'outer',
                                        formatter : function (params){
                                            console.log(params)
                                            if(params.percent){
                                                return params.name + params.percent+ '%\n'
                                            }
                                            return params.name + params.value
                                        }
                                    }
                                }
                            },
                            data:chartOption.chartSeries
                        }
                    ]
                };
                chartOption.loadDone = true;
                if (chartOption.loadDone) {
                    myChart.hideLoading();
                    myChart.setOption(option);
                    chartOption.loadDone = false;
                }
            });
        },
        drawMix: function (option) {
            var chartOption = option;
            require(['echarts', 'echarts/chart/line', 'echarts/chart/bar'], function (ec) {
                var myChart = ec.init(document.getElementById(chartOption.chartId),'macarons');
                myChart.showLoading({
                    text: '正在努力的加载数据中...',
                    effect: 'bubble',
                    textStyle: {
                        fontSize: 22
                    }
                });
                option = {
                    title : {
                        text: chartOption.titleText,
                        subtext: chartOption.titleSubtext,
                        x:'center'
                    },
                    tooltip : {
                        trigger: 'axis'
                    },
                    legend: {
                        orient : 'vertical',
                        x : 'left',
                        data:chartOption.legend
                    },
                    toolbox: {
                        show: true,
                        feature: {
                            mark: { show: false },
                            dataView: { show: false, readOnly: false },
                            magicType: { show: true, type: ['line', 'bar'] },
                            restore: { show: true },
                            saveAsImage: { show: true }
                        }
                    },
                    xAxis : [
                        {
                            type : 'category',
                            data : chartOption.chartXaxis,
                            name: chartOption.chartUnit
                        }
                    ],
                    yAxis : chartOption.chartYaxis,
                    series :chartOption.chartSeries
                };
                chartOption.loadDone = true;
                if (chartOption.loadDone) {
                    myChart.hideLoading();
                    myChart.setOption(option);
                    chartOption.loadDone = false;
                }
            });

        }
    }
})();