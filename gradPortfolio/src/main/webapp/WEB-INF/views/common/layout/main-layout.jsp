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
	<script src="/common/js/Popper.js"></script>
	<script src="/common/js/Tooltip.js"></script>
	<script src="/common/js/bootstrap.min.js"></script>
	<script src="/common/js/jquery.validate.js"></script>
	<script src="/common/js/jquery-validate.bootstrap-tooltip.min.js"></script>
	<script src="/common/js/common_utils.js"></script>
	<script src="/common/js/bPopup.js"></script>
	
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
		<style type="text/css">
		* {
			margin: 0;
			padding: 0;
		}
		.pop-layer .pop-container {
			padding: 20px 25px;
		}
		
		.pop-layer p.ctxt {
			color: #666;
			line-height: 25px;
		}
		
		.pop-layer .btn-r {
			width: 100%;
			margin: 10px 0 20px;
			padding-top: 10px;
			border-top: 1px solid #DDD;
			text-align: right;
		}
		
		.pop-layer {
			display: none;
			position: absolute;
			top: 50%;
			left: 50%;
			width: 410px;
			height: auto;
			background-color: #fff;
			border: 5px solid #3571B5;
			z-index: 10;
		}
		
		.dim-layer {
			display: none;
			position: fixed;
			_position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			z-index: 100;
		}
		
		.dim-layer .dimBg {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			background: #000;
			opacity: .5;
			filter: alpha(opacity = 50);
		}
		
		.dim-layer .pop-layer {
			display: block;
		}
		
		a.btn-layerClose {
			display: inline-block;
			height: 25px;
			padding: 0 14px 0;
			border: 1px solid #304a8a;
			background-color: #3f5a9d;
			font-size: 13px;
			color: #fff;
			line-height: 25px;
		}
		
		a.btn-layerClose:hover {
			border: 1px solid #091940;
			background-color: #1f326a;
			color: #fff;
		}
	</style>
</head>
<body>
	<div class="login" style="padding-top: 100px">
		<tiles:insertAttribute name="body"/>	
	</div>
	
</body>

<script type="text/javascript">
	
</script>
</html>