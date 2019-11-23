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
						<a href="/main/index2.do" class="btn-get-started scrollto">Find Started</a>
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
			Team Section
		============================-->
		<section id="team" class="section-bg">
			<div class="container">
				<div class="section-header">
					<h3>보호중 현황</h3>
					<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque</p>
				</div>

				<div class="row">
					<c:forEach var="l" items="${list}" varStatus="status">
						<div class="col-lg-3 col-md-6 wow fadeInUp">
							<div class="member">
								<img src="${empty l.fullPath?"http://toeic.ybmclass.com/toeic/img/noimage.gif":"https://".concat(l.fullPath)}" class="img-fluid" alt="">
								<div class="member-info">
									<div class="member-info-content">
										<h4>${l.subject}</h4>
										<span>${l.displayName}</span>
										<div class="social">
										<!-- 
											<a href=""><i class="fa fa-twitter"></i></a>
											<a href=""><i class="fa fa-facebook"></i></a>
											<a href=""><i class="fa fa-google-plus"></i></a>
											<a href=""><i class="fa fa-linkedin"></i></a>
											 -->
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>

				</div>

			</div>
		</section><!-- #team -->

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
										<a href="javascript:void(0);" class="link-details" title="More Details"><i class="ion ion-android-open"></i></a>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>

			</div>
		</section><!-- #portfolio2 -->
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
							<h3>유기동물 현황 조회중</h3>
						</div>
						
					</div>
				</div>
			</div>
		</section>
		<%--
		<section id="testimonials2">
			<div class="container wow bounceInUp" data-wow-duration="1.4s">

				<header class="section-header">
					<h3>보호중 현황</h3>
				</header>

				<div class="row justify-content-center wow bounceInUp" data-wow-duration="1.4s">
					<div class="col-lg-8">
						
						<div class="owl-carousel testimonials-carousel2">
							<c:forEach var="l" items="${list}" varStatus="status">
								<div class="testimonial-item">
									<div style="position:relative;text-align:center;width: 100%;height:auto;">
										<img src="${empty l.fullPath?"http://toeic.ybmclass.com/toeic/img/noimage.gif":"https://".concat(l.fullPath)}" class="testimonial-img" alt="">
									</div>
									<div style="position:relative;text-align:center;width: 100%;height:auto;">
										<h3>${l.kinds eq "1"?"강아지":(l.kinds eq "1"?"고양이":"기타동물")} - ${l.subject}</h3>
										<h4>${l.displayName}</h4>
									</div>
								</div>
							</c:forEach>
						</div>

					</div>
				</div>

			</div>
		</section><!-- #testimonials2 -->
		
		<section id="testimonials3">
			<div class="container wow bounceInUp" data-wow-duration="1.4s">

				<header class="section-header">
					<h3>찾아요 현황</h3>
				</header>

				<div class="row justify-content-center wow bounceInUp" data-wow-duration="1.4s">
					<div class="col-lg-8">
						
						<div class="owl-carousel testimonials-carousel2">
							<c:forEach var="l" items="${list2}" varStatus="status">
								<div class="testimonial-item">
									<div style="position:relative;text-align:center;width: 100%;height:auto;">
										<img src="${empty l.fullPath?"http://toeic.ybmclass.com/toeic/img/noimage.gif":"https://".concat(l.fullPath)}" class="testimonial-img" alt="">
									</div>
									<div style="position:relative;text-align:center;width: 100%;height:auto;">
										<h3>${l.kinds eq "1"?"강아지":(l.kinds eq "1"?"고양이":"기타동물")} - ${l.subject}</h3>
										<h4>${l.displayName}</h4>
									</div>
								</div>
							</c:forEach>
						</div>

					</div>
				</div>

			</div>
		</section><!-- #testimonials2 -->
 --%>
		<!--==========================
			Team Section
		============================-->
		<!-- 
		<section id="team" class="section-bg">
			<div class="container">
				<div class="section-header">
					<h3>Team</h3>
					<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque</p>
				</div>

				<div class="row">

					<div class="col-lg-3 col-md-6 wow fadeInUp">
						<div class="member">
							<img src="/common2/img/team-1.jpg" class="img-fluid" alt="">
							<div class="member-info">
								<div class="member-info-content">
									<h4>Walter White</h4>
									<span>Chief Executive Officer</span>
									<div class="social">
										<a href=""><i class="fa fa-twitter"></i></a>
										<a href=""><i class="fa fa-facebook"></i></a>
										<a href=""><i class="fa fa-google-plus"></i></a>
										<a href=""><i class="fa fa-linkedin"></i></a>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
						<div class="member">
							<img src="/common2/img/team-2.jpg" class="img-fluid" alt="">
							<div class="member-info">
								<div class="member-info-content">
									<h4>Sarah Jhonson</h4>
									<span>Product Manager</span>
									<div class="social">
										<a href=""><i class="fa fa-twitter"></i></a>
										<a href=""><i class="fa fa-facebook"></i></a>
										<a href=""><i class="fa fa-google-plus"></i></a>
										<a href=""><i class="fa fa-linkedin"></i></a>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.2s">
						<div class="member">
							<img src="/common2/img/team-3.jpg" class="img-fluid" alt="">
							<div class="member-info">
								<div class="member-info-content">
									<h4>William Anderson</h4>
									<span>CTO</span>
									<div class="social">
										<a href=""><i class="fa fa-twitter"></i></a>
										<a href=""><i class="fa fa-facebook"></i></a>
										<a href=""><i class="fa fa-google-plus"></i></a>
										<a href=""><i class="fa fa-linkedin"></i></a>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
						<div class="member">
							<img src="/common2/img/team-4.jpg" class="img-fluid" alt="">
							<div class="member-info">
								<div class="member-info-content">
									<h4>Amanda Jepson</h4>
									<span>Accountant</span>
									<div class="social">
										<a href=""><i class="fa fa-twitter"></i></a>
										<a href=""><i class="fa fa-facebook"></i></a>
										<a href=""><i class="fa fa-google-plus"></i></a>
										<a href=""><i class="fa fa-linkedin"></i></a>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>

			</div>
		</section> -->
		<!-- #team -->

		<!--==========================
			Clients Section
		============================-->
		<section id="clients" class="wow fadeInUp">
			<div class="container">

				<header class="section-header">
					<h3>베너</h3>
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