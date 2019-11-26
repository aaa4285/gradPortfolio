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
					<h2>지금 당신의<br><span>반려동물</span>을 찾으세요!</h2>
					<div>
						<a href="/main/index2.do" class="btn-get-started scrollto">FIND STARTED</a>
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
			Portfolio Section
		============================-->
<c:set var="numOfRows" value="4"/>
<script type="text/javascript">
	function delayFormat(d){
		console.log(d);
		
		return (d%2==1?'data-wow-delay="0.1s"':""); 
	}
	function filterFormat(d) {
		if (d.indexOf("[개]")>-1) {
			return "filter-dog";
		} else if (d.indexOf("[고양이]")>-1) {
			return "filter-cat";
		}
		return "filter-etc";
	}
	$(document).ready(function() {
		ajax("/abandonmentPublic",
			{pageNo:1,numOfRows:${numOfRows}},
			function(data){
				list = data.data;
				resetHtml("owl-carousel",data.data,function(){
					setTimeout(function(){
						$("#owl-carousel-loading").css("display","none");
						$(".testimonials-carousel").owlCarousel({
						    autoplay: true,
						    dots: true,
						    loop: true,
						    items: 1
						  });
					},300);
				});
			}, false);
	});
	
</script>

<script type="text/html" id="owl-carousel">
<div class="testimonial-item">
	<div style="position:relative;text-align:center;width: 100%;height:auto;">
		<img src="#popfile#" class="testimonial-img" alt="">
	</div>
	<div style="position:relative;text-align:center;width: 100%;height:auto;">
		<h3>#kindCd# - #processState#</h3>
		<h4>발견장소 : #happenPlace#</h4>
	</div>
</div>
</script>
		
		<!--==========================
			Portfolio Section
		============================-->
		<section id="portfolio2" class="section-bg">
			<div class="container">

				<header class="section-header">
					<h3 class="section-title">찾아요 현황</h3>
				</header>

				<div class="row">
					<div class="col-lg-12">
						<ul id="portfolio-flters2">
							<li data-filter="*" class="filter-active">All</li>
							<li data-filter=".filter-dog">강아지</li>
							<li data-filter=".filter-cat">고양이</li>
							<li data-filter=".filter-etc">기타</li>
						</ul>
					</div>
				</div>
				
				<div class="row portfolio-container2">
					<c:forEach var="l" items="${list}" varStatus="status">
						<c:set var="filter" value="filter-etc" />
						<c:if test="${l.kinds eq '1'}">
							<c:set var="filter" value="filter-dog" />
						</c:if>
						<c:if test="${l.kinds eq '2'}">
							<c:set var="filter" value="filter-cat" />
						</c:if> 
						<div class="col-lg-4 col-md-6 portfolio-item ${filter} wow bounceInUp" data-wow-duration="1.4s" <c:if test="${status.count%2 == 0}">data-wow-delay="0.1s"</c:if>>
							<div class="portfolio-wrap">
								<img src="${empty l.fullPath?"http://toeic.ybmclass.com/toeic/img/noimage.gif":"https://".concat(l.fullPath)}" class="img-fluid" alt="">
								<div class="portfolio-info">
									<h4><a href="javascript:void(0);">${l.subject}</a></h4>
									<p>${l.displayName}</p>
									<div>
										<c:if test="${!empty l.fullPath}">
											<a href="https://${l.fullPath}" data-lightbox="portfolio" data-title="${l.subject}" class="link-preview" title="Preview"><i class="ion ion-eye"></i></a>
										</c:if>
										<a href="/board/detail/${l.board_id}" class="link-details" title="More Details"><i class="ion ion-android-open"></i></a>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>

			</div>
		</section><!-- #portfolio2 -->
		
		<section id="portfolio3" class="section-bg">
			<div class="container">

				<header class="section-header">
					<h3 class="section-title">보호중 현황</h3>
				</header>

				<div class="row">
					<div class="col-lg-12">
						<ul id="portfolio-flters3">
							<li data-filter="*" class="filter-active">All</li>
							<li data-filter=".filter-dog">강아지</li>
							<li data-filter=".filter-cat">고양이</li>
							<li data-filter=".filter-etc">기타</li>
						</ul>
					</div>
				</div>
				
				<div class="row portfolio-container3">
					<c:forEach var="l" items="${list2}" varStatus="status">
						<c:set var="filter" value="filter-etc" />
						<c:if test="${l.kinds eq '1'}">
							<c:set var="filter" value="filter-dog" />
						</c:if>
						<c:if test="${l.kinds eq '2'}">
							<c:set var="filter" value="filter-cat" />
						</c:if> 
						<div class="col-lg-4 col-md-6 portfolio-item ${filter} wow bounceInUp" data-wow-duration="1.4s" <c:if test="${status.count%2 == 1}">data-wow-delay="0.1s"</c:if>>
							<div class="portfolio-wrap">
								<img src="${empty l.fullPath?"http://toeic.ybmclass.com/toeic/img/noimage.gif":"https://".concat(l.fullPath)}" class="img-fluid" alt="">
								<div class="portfolio-info">
									<h4><a href="javascript:void(0);">${l.subject}</a></h4>
									<p>${l.displayName}</p>
									<div>
										<c:if test="${!empty l.fullPath}">
											<a href="https://${l.fullPath}" data-lightbox="portfolio" data-title="${l.subject}" class="link-preview" title="Preview"><i class="ion ion-eye"></i></a>
										</c:if>
										<a href="/proBoard/detail/${l.board_id}" class="link-details" title="More Details"><i class="ion ion-android-open"></i></a>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>

			</div>
		</section><!-- #portfolio3 -->
		
		<!--==========================
			Clients Section
		============================-->
		<section id="testimonials">
			<div class="container wow bounceInUp" data-wow-duration="1.4s">

				<header class="section-header">
					<h3>유기동물 현황</h3>
				</header>

				<div class="row justify-content-center">
					<div class="col-lg-8">

						<div class="owl-carousel testimonials-carousel" for="owl-carousel">
						</div>
						<div class="testimonial-item" id="owl-carousel-loading">
							<div style="position:relative;text-align:center;width: 100%;height:auto;">
								<img src="http://images.battlecomics.co.kr/users/342512/page/item/381adfc0-c22d-4d62-9cd9-64781c063223.gif" class="testimonial-img" alt="">
							</div>
							<div style="position:relative;text-align:center;width: 100%;height:auto;">
								<h3>유기동물정보 로딩중</h3>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>