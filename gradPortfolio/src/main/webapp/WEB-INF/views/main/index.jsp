<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.body{text-align:center;width:100%;min-height:550px;padding-top:25px;}
.inner{display:inline-block;width:1024px;}
.radius{border-radius: 3px;}
.row{position: relative;width:100%;padding:2px 0;}
.col2
{    
	padding:0 2px;
    float: left;
    width: 50%;
}
.col3
{    
	padding:0 2px;
    float: left;
    width: 33.33333%;
}
.col3_2
{    
	padding:0 2px;
    float: left;
    width: 66.6666%;
}
.card{
	background: #fff;
	box-shadow:0px 1px 1px rgba(0, 0, 0, 0.24);
}
.row2
{
	padding:2px 0;
	position: relative;width:100%;height:50%;
}
.chart
{
	width:100%;
	min-height: 250px;
	/*background: black;*/
}
*, *::after, *::before {
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}
.chart::before{
	/*content: '';*/
}
</style>
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>

<!-- Chart code -->
<script>

	am4core.ready(function() {

		// Themes begin
		am4core.useTheme(am4themes_animated);
		// Themes end

		// Create chart instance
		var chart = am4core.create("barchart", am4charts.XYChart);

		// Add data
		chart.data = [ {
			"year" : "11-10",
			"dog" : 2.1,
			"cat" : 0.2,
			"etc" : 0.1
		}, {
			"year" : "11-11",
			"dog" : 2.2,
			"cat" : 0.3,
			"etc" : 0.1
		}, {
			"year" : "11-12",
			"dog" : 2.4,
			"cat" : 0.3,
			"etc" : 0.1
		} ];

		// Create axes
		var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
		categoryAxis.dataFields.category = "year";
		categoryAxis.title.text = "유기 현황";
		categoryAxis.renderer.grid.template.location = 0;
		categoryAxis.renderer.minGridDistance = 20;
		categoryAxis.renderer.cellStartLocation = 0.1;
		categoryAxis.renderer.cellEndLocation = 0.9;

		var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
		valueAxis.min = 0;
		valueAxis.title.text = "";

		// Create series
		function createSeries(field, name, stacked) {
			var series = chart.series.push(new am4charts.ColumnSeries());
			series.dataFields.valueY = field;
			series.dataFields.categoryX = "year";
			series.name = name;
			series.columns.template.tooltipText = "{name}: [bold]{valueY}[/]";
			series.stacked = stacked;
			series.columns.template.width = am4core.percent(95);
		}
		
		createSeries("dog", "강아지", false);
		createSeries("cat", "고양이", true);
		createSeries("etc", "기타", true);

		// Add legend
		chart.legend = new am4charts.Legend();

	}); // end am4core.ready()
</script>
<div class="inner radius">
	<div class="row">
		<div class="col2">
			<div class="radius card" id="barchart"  style="height:400px;"></div>
		</div>
		<div class="col2">
			<div class="radius card" id="barchart2"  style="height:400px;"></div>
		</div>
	</div>
	<div class="row">
		<div class="col3" style="height:800px;">
			<div class="radius card" id="chartdiv3" style="width:100%;height: 395px;margin-bottom: 5px;"></div>
			<div class="radius card" id="chartdiv2" style="width:100%;height: 400px;"></div>
		</div>
		<div class="col3_2 radius card" id="chartdiv" style="height:800px;">aa</div>
	</div>
