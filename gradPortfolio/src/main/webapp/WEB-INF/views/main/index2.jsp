<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	$(document).ready(function(){
		// 검색 버튼 click
		$("#searchBtn").on("click",function(){
			$.ajax({
				type:"POST",
				url:"/abandonmentPublic",
				contentType:"application/json;charset=UTF-8",
				data:JSON.stringify({upr_cd:$("#upr_cd").val(),org_cd:$("#org_cd").val(),careRegNo:$("careRegNo").val()}),
				success : function(data){
					alert(JSON.stringify(data));
					console.log(data);
					resetHtml("searchList",data.data);
				},
				error: function(request,status,error){
		            alert("code:"+request.status+"\n"+"error:"+error);
		        }
		 
			});
			
		});
		// 시도 change - 시군구 조회
		$("#upr_cd").on("change", function(){
			// 시군구,보호소 초기화
			$("#org_cd option[value!='']").remove();
			$("#careRegNo option[value!='']").remove();
			
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
			// 보호소 초기화
			$("#careRegNo option[value!='']").remove();
			
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
		});
	});
</script>
<!-- 타이틀? -->
<div class="container">
	<div class="row pt-1 pb-1">
		<div class="col-lg-12">
			<h4 class="text-center">Carousel with Three input search</h4>
		</div>
	</div>
</div>

<!-- 검색조건 -->
<section class="search-sec">
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
						
							<select class="form-control search-slt" id="careRegNo" name="careRegNo">
								<option value="">전체</option>
							</select>
							<!-- <input type="text" class="form-control search-slt" placeholder="보호소명"> -->
						</div>
						<div class="col-lg-3 col-md-3 col-sm-12 p-0">
							<button type="button" class="btn btn-danger wrn-btn"
								id="searchBtn">Search</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</section>

<!-- Page Content -->
<div class="container">

	<!-- Page Features -->
	<div class="row text-center" for="searchList">
		
		<div class="col-lg-3 col-md-6 mb-4">
			<div class="card h-100">
				<img class="card-img-top" src="http://placehold.it/500x325" alt="">
				<div class="card-body">
					<h4 class="card-title">Card title</h4>
					<p class="card-text">Lorem ipsum dolor sit amet, consectetur
						adipisicing elit. Sapiente esse necessitatibus neque.</p>
				</div>
				<div class="card-footer">
					<a href="javascript:void(0)" class="btn btn-primary">Find Out
						More!</a>
				</div>
			</div>
		</div>

		<div class="col-lg-3 col-md-6 mb-4">
			<div class="card h-100">
				<img class="card-img-top" src="http://placehold.it/500x325" alt="">
				<div class="card-body">
					<h4 class="card-title">Card title</h4>
					<p class="card-text">Lorem ipsum dolor sit amet, consectetur
						adipisicing elit. Explicabo magni sapiente, tempore debitis beatae
						culpa natus architecto.</p>
				</div>
				<div class="card-footer">
					<a href="javascript:void(0)" class="btn btn-primary">Find Out
						More!</a>
				</div>
			</div>
		</div>

		<div class="col-lg-3 col-md-6 mb-4">
			<div class="card h-100">
				<img class="card-img-top" src="http://placehold.it/500x325" alt="">
				<div class="card-body">
					<h4 class="card-title">Card title</h4>
					<p class="card-text">Lorem ipsum dolor sit amet, consectetur
						adipisicing elit. Sapiente esse necessitatibus neque.</p>
				</div>
				<div class="card-footer">
					<a href="javascript:void(0)" class="btn btn-primary">Find Out
						More!</a>
				</div>
			</div>
		</div>

		<div class="col-lg-3 col-md-6 mb-4">
			<div class="card h-100">
				<img class="card-img-top" src="http://placehold.it/500x325" alt="">
				<div class="card-body">
					<h4 class="card-title">Card title</h4>
					<p class="card-text">Lorem ipsum dolor sit amet, consectetur
						adipisicing elit. Explicabo magni sapiente, tempore debitis beatae
						culpa natus architecto.</p>
				</div>
				<div class="card-footer">
					<a href="javascript:void(0)" class="btn btn-primary">Find Out
						More!</a>
				</div>
			</div>
		</div>
		
		<div class="col-lg-3 col-md-6 mb-4">
			<div class="card h-100">
				<img class="card-img-top" src="http://placehold.it/500x325" alt="">
				<div class="card-body">
					<h4 class="card-title">Card title</h4>
					<p class="card-text">Lorem ipsum dolor sit amet, consectetur
						adipisicing elit. Explicabo magni sapiente, tempore debitis beatae
						culpa natus architecto.</p>
				</div>
				<div class="card-footer">
					<a href="javascript:void(0)" class="btn btn-primary">Find Out
						More!</a>
				</div>
			</div>
		</div>
		
	</div>
	<!-- /.row -->

</div>
<!-- /.container -->

<script type="text/html" id="searchList">
	<div class="row-col-4">
		<div class="img-box w24 h24" style="background-image: url(#popfile#)">
		</div>
		<h2>#kindCd#</h2>
		<p>#happenPlace#</p>
		<p>
			<a class="btn btn-default" href="javascript:void(0)" role="button">상세보기&raquo;</a>
		</p>
	</div>
</script>