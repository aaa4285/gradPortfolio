<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>

	<link rel="stylesheet" href="/common/test/reset.css"> <!-- CSS reset -->
	<link rel="stylesheet" href="/common/test/style.css"> <!-- Resource style -->
	<script src="/common/test/modernizr.js"></script> <!-- Modernizr -->
	<style>
		table.col_2 th{width:128px;}
		table.col_2 td{width:calc(100% - 128px);}
		table.col_4 th{width:60x;}
		table.col_4 td{width:calc(50% - 60px);}
	    html.loader::after {
	    	position:absolute;
	    	left: calc(50% + 40px);
	    	top: calc(50% + 40px);
	    	z-index: 9999;
	    	margin: -75px 0 0 -75px;
	    	border: 10px solid #f3f3f3;
	    	border-radius: 50%;
	    	border-top: 10px solid #3498db;
	    	width:80px;
	    	height: 80px;
	    	-webkit-animation: spin 2s linear infinite;
	    	animation: spin 2s linear infinite;
	    }
	    @-webkitkeyframes spin{
	    	0% {-webkit-transform: rotate(0deg);}
	    	100% {-webkit-transform: rotate(360deg);}
	    }
	    @keyframes spin{
	    	0% {-webkit-transform: rotate(0deg);}
	    	100% {-webkit-transform: rotate(360deg);}
	    }
	    .bg {
	    	display:none;
		    background: black;
		    width: 100%;
		    height: 100%;
		    top: 0;
		    position: absolute;
		    z-index: 1003;
		    opacity: 0.5;
    	}
    	.bg.show{
    		display:block;
    	}
    	li.cd-item div.img-box:hover{
    		cursor: pointer;
    		opacity: 0.8;
    	}
	</style>
	<script>
		var list = [];
		$(document).ready(function(){
			// 이전 버튼
			$("#prevBtn").on("click",function(){
				var pageNo = $("#pageNo").html()*1;
				if (pageNo==1) {
					alert("첫페이지입니다.");
					return;
				}
				search($("#pageNo").html()*1-1);
			});
			// 이후 버튼
			$("#nextBtn").on("click",function(){
				var pageNo = $("#pageNo").html()*1;
				var totalCount = $("#totalCount").html()*1;
				var numOfRows = $("#numOfRows").html()*1;
				if (Math.ceil(totalCount/numOfRows)<=pageNo) {
					alert("마지막페이지입니다.");
					return;
				}
				search(pageNo+1);
			});
			// 검색 버튼 click
			$("#searchBtn").on("click",function(){
				search();
			});
			// 시도 change - 시군구 조회
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
			            alert("code:"+request.status+"\n"+"error:"+error);
			        }
			 
				});
			});
			// 시군구 change - 보호소 조회
			$("#org_cd").on("change", function(){
				/*
				// 공백체크
				if ($("#org_cd").val()=="") {
					return;
				}
				
				$.ajax({
					type:"POST",
					url:"/shelter",
					contentType:"application/json;charset=UTF-8",
					data:JSON.stringify({upr_cd:$("#upr_cd").val(),org_cd:$("#org_cd").val()}),
					success : function(data){
						data.data.forEach(function(map){
							$("#careRegNo").append('<option value="'+map.careRegNo+'">'+map.careNm+'</option>');
						});
					},
					error: function(request,status,error){
			            alert("code:"+request.status+"\n"+"error:"+error);
			        }
			 
				});
				*/
			});
			search();
		});
	</script>
	<!-- 검색조건 -->
	<section class="search-sec" style="margin-bottom:50px;">
		<div class="container">
			<form id="searchForm" name="searchForm" action="#" method="post" novalidate="novalidate">
				<div class="row">
					<div class="col-lg-12">
						<div class="row">
							<div class="col-lg-3 col-md-3 col-sm-12 p-0">
								<select class="form-control search-slt" id="upr_cd" name="upr_cd">
									<option value="">전체</option>
									<c:forEach var="map" items="${sido.data}" varStatus="status">
										<option value="${map.orgCd}">${map.orgdownNm}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-lg-3 col-md-3 col-sm-12 p-0">
								<select class="form-control search-slt" id="org_cd" name="org_cd">
									<option value="">전체</option>
								</select>
							</div>
							<div class="col-lg-3 col-md-3 col-sm-12 p-0">
								<!-- 축종코드 -->
								<select class="form-control search-slt" id="upkind" name="upkind">
									<option value="">전체</option>
									<option value="417000">강아지</option>
									<option value="422400">고양이</option>
									<option value="429900">기타</option>
								</select>
								<!-- <input type="text" class="form-control search-slt" placeholder="보호소명"> -->
							</div>
							<div class="col-lg-3 col-md-3 col-sm-12 p-0">
								<button type="button" class="btn btn-primary wrn-btn"
									id="searchBtn">검색</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</section>
	<div id="viewLoading"></div>
	<div class="cd-items cd-container">
		전체 결과수 : <label id="totalCount">0</label>건<br/>
		조회 건수 : <label id="numOfRows"></label><br/>
		현재 페이지 : <label id="pageNo"></label><br/>
		<a href="javascript:void(0)" id="prevBtn" class="btn btn-primary" style="float:left;">이전</a>
		<a href="javascript:void(0)" id="nextBtn" class="btn btn-primary" style="float:right;">다음</a>
	</div>
	
	<ul class="cd-items cd-container" for="liveList">
	</ul> <!-- cd-items -->

	<div class="cd-quick-view" style="">
		<div class="cd-slider-wrapper">
			<ul class="cd-slider">
				<li class="selected">
					<!-- <img src="" alt="Product 1">  -->
					<div src="#popfile#" class="img-box w24 h24" style="background-image: url(#popfile#);"></div>
				</li>
			</ul> <!-- cd-slider -->
		</div> <!-- cd-slider-wrapper -->

		<div class="cd-item-info" for="detail">
			<h2>Produt Title</h2>
			<p>sdds</p>
			<ul class="cd-item-action">
				<li><button class="add-to-cart">Add to cart</button></li>					
				<li><a href="#0">Learn more</a></li>	
			</ul> <!-- cd-item-action -->
		</div> <!-- cd-item-info -->
		<a href="#0" class="cd-close">Close</a>
	</div> <!-- cd-quick-view -->
