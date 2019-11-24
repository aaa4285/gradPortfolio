<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

  <!-- Custom fonts for this theme -->
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

  <!-- Theme CSS -->
  <link href="/common3/css/freelancer.css" rel="stylesheet">
  <style>
  	.blog-post-list{
  	padding:0;
  	}
	  .portfolio-item img.img-fluid {
	    object-fit: cover;
	    height: 250px !important;
	    width: 100%  !important;
	  }
	  .modal-content img.img-fluid {
	    max-height: 400px;
	    width: 100%;
	    object-fit: contain;
	  }
	      
	  .modal-content table{
	  	display: inline-block;
	  	margin-bottom: 10px;
	  }
	  .modal-content tr {
	  	 border-bottom: 3px solid white;
	  }
	  .modal-content th {
	      padding: 10px;
	  	border: none;
	    background: #cacaca;
	    text-align: left;
	    color: #4f5763;
	    border-top-left-radius: 8px;
	    border-bottom-left-radius: 8px;
	  }
	  .modal-content td {
	   color: #4f5763;
	      padding: 10px;
	  	text-align:left;
	  	border: none;
	  }
	  .modal-content .mask {
	  	left: 5px;
	    position: absolute;
	    top: 5px;
	  }
	  .portfolio-modal{
	  	    z-index: 9999;
	  }
	  .portfolio-modal .close {
	  	    color: #000000;
	  }
	  .btn-primary.focus,.btn-primary:focus{box-shadow:0 0 0 .2rem #6e5eb5}
	  .single-post .tags{
	  	padding: 0;
	  	margin: 0;
	  }
	  .portfolio-modal h5,.portfolio-modal p{
	  	margin:0;pedding:0;
	  }
	  .portfolio-modal h2{
	  	margin:0;padding-bottom: 10px;
	  }
	  
  </style>
<script type="text/html" id="liveList">
        <div class="col-md-6 col-lg-4" idx="#_list_idx_#">
          <div class="portfolio-item mx-auto" data-toggle="modal" data-target="#fn{detailFormat:_list_idx_}#">
            <div class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
              <div class="portfolio-item-caption-content text-center text-white">
                <i class="fa fa-search-plus"></i>
              </div>
            </div>
            <img class="img-fluid" src="#popfile#" alt="">
          </div>
        </div>
</script>

<script type="text/html" id="detail">
<div class="portfolio-modal modal fade"
	id="#fn{detailIdFormat:_list_idx_}#" tabindex="-1" role="dialog"
	aria-labelledby="portfolioModal1Label" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<button type="button" class="close" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true"> <i class="fa fa-close"></i>
				</span>
			</button>
			<div class="modal-body text-center">
				<div class="container">
					<div class="row justify-content-center">

						<div class="col-lg-12 post-list blog-post-list">
							<div class="single-post">
								<div style="position: relative;" class="img-overap">
									<a href="#popfile#" data-lightbox="portfolio"
										data-title="#kindCd#, #processState#" title="원본보기"> <img
										class="img-fluid" src="#popfile#" alt="">
									</a>
								</div>
								<ul class="tags">
									<li><a href="javascript:void(0);"><i class="fa fa-hashtag"></i>#age#</a> ,</li>
									<li><a href="javascript:void(0);"><i class="fa fa-hashtag"></i>#sexCdNm#</a> ,</li>
									<li><a href="javascript:void(0);"><i class="fa fa-hashtag"></i>#weight#</a></li>
								</ul>
								<h2>
									<i class="fa fa-quote-left"></i> #kindCd# #processState#
									<i class="fa fa-quote-right"></i>
								</h2>
<table class="col-lg-9">
<tr>
<th width="100px"><h5>공고기간</h5></th>
<td width="*"><h5>#fn{yyyyMMddFormat:noticeSdt}# ~ #fn{yyyyMMddFormat:noticeEdt}#</h5></td>
</tr>
<tr>
<th width="100px"><h5>공고번호</h5></th>
<td width="*"><h5>#noticeNo#</h5></td>
</tr>
<tr>
<th width="100px"><h5>유기번호</h5></th>
<td width="*"><h5>#desertionNo#</h5></td>
</tr>
<tr>
<th width="100px"><h5>발견장소</h5></th>
<td width="*"><h5>#happenPlace#</h5></td>
</tr>
<tr>
<th width="100px"><h5>보호소</h5></th>
<td width="*"><h5>#careNm# (<i class="fa fa-phone"></i> #careTel#)</h5></td>
</tr>
<tr>
<th width="100px"><h5>담당자</h5></th>
<td width="*"><h5>#chargeNm# (<i class="fa fa-phone"></i> #officetel#)</h5></td>
</tr>
<tr>
<th width="120px"><h5>중성화여부</h5></th>
<td width="*"><h5>#neuterYnNm#</h5></td>
</tr>
<tr>
<th width="100px"><h5>특징</h5></th>
<td width="*"><h5>#specialMark#</h5></td>
</tr>
</table>
<div>
<button class="btn btn-primary" href="#" data-dismiss="modal">
                  <i class="fa fa-close"></i>
                  Close
                </button>
</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</script>
<script>
function processStateFormat(d){
	if (d == "보호중") {
		return "label-primary";
	}
	return "label-default";
}
function detailFormat(d){
	return "#portfolioModal"+d;
}
function detailIdFormat(d){
	return "portfolioModal"+d;
}
	$(document).ready(function(){
		$('.default-select > select').niceSelect();
		// 시도 change - 시군구 조회
		$("#upr_cd").on("change", function(){
			
			// 군구 초기화
			$("#org_cd option").not(":eq(0)").remove();
			if ($("#org_cd").next("div.nice-select").length == 1) {
				$("#org_cd").next("div.nice-select").find("ul.list li").not(":eq(0)").remove();
				$("#org_cd").next("div.nice-select").find("ul.list li:eq(0)").addClass("selected");
				$("#org_cd").next("div.nice-select").find("span.current").text($("#org_cd").next("div.nice-select").find("ul.list li:eq(0)").text());
			}
			
			// 공백체크
			if ($("#upr_cd").val()=="") {
				return;
			}
			
			ajax("/sigungu",{upr_cd:$("#upr_cd").val()},
				function(data){
					data.data.forEach(function(map){
						$("#org_cd").append('<option value="'+map.orgCd+'">'+map.orgdownNm+'</option>');
						if ($("#org_cd").next("div.nice-select").length == 1) {
							$("#org_cd").next("div.nice-select").find("ul.list").append('<li data-value="'+map.orgCd+'" class="option">'+map.orgdownNm+'</li>');
						}
					});
				});
		});
		// 검색 버튼 click
		$("#btnSearch").on("click",function(){
			search(1);
		});
		search(1);
	});
	function search(pageNo){
		
		ajax("/abandonmentPublic",
			{upr_cd:$("#upr_cd").val(),org_cd:$("#org_cd").val(),upkind:$("#upkind").val(),pageNo:(pageNo||1),numOfRows:12},
			function(data){
				list = data.data;
				$("#numOfRows").html(data.numOfRows);
				$("#pageNo").html(data.pageNo);
				$("#totalCount").html(data.totalCount);
				// list 셋팅
				resetHtml("liveList",data.data);
				resetHtml("detail",data.data);
				setPaging(data.totalCount,data.numOfRows,data.pageNo);
			});
	}
</script>

	<section class="banner-area logo1 relative" id="home">	
		<div class="overlay overlay-bg"></div>
		<div class="container">
			<div class="row d-flex align-items-center justify-content-center">
				<div class="banner-content col-lg-12">
					<h1 class="text-white">
						<span>유기동물</span> 찾기				
					</h1>	
					<form id="form" class="serach-form-area" method="get">
						<input type="hidden" name="page" value="${search.page}">
						<div class="row justify-content-center form-wrap">
							<div class="col-lg-3 form-cols">
								<div class="default-select">
									<select style="display: none;" id="upr_cd" name="upr_cd">
										<option value="" selected='selected'>전체</option>
										<c:forEach var="map" items="${sido.data}" varStatus="status">
											<option value="${map.orgCd}">${map.orgdownNm}</option>
										</c:forEach>
									</select>
									<div class="nice-select" tabindex="0">
										<span class="current">시도 선택</span>
										<ul class="list">
											<li data-value="" class='option selected'>시도 선택</li>
											<c:forEach var="map" items="${sido.data}" varStatus="status">
												<li data-value="${map.orgCd}" class='option'>${map.orgdownNm}</li>
											</c:forEach>
										</ul>
									</div>
								</div>										
							</div>
							<div class="col-lg-3 form-cols">
								<div class="default-select">
									<select style="display: none;" id="org_cd" name="org_cd">
										<option value="" selected='selected'>전체</option>
									</select>
									<div class="nice-select" tabindex="0">
										<span class="current">지역 선택</span>
										<ul class="list">
											<li data-value="" class="option selected">지역 선택</li>
										</ul>
									</div>
								</div>										
							</div>
							<div class="col-lg-3 form-cols">
								<div class="default-select">
									<select style="display:none;" id="upkind" name="upkind">
										<option value="" selected='selected'>전체</option>
										<option value="417000">강아지</option>
										<option value="422400">고양이</option>
										<option value="429900">다른 동물</option>
									</select>
									<div class="nice-select" tabindex="0">
										<span class="current">전체</span>
										<ul class="list">
											<li data-value="" class='option selected'>전체</li>
											<li data-value="417000" class='option'>강아지</li>
											<li data-value="422400" class='option'>고양이</li>
											<li data-value="429900" class='option'>다른 동물</li>
										</ul>
									</div>
								</div>
							</div>
							<div class="col-lg-2 form-cols">
							    <button type="button" class="btn btn-info" id="btnSearch">
							      <span class="lnr lnr-magnifier"></span> Search
							    </button>
							</div>								
						</div>
					</form>	
				</div>											
			</div>
		</div>
	</section>

  <!-- Portfolio Section -->
  <section class="page-section portfolio section-bg" id="portfolio">
    <div class="container wow bounceInUp" data-wow-duration="1.4s">

      <!-- Portfolio Grid Items -->
      <div class="row" for="liveList">

      </div>
      <!-- /.row -->
		
			<!-- 페이징 -->
	<script type="text/html" id="paging">
		<li class="page-item" idx="#idx#">
			<a class="page-link waves-effect waves-effect">#idx#</a>
		</li>
	</script>
	<script>
		function setPaging(total,numOfRows,pageNo) {
			/*
			var total = 11604;
			var numOfRows = 12;
			var pageNo = 11;
			*/
			var pageArr = [];
			var showpage = 5;
			// 5단위로 넘기기
			// i=(Math.floor((pageNo-1)/showpage)*showpage)+1;
			// 중간에오게
			// i=pageNo-2<0?1:pageNo-2;
			$("#page").children().remove();
			var maxNo = Math.ceil(total/numOfRows);
			
			var startNo = (maxNo-pageNo<2?maxNo-4:pageNo-2);
			for (var i=startNo<1?1:startNo;i<maxNo+1;i++) {
				if (pageArr.length>4) {
					break;
				}
				pageArr.push({idx:i});
			}
			var callback = function(){
				$("li.page-item[idx='"+pageNo+"']").addClass("active");
				$("#page li.page-item").not(".active").on("click",function(){
					$("#page li.page-item").removeClass("active");
					$(this).addClass("active");
					search($(this).attr("idx"));
				});
			}
			resetHtml("paging",pageArr,callback);
		}
	</script>
	<div style="position: relative; text-align: center;width:100%;padding-top:25px;">
		<nav style="display: inline-block;">
			<ul class="pagination pg-purple fl" id="page" for="paging">
			</ul>
		</nav>
	</div>
	<!-- //페이징 -->
    </div>
  </section>

  <!-- Portfolio Modals -->

  <!-- Portfolio Modal 1 -->
  <div for="detail">

  </div>
  
  <!-- Bootstrap core JavaScript -->

  <!-- Plugin JavaScript -->
  <script src="/common3/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Contact Form JavaScript -->
  <script src="/common3/js/jqBootstrapValidation.js"></script>
  <script src="/common3/js/contact_me.js"></script>

  <!-- Custom scripts for this template -->
  <script src="/common3/js/freelancer.min.js"></script>
  