<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Styles -->
<style>
#chartdiv {
  width: 700px;;
  height: 700px;
}
</style>
<style>
.findAPetMenu-locationInputContainer:after {
    content: "";
    position: absolute;
    display: block;
    top: 0;
    left: 100%;
    border-left: 20px solid #2e0152;
    border-top: 50px solid transparent;
    border-bottom: 50px solid transparent;
}
.findAPetMenu-button_other:after {
    -webkit-transform: rotate(0);
    -ms-transform: rotate(0);
    transform: rotate(0);
    }
    /* 화살표 */
    .findAPetMenu-button_other:after {
    content: "";
    display: inline-block;
    width: 14px;
    height: 14px;
    margin-left: 10px;
    background: transparent url(data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' …a3.5 3.5 0 0 0-5 0 3.5 3.5 0 0 0 0 5l8.9 8.9z' fill='%23fff'/%3E%3C/svg%3E) no-repeat 50%;
    background-size: 14px;
    -webkit-transform: rotate(-90deg);
    -ms-transform: rotate(-90deg);
    transform: rotate(-90deg);
    -webkit-transition: -webkit-transform .2s;
    transition: -webkit-transform .2s;
    -o-transition: transform .2s;
    transition: transform .2s;
    transition: transform .2s, -webkit-transform .2s;
    vertical-align: middle;
}
/* hero */
.hero-img {
    display: block;
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    height: 100%;
    width: 100%;
    font-family: "object-fit:cover;object-position:center";
    -o-object-fit: cover;
    object-fit: cover;
    -o-object-position: center;
    object-position: center;
    -webkit-transition: opacity .5s;
    -o-transition: opacity .5s;
    transition: opacity .5s;
    }
.hero {
    display: block;
    overflow: hidden;
    position: relative;
    height: 200px;
    background: transparent no-repeat 50%;
    background-size: cover;
}    
.findAPetMenu-locationInputContainer{
}
@media print, screen and (min-width: 668px){
.hero {
    height: 280px;
}}
@media print, screen and (min-width: 1024px){
.hero {
    height: 320px;
}}
button.findAPetMenu-button:hover *{
color:#2e0152 !important;
fill:#2e0152 !important;
}
</style>
<div class="hero">
	<img class="hero-img" src="https://d17fnq9dkz9hgj.cloudfront.net/uploads/2017/06/why-are-dogs-scared-of-firework-header.jpg" srcset="https://d17fnq9dkz9hgj.cloudfront.net/uploads/2017/06/why-are-dogs-scared-of-firework-header.jpg 800w, https://d17fnq9dkz9hgj.cloudfront.net/uploads/2017/06/feeding-small-dogs@420.jpg 500w" sizes="(max-width: 500px) 500px, (max-width: 800px) 800px" alt="" aria-hidden="true">
