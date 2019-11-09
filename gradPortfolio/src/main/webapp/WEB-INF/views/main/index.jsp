<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Styles -->
<style>
#chartdiv {
  width: 700px;;
  height: 700px;
}
</style>

<!-- Resources -->
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/maps.js"></script>
<script src="https://www.amcharts.com/lib/4/geodata/worldHigh.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<script src="/common/js/common_utils.js"></script>
<!-- Chart code -->
<script>
var mapPolygonTemplate;
am4core.ready(function() {

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
chart.seriesContainer.events.disableType("doublehit");
chart.chartContainer.background.events.disableType("doublehit");
/**/
// zoomout on background click
chart.chartContainer.background.events.on("hit", function () { zoomOut() });

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
//mapPolygonTemplate.tooltipText = "{name}";
//mapPolygonTemplate.alwaysShowTooltip = true;
// take a color from color set
mapPolygonTemplate.adapter.add("fill", function (fill, target) {
	//target.dataItem.dataContext
	if (target.dataItem.dataContext&&!getMapCodeInfo(target.dataItem.dataContext.id)) {
		return am4core.color("#e0e0e0");
	}
	if (target.dataItem.dataContext) {
		return am4core.color(mapData2[getMapCodeInfo(target.dataItem.dataContext.id).upr_cd].color);
	}
    return colorSet.getIndex(target.dataItem.index + 1);
})

// desaturate filter for countries
var desaturateFilter = new am4core.DesaturateFilter();
desaturateFilter.saturation = 1;
mapPolygonTemplate.filters.push(desaturateFilter);

// 맵차트 호버 스타일
/*
var hoverState = mapPolygonTemplate.states.create("hover");
hoverState.properties.fillOpacity = 0.5;
*/


// what to do when country is clicked
/*
mapPolygonTemplate.events.on("hit", function (event) {
    event.target.zIndex = 1000000;
    if (event.target.dataItem.dataContext&&getMapCodeInfo(event.target.dataItem.dataContext.id)) {
    	selectPolygon(event.target);
    }
})
*/

// Pie chart
var pieChart = chart.seriesContainer.createChild(am4charts.PieChart);
// Set width/heigh of a pie chart for easier positioning only
pieChart.width = 100;
pieChart.height = 100;
pieChart.hidden = true; // can't use visible = false!

// because defauls are 50, and it's not good with small countries
pieChart.chartContainer.minHeight = 1;
pieChart.chartContainer.minWidth = 1;

var pieSeries = pieChart.series.push(new am4charts.PieSeries());
pieSeries.dataFields.value = "value";
pieSeries.dataFields.category = "category";
var a = [417000,422400,429900].map(function(d,i,arr){
	return {code:d,value:0,category:getUpkindNm(d)};
	});
pieSeries.data = a;//[{ value: 0, category: "417000" }, { value: 0, category: "422400" }, { value: 0, category: "429900" }];

var dropShadowFilter = new am4core.DropShadowFilter();
dropShadowFilter.blur = 4;
pieSeries.filters.push(dropShadowFilter);

var sliceTemplate = pieSeries.slices.template;
sliceTemplate.fillOpacity = 1;
sliceTemplate.strokeOpacity = 0;

var activeState = sliceTemplate.states.getKey("active");
activeState.properties.shiftRadius = 0; // no need to pull on click, as country circle under the pie won't make it good

var sliceHoverState = sliceTemplate.states.getKey("hover");
sliceHoverState.properties.shiftRadius = 0; // no need to pull on click, as country circle under the pie won't make it good

// we don't need default pie chart animation, so change defaults
var hiddenState = pieSeries.hiddenState;
hiddenState.properties.startAngle = pieSeries.startAngle;
hiddenState.properties.endAngle = pieSeries.endAngle;
hiddenState.properties.opacity = 0;
hiddenState.properties.visible = false;

// series labels
var labelTemplate = pieSeries.labels.template;
labelTemplate.nonScaling = true;
labelTemplate.fill = am4core.color("#FFFFFF");
labelTemplate.fontSize = 10;
labelTemplate.background = new am4core.RoundedRectangle();
labelTemplate.background.fillOpacity = 0.9;
labelTemplate.padding(4, 9, 4, 9);
labelTemplate.background.fill = am4core.color("#7678a0");

// we need pie series to hide faster to avoid strange pause after country is clicked
pieSeries.hiddenState.transitionDuration = 200;

// country label
var countryLabel = chart.chartContainer.createChild(am4core.Label);
/*
countryLabel.text = "Select a country";
countryLabel.fill = am4core.color("#7678a0");
countryLabel.fontSize = 40;

countryLabel.hiddenState.properties.dy = 1000;
countryLabel.defaultState.properties.dy = 0;
countryLabel.valign = "middle";
countryLabel.align = "right";
countryLabel.paddingRight = 50;
countryLabel.hide(0);
countryLabel.show();
*/

// select polygon
function selectPolygon(mapPolygon) {
    if (morphedPolygon != mapPolygon) {
        var animation = pieSeries.hide();
        console.log("animation",animation);
        if (animation) {
            animation.events.on("animationended", function () {
                morphToCircle(mapPolygon);
            })
        }
        else {
            morphToCircle(mapPolygon);
        }
    }
}

// fade out all countries except selected
function fadeOut(exceptPolygon) {
    for (var i = 0; i < mapPolygonSeries.mapPolygons.length; i++) {
        var polygon = mapPolygonSeries.mapPolygons.getIndex(i);
        if (polygon != exceptPolygon) {
            polygon.defaultState.properties.fillOpacity = map_option.fillOpacity;
            polygon.animate([{ property: "fillOpacity", to: map_option.fillOpacity }, { property: "strokeOpacity", to: 1 }], polygon.polygon.morpher.morphDuration);
        }
    }
}

function zoomOut() {
    if (morphedPolygon) {
        pieSeries.hide();
        morphBack();
        fadeOut();
        countryLabel.hide();
        morphedPolygon = undefined;
    }
}

function morphBack() {
    if (morphedPolygon) {
        morphedPolygon.polygon.morpher.morphBack();
        
        /*
        var dsf = morphedPolygon.filters.getIndex(0);
        dsf.animate({ property: "saturation", to: 0.25 }, morphedPolygon.polygon.morpher.morphDuration);
        */
    }
}

function morphToCircle(mapPolygon) {

    var animationDuration = mapPolygon.polygon.morpher.morphDuration;
    // if there is a country already morphed to circle, morph it back
    morphBack();
    // morph polygon to circle
    mapPolygon.toFront();
    mapPolygon.polygon.morpher.morphToSingle = true;
    var morphAnimation = mapPolygon.polygon.morpher.morphToCircle();

    mapPolygon.strokeOpacity = 0; // hide stroke for lines not to cross countries

    mapPolygon.defaultState.properties.fillOpacity = map_option.fillOpacity;
    mapPolygon.animate({ property: "fillOpacity", to: map_option.fillOpacity }, animationDuration);

    // animate desaturate filter
    //var filter = mapPolygon.filters.getIndex(0);
    //filter.animate({ property: "saturation", to: 1 }, animationDuration);

    // save currently morphed polygon
    morphedPolygon = mapPolygon;

    // fade out all other
    fadeOut(mapPolygon);

    // hide country label
    countryLabel.hide();

    if (morphAnimation) {
        morphAnimation.events.on("animationended", function () {
            zoomToCountry(mapPolygon);
        })
    }
    else {
        zoomToCountry(mapPolygon);
    }
}

function zoomToCountry(mapPolygon) {
	// 포커스 이동하는거인듯
	/*
    var zoomAnimation = chart.zoomToMapObject(mapPolygon, 2.2, true);
    if (zoomAnimation) {
        zoomAnimation.events.on("animationended", function () {
            showPieChart(mapPolygon);
        })
    }
    else {*/
        showPieChart(mapPolygon);
    //}
}

function showPieChart(mapPolygon) {
	// 시도 코드
	var mapCodeInfo = getMapCodeInfo(mapPolygon.polygon.dataItem.dataContext.id);
	if (!mapCodeInfo && !pieData[mapCodeInfo.upr_cd]) {
		return;
	}
	// 임시데이터 {시도구분코드:{건수:cnt,많은순서:}}
	var data = pieData[mapCodeInfo.upr_cd];
    mapPolygon.polygon.measure();
    var radius = mapPolygon.polygon.measuredWidth / (2 * mapPolygon.globalScale) / chart.seriesContainer.scale;
    pieChart.width = radius * 2;
    pieChart.height = radius * 2;
    pieChart.radius = radius;

    var centerPoint = am4core.utils.spritePointToSvg(mapPolygon.polygon.centerPoint, mapPolygon.polygon);
    centerPoint = am4core.utils.svgPointToSprite(centerPoint, chart.seriesContainer);

    pieChart.x = centerPoint.x - radius;
    pieChart.y = centerPoint.y - radius;

    var fill = mapPolygon.fill;
    var desaturated = fill.saturate(0.3);
    for (var i = 0; i < pieSeries.dataItems.length; i++) {
        var dataItem = pieSeries.dataItems.getIndex(i);
        var color = am4core.color(upkindObj[dataItem.dataContext.code].color).rgb;
     	// 데이터 셋팅
        dataItem.value = data[dataItem.dataContext.code].value;
     	// 색깔
        dataItem.slice.fill = am4core.color(am4core.colors.interpolate(
        		fill.rgb,
            am4core.color("#ffffff").rgb,
            0.2 * data[dataItem.dataContext.code].sort // 건수 많은 순으로 색 변화주기
        ));
        dataItem.label.text = dataItem.dataContext.category;
        dataItem.label.background.fill = desaturated;
        dataItem.tick.stroke = fill;
    }

    pieSeries.show();
    pieChart.show();

    countryLabel.text = "{name}";
    countryLabel.dataItem = mapPolygon.dataItem;
    countryLabel.fill = desaturated;
    countryLabel.show();
}
/////////////////////////////////////////////////////
//Image series
var imageSeries = chart.series.push(new am4maps.MapImageSeries());

var imageTemplate = imageSeries.mapImages.template;
imageTemplate.propertyFields.longitude = "longitude";
imageTemplate.propertyFields.latitude = "latitude";
imageTemplate.nonScaling = true;
//imageTemplate.tooltipText = "{name}";
//imageTemplate.alwaysShowTooltip = true;
imageTemplate.adapter.add("fill", function (fill, target) {
	//target.dataItem.dataContext
	if (target.dataItem.dataContext&&!getMapCodeInfo(target.dataItem.dataContext.upr_cd)) {
		return am4core.color("#e0e0e0");
	}
	if (target.dataItem.dataContext) {
		return am4core.color(mapData2[getMapCodeInfo(target.dataItem.dataContext.upr_cd).upr_cd].color);
	}
    return colorSet.getIndex(target.dataItem.index + 1);
})

var label = imageTemplate.createChild(am4core.Label);
label.text = "{name}";
label.horizontalCenter = "middle";
label.verticalCenter = "top";
label.dy = -2;
label.dx = 15;
label.fill = am4core.color("#FFFFFF");
label.fontSize = 10;
label.padding(14, 12, 4, 13);
label.background = new am4core.RoundedRectangle();
//label.background.fillOpacity = 0.9;
label.background.fill = am4core.color("#7678a0");
label.hide(0);

var image = imageTemplate.createChild(am4core.Image);
image.propertyFields.href = "imageURL";
image.width = 50;
image.height = 50;
image.horizontalCenter = "middle";
image.verticalCenter = "middle";

/////////////////////////////////////////////////////

imageSeries.data = mapData.map(function(d){
	d.name = d.name.replace("특별시","").replace("특별자치시","").replace("광역시","").replace("도","")
	d.width = 32;
	d.height = 32;
	return d;
});

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

imageTemplate.events.on("out", function (ev) {
	ev.target.children.each(function(c){
		if (c._className == "Label"){
			c.hide(0);
		}
		if (c._className == "Image"){
			c.width = 50;
			c.height = 50;
		}
	})
});

///////////////////////////////////////////////////////////////////////////////////////////
//////								pie 차트											///////
//////								pie 차트											///////
//////								pie 차트											///////
///////////////////////////////////////////////////////////////////////////////////////////
// Pie chart
var pieChart = am4core.create("chartdiv3", am4charts.PieChart);
pieChart.innerRadius = 100;
pieChart.width = 300;
pieChart.height = 200;
pieChart.chartContainer.minHeight = 1;
pieChart.chartContainer.minWidth = 1;
pieChart.x = 50;
pieChart.y = 100;
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
label3.fontSize = 50;

imageTemplate.events.on("over", function (ev) {
	// map event
	ev.target.children.each(function(c){
		if (c._className == "Label"){
			c.show();
			c.fill = am4core.color(ev.target.dataItem.dataContext.color).brighten(-0.1);
			c.background.fill = am4core.color("#ffffff");
			c.fontSize = 13;
		}
		if (c._className == "Image"){
			c.width = 60;
			c.height = 60;
		}
	})
	// gauge event
	var value = ev.target.dataItem.dataContext.total;
	label.text = value;
	label2.text = ev.target.dataItem.dataContext.name;
	label2.fill = am4core.color(ev.target.dataItem.dataContext.color).brighten(-0.2);
	label.fill = am4core.color(ev.target.dataItem.dataContext.color).brighten(-0.1);
	var animation = new am4core.Animation(hand, {
	    property: "value",
	    to: value>200?200:value
	}, 1000, am4core.ease.cubicOut).start();
	
	// pie event
	var upr_cd = ev.target.dataItem.dataContext.upr_cd;
	if (upr_cd) {
    	pieChart.hidden = true;
    	for (var i = 0; i < pieSeries.dataItems.length; i++) {
            var dataItem = pieSeries.dataItems.getIndex(i);
         	// 데이터 셋팅
            dataItem.value = pieData[upr_cd][i].value;
            dataItem.category = pieData[upr_cd][i].category;
         	// 색깔
            dataItem.slice.fill = am4core.color(am4core.colors.interpolate(
            	am4core.color(mapData2[upr_cd].color).rgb,
                am4core.color("#ffffff").rgb,
                0.4 * pieData[upr_cd][i].sort // 건수 많은 순으로 색 변화주기
            ));
            dataItem.slice.stroke = am4core.color("#ffffff");
            dataItem.label.text = pieData[upr_cd][i].category+" : "+pieData[upr_cd][i].value+"마리";
            dataItem.label.background.fill = am4core.color(mapData2[upr_cd].color);
            dataItem.tick.stroke = am4core.color(mapData2[upr_cd].color);
        }
    	pieChart.show();
    	label3.text = ev.target.dataItem.dataContext.name;
    	label3.fill = am4core.color(mapData2[upr_cd].color).brighten(-0.3); 
    }
});

}); // end am4core.ready()
</script>
<!-- HTML -->
<div class="container">
<table style="width:100%;">
<tr>
<td rowspan="2"><div id="chartdiv" style="float:left;"></div></td>
<td><div id="chartdiv3" style="height: 400px;width:400px;float:left;"></div></td>
</tr>
<tr>
<td><div id="chartdiv2" style="height: 300px;width:300px;float:left;"></div></td>
</tr>
</table>
</div>
<script>
// chart data create
var tmp = {6110000:25, 6290000:10, 5690000:10, 6300000:10, 6280000:19, 6310000:25, 6410000:88, 6420000:14, 6260000:34, 6270000:16};
var mapData = [];
var pieData = {};
for (var upr_cd in tmp) {
	var dd = [] ;
	for (var i in upkindArr) {
		var ddd = getMapCodeInfo(upr_cd);
		ddd.upkind=upkindArr[i];
		ddd.upkindNm=getUpkindNm(upkindArr[i]);
		ddd.code=upkindArr[i];
		ddd.category=getUpkindNm(upkindArr[i]);
		ddd.value=Math.round(Math.random()*100)+10;
		dd.push(ddd);
	}
	// 정렬
	for (var i=1;i<dd.length;i++) {
		for (var j=0;j<dd.length-i;j++) {
			if (dd[j].value<dd[j+1].value){
				var dtmp = dd[j]; 
				dd[j] = dd[j+1];
				dd[j+1] = dtmp;
			}
		}
	}
	var prev = null;
	var cnt = -1;
	var total = 0;
	// 정렬후 순서 셋팅
	for (var i=0;i<dd.length;i++) {
		if(prev!=null && dd[i].value == prev){
			dd[i].sort = cnt;
		} else {
			dd[i].sort = ++cnt;
		}
		prev = dd[i].value;
		
		/*
		// pieData = {시도코드:{{멍},{냥},..},..};
		if (!pieData[upr_cd]) {
			pieData[upr_cd] = {};
		}
		pieData[upr_cd][dd[i].upkind] = dd[i];
		*/
		
		// mapData용
		total += dd[i].value;
	}
	// pieData = {시도코드:[{멍},{냥},..],..};
	pieData[upr_cd] = dd;
	
	var ddd = getMapCodeInfo(upr_cd);
	ddd.total=total;
	mapData.push(ddd);
}

