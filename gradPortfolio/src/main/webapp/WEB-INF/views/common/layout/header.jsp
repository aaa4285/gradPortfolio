<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- title -->
<div class="title">
	<div class="fr">
		
	</div>
	<H1 class="tc">나를 찾아줘</H1>
</div>
<%-- <!-- menu -->
<nav class="navbar navbar-default navbar-static-top">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<c:forEach var="menu" items="${sessionVO.menuList}" varStatus="status">
					<li <c:if test="${sessionVO.menuIdx == menu.idx}">class="active"</c:if> idx="${menu.idx}" url="${menu.url}"><a href="javascript:void(0)">${menu.title}</a></li>
				</c:forEach>
			</ul>
		</div>
		<!--/.nav-collapse -->
	</div> --%>
	
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#"></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div id="navbar" class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
		<c:forEach var="menu" items="${sessionVO.menuList}" varStatus="status">
			<li <c:if test="${sessionVO.menuIdx == menu.idx}"> </c:if> class="nav-item" idx="${menu.idx}" url="${menu.url}"><a class="nav-link" href="javascript:void(0)">${menu.title}</a></li>
		</c:forEach>
	</ul>
  </div>
</nav>


