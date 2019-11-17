<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.root {
width:100%;
background: red;
}
.navbar-nav, .nav-link2{
	font-weight: bold;
    font-size: 16px;
    color: #ecd7fd;
    text-align: center;
}
.nav-link2:hover{
    color: #ffffff !important;
    text-decoration: none;
}
.navbar {height: 55px;}
.ft-theme{
color: #6504b5 !important;
font-family: Nexa Heavy,arial,helvetica,sans-serif;
}
.bg-theme{
background: #6504b5 !important;
color: #ecd7fd !important;
}
ul.navbar-nav{width: 100%;}
ul.navbar-nav li.nav-item{width:25%;}
.navbar-expand-lg2 .navbar-collapse {
    display: -ms-flexbox !important;
    display: flex !important;
    -ms-flex-preferred-size: auto;
    flex-basis: auto;
}
.navbar-expand-lg2 .navbar-nav {
    -ms-flex-direction: row;
    flex-direction: row;
}
.navbar-expand-lg2 {
    -ms-flex-flow: row nowrap;
    flex-flow: row nowrap;
    -ms-flex-pack: start;
    justify-content: flex-start;
}
</style>
<!-- title -->
<div style="position:absolute;top:0;right:0;padding:2px 5px;">

<script>
console.log('${sessionScope.userSession}');
</script>
${sessionScope.userSession.displayName}님 환영합니다. <button type="button" onclick="location.href='/logout'" class="btn btn-secondary btn-rounded waves-effect waves-light" style="font-size: 11px;padding: 1px 5px;">로그아웃</button>
</div>
<div class="container title ft-theme" onclick="location.href='/';" style="cursor:pointer;">
	<svg id="Capa_1" viewBox="0 0 512 512" style="float: left;width: 50px;fill: #6504b5;"><path d="m60 468.027v28.973c0 8.284 6.716 15 15 15h100c8.284 0 15-6.716 15-15v-28.974h-130z"></path><path d="m178.245 345.155-40.374-57.66c-10.511-15.013-30.933-19.776-46.494-10.844-4.68 2.687-8.631 6.426-11.592 10.896-.01-.018-.02-.036-.03-.053-7.812 11.66-8.144 27.415.377 39.584l17.225 24.599c4.752 6.786 3.103 16.139-3.683 20.891-6.786 4.752-16.139 3.103-20.891-3.684l-17.224-24.599c-9.95-14.211-13.769-31.459-10.751-48.567 2.914-16.525 11.878-30.977 25.29-40.911-.058-1.172-.098-2.345-.098-3.52v-93.629c0-19.112-15.049-35.195-34.156-35.647-19.683-.466-35.844 15.41-35.844 34.989v137.907c0 2.031.412 4.041 1.212 5.907l58.788 137.213h130v-55.59c0-13.408-4.064-26.3-11.755-37.282z"></path><path d="m452 468.027v28.973c0 8.284-6.716 15-15 15h-100c-8.284 0-15-6.716-15-15v-28.974h130z"></path><path d="m333.755 345.155 40.374-57.66c10.511-15.013 30.933-19.776 46.494-10.844 4.68 2.687 8.631 6.426 11.592 10.896.01-.018.02-.036.03-.053 7.812 11.66 8.144 27.415-.377 39.584l-17.225 24.599c-4.752 6.786-3.103 16.139 3.683 20.891 6.786 4.752 16.139 3.103 20.891-3.684l17.224-24.599c9.95-14.211 13.769-31.459 10.751-48.567-2.914-16.525-11.878-30.977-25.29-40.911.058-1.172.098-2.346.098-3.521v-93.629c0-19.112 15.049-35.195 34.156-35.647 19.683-.465 35.844 15.411 35.844 34.99v137.907c0 2.031-.412 4.041-1.212 5.907l-58.788 137.213h-130v-55.59c0-13.408 4.065-26.3 11.755-37.282z"></path><path d="m241 170h30v80h-30z"></path><path d="m395.966 119.345-130-115.556c-5.684-5.053-14.248-5.053-19.932 0l-130 115.556c-6.191 5.503-6.749 14.985-1.245 21.176 5.503 6.191 14.984 6.75 21.177 1.246l15.034-13.364v106.597c0 8.284 6.716 15 15 15h45v-95c0-8.284 6.716-15 15-15h60c8.284 0 15 6.716 15 15v95h45c8.284 0 15-6.716 15-15v-106.597l15.034 13.364c2.858 2.541 6.416 3.789 9.96 3.789 4.136 0 8.254-1.701 11.217-5.035 5.504-6.191 4.946-15.672-1.245-21.176z"></path></svg>
	<H1 class="tl">find me</H1>
</div>
<div class="root bg-theme">
	<nav class="container navbar navbar-expand-lg2 bg-theme">
	  <a class="navbar-brand" href="javascript:void(0);"></a>
	
	  <div id="navbar" class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
			<c:forEach var="menu" items="${sessionVO.menuList}" varStatus="status">
				<li <c:if test="${sessionVO.menuIdx == menu.idx}"> </c:if> class="nav-item" idx="${menu.idx}" url="${menu.url}"><a class="nav-link nav-link2" href="javascript:void(0)">${menu.title}</a></li>
			</c:forEach>
		</ul>
	  </div>
	</nav>
</div>