</div>
<div class="u-pullUpLarge" style="margin-top: -50px;">
	<div class="findAPetMenu" style="padding: 0 50px;">
		<div class="findAPetMenu-inner" data-test="Find_A_Pet_Menu"
			style="display: -webkit-box; display: -ms-flexbox; display: flex; -ms-flex-wrap: wrap; flex-wrap: wrap; position: relative; width: 100%; background: #6504b5; -ms-flex-wrap: nowrap; flex-wrap: nowrap; height: 100px; max-width: 1220px; margin: 0 auto; border-radius: 10px; -webkit-box-shadow: 0 1px 3px rgba(77, 71, 81, .2); box-shadow: 0 1px 3px rgba(77, 71, 81, .2);">
			<div class="findAPetMenu-locationInputContainer"
				style="display: none; position: relative; background-color: #2e0152; border-radius: 10px 0 0 10px; -webkit-box-flex: 1; -ms-flex-positive: 1; flex-grow: 1; height: 100px; -ms-flex-preferred-size: 20%; flex-basis: 20%; display: block;">
				<div class="u-isVisuallyHidden" aria-live="polite" aria-busy="false"
					aria-atomic="true"
					style="overflow: hidden !important; width: 1px !important; height: 1px !important; margin: -1px !important; border: 0 !important; padding: 0 !important; position: absolute !important; clip: rect(1px, 1px, 1px, 1px) !important; clip: rect(1px, 1px, 1px, 1px) !important; -webkit-clip-path: rect(1px, 1px, 1px, 1px) !important; clip-path: rect(1px, 1px, 1px, 1px) !important;"></div>
				<form id="form">
					<select class="findAPetMenu-locationInput" id="upr_cd" name="upr_cd"
						aria-label="위치별로 애완 동물 찾기"
						aria-describedby="FindAPetMenu_Location_Input_Description"
						data-test="Find_A_Pet_Menu_Location_Input"
						style="display: block; height: 100px; width: 50%; float:left;border-right: 1px solid #482367 !important; padding: 0 0 0 15%; background-color: #2e0152; border: none; border-radius: 10px 0 0 10px; -webkit-box-sizing: border-box; box-sizing: border-box; color: #fff; font-size: 14px; font-family: Nexa Regular, arial, helvetica, sans-serif;">
						<option value="">지역선택</option>
						<c:forEach var="map" items="${sido.data}" varStatus="status">
							<option value="${map.orgCd}">${map.orgdownNm}</option>
						</c:forEach>
					</select>
					<select class="findAPetMenu-locationInput"  id="org_cd" name="org_cd"
						aria-describedby="FindAPetMenu_Location_Input_Description"
						data-test="Find_A_Pet_Menu_Location_Input"
						style="display: block; height: 100px; width: 50%; float:left;padding: 0 0 0 15%; background-color: #2e0152; border: none; border-radius: 10px 0 0 10px; -webkit-box-sizing: border-box; box-sizing: border-box; color: #fff; font-size: 14px; font-family: Nexa Regular, arial, helvetica, sans-serif;">
						<option value="">지역선택</option>
					</select>
					<input type="hidden" name="upkind" value="">
				</form>
			</div>
			<button class="findAPetMenu-button findAPetMenu-button_dogs"
				data-test="Find_A_Pet_Find_Dog_Button" type="button"
				aria-label="개 찾기"
				style="border: none; background: #6504b5; display: block; width: 13%; color: #fff; font-size: 13px; -webkit-transition: background-color .25s; -o-transition: background-color .25s; transition: background-color .25s; font-size: 14px; text-align: center; -webkit-box-flex: 1; -ms-flex-positive: 1; flex-grow: 1; height: 100px;">
				<span class="findAPetMenu-buttonIcon"
					style="display: inline-block; width: 30px; height: 40px; margin-right: 10px; vertical-align: middle; width: 50px; height: 50px;"><svg
						role="img" focusable="false"
						style="display: block; width: 100%; height: 100%; overflow: visible; fill: #fff;">
							<use xlink:href="#icon-dog"></use></svg></span><span><font
					style="vertical-align: inherit;"><font
						style="vertical-align: inherit;">개 찾기</font></font></span>
			</button>
			<button class="findAPetMenu-button findAPetMenu-button_cats"
				data-test="Find_A_Pet_Find_Cat_Button" type="button"
				aria-label="고양이 찾기"
				style="border:none; background: #6504b5; display: block; width: 13%; color: #fff; font-size: 13px; -webkit-transition: background-color .25s; -o-transition: background-color .25s; transition: background-color .25s; font-size: 14px; text-align: center; -webkit-box-flex: 1; -ms-flex-positive: 1; flex-grow: 1; height: 100px; border-left: 1px solid #2e0152;">
				<span class="findAPetMenu-buttonIcon"
					style="display: inline-block; width: 30px; height: 40px; margin-right: 10px; vertical-align: middle; width: 50px; height: 50px;"><svg
						role="img" focusable="false"
						style="display: block; width: 100%; height: 100%; overflow: visible; fill: #fff;">
							<use xlink:href="#icon-cat"></use></svg></span><span><font
					style="vertical-align: inherit;"><font
						style="vertical-align: inherit;">고양이 찾기</font></font></span>
			</button>
			<button class="findAPetMenu-button findAPetMenu-button_other"
				type="button" aria-expanded="false"
				data-test="Find_A_Pet_Find_Other_Pets_Button"
				style="width:10%;color: white; border:none; background: #6504b5; -webkit-box-flex: 1; -ms-flex-positive: 1; flex-grow: 1; height: 100px; background-color: transparent; border-left: 1px solid #2e0152; border-radius: 0 10px 10px 0; border-left: 1px solid #2e0152; font-family: Nexa Regular, arial, helvetica, sans-serif;">
				<font style="vertical-align: inherit;"><font
					style="vertical-align: inherit;">다른 애완 동물 찾기</font></font>
			</button>
		</div>
	</div>