<script src="/common/test/velocity.min.js"></script>
<script src="/common/test/main.js"></script> <!-- Resource jQuery -->
<script src="/common/js/common_utils.js"></script>
<script>
function search(pageNo){
	$('body').addClass('overlay-layer');
	$('html').addClass('loader');
	
	$.ajax({
		type:"POST",
		url:"/abandonmentPublic",
		contentType:"application/json;charset=UTF-8",
		data:JSON.stringify({upr_cd:$("#upr_cd").val(),org_cd:$("#org_cd").val(),upkind:$("#upkind").val(),pageNo:(pageNo||1),numOfRows:12}),
		success : function(data){
			$('body').removeClass('overlay-layer');
			$('html').removeClass('loader');
			
			list = data.data;
			$("#numOfRows").html(data.numOfRows);
			$("#pageNo").html(data.pageNo);
			$("#totalCount").html(data.totalCount);
			console.log(data);
			
			// list 셋팅
			resetHtml("liveList",data.data);
			
			var sliderFinalWidth = 400,
			maxQuickWidth = 900;
			//open the quick view panel
			$('li.cd-item .cd-trigger, li.cd-item div.img-box').on('click', function(event){
				var selectedImage = $(this).parent('.cd-item').children('div.img-box'),
					slectedImageUrl = selectedImage.attr('src');
				
				// 상세 데이터 셋팅
				$(".cd-quick-view ul.cd-slider li").remove();
				$(".cd-quick-view ul.cd-slider").append('<li class="selected"><div src="'+selectedImage.attr("src")+'" class="img-box" style="width:450px;height:600px;background-image: url('+selectedImage.attr("src")+');"></div></li>');
				resetHtml("detail",[list[$(this).parent().attr("idx")]]);
				
				$('body').addClass('overlay-layer');
				animateQuickView(selectedImage, sliderFinalWidth, maxQuickWidth, 'open');

				updateQuickView(slectedImageUrl);
			});
		},
		error: function(request,status,error){
			$('body').removeClass('overlay-layer');
			$('html').removeClass('loader');
            alert("code:"+request.status+"\n"+"error:"+error);
        }
 
	});
}
</script>

<script type="text/html" id="liveList">
<li class="cd-item"  idx="#_list_idx_#">
	<div src="#popfile#" class="img-box w24 h24" style="background-image: url(#popfile#);"></div>
	<a href="#0" class="cd-trigger w24">상세보기</a>
</li> <!-- cd-item -->
</script>
<script type="text/html" id="detail">
	<h2>#kindCd#</h2>
	<p>#processState#</p>
<table class="table col_2" style="max-width:413px !important;">
	<tr>
		<th>공고일</th>
		<td>#fn{yyyyMMddFormat:noticeSdt}# ~ #fn{yyyyMMddFormat:noticeEdt}#</td>
	</tr>
	<tr>
		<th>공고번호</th>
		<td>#noticeNo#</td>
	</tr>
	<tr>
		<th>발견장소</th>
		<td>#happenPlace#</td>
	</tr>
	<tr>
		<th>유기번호</th>
		<td>#desertionNo#</td>
	</tr>
	<tr>
		<th>보호장소</th>
		<td>#careAddr#</td>
	</tr>
	<tr>
		<th>보호소이름</th>
		<td>#careNm#</td>
	</tr>
	<tr>
		<th>보호소전화번호</th>
		<td>#careTel#</td>
	</tr>
	<tr>
		<th>담당자</th>
		<td>#chargeNm#</td>
	</tr>
	<tr>
		<th>담당자 연락처</th>
		<td>#officetel#</td>
	</tr>
</table>
<table class="table col_4" style="max-width:413px !important;">
	<tr>
		<th>나이</th>
		<td>#age#</td>
		<th>몸무게</th>
		<td>#weight#</td>
	</tr>
	<tr>
		<th>성별</th>
		<td>#sexCdNm#</td>
		<th>중성화여부</th>
		<td>#neuterYnNm#</td>
	</tr>
	<tr>
		<th>특징</th>
		<td colspan="3">#specialMark#</td>
	</tr>
</table>
<!-- 
	<ul class="cd-item-action">
		<li><button class="add-to-cart">Add to cart</button></li>					
		<li><a href="#0">Learn more</a></li>	
	</ul>-->
</script>