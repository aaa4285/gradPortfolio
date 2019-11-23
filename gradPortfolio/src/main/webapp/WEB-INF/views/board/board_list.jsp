<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="kindsNm" value="전체"/>
<c:set var="kinds" value="${search.kinds}"/>
<c:set var="genderNm" value="전체"/>
<c:set var="gender" value="${search.gender}"/>
<c:if test="${kinds eq '1'}">
	<c:set var="kindsNm" value="강아지"/>
</c:if>
<c:if test="${kinds eq '2'}">
	<c:set var="kindsNm" value="고양이"/>
</c:if>
<c:if test="${kinds eq '3'}">
	<c:set var="kindsNm" value="기타"/>
</c:if>
<c:if test="${kinds eq '0'}">
	<c:set var="genderNm" value="암컷"/>
</c:if>
<c:if test="${kinds eq '1'}">
	<c:set var="genderNm" value="수컷"/>
</c:if>
<c:if test="${kinds eq '2'}">
	<c:set var="genderNm" value="미상"/>
</c:if>
	<script>
		$(document).ready(function(){
			$('.default-select > select').niceSelect();
		})
		function goPage(page,_this) {
			if (_this) {
				$(".page-item").removeClass("active");
				$(_this).addClass("active");
			}
			loder_show();
			//location.href=url;
			$("#form").find("input[name=page]").val(page||1);
			$("#form").attr("action", "/board/list");
			$("#form").submit();
		}
		function goDetail(board_id) {
			loder_show();
			location.href='/board/detail/'+board_id;
		}
	</script>
	<section class="banner-area logo2 relative" id="home">	
		<div class="overlay overlay-bg"></div>
		<div class="container">
			<div class="row d-flex align-items-center justify-content-center">
				<div class="banner-content col-lg-12">
					<h1 class="text-white">
						<span>실종동물</span> 찾기			
					</h1>	
					<form id="form" class="serach-form-area" method="get">
						<input type="hidden" name="page" value="${search.page}">
						<div class="row justify-content-center form-wrap">
							<div class="col-lg-4 form-cols">
								<input type="text" class="form-control" name="subject" placeholder="검색할 제목 입력" value="${search.subject}">
							</div>
							<div class="col-lg-3 form-cols">
								<div class="default-select" id="default-selects">
									<select style="display:none;" name="kinds">
										<option value="" ${empty kinds?"selected='selected'":""}>전체</option>
										<option value="1" ${kinds eq "1"?"selected='selected'":""}>강아지</option>
										<option value="2" ${kinds eq "2"?"selected='selected'":""}>고양이</option>
										<option value="3" ${kinds eq "3"?"selected='selected'":""}>기타</option>
									</select>
									<div class="nice-select" tabindex="0">
										<span class="current">${kindsNm}</span>
										<ul class="list">
											<li data-value="" class='option${empty kinds ? " selected":""}'>전체</li>
											<li data-value="1" class='option${kinds eq "1" ? " selected":""}'>강아지</li>
											<li data-value="2" class='option${kinds eq "2" ? " selected":""}'>고양이</li>
											<li data-value="3" class='option${kinds eq "3" ? " selected":""}'>기타</li>
										</ul>
									</div>
								</div>
							</div>
							<div class="col-lg-3 form-cols">
								<div class="default-select" id="default-selects2">
									<select style="display: none;" name="gender">
										<option value="" ${empty gender?"selected='selected'":""}>전체</option>
										<option value="0" ${gender eq "3"?"selected='selected'":""}>암컷</option>
										<option value="1" ${gender eq "3"?"selected='selected'":""}>수컨</option>
										<option value="2" ${gender eq "3"?"selected='selected'":""}>미상</option>
									</select>
									<div class="nice-select" tabindex="0">
										<span class="current">전체</span>
										<ul class="list">
											<li data-value="" class='option${empty gender ? " selected":""}'>전체</li>
											<li data-value="0" class='option${gender eq "0" ? " selected":""}'>암컷</li>
											<li data-value="1" class='option${gender eq "1" ? " selected":""}'>수컷</li>
											<li data-value="2" class='option${gender eq "2" ? " selected":""}'>미상</li>
										</ul>
									</div>
								</div>										
							</div>
							<div class="col-lg-2 form-cols">
							    <button type="button" class="btn btn-info" onclick="goPage();">
							      <span class="lnr lnr-magnifier"></span> Search
							    </button>
							</div>								
						</div>
					</form>	
				</div>											
			</div>
		</div>
	</section>
	
<main id="main">
	<section id="portfolio2" class="section-bg">
			<div class="container wow bounceInUp" data-wow-duration="1.4s">

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
						<div class="col-md-3 col-sm-3 col-xs-6 portfolio-item ${filter} wow bounceInUp">
							<div class="portfolio-wrap screenshot-holder">
								<img src="${empty l.fullPath?"http://toeic.ybmclass.com/toeic/img/noimage.gif":"https://".concat(l.fullPath)}" class="img-fluid" alt="">
								<div class="portfolio-info" onclick="goDetail('${l.board_id}');" style="cursor:pointer;">
									<h4><a href="javascript:void(0);">${l.subject}</a></h4>
									<p>${l.displayName}</p>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				  <!-- Pagination -->
			  <ul class="pagination justify-content-center">
			  	<c:if test="${pageMaker.prev}">
				    <li class="page-item">
				      <a class="page-link" href="javascript:void(0);" aria-label="Previous">
				            <span aria-hidden="true">&laquo;</span>
				            <span class="sr-only">Previous</span>
				          </a>
				    </li>
			    </c:if>
			    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					<li class="page-item ${pageMaker.cri.page eq idx?" active":""}" onclick="goPage('${idx}',this)">
						<a class="page-link waves-effect waves-effect" href='javascript:void(0);'>${idx}</a>
					</li>
				</c:forEach>
			    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
				    <li class="page-item">
				      <a class="page-link" href="javascript:void(0);" aria-label="Next">
				            <span aria-hidden="true">&raquo;</span>
				            <span class="sr-only">Next</span>
				          </a>
				    </li>
			    </c:if>
			  </ul>
			</div>
	</section><!-- #portfolio2 -->
</main>