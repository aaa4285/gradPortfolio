<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.body{text-align:center;width:100%;min-height:550px;padding-top:25px;}
.inner{display:inline-block;width:1024px;}
.radius{border-radius: 3px;}
.row{position: relative;width:100%;padding:3px 0;}
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
.card .inner{
	width:25%;display:inline-block;height:100%;padding:5px;
}
.card .inner img {
	border-radius: 2px;height: calc(100% - 30px);background: #ffffff;width:100%;border: 1px solid #e8e8e8;display: inline-block;
}
.card .inner div.fake {
	border-radius: 2px;height: calc(100% - 30px);background: #46156f;width:100%;border: 1px solid #e8e8e8;display: inline-block;
}
.card .inner div:last-child {
	background: #e8e8e8;width:100%;height:30px;display: inline-block;
}
.row .title{
text-align: left;background: #6504b5;width: 100%;height: 30px;margin: 0 3px;border-top-right-radius: 8px;color: white;border-top-left-radius: 8px;padding-left: 14px;
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
		<div class="title"><h4>FREE BOARD</h4></div>
		<div class="col">
			<div class="radius card" style="display: block;height:250px;">
				<c:forEach var="l" items="${list}" varStatus="status">
				<div class="fl inner">
					<img class="fl" src="http://${empty l.fullPath?"toeic.ybmclass.com/toeic/img/noimage.gif":l.fullPath}">
					<div class="fl">${l.subject}</div>
				</div>
				</c:forEach>
				<div style="position:absolute;top:-1px;right:0;">
					<a href="/board/list" class="btn btn-secondary btn-rounded waves-effect waves-light btn-sm" style="float:left;cursor:pointer;">more></a>
				</div>
			</div>
		</div>
	</div>
	<div class="row" id="abandonmentPublic">
		<div class="title"><h4>FIND PAT</h4></div>
		<div class="col">
		<!-- 
			<div class="radius card init" style="z-index: 1;width:calc(100% - 5px);display: block;height: 250px;position: absolute;background:rgba(255, 255, 255, 0.52);padding-top: 111px;">
				<h4>조회중..</h4>
			</div>
			 -->
			<div class="radius card" style="display: block;height:250px;">
				<div class="fl inner">
					<div class="fake">
						<span class="icon icon_xxl m-icon_colorWhite">
			               <svg role="img" focusable="false" aria-hidden="true" style="fill: #fff;width: 139px;padding-top:30px;">
			                   <use xlink:href="#icon-strokedPaw"></use>
			               </svg>
						</span>
					</div>
					<div class="processState"></div>
				</div>
				<div class="fl inner">
					<div class="fake">
						<span class="icon icon_xxl m-icon_colorWhite">
			               <svg role="img" focusable="false" aria-hidden="true" style="fill: #fff;width: 139px;padding-top:30px;">
			                   <use xlink:href="#icon-strokedPaw"></use>
			               </svg>
						</span>
					</div>
					<div class="processState"></div>
				</div>
				<div class="fl inner">
					<div class="fake">
						<span class="icon icon_xxl m-icon_colorWhite">
			               <svg role="img" focusable="false" aria-hidden="true" style="fill: #fff;width: 139px;padding-top:30px;">
			                   <use xlink:href="#icon-strokedPaw"></use>
			               </svg>
						</span>
					</div>
					<div class="processState"></div>
				</div>
				<div class="fl inner">
					<div class="fake">
						<span class="icon icon_xxl m-icon_colorWhite">
			               <svg role="img" focusable="false" aria-hidden="true" style="fill: #fff;width: 139px;padding-top:30px;">
			                   <use xlink:href="#icon-strokedPaw"></use>
			               </svg>
						</span>
					</div>
					<div class="processState"></div>
				</div>
				<div style="position:absolute;top:-1px;right:0;">
					<a href="/main/index2.do" class="btn btn-secondary btn-rounded waves-effect waves-light btn-sm" style="float:left;cursor:pointer;">more></a>
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
ajax("/abandonmentPublic",{pageNo:1,numOfRows:4},
	function(data){
		data.data.forEach(function(d,i){
			//$("#abandonmentPublic .radius.card.init").hide();
			var p = $("#abandonmentPublic .radius.card > div.inner").eq(i);
			if (!p) {
				return;
			}
			p.find("div.fake").remove();
			p.prepend('<img class="fl" src="'+d.popfile+'">');
			p.find("div.processState").text(d.processState);
		})
	}, false);
var lv_info = {
		color:{4:"#ff3a3a",3:"#ff9a44",2:"#ffe73c",1:"#32b936",0:"#e0e0e0"},
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
<div style="display:none;">
	<svg id="icon-strokedPaw" viewBox="0 0 42.26 40.83"><path d="M10.42 17.57c0-3.51-2.34-6.36-5.21-6.36S0 14.06 0 17.57s2.34 6.35 5.21 6.35 5.21-2.85 5.21-6.35zm-5.21 4.57c-1.9 0-3.44-2.05-3.44-4.58s1.54-4.58 3.44-4.58 3.42 2.06 3.42 4.59-1.52 4.57-3.42 4.57zM42.26 17.56c0-3.5-2.34-6.35-5.21-6.35s-5.21 2.85-5.21 6.36a.89.89 0 1 0 1.77 0c0-2.52 1.54-4.58 3.44-4.58s3.44 2.05 3.44 4.58c0 2.52-1.54 4.57-3.44 4.57a.89.89 0 0 0 0 1.78c2.87 0 5.21-2.85 5.21-6.36zM27.63 12.72c2.87 0 5.21-2.85 5.21-6.36S30.49 0 27.63 0s-5.21 2.85-5.21 6.36 2.32 6.36 5.21 6.36zm0-10.94c1.9 0 3.44 2.05 3.44 4.58s-1.56 4.58-3.44 4.58-3.44-2.05-3.44-4.58 1.53-4.58 3.44-4.58zM14.63 12.72c2.87 0 5.21-2.85 5.21-6.36S17.52 0 14.63 0 9.42 2.85 9.42 6.36s2.35 6.36 5.21 6.36zm0-10.94c1.9 0 3.44 2.05 3.44 4.58s-1.53 4.58-3.44 4.58-3.44-2.05-3.44-4.58 1.56-4.58 3.44-4.58zM33.63 28.65l-5.5-9.63c-1.82-3.17-4.31-4.92-7-4.92s-5.18 1.75-7 4.92l-5.5 9.62a11.12 11.12 0 0 0-.9 2 7.54 7.54 0 0 0-.5 2.69.61.61 0 0 0 0 .08 7.5 7.5 0 0 0 7.1 7.41h.3a7.35 7.35 0 0 0 2.91-.59c.66-.26 1.76-.76 2.9-1.3l.41.17a18.59 18.59 0 0 0 7.07 1.71 7.51 7.51 0 0 0 7.14-7.39 9 9 0 0 0-.49-2.72 11.18 11.18 0 0 0-.94-2.05zm-5.72 10.39a15.1 15.1 0 0 1-5.28-1.14l.34-.17 1-.46a.86.86 0 0 0 .18-.14l1-.51.94-.48a.89.89 0 0 0-.8-1.59l-1 .48c-1.55.79-4.14 2.12-5.23 2.57l-.1.07c-.83.39-1.6.73-2.08.92a5.2 5.2 0 0 1-2.4.45h-.09a5.72 5.72 0 0 1-5.42-5.62.35.35 0 0 0 0-.07 5.82 5.82 0 0 1 .4-2.09 9.27 9.27 0 0 1 .77-1.7l5.49-9.65c1.49-2.6 3.43-4 5.47-4s4 1.43 5.47 4l5.53 9.63a9.47 9.47 0 0 1 .77 1.7 7.21 7.21 0 0 1 .42 2.18 5.71 5.71 0 0 1-5.38 5.62z"></path></svg>
</div>