</div>
<script src="https://www.amcharts.com/lib/4/maps.js"></script>
<script src="https://www.amcharts.com/lib/4/geodata/worldHigh.js"></script>
<script src="/common/js/common_utils.js"></script>
<script>
var mapPolygonTemplate;
am4core.ready(function() {
	var lv_info = {
		color:{4:"#ffa68c",3:"#ffd18c",2:"#ffe68c",1:"#a3e4a2",0:"#e0e0e0"},
		imageURL:{
			4:"https://www.amcharts.com/lib/images/weather/animated/thunder.svg",
			3:"https://www.amcharts.com/lib/images/weather/animated/rainy-1.svg",
			2:"https://www.amcharts.com/lib/images/weather/animated/cloudy-day-1.svg",
			1:"https://www.amcharts.com/lib/images/weather/animated/day.svg",
			0:""
		}
	};
	var mapData = [];
	var pieData = {};
	${chartData}
	var mapData2 = {};
	// pieData = {시도코드:[{멍},{냥},..],..};
	for (var k in pieData) {
		for (var i in pieData[k]) {
			pieData[k][i] = objConcat(pieData[k][i],getMapCodeInfo(k));
		}
	}
	// mapData = [{시도코드,토탈,..},{},..]
	for (var i in mapData) {
		var upr_cd = mapData[i].upr_cd;
		
		mapData[i] = objConcat(mapData[i],getMapCodeInfo(mapData[i].upr_cd));
		
		// lv 설정
		if (mapData[i].total>150) {
			mapData[i].lv = 4;
		} else if (mapData[i].total>100) {
			mapData[i].lv = 3;
		} else if (mapData[i].total>50) {
			mapData[i].lv = 2;
		} else if (mapData[i].total>0) {
			mapData[i].lv = 1;
		} else {
			mapData[i].lv = 0;
		}
		
		// color image 설정
		mapData[i].color = lv_info.color[mapData[i].lv];
		mapData[i].imageURL = lv_info.imageURL[mapData[i].lv];
		
		
		if (!mapData2[upr_cd]) {
			mapData2[upr_cd] = {};
		}
		
		mapData2[upr_cd] = mapData[i];
	}
	// mapData2 = {시도코드:{시도코드,토탈},시도코드:{..}..};
	console.log("2pieData",pieData);
	console.log("2mapData",mapData);
	console.log("2mapData2",mapData2);
// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

var chart = am4core.create("chartdiv", am4maps.MapChart);

try {
    chart.geodata = am4geodata_worldHigh;
}
catch (e) {
    chart.raiseCriticalError(new Error("Map geodata could not be loaded. Please download the latest <a href=\"https://www.amcharts.com/download/download-v4/\">amcharts geodata</a> and extract its contents into the same directory as your amCharts files."));
}

chart.projection = new am4maps.projections.Mercator();
/* 고정,줌 못하게 */
chart.seriesContainer.draggable = false;
chart.seriesContainer.resizable = false;
chart.maxZoomLevel = 1;

var colorSet = new am4core.ColorSet();
var morphedPolygon;
var map_option = {fillOpacity:0.7};
// map chart obj
var mapPolygonSeries = chart.series.push(new am4maps.MapPolygonSeries());
mapPolygonSeries.useGeodata = true;
mapPolygonSeries.geodataSource.url = "/common/json/korea.json";
mapPolygonSeries.geodataSource.load();

// country area look and behavior
mapPolygonTemplate = mapPolygonSeries.mapPolygons.template;
mapPolygonTemplate.strokeOpacity = 1;
mapPolygonTemplate.stroke = am4core.color("#ffffff");
mapPolygonTemplate.fillOpacity = map_option.fillOpacity;
mapPolygonTemplate.tooltipText = "{name}";
//mapPolygonTemplate.alwaysShowTooltip = true;
// 맵차트 색지정
mapPolygonTemplate.adapter.add("fill", function (fill, target) {
	//target.dataItem.dataContext
	if (target.dataItem&&target.dataItem.dataContext&&!getMapCodeInfo(target.dataItem.dataContext.id)) {
		return am4core.color("#e0e0e0");
	}
	if (target.dataItem.dataContext) {
		return am4core.color(mapData2[getMapCodeInfo(target.dataItem.dataContext.id).upr_cd].color);
		return am4core.color(am4core.colors.interpolate(
            	am4core.color("#6504b5").rgb,
                am4core.color("#ffffff").rgb,
                0.4 * (mapData2[getMapCodeInfo(target.dataItem.dataContext.id).upr_cd].lv) // 건수 많은 순으로 색 변화주기
            ));
	}
    //return colorSet.getIndex(target.dataItem.index + 1);
	return am4core.color("#e0e0e0");
})

// desaturate filter for countries
var desaturateFilter = new am4core.DesaturateFilter();
desaturateFilter.saturation = 1;
mapPolygonTemplate.filters.push(desaturateFilter);

///////////////////////////////////////////////////////////////////////////////////////////
////// 								게이지 차트											///////
////// 								게이지 차트											///////
////// 								게이지 차트											///////
///////////////////////////////////////////////////////////////////////////////////////////

var percent = 60;

// create chart
var chart = am4core.create("chartdiv2", am4charts.GaugeChart);
chart.innerRadius = am4core.percent(percent);

/**
 * 게이지바 수치
 */
var axis = chart.xAxes.push(new am4charts.ValueAxis());
axis.min = 0;
axis.max = 200;
axis.strictMinMax = true;
axis.renderer.radius = am4core.percent(percent);
axis.renderer.inside = true;
axis.renderer.line.strokeOpacity = 0;
axis.renderer.ticks.template.disabled = false
axis.renderer.ticks.template.strokeOpacity = 1;
axis.renderer.ticks.template.length = 0;
axis.renderer.grid.template.disabled = true;
axis.renderer.labels.template.radius = -56;
axis.renderer.minGridDistance = 100;
axis.renderer.labels.template.fill = am4core.color("#7678a0");
axis.renderer.labels.template.adapter.add("text", function(text) {
	if (text == 200){return "max";}
  return text;
})

/**
 * 게이지바 색
 */
var colorSet = new am4core.ColorSet();
var axis2 = chart.xAxes.push(new am4charts.ValueAxis());
axis2.min = 0;
axis2.max = 200;
axis2.renderer.innerRadius = 10
axis2.strictMinMax = true;
axis2.renderer.labels.template.disabled = true;
axis2.renderer.ticks.template.disabled = true;
axis2.renderer.grid.template.disabled = true;

var range0 = axis2.axisRanges.create();
range0.value = 0;
range0.endValue = 50;
range0.axisFill.fillOpacity = 1;
range0.axisFill.fill = am4core.color(lv_info.color[1]);//colorSet.getIndex(0);
var range1 = axis2.axisRanges.create();
range1.value = 50;
range1.endValue = 100;
range1.axisFill.fillOpacity = 1;
range1.axisFill.fill = am4core.color(lv_info.color[2]);//colorSet.getIndex(0);
var range2 = axis2.axisRanges.create();
range2.value = 100;
range2.endValue = 150;
range2.axisFill.fillOpacity = 1;
range2.axisFill.fill = am4core.color(lv_info.color[3]);//colorSet.getIndex(0);
var range3 = axis2.axisRanges.create();
range3.value = 150;
range3.endValue = 200;
range3.axisFill.fillOpacity = 1;
range3.axisFill.fill = am4core.color(lv_info.color[4]);//colorSet.getIndex(2);


/**
 * Hand
 */
var hand = chart.hands.push(new am4charts.ClockHand());
hand.axis = axis2;
hand.innerRadius = am4core.percent(percent);
hand.startWidth = 10;
hand.pin.disabled = true;
hand.value = 0;
hand.fill = am4core.color("#7678a0");
hand.stroke = am4core.color("#7678a0");

/**
 * Label
 */
var label = chart.radarContainer.createChild(am4core.Label);
label.isMeasured = false;
label.fontSize = 25;
label.x = am4core.percent(50);
label.y = am4core.percent(100);
label.horizontalCenter = "middle";
label.verticalCenter = "bottom";
label.text = "";
label.fill = am4core.color("#7678a0");

var label2 = chart.radarContainer.createChild(am4core.Label);
label2.isMeasured = false;
label2.fontSize = 15;
label2.dx = 0;
label2.dy = -45;
label2.horizontalCenter = "middle";
label2.verticalCenter = "top";
label2.text = "";
label2.fill = am4core.color("#7678a0");

///////////////////////////////////////////////////////////////////////////////////////////
//////								pie 차트											///////
//////								pie 차트											///////
//////								pie 차트											///////
///////////////////////////////////////////////////////////////////////////////////////////
// Pie chart
var pieChart = am4core.create("chartdiv3", am4charts.PieChart);
pieChart.innerRadius = 60;
pieChart.width = 200;
pieChart.height = 100;
pieChart.chartContainer.minHeight = 1;
pieChart.chartContainer.minWidth = 1;
pieChart.x = 75;
pieChart.y = 150;
pieChart.hidden = true;

var pieSeries = pieChart.series.push(new am4charts.PieSeries());
pieSeries.dataFields.value = "value";
pieSeries.dataFields.category = "category";
pieSeries.data = [{ value: 30, category: "417000", a:'' }, { value: 50, category: "422400", a:'' }, { value: 70, category: "429900", a:'' }];

// series labels
var labelTemplate = pieSeries.labels.template;
labelTemplate.nonScaling = true;
labelTemplate.fill = am4core.color("#FFFFFF");
labelTemplate.fontSize = 13;
labelTemplate.background = new am4core.RoundedRectangle();
labelTemplate.background.fillOpacity = 1;
labelTemplate.padding(4, 9, 4, 9);
labelTemplate.background.fill = am4core.color("#ffffff");

var label3 = pieChart.seriesContainer.createChild(am4core.Label);
label3.text = "{name}";
label3.horizontalCenter = "middle";
label3.verticalCenter = "middle";
label3.fontSize = 20;
mapPolygonTemplate.events.on("over", function (ev) {
	if (!ev.target.dataItem||!ev.target.dataItem.dataContext||!getMapCodeInfo(ev.target.dataItem.dataContext.id)) {
		return;
	}
	// gauge event
	var mapData = mapData2[getMapCodeInfo(ev.target.dataItem.dataContext.id).upr_cd];
	var color = am4core.color(mapData.color) /*am4core.color(am4core.colors.interpolate(
        	am4core.color("#6504b5").rgb,
            am4core.color("#ffffff").rgb,
            0.4 * (mapData.lv) // 건수 많은 순으로 색 변화주기
        ))*/;
	var value = mapData.total;
	label.text = value;
	label2.text = mapData.name;
	label2.fill = color.brighten(-0.2);
	label.fill = color.brighten(-0.1);
	var animation = new am4core.Animation(hand, {
	    property: "value",
	    to: value>200?200:value
	}, 1000, am4core.ease.cubicOut).start();
	
	// pie event
	if (mapData && pieSeries.dataItems) {
		var upr_cd = mapData.upr_cd;
    	for (var i = 0; i < pieSeries.dataItems.length; i++) {
            var dataItem = pieSeries.dataItems.getIndex(i);
         	// 데이터 셋팅
            dataItem.value = pieData[upr_cd][i].value;
            dataItem.category = pieData[upr_cd][i].category;
         	// 색깔
         	var pieColor = am4core.color(am4core.colors.interpolate(
            		color.rgb,
                    am4core.color("#ffffff").rgb,
                    0.4 * pieData[upr_cd][i].sort // 건수 많은 순으로 색 변화주기
                ));
            dataItem.slice.fill = pieColor;
            dataItem.slice.stroke = am4core.color("#ffffff");
            dataItem.label.text = pieData[upr_cd][i].category+" : "+pieData[upr_cd][i].value+"마리";
            dataItem.label.background.fill = pieColor;
            dataItem.label.fill = am4core.color(color).brighten(-0.2);
            dataItem.tick.stroke = am4core.color("#000000");
        }
    	pieChart.show();
    	label3.text = mapData.name;
    	label3.fill = color.brighten(-0.3); 
    }
});
}); // end am4core.ready()
</script>
