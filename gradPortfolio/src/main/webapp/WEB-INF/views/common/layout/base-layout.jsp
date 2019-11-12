<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>Static Top Navbar Example for Bootstrap</title>
	<!-- Bootstrap core CSS -->
	<link href="/common/css/bootstrap.css" rel="stylesheet">
	
	<!-- Custom styles for this template -->
	<link href="/common/css/index.css" rel="stylesheet">
	
	<script src="/common/test/jquery-2.1.1.js"></script>
	<script src="/common/js/bootstrap.min.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="/common/js/common_utils.js"></script>	<script>
  		$(document).ready(function(){
  			// 스크롤 메뉴 fixed 이벤트
  			$(window).scroll(function() {
  				var nav = $("body > nav.navbar.navbar-expand-lg");
  				if(!nav || !nav.offset()){return;}
  			  if (!$("body").hasClass("fixed") && $(document).scrollTop() >= nav.offset().top) {
  			    nav.addClass('fixed-top');
  				nav.removeClass('static-top');
  				$("body").addClass('fixed');
  			  } else if ($("body").hasClass("fixed") && $(document).scrollTop()<=$("body > div.title").height()) {
  			    nav.removeClass('fixed-top');
  				nav.addClass('static-top');
  				$("body").removeClass('fixed');
  			  }
  			});
  			
  			// 메뉴 click 이벤트
  			$("#navbar li").click(function(){
  				var url = $(this).attr("url");
  				location.href = url;
  			});
  			
  		});
  	</script>
<title>Insert title here</title>
<style>
.body{
background: #efeef1;
padding-bottom: 40px;
}
.body > .container{
background: #fff;
}
</style>
</head>
<body>
	<tiles:insertAttribute name="header"/>
	<div class="body">
	<tiles:insertAttribute name="body"/>
	</div>
	<tiles:insertAttribute name="footer"/>
</body>
</html>