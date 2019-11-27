<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<header id="header">
	
		<div id="topbar">
			<div class="container">
				<div class="social-links">
					<c:choose>
						<c:when test="${not empty sessionScope.userSession}">
							${sessionScope.userSession.displayName}님 환영합니다. <a href="javascript:void(0);" onclick="location.href='/logout'" class="logout"><i class="fa fa-sign-out"></i>로그아웃</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:void(0);" onclick="location.href='/login'" class="login"><i class="fa fa-sign-in"></i>로그인</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		
		<div class="container">

			<div class="logo float-left">
				<!-- Uncomment below if you prefer to use an image logo -->
				<h1 class="text-light"><a href="/" class="scrollto"><span>Find Pet</span></a></h1>
			</div>

			<nav class="main-nav float-right d-none d-lg-block">
				<ul>
					<c:forEach var="menu" items="${sessionVO.menuList}" varStatus="status">
						<li class="${sessionVO.menuIdx  eq menu.idx?'active':''}"><a href='javascript:void(0)' onclick="goPage('${menu.url}')">${menu.title}</a></li>
					</c:forEach>
				</ul>
			</nav><!-- .main-nav -->
			
		</div>
		<div id="mobile-nav-login" style="display:none;">
			<c:choose>
				<c:when test="${not empty sessionScope.userSession}">
					<li>
						<label style="color:white;padding:0 20px;">${sessionScope.userSession.displayName}님 환영합니다.</label>
						<a href="javascript:void(0);" onclick="location.href='/logout'" class="logout"><i class="fa fa-sign-out"></i>로그아웃</a>
					</li>
				</c:when>
				<c:otherwise>
					<li>
					<a href="javascript:void(0);" onclick="location.href='/login'" class="login"><i class="fa fa-sign-in"></i>로그인</a>
					</li>
				</c:otherwise>
			</c:choose>
		</div>
		<script type="text/javascript">
			function goPage(url) {
				loder_show();
				location.href=url;
			}
		
		</script>
	</header><!-- #header -->