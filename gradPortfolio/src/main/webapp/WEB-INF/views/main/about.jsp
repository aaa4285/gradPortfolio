<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

	<!--==========================
		Intro Section
	============================-->
	<section id="intro" class="clearfix">
		<div class="container d-flex h-100">
			<div class="row justify-content-center align-self-center">
				<div class="col-md-6 intro-info order-md-first order-last">
					<h2>이 지금 당신의<br><span>Pet</span>을 찾으세요!</h2>
					<div>
						<a href="#about" class="btn-get-started scrollto">Find Started</a>
					</div>
				</div>
	
				<div class="col-md-6 intro-img order-md-last order-first">
					<img src="http://www.petn.co.kr/images/illust.png" alt="" class="img-fluid">
				</div>
			</div>

		</div>
	</section><!-- #intro -->
	
<main id="main">

		<!--==========================
			Why Us Section
		============================-->
		<section id="why-us" class="wow fadeIn">
			<div class="container-fluid">
				
				<header class="section-header">
					<h3>1년간 유기된 동물수</h3>
				</header>
				
			</div>

			<div class="container">
			
				<div class="row counters">

					<div class="col-lg-3 col-6 text-center">
						<span data-toggle="counter-up">1,364</span>
						<p>전체</p>
					</div>

					<div class="col-lg-3 col-6 text-center">
						<span data-toggle="counter-up">721</span>
						<p>강아지</p>
					</div>

					<div class="col-lg-3 col-6 text-center">
						<span data-toggle="counter-up">568</span>
						<p>고양이</p>
					</div>

					<div class="col-lg-3 col-6 text-center">
						<span data-toggle="counter-up">18</span>
						<p>기타</p>
					</div>
	
				</div>
				
				<div class="row wow bounceInUp" data-wow-duration="1.4s">

					<div class="col-lg-12" id="line" style="height:300px;">
					</div>
				</div>
				
				<div class="container-fluid wow fadeIn" data-wow-duration="1.4s" style="margin-top: 60px;">
				
					<header class="section-header">
						<h3>1주간 유기된 동물수</h3>
					</header>
					
				</div>
				
				<div class="row wow bounceInUp" data-wow-duration="1.4s">
	 				<div class="col-lg-6" id="barchart">
	 				</div>
					<div class="col-lg-6" id="">
						<div class="radius card" style="height:400px;width:100%;">
							<div id="chartdiv3" style="width: 230px;height:233px;position: absolute;left: 23px;top: 10px;"></div>
							<div id="chartdiv2" style="width: 230px;height:132px;position: absolute;left: 31px;bottom: 18px;"></div>
							<div id="chartdiv"style="width: calc(100% - 181px);height:400px;position: absolute;right: -47px;"></div>
						</div>
					</div>
				</div>

			</div>
		</section>
		
		
		<!--==========================
			Services Section
		============================-->
		<section id="services" class="section-bg">
			<div class="container">

				<header class="section-header">
					<h3>Services</h3>
					<p>Laudem latine persequeris id sed, ex fabulas delectus quo. No vel partiendo abhorreant vituperatoribus.</p>
				</header>

				<div class="row">

					<div class="col-md-6 col-lg-4 wow bounceInUp" data-wow-duration="1.4s">
						<div class="box">
							<div class="icon" style="background: #fceef3;"><i class="ion-ios-analytics-outline" style="color: #ff689b;"></i></div>
							<h4 class="title"><a href="">유기동물 조회</a></h4>
							<p class="description">Voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident</p>
						</div>
					</div>
					<div class="col-md-6 col-lg-4 wow bounceInUp" data-wow-duration="1.4s">
						<div class="box">
							<div class="icon" style="background: #fff0da;"><i class="ion-ios-bookmarks-outline" style="color: #e98e06;"></i></div>
							<h4 class="title"><a href="">보호동물 게시</a></h4>
							<p class="description">Minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat tarad limino ata</p>
						</div>
					</div>

					<div class="col-md-6 col-lg-4 wow bounceInUp" data-wow-delay="0.1s" data-wow-duration="1.4s">
						<div class="box">
							<div class="icon" style="background: #e6fdfc;"><i class="ion-ios-paper-outline" style="color: #3fcdc7;"></i></div>
							<h4 class="title"><a href="">실종동물 찾기</a></h4>
							<p class="description">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur</p>
						</div>
					</div>
				</div>

			</div>
		</section><!-- #services -->
		
		<!--==========================
			About Us Section
		============================-->
		<section id="about" class="wow fadeInUp">

			<div class="container">
				<div class="row">

					<div class="col-lg-5 col-md-6" style="height:auto;">
						<div class="about-img">
							<img src="https://www.muan.go.kr/images/www/sub/public_data_img.gif" alt="">
						</div>
					</div>

					<div class="col-lg-7 col-md-6" style="height:auto;">
						<div class="about-content">
							<h2>About Us</h2>
							<h3>공공데이터란 ?</h3>
							<p>데이터베이스, 전자화된 파일등 공공기관이 법령 등에서 정하는 목적을 위하여 생성 또는 취득하여 관리하고 있는 광 또는 전자적 방식으로 처리된 자료 또는 정보를 말함.</p>
							<h3>동물보호관리시스템 유기동물 조회 서비스란?</h3>
							<p>농림축산식품부 농림축산검역본부에서 관리하는 동물보호관리시스템의 유기동물 정보를 조회할 수 있다.</p>
							<!-- 
							<ul>
								<li><i class="ion-android-checkmark-circle"></i></li>
							</ul>
							 -->
						</div>
					</div>
				</div>
			</div>

		</section><!-- #about -->

		<!--==========================
			Clients Section
		============================-->
		<section id="clients" class="wow fadeInUp">
			<div class="container">

				<header class="section-header">
					<h3>Our Clients</h3>
				</header>

				<div class="owl-carousel clients-carousel">
					<img src="/common2/img/clients/client-1.png" alt="">
					<img src="/common2/img/clients/client-2.png" alt="">
					<img src="/common2/img/clients/client-3.png" alt="">
					<img src="/common2/img/clients/client-4.png" alt="">
					<img src="/common2/img/clients/client-5.png" alt="">
					<img src="/common2/img/clients/client-6.png" alt="">
					<img src="/common2/img/clients/client-7.png" alt="">
					<img src="/common2/img/clients/client-8.png" alt="">
				</div>

			</div>
		</section><!-- #clients -->

	</main>
	
	
<!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- 데이터 셋팅 -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* -->
<!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- 데이터 셋팅 -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* -->
<!-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- 데이터 셋팅 -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-* -->
<script>
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
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<script src="https://www.amcharts.com/lib/4/maps.js"></script>
<script src="https://www.amcharts.com/lib/4/geodata/worldHigh.js"></script>
<script src="/common/js/common_utils.js"></script>
<script src="/common/js/chart/line.js"></script>
<script src="/common/js/chart/bar.js"></script>
<script src="/common/js/chart/map.js"></script>