</div>
<!-- Resources -->
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/maps.js"></script>
<script src="https://www.amcharts.com/lib/4/geodata/worldHigh.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<script src="/common/js/common_utils.js"></script>
<script>
$(document).ready(function(){
	//시도 change - 시군구 조회
	$("#upr_cd").on("change", function(){
		// 시군구,보호소 초기화
		$("#org_cd option[value!='']").remove();
		
		// 공백체크
		if ($("#upr_cd").val()=="") {
			return;
		}
		$.ajax({
			type:"POST",
			url:"/sigungu",
			contentType:"application/json;charset=UTF-8",
			data:JSON.stringify({upr_cd:$("#upr_cd").val()}),
			success : function(data){
				data.data.forEach(function(map){
					$("#org_cd").append('<option value="'+map.orgCd+'">'+map.orgdownNm+'</option>');
				});
			},
			error: function(request,status,error){
	            alert("2code:"+request.status+"\n"+"error:"+error);
	        }
	 
		});
	});
})
</script>
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
//mapPolygonTemplate.tooltipText = "{name}";
//mapPolygonTemplate.alwaysShowTooltip = true;
// take a color from color set
mapPolygonTemplate.adapter.add("fill", function (fill, target) {
	//target.dataItem.dataContext
	if (target.dataItem&&target.dataItem.dataContext&&!getMapCodeInfo(target.dataItem.dataContext.id)) {
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

/////////////////////////////////////////////////////
//Image series
var imageSeries = chart.series.push(new am4maps.MapImageSeries());

var imageTemplate = imageSeries.mapImages.template;
imageTemplate.propertyFields.longitude = "longitude";
imageTemplate.propertyFields.latitude = "latitude";
imageTemplate.nonScaling = true;
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

var label = imageTemplate.createChild(am4core.Label);
label.text = "{name}";
label.horizontalCenter = "middle";
label.verticalCenter = "top";
label.dy = -2;
label.dx = 15;
label.fill = am4core.color("#FFFFFF");
label.fontSize = 10;
label.padding(12, 12, 4, 12);
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
	<table style="width: 100%;">
		<tr>
			<td rowspan="2"><div id="chartdiv" style="float: left;"></div></td>
			<td><div id="chartdiv3"
					style="height: 400px; width: 400px; float: left;"></div></td>
		</tr>
		<tr>
			<td><div id="chartdiv2"
					style="height: 300px; width: 300px; float: left;"></div></td>
		</tr>
	</table>
</div>
<div style="display:none;">
<svg id="icon-dog" viewBox="0 0 101.8 87.7"><circle cx="21.8" cy="16.3" r="2.7"></circle><path d="M100.1 27.8C81 27.8 81 44.5 81 50v26.8c0 2.9-2.3 5.2-5.2 5.2h-.6c-2.9 0-5.2-2.3-5.2-5.2v-8.5c0-2.6-1.2-5.2-3.1-6.8-1.6-1.4-3.6-2-5.7-1.7l-18.1 2.7c-5.1.9-8.2 4.1-8.2 8.5v5.9c0 2.9-2.3 5.2-5.2 5.2h-.6c-2.9 0-5.2-2.3-5.2-5.2V35.7H25c.9 0 1.7-.7 1.7-1.7 0-.9-.7-1.7-1.7-1.7H14.1c-6.6 0-9.2-6.4-9.4-6.7-1.7-4.1-1.5-5.7-1.4-6.1.4-.3 2-1.2 7.1-2.2 1.7-.4 3-1.3 4-2.9 1.2-1.7 2.5-3.6 2.8-3.9C19.1 8.3 21 7.4 24.9 7c0 0 3.9-.3 7.6 0h.5l7.1-1.4c1.5-.3 1.7-.1 2.5.9l.1.2c2 2.5 5.7 8.1 6.9 13.3-.4.5-2.4 1.4-4.9 1-2.1-.3-5.8-1.6-7.1-7.1-.2-.9-1.1-1.4-2-1.2s-1.4 1.1-1.2 2c1.4 5.8 5.1 8.7 9 9.5v3.4c0 5.6 3.2 8.9 8.9 8.9h9.2c.9 0 1.7-.7 1.7-1.7 0-.9-.7-1.7-1.7-1.7h-9.2c-3.8 0-5.5-1.7-5.5-5.5v-3.1c.6 0 1.2-.1 1.7-.2 3.2-.7 5-2.6 4.5-4.7-1.3-5.4-5-11.4-7.7-14.8l-.1-.1C44 3.2 42.8 2 39.5 2.6L32.7 4c-4-.4-7.8 0-8 0-4.8.5-7.5 1.8-9.9 4.6-.4.5-2.4 3.3-3 4.1-.6.9-1.2 1.3-2 1.5-4.9 1-7.9 2.2-8.9 3.3-.9.9-1.7 3.2.8 9.5.1.4 3.6 8.7 12.4 8.7h6.4v41.1c0 4.7 3.8 8.5 8.5 8.5h.6c4.7 0 8.5-3.8 8.5-8.5v-5.9c0-3.7 3.4-4.9 5.4-5.2l18-2.6c1.3-.2 2.4.4 3 .9 1.2 1 1.9 2.7 1.9 4.3v8.5c0 4.7 3.8 8.5 8.5 8.5h.6c4.7 0 8.5-3.8 8.5-8.5V50c0-8.8 1.8-18.9 15.8-18.9.9 0 1.7-.7 1.7-1.7s-.4-1.6-1.4-1.6z"></path></svg>
<svg id="icon-cat" viewBox="0 0 101.8 87.7"><path d="M34.1 31.4c-.8 0-1.4-.5-1.6-1.3-.2-.9.4-1.7 1.3-1.9l10.9-2.1c.9-.2 1.7.4 1.9 1.3s-.4 1.7-1.3 1.9l-10.9 2.1h-.3zM45 39h-.3l-10.9-2.2c-.9-.2-1.4-1-1.3-1.9.2-.9 1-1.4 1.9-1.3l10.9 2.1c.9.2 1.4 1 1.3 1.9-.2.9-.8 1.4-1.6 1.4z"></path><circle cx="26.6" cy="25.8" r="2.2"></circle><path d="M87 58.2c-.8-.5-1.8-.3-2.2.5-.5.8-.3 1.8.5 2.2 3.5 2.3 5.6 6.1 5.6 10.2 0 6.7-5.5 12.2-12.2 12.2H22.9v-2.6c0-.7.6-1.3 1.3-1.3h.9c3.6-.1 4-3.2 4-4.5v-29c.6.1 1.1.1 1.6.1h.5c.9 0 1.6-.8 1.5-1.7 0-.9-.8-1.6-1.7-1.6-.4 0-9.7.3-12.8-8.2-.1-.3-.4-1.4 0-2.2.1-.3.3-.6 1.1-.9.6-.2 1.1-.9 1.1-1.5 0-.1-.1-7.7 4.8-12.3l.1-.1s2.3-2.5 6.9-4h.1s.1 0 .2-.1c0 0 .1 0 .1-.1.1 0 .1-.1.1-.1l.1-.1.1-.1.1-.1.1-.1s0-.1.1-.1c0-.1 0-.1.1-.2V11.6l-1.2-5.4c1.3.3 3 1 4.6 2.2.1.1.1.1.2.1.1.5.3.6.5.6.9.2 1.7-.3 2-1.2l.7-3c1.9 1.2 5.5 4.3 8.4 12.2v.1s.1.2.2.3l.1.1s0 .1.1.1c3.2 3.2 5 7.5 5 12 0 4.4-1.7 8.6-4.8 11.8v.1c-.4.3-.6.8-.6 1.3 0 4.9 4 8.9 8.9 8.9h.6c7.9 0 14.3 6.4 14.3 14.3v9.4c0 .9.7 1.6 1.6 1.6.9 0 1.6-.7 1.6-1.6v-9.4c0-9.7-7.9-17.6-17.6-17.6h-.6c-2.9 0-5.3-2.2-5.6-5 3.5-3.7 5.5-8.6 5.5-13.8 0-5.3-2-10.2-5.7-14-4.9-13-11.9-14.5-12.2-14.6-.8-.2-1.7.4-1.9 1.2l-.6 2.6c-3.3-1.9-6.6-2-6.8-2-.5 0-1 .2-1.3.6-.3.4-.4.9-.3 1.4l1.4 6.3c-4.2 1.7-6.4 3.9-6.8 4.3-4.9 4.5-5.7 11.1-5.9 13.6-.8.5-1.5 1.2-1.9 2.1-1 2.1-.1 4.4 0 4.6 2.1 5.7 6.6 8.4 10.6 9.6V75c0 1.3-.3 1.3-.9 1.3h-.7c-2.5 0-4.5 2-4.5 4.5V85c0 .9.7 1.6 1.6 1.6h57.3c8.5 0 15.4-6.9 15.4-15.4 0-5.3-2.6-10.1-7-13z"></path></svg>
<svg id="Capa_1" enable-background="new 0 0 512 512" height="512" viewBox="0 0 512 512" width="512" xmlns="http://www.w3.org/2000/svg"><path d="m60 468.027v28.973c0 8.284 6.716 15 15 15h100c8.284 0 15-6.716 15-15v-28.974h-130z"/><path d="m178.245 345.155-40.374-57.66c-10.511-15.013-30.933-19.776-46.494-10.844-4.68 2.687-8.631 6.426-11.592 10.896-.01-.018-.02-.036-.03-.053-7.812 11.66-8.144 27.415.377 39.584l17.225 24.599c4.752 6.786 3.103 16.139-3.683 20.891-6.786 4.752-16.139 3.103-20.891-3.684l-17.224-24.599c-9.95-14.211-13.769-31.459-10.751-48.567 2.914-16.525 11.878-30.977 25.29-40.911-.058-1.172-.098-2.345-.098-3.52v-93.629c0-19.112-15.049-35.195-34.156-35.647-19.683-.466-35.844 15.41-35.844 34.989v137.907c0 2.031.412 4.041 1.212 5.907l58.788 137.213h130v-55.59c0-13.408-4.064-26.3-11.755-37.282z"/><path d="m452 468.027v28.973c0 8.284-6.716 15-15 15h-100c-8.284 0-15-6.716-15-15v-28.974h130z"/><path d="m333.755 345.155 40.374-57.66c10.511-15.013 30.933-19.776 46.494-10.844 4.68 2.687 8.631 6.426 11.592 10.896.01-.018.02-.036.03-.053 7.812 11.66 8.144 27.415-.377 39.584l-17.225 24.599c-4.752 6.786-3.103 16.139 3.683 20.891 6.786 4.752 16.139 3.103 20.891-3.684l17.224-24.599c9.95-14.211 13.769-31.459 10.751-48.567-2.914-16.525-11.878-30.977-25.29-40.911.058-1.172.098-2.346.098-3.521v-93.629c0-19.112 15.049-35.195 34.156-35.647 19.683-.465 35.844 15.411 35.844 34.99v137.907c0 2.031-.412 4.041-1.212 5.907l-58.788 137.213h-130v-55.59c0-13.408 4.065-26.3 11.755-37.282z"/><path d="m241 170h30v80h-30z"/><path d="m395.966 119.345-130-115.556c-5.684-5.053-14.248-5.053-19.932 0l-130 115.556c-6.191 5.503-6.749 14.985-1.245 21.176 5.503 6.191 14.984 6.75 21.177 1.246l15.034-13.364v106.597c0 8.284 6.716 15 15 15h45v-95c0-8.284 6.716-15 15-15h60c8.284 0 15 6.716 15 15v95h45c8.284 0 15-6.716 15-15v-106.597l15.034 13.364c2.858 2.541 6.416 3.789 9.96 3.789 4.136 0 8.254-1.701 11.217-5.035 5.504-6.191 4.946-15.672-1.245-21.176z"/></svg>
</div>