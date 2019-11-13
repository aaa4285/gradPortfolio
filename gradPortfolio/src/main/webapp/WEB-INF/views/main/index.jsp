<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.body{text-align:center;width:100%;min-height:550px;padding-top:25px;}
.inner{display:inline-block;width:1024px;}
.radius{border-radius: 3px;}
.row{position: relative;width:100%;padding:2px 0;}
.col{
	padding:0 2px;
    float: left;
    width: 100%;
}
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
.card .inner{
	width:25%;display:inline-block;height:100%;padding:5px;
}
.card .inner img {
	border-radius: 2px;height: calc(100% - 30px);background: #ffffff;width:100%;border: 1px solid #e8e8e8;
}
.card .inner img + div {
	background: #e8e8e8;width:100%;height:30px;
}
</style>
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<script src="https://www.amcharts.com/lib/4/maps.js"></script>
<script src="https://www.amcharts.com/lib/4/geodata/worldHigh.js"></script>
<script src="/common/js/common_utils.js"></script>
<script src="/common/js/chart/line.js"></script>
<script src="/common/js/chart/bar.js"></script>
<script src="/common/js/chart/map.js"></script>
<!-- Chart code -->
<div class="inner radius">
	<div class="row">
		<div class="col">
			<div class="radius card" style="display: block;height:250px;">
				<div class="fl inner">
					<img class="fl" src="${search.data[0].popfile}">
					<div class="fl">${search.data[0].processState}</div>
				</div>
				<div class="fl inner">
					<img class="fl" src="${search.data[1].popfile}">
					<div class="fl">${search.data[1].processState}</div>
				</div>
				<div class="fl inner">
					<img class="fl" src="${search.data[2].popfile}">
					<div class="fl">${search.data[2].processState}</div>
				</div>
				<div class="fl inner">
					<img class="fl" src="${search.data[3].popfile}">
					<div class="fl">${search.data[3].processState}</div>
				</div>
				<div style="position:absolute;top:0;right:0;">
					<a href="/main/index2.do" class="btn btn-primary" style="float:left;">더보기></a>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<div class="radius card" id="line"  style="height:300px;"></div>
		</div>
	</div>
	<div class="row">
		<div class="col2">
			<div class="radius card" id="barchart"  style="height:400px;"></div>
		</div>
		<div class="col2">
			<div class="radius card" style="height:400px;width:100%;">
				<div id="chartdiv3" style="width: 230px;height:233px;position: absolute;left: 23px;top: 10px;"></div>
				<div id="chartdiv2" style="width: 230px;height:132px;position: absolute;left: 31px;bottom: 18px;"></div>
				<div id="chartdiv"style="width: calc(100% - 181px);height:400px;position: absolute;right: -47px;"></div>
			</div>
		</div>
	</div>
</div>
<!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- 데이터 셋팅 -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* -->
<!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- 데이터 셋팅 -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* -->
<!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- 데이터 셋팅 -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* -->
<script>
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

</script>
