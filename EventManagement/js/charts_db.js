var baseURL = window.location.host;

var TREND_CHART_SERVICE_URL = "http://" + baseURL + "/api/TrendChartData";
var UNIT_COUNT_CHART_SERVICE_URL = "http://" + baseURL + "/api/UnitEventCountsData";
var EVENT_COUNT_CHART_SERVICE_URL = "http://" + baseURL + "/api/EventCountsData";

var chartRegistrationsStore = new DevExpress.data.CustomStore({
    load: function (loadOptions) {
        return $.ajax({
            dataType: "JSON",
            url: TREND_CHART_SERVICE_URL,
            contentType: "application/json; charset=utf-8",
            type: "GET"
        })
        //return $.getJSON(TREND_CHART_SERVICE_URL);
    }
});
var chartUnitEventCountsStore = new DevExpress.data.CustomStore({
    load: function (loadOptions) {
        return $.ajax({
            dataType: "JSON",
            url: UNIT_COUNT_CHART_SERVICE_URL,
            contentType: "application/json; charset=utf-8",
            type: "GET"
        })
    }
});
var chartEventCountsStore = new DevExpress.data.CustomStore({
    load: function (loadOptions) {
        return $.ajax({
            dataType: "JSON",
            url: EVENT_COUNT_CHART_SERVICE_URL,
            contentType: "application/json; charset=utf-8",
            type: "GET"
        })
    }
});

var chartRegistratinosSource = new DevExpress.data.DataSource({
    store: chartRegistrationsStore
});
var chartUnitEventCountsSource = new DevExpress.data.DataSource({
    store: chartUnitEventCountsStore
});
var chartEventCountsSource = new DevExpress.data.DataSource({
    store: chartEventCountsStore
});

$(function () {

    var zoomedChart = $("#registrationChart").dxChart({
        palette: "Default",
        dataSource: chartRegistratinosSource,
        commonSeriesSettings: {
            argumentField: "registrationDate",
            type:"spline"
        },
        argumentAxis: {
            valueMarginsEnabled: true,
            tickInterval: { days: 3 },
            label: {
                format: "shortDate"
            },
            title: "Days",
            argumentType: "datetime"
        },
        valueAxis: {
            max: 10,
            min: 0,
            title: "Daily Registrations"
        },
        series: [{
            name: 'Volunteer',
            valueField: "volunteerCount"
        }, {
            name: 'Registrations',
            valueField: "registrationCount"
        }, {
            name: 'Waiting List',
             valueField: "reservationCount"
        }],
        scrollBar: {
            visible: true
        },
        scrollingMode: "all",
        zoomingMode: "all",
        legend: {
            visible: true
        }
    }).dxChart("instance");

    //zoomedChart.zoomArgument(300, 500);
});
$(function () {
    $("#unitCountStackedChart").dxChart({
        dataSource: chartUnitEventCountsSource,
        commonSeriesSettings: {
            argumentField: "unit",
            type: "stackedBar"
        },
        series: [
            { valueField: "volunteerCount", name: "Volunteers" },
            { valueField: "registrationCount", name: "Registrations" },
            { valueField: "reservationCount", name: "Waiting List" }
        ],
        legend: {
            verticalAlignment: "bottom",
            horizontalAlignment: "center",
            itemTextPosition: 'top'
        },
        valueAxis: {
            title: {
                text: "Total Count"
            },
            max: 30,
            min: 0,
            position: "left"
        },
        title: "Unit Event Counts",
        "export": {
            enabled: true
        },
        scrollBar: {
            visible: true
        },
        scrollingMode: "all",
        tooltip: {
            enabled: true,
            location: "edge",
            customizeTooltip: function (arg) {
                return {
                    text: arg.seriesName + ": " + arg.valueText
                };
            }
        }
    });
});

$(function () {
    $("#volunteerDistribution").dxPieChart({
        type: "doughnut",
        palette: "Default",
        dataSource: chartEventCountsSource,
        title: "Registration Count Split",
        tooltip: {
            enabled: true,
            format: "Individual Registrations",
            customizeTooltip: function (arg) {
                var percentText = arg.percentText;

                return {
                    text: arg.argumentText + " - " + percentText
                };
            }
        },
        legend: {
            horizontalAlignment: "right",
            verticalAlignment: "top",
            margin: 0
        },
        "export": {
            enabled: true
        },
        series: [{
            argumentField: "regType",
            label: {
                visible: true,
                connector: {
                    visible: true
                }
            }
        }]
    });
});
