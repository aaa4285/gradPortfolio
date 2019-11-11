<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>

	<link rel="stylesheet" href="/common/test/style.css"> <!-- Resource style -->
	<script src="/common/test/modernizr.js"></script> <!-- Modernizr -->
	<style>
	.search-sec select {
		-webkit-appearance: none;
	    border: 1px solid #46156f;
	    border-radius: 7px;
	 }
	 #searchBtn{border-radius: 7px;}
	 section.search-sec .col-lg-3{
	 	    padding-right: 10px !important;
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
			            alert("2code:"+request.status+"\n"+"error:"+error);
			        }
			 
				});
			});
			search();
		});
	</script>
<a href="https://www.petfinder.com/search/pets-for-adoption/gu/piti-municipality/" class="actionCard-overlay actionCard-overlay_link" aria-label="147 more pets available on Petfinder: MEET THEM"></a>
<!-- 검색조건 -->
	<section class="search-sec" style="margin-bottom:50px;background: white;border-bottom: 1px solid #6504b5;border-top: 1px solid #6504b5;">
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
	<div class="cd-items cd-container">
		전체 결과수 : <label id="totalCount">0</label>건<br/>
		조회 건수 : <label id="numOfRows"></label><br/>
		현재 페이지 : <label id="pageNo"></label><br/>
		<a href="javascript:void(0)" id="prevBtn" class="btn btn-primary" style="float:left;">이전</a>
		<a href="javascript:void(0)" id="nextBtn" class="btn btn-primary" style="float:right;">다음</a>
	</div>
	
	<ul class="cd-items cd-container" for="liveList">
		<%for(int i=0;i<12;i++){%>
		<li class="cd-item">
			<div class="img-box w24 h24" style="background: #46156f;">
				<span class="icon icon_xxl m-icon_colorWhite" style="width: 72px;padding-left: 50px;height: 72px;">
	               <svg role="img" focusable="false" aria-hidden="true" style="fill: #fff;width: 139px;padding-top: 46px;">
	                   <use xlink:href="#icon-strokedPaw"></use>
	               </svg>
				</span>
			</div>
		</li>
		<%} %>
	</ul> <!-- cd-items -->
	<div class="cd-quick-view">
		<div class="cd-slider-wrapper" style="max-width:500px;">
			
		</div> <!-- cd-slider-wrapper -->

		<div class="cd-item-info" for="detail" style="max-width:400px;">
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
function myinfo(obj){
	var h = obj.naturalHeight;
	var w = obj.naturalWidth;
	var hl = h/w;
	var wl = w/h;
	
	if (w<500 && h<700) {
		$(obj).css("width","500px");
		$(obj).css("height","auto");
	} else {
		$(obj).css("width","auto");
		$(obj).css("height","auto");
	}
	
	$(obj).css("max-width","500px");
	$(obj).css("max-height","700px");
	
}
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
			
			var sliderFinalWidth = 500,
			maxQuickWidth = 900;
			//open the quick view panel
			$('li.cd-item .cd-trigger, li.cd-item div.img-box').on('click', function(event){
				var selectedImage = $(this).parent('.cd-item').children('div.img-box'),
					slectedImageUrl = selectedImage.attr('src');
				
				// 상세 데이터 셋팅
				$(".cd-quick-view .cd-slider-wrapper").html("");
				$(".cd-quick-view .cd-slider-wrapper").append('<img src="'+slectedImageUrl+'" class="img-box" onload="javascript:myinfo(this);"></li>');
				
				resetHtml("detail",[list[$(this).parent().attr("idx")]]);
				$('body').addClass('overlay-layer');
				
				animateQuickView(selectedImage, sliderFinalWidth, maxQuickWidth, 'open');

				updateQuickView(slectedImageUrl);
			});
		},
		error: function(request,status,error){
			$('body').removeClass('overlay-layer');
			$('html').removeClass('loader');
            alert("1code:"+request.status+"\n"+"error:"+error);
        }
 
	});
}
</script>

