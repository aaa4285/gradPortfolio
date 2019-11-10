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
<title>I LOVE PUPPY</title>
	<!-- Bootstrap core CSS -->
	<link href="/common/css/bootstrap.css" rel="stylesheet">
	
	<!-- Custom styles for this template -->
	<link href="/common/css/index.css" rel="stylesheet">
	
	<script src="/common/test/jquery-2.1.1.js"></script>
	<script src="/common/js/bootstrap.min.js"></script>
	<style>
		.login.container {background-size: cover;
		background-attachment: fixed;
    	background-image: url(https://demo.w3layouts.com/demos_new/template_demo/28-07-2017/pet_adoption_form-demo_Free/351104541/web/images/3.jpg);
		}
		.login.container {
			width:100%;
			height: 100%;
			padding:0;
			margin:0;
		}
		@media (min-width: 992px)
		.login.container > div {
		    max-width: 960px;
		}
		@media (min-width: 768px)
		.login.container {
		    max-width: 720px;
		}
		@media (min-width: 576px)
		.login.container {
		    max-width: 540px;
		}
	</style>
</head>
<body>
	<div class="login container">
	
	</div>

	<tiles:insertAttribute name="body"/>
</body>
</html>