for (var i=1;i<mapData.length;i++) {
	for (var j=0;j<mapData.length-i;j++) {
		if (mapData[j].total<mapData[j+1].total){
			var dtmp = mapData[j]; 
			mapData[j] = mapData[j+1];
			mapData[j+1] = dtmp;
		}
	}
}
var mapData2 = {};
var cnt = -1;

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
var sido_info = [{"upr_cd":"6280000","map_id":"28","name":"인천광역시","latitude":37.55,"longitude":126.65},{"upr_cd":"6110000","map_id":"11","name":"서울특별시","latitude":37.6,"longitude":127.002},{"upr_cd":"6410000","map_id":"41","name":"경기도","latitude":37.3,"longitude":127.3},{"upr_cd":"6420000","map_id":"42","name":"강원도","latitude":37.7,"longitude":128.3},{"upr_cd":"5690000","map_id":"36","name":"세종특별자치시","latitude":36.6,"longitude":127.28167},{"upr_cd":"6300000","map_id":"30","name":"대전광역시","latitude":36.3,"longitude":127.43},{"upr_cd":"6270000","map_id":"27","name":"대구광역시","latitude":35.87222,"longitude":128.6025},{"upr_cd":"6310000","map_id":"31","name":"울산광역시","latitude":35.53889,"longitude":129.31},{"upr_cd":"6260000","map_id":"26","name":"부산광역시","latitude":35.25,"longitude":129},{"upr_cd":"6290000","map_id":"29","name":"광주광역시","latitude":35.18,"longitude":126.85}];
var sidoMax = 0;
for (var i=0;i<mapData.length;i++) {
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
	
	// max set
	if (sidoMax<total) {
		sidoMax = total;
	}
	
	var upr_cd = mapData[i].upr_cd;
	if (!mapData2[upr_cd]) {
		mapData2[upr_cd] = {};
	}
	mapData2[upr_cd] = mapData[i];
}
console.log("pieData",pieData);
console.log("mapData",mapData);
console.log("mapData2",mapData2);
</script>