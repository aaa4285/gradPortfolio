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
axis.renderer.labels.template.radius = -40;
axis.renderer.minGridDistance = 100;
axis.renderer.labels.template.fill = am4core.color("#7678a0");
axis.renderer.labels.template.adapter.add("text", function(text) {
	if (text == 200){return "max";}
  return text;1
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
range0.axisFill.fillOpacity = 0.7;
range0.axisFill.fill = am4core.color(lv_info.color[1]);//colorSet.getIndex(0);
var range1 = axis2.axisRanges.create();
range1.value = 50;
range1.endValue = 100;
range1.axisFill.fillOpacity = 0.7;
range1.axisFill.fill = am4core.color(lv_info.color[2]);//colorSet.getIndex(0);
var range2 = axis2.axisRanges.create();
range2.value = 100;
range2.endValue = 150;
range2.axisFill.fillOpacity = 0.7;
range2.axisFill.fill = am4core.color(lv_info.color[3]);//colorSet.getIndex(0);
var range3 = axis2.axisRanges.create();
range3.value = 150;
range3.endValue = 200;
range3.axisFill.fillOpacity = 0.7;
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
var def = "6110000"; // 초기값 서울
// Pie chart
var pieChart = am4core.create("chartdiv3", am4charts.PieChart);

// Add and configure Series
var pieSeries = pieChart.series.push(new am4charts.PieSeries());
pieSeries.dataFields.value = "value";
pieSeries.dataFields.category = "category";
pieSeries.data = pieData[def];//[{ value: 30, category: "417000", a:'' }, { value: 50, category: "422400", a:'' }, { value: 70, category: "429900", a:'' }];
// Let's cut a hole in our Pie chart the size of 30% the radius
pieChart.innerRadius = am4core.percent(30);

// Put a thick white border around each Slice
pieSeries.slices.template.stroke = am4core.color("#fff");
pieSeries.slices.template.strokeWidth = 2;
pieSeries.slices.template.strokeOpacity = 0.7;
pieSeries.slices.template
  .cursorOverStyle = [
    {
      "property": "cursor",
      "value": "pointer"
    }
  ];
pieSeries.slices.template.adapter.add("fill", function (fill, target) {
	//target.dataItem.dataContext
	var upr_cd = target.dataItem.dataContext.upr_cd;
	if (!target.dataItem||!target.dataItem.dataContext||!target.dataItem.dataContext.upr_cd) {
		return am4core.color("#e0e0e0");
	}
	
	var upr_cd = target.dataItem.dataContext.upr_cd||"";
	var mapData = mapData2[upr_cd];
	if (mapData) {
		var color = am4core.color(mapData.color);
		var pieColor = am4core.color(am4core.colors.interpolate(
        		color.rgb,
                am4core.color("#ffffff").rgb,
                0.4 * target.dataItem.dataContext.sort // 건수 많은 순으로 색 변화주기
            ));
		return pieColor;
	}
	return am4core.color("#e0e0e0");
});

pieSeries.alignLabels = false;
pieSeries.labels.template.bent = true;
pieSeries.labels.template.radius = 3;
pieSeries.labels.template.padding(0,0,0,0);
pieSeries.labels.template.fontSize = 11;

pieSeries.labels.template.adapter.add("fill", function (fill, target) {
	var upr_cd = target.dataItem.dataContext.upr_cd;
	if (!target.dataItem||!target.dataItem.dataContext||!target.dataItem.dataContext.upr_cd) {
		return am4core.color("#e0e0e0");
	}
	
	var upr_cd = target.dataItem.dataContext.upr_cd||"";
	var mapData = mapData2[upr_cd];
	if (mapData) {
		var color = am4core.color(mapData.color);
		return color.brighten(-0.3);
	}
	return am4core.color("#e0e0e0");
});
pieSeries.labels.template.adapter.add("background.fill", function (fill, target) {
	var upr_cd = target.dataItem.dataContext.upr_cd;
	if (!target.dataItem||!target.dataItem.dataContext||!target.dataItem.dataContext.upr_cd) {
		return am4core.color("#e0e0e0");
	}
	
	var upr_cd = target.dataItem.dataContext.upr_cd||"";
	var mapData = mapData2[upr_cd];
	if (mapData) {
		var color = am4core.color(mapData.color);
		var pieColor = am4core.color(am4core.colors.interpolate(
        		color.rgb,
                am4core.color("#ffffff").rgb,
                0.4 * target.dataItem.dataContext.sort // 건수 많은 순으로 색 변화주기
            ));
		return pieColor;
	}
	return am4core.color("#e0e0e0");
});

pieSeries.ticks.template.disabled = true;

// Create a base filter effect (as if it's not there) for the hover to return to
var shadow = pieSeries.slices.template.filters.push(new am4core.DropShadowFilter);
shadow.opacity = 0;

// Create hover state
var hoverState = pieSeries.slices.template.states.getKey("hover"); // normally we have to create the hover state, in this case it already exists

// Slightly shift the shadow and make it more prominent on hover
var hoverShadow = hoverState.filters.push(new am4core.DropShadowFilter);
hoverShadow.opacity = 0.7;
hoverShadow.blur = 5;

// 지역 나타내는 label
var label3 = pieChart.seriesContainer.createChild(am4core.Label);
label3.text = "{name}";
label3.horizontalCenter = "middle";
label3.verticalCenter = "middle";
label3.fontSize = 20;
label3.text = mapData2[def].name;
label3.fill = am4core.color( mapData2[def].color).brighten(-0.3);

//pieChart.hidden = true;

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
            dataItem.label.fill = am4core.color(color).brighten(-0.3);
        }
    	//pieChart.show();
    	label3.text = mapData.name;
    	label3.fill = color.brighten(-0.3); 
    }
});
}); // end am4core.ready()