<script type="text/html" id="liveList">
<li class="cd-item"  idx="#_list_idx_#">
	<div src="#popfile#" class="img-box w24 h24" style="background-image: url(#popfile#);"></div>
	<!--<a href="#0" class="cd-trigger w24">상세보기</a>-->
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
<div style="display:none;">
<svg id="icon-dog" viewBox="0 0 101.8 87.7"><circle cx="21.8" cy="16.3" r="2.7"></circle><path d="M100.1 27.8C81 27.8 81 44.5 81 50v26.8c0 2.9-2.3 5.2-5.2 5.2h-.6c-2.9 0-5.2-2.3-5.2-5.2v-8.5c0-2.6-1.2-5.2-3.1-6.8-1.6-1.4-3.6-2-5.7-1.7l-18.1 2.7c-5.1.9-8.2 4.1-8.2 8.5v5.9c0 2.9-2.3 5.2-5.2 5.2h-.6c-2.9 0-5.2-2.3-5.2-5.2V35.7H25c.9 0 1.7-.7 1.7-1.7 0-.9-.7-1.7-1.7-1.7H14.1c-6.6 0-9.2-6.4-9.4-6.7-1.7-4.1-1.5-5.7-1.4-6.1.4-.3 2-1.2 7.1-2.2 1.7-.4 3-1.3 4-2.9 1.2-1.7 2.5-3.6 2.8-3.9C19.1 8.3 21 7.4 24.9 7c0 0 3.9-.3 7.6 0h.5l7.1-1.4c1.5-.3 1.7-.1 2.5.9l.1.2c2 2.5 5.7 8.1 6.9 13.3-.4.5-2.4 1.4-4.9 1-2.1-.3-5.8-1.6-7.1-7.1-.2-.9-1.1-1.4-2-1.2s-1.4 1.1-1.2 2c1.4 5.8 5.1 8.7 9 9.5v3.4c0 5.6 3.2 8.9 8.9 8.9h9.2c.9 0 1.7-.7 1.7-1.7 0-.9-.7-1.7-1.7-1.7h-9.2c-3.8 0-5.5-1.7-5.5-5.5v-3.1c.6 0 1.2-.1 1.7-.2 3.2-.7 5-2.6 4.5-4.7-1.3-5.4-5-11.4-7.7-14.8l-.1-.1C44 3.2 42.8 2 39.5 2.6L32.7 4c-4-.4-7.8 0-8 0-4.8.5-7.5 1.8-9.9 4.6-.4.5-2.4 3.3-3 4.1-.6.9-1.2 1.3-2 1.5-4.9 1-7.9 2.2-8.9 3.3-.9.9-1.7 3.2.8 9.5.1.4 3.6 8.7 12.4 8.7h6.4v41.1c0 4.7 3.8 8.5 8.5 8.5h.6c4.7 0 8.5-3.8 8.5-8.5v-5.9c0-3.7 3.4-4.9 5.4-5.2l18-2.6c1.3-.2 2.4.4 3 .9 1.2 1 1.9 2.7 1.9 4.3v8.5c0 4.7 3.8 8.5 8.5 8.5h.6c4.7 0 8.5-3.8 8.5-8.5V50c0-8.8 1.8-18.9 15.8-18.9.9 0 1.7-.7 1.7-1.7s-.4-1.6-1.4-1.6z"></path></svg>
<svg id="icon-cat" viewBox="0 0 101.8 87.7"><path d="M34.1 31.4c-.8 0-1.4-.5-1.6-1.3-.2-.9.4-1.7 1.3-1.9l10.9-2.1c.9-.2 1.7.4 1.9 1.3s-.4 1.7-1.3 1.9l-10.9 2.1h-.3zM45 39h-.3l-10.9-2.2c-.9-.2-1.4-1-1.3-1.9.2-.9 1-1.4 1.9-1.3l10.9 2.1c.9.2 1.4 1 1.3 1.9-.2.9-.8 1.4-1.6 1.4z"></path><circle cx="26.6" cy="25.8" r="2.2"></circle><path d="M87 58.2c-.8-.5-1.8-.3-2.2.5-.5.8-.3 1.8.5 2.2 3.5 2.3 5.6 6.1 5.6 10.2 0 6.7-5.5 12.2-12.2 12.2H22.9v-2.6c0-.7.6-1.3 1.3-1.3h.9c3.6-.1 4-3.2 4-4.5v-29c.6.1 1.1.1 1.6.1h.5c.9 0 1.6-.8 1.5-1.7 0-.9-.8-1.6-1.7-1.6-.4 0-9.7.3-12.8-8.2-.1-.3-.4-1.4 0-2.2.1-.3.3-.6 1.1-.9.6-.2 1.1-.9 1.1-1.5 0-.1-.1-7.7 4.8-12.3l.1-.1s2.3-2.5 6.9-4h.1s.1 0 .2-.1c0 0 .1 0 .1-.1.1 0 .1-.1.1-.1l.1-.1.1-.1.1-.1.1-.1s0-.1.1-.1c0-.1 0-.1.1-.2V11.6l-1.2-5.4c1.3.3 3 1 4.6 2.2.1.1.1.1.2.1.1.5.3.6.5.6.9.2 1.7-.3 2-1.2l.7-3c1.9 1.2 5.5 4.3 8.4 12.2v.1s.1.2.2.3l.1.1s0 .1.1.1c3.2 3.2 5 7.5 5 12 0 4.4-1.7 8.6-4.8 11.8v.1c-.4.3-.6.8-.6 1.3 0 4.9 4 8.9 8.9 8.9h.6c7.9 0 14.3 6.4 14.3 14.3v9.4c0 .9.7 1.6 1.6 1.6.9 0 1.6-.7 1.6-1.6v-9.4c0-9.7-7.9-17.6-17.6-17.6h-.6c-2.9 0-5.3-2.2-5.6-5 3.5-3.7 5.5-8.6 5.5-13.8 0-5.3-2-10.2-5.7-14-4.9-13-11.9-14.5-12.2-14.6-.8-.2-1.7.4-1.9 1.2l-.6 2.6c-3.3-1.9-6.6-2-6.8-2-.5 0-1 .2-1.3.6-.3.4-.4.9-.3 1.4l1.4 6.3c-4.2 1.7-6.4 3.9-6.8 4.3-4.9 4.5-5.7 11.1-5.9 13.6-.8.5-1.5 1.2-1.9 2.1-1 2.1-.1 4.4 0 4.6 2.1 5.7 6.6 8.4 10.6 9.6V75c0 1.3-.3 1.3-.9 1.3h-.7c-2.5 0-4.5 2-4.5 4.5V85c0 .9.7 1.6 1.6 1.6h57.3c8.5 0 15.4-6.9 15.4-15.4 0-5.3-2.6-10.1-7-13z"></path></svg>
<svg id="icon-strokedPaw" viewBox="0 0 42.26 40.83"><path d="M10.42 17.57c0-3.51-2.34-6.36-5.21-6.36S0 14.06 0 17.57s2.34 6.35 5.21 6.35 5.21-2.85 5.21-6.35zm-5.21 4.57c-1.9 0-3.44-2.05-3.44-4.58s1.54-4.58 3.44-4.58 3.42 2.06 3.42 4.59-1.52 4.57-3.42 4.57zM42.26 17.56c0-3.5-2.34-6.35-5.21-6.35s-5.21 2.85-5.21 6.36a.89.89 0 1 0 1.77 0c0-2.52 1.54-4.58 3.44-4.58s3.44 2.05 3.44 4.58c0 2.52-1.54 4.57-3.44 4.57a.89.89 0 0 0 0 1.78c2.87 0 5.21-2.85 5.21-6.36zM27.63 12.72c2.87 0 5.21-2.85 5.21-6.36S30.49 0 27.63 0s-5.21 2.85-5.21 6.36 2.32 6.36 5.21 6.36zm0-10.94c1.9 0 3.44 2.05 3.44 4.58s-1.56 4.58-3.44 4.58-3.44-2.05-3.44-4.58 1.53-4.58 3.44-4.58zM14.63 12.72c2.87 0 5.21-2.85 5.21-6.36S17.52 0 14.63 0 9.42 2.85 9.42 6.36s2.35 6.36 5.21 6.36zm0-10.94c1.9 0 3.44 2.05 3.44 4.58s-1.53 4.58-3.44 4.58-3.44-2.05-3.44-4.58 1.56-4.58 3.44-4.58zM33.63 28.65l-5.5-9.63c-1.82-3.17-4.31-4.92-7-4.92s-5.18 1.75-7 4.92l-5.5 9.62a11.12 11.12 0 0 0-.9 2 7.54 7.54 0 0 0-.5 2.69.61.61 0 0 0 0 .08 7.5 7.5 0 0 0 7.1 7.41h.3a7.35 7.35 0 0 0 2.91-.59c.66-.26 1.76-.76 2.9-1.3l.41.17a18.59 18.59 0 0 0 7.07 1.71 7.51 7.51 0 0 0 7.14-7.39 9 9 0 0 0-.49-2.72 11.18 11.18 0 0 0-.94-2.05zm-5.72 10.39a15.1 15.1 0 0 1-5.28-1.14l.34-.17 1-.46a.86.86 0 0 0 .18-.14l1-.51.94-.48a.89.89 0 0 0-.8-1.59l-1 .48c-1.55.79-4.14 2.12-5.23 2.57l-.1.07c-.83.39-1.6.73-2.08.92a5.2 5.2 0 0 1-2.4.45h-.09a5.72 5.72 0 0 1-5.42-5.62.35.35 0 0 0 0-.07 5.82 5.82 0 0 1 .4-2.09 9.27 9.27 0 0 1 .77-1.7l5.49-9.65c1.49-2.6 3.43-4 5.47-4s4 1.43 5.47 4l5.53 9.63a9.47 9.47 0 0 1 .77 1.7 7.21 7.21 0 0 1 .42 2.18 5.71 5.71 0 0 1-5.38 5.62z"></path></svg>
</div>