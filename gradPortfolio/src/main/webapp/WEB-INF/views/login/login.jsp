<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<style>
:root {
	-input-padding-x: 1.5rem;
	-input-padding-y: .75rem;
}

body {
	/* background: #007bff;
	background: linear-gradient(to right, #0062E6, #33AEFF); */
	
}

.card-signin {
	border: 0;
	border-radius: 1rem;
	box-shadow: 0 0.5rem 1rem 0 rgba(0, 0, 0, 0.1);
}

.card-signin .card-title {
	margin-bottom: 2rem;
	font-weight: 300;
	font-size: 1.5rem;
}

.card-signin .card-body {
	padding: 2rem;
}

.form-signin {
	width: 100%;
}

.form-signin .btn {
	font-size: 80%;
	border-radius: 5rem;
	letter-spacing: .1rem;
	font-weight: bold;
	transition: all 0.2s;
}

.form-label-group {
	position: relative;
	margin-bottom: 1rem;
}

.form-label-group input {
	height: auto;
	border-radius: 2rem;
}

.form-label-group>input, .form-label-group>label {
	padding: var(- -input-padding-y) var(- -input-padding-x);
}

.form-label-group>label {
	position: absolute;
	top: 0;
	left: 0;
	display: block;
	width: 100%;
	margin-bottom: 0;
	/* Override default `<label>` margin */
	line-height: 1.5;
	color: #495057;
	border: 1px solid transparent;
	border-radius: .25rem;
	transition: all .1s ease-in-out;
	margin-left: 10px;
	margin-top: 5px;
}

.form-label-group input:not (:placeholder-shown )~label {
	padding-top: calc(var(- -input-padding-y)/3);
	padding-bottom: calc(var(- -input-padding-y)/3);
	font-size: 12px;
	color: #777;
}

.btn-google {
	color: white;
	background-color: #ea4335;
}

.btn-facebook {
	color: white;
	background-color: #3b5998;
}

.btn-kakao {
	color: #543939;
	background-color: #fbd61e;
}

.btn-kakao:hover {
	color: white !important;
}

.logo-google {
	background: url('img/logo.png') -303px -657px;
	width: 37px;
	height: 37px;
	border-style: none;
	float: left;
}

.btn-google div+div {
	margin-top: 8px;
}

.logo-facebook {
	background: url('img/logo.png') -386px -574px;
	width: 37px;
	height: 37px;
	border-style: none;
	float: left;
}

.btn-facebook div+div {
	margin-top: 8px;
}

.logo-kakao {
	background: url('img/logo.png') -303px -616px;
	width: 37px;
	height: 37px;
	border-style: none;
	float: left;
}

.btn-kakao div+div {
	margin-top: 8px;
}

/* Fallback for Edge
-------------------------------------------------- */
@
supports (-ms-ime-align: auto ) { .form-label-group>label {
	display: none;
}

.form-label-group input::-ms-input-placeholder {
	color: #777;
}

}

/* Fallback for IE
-------------------------------------------------- */
@media all and (-ms-high-contrast: none) , ( -ms-high-contrast : active)
	{
	.form-label-group>label {
		display: none;
	}
	.form-label-group input:-ms-input-placeholder {
		color: #777;
	}
}
.signUp{
position:absolute;
right:0;
}
</style>
<section class="blog-posts-area section-login-gap">
	<div class="container">
		<div class="row">
			<div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
				<div class="card card-signin my-5">
					<div class="card-body">
						<h5 class="card-title text-center">Sign In</h5>
						<form class="form-signin" method="POST">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
							<div class="form-label-group">
								<input type="email" id="email" name="username"
									class="form-control" placeholder="Email address" required
									autofocus> <label for="inputEmail"></label>
							</div>

							<div class="form-label-group">
								<input type="password" id="password" name="password"
									class="form-control" placeholder="Password" required> <label
									for="inputPassword"></label>
								<c:if test="${not empty ERRORMSG}">
									<font style="float: left;" color="red"> ${ERRORMSG } </font>
								</c:if>
							</div>
							<button class="btn btn-lg btn-primary btn-block text-uppercase"
								type="submit">로그인</button>
							<div class="custom-control mb-3">
								<div class="d-flex justify-content-center links">
									<a href="#" onclick="sign()" class="signUp">회원가입</a>
								</div>
							</div>
							<hr class="my-4">
							<button class="btn btn-lg btn-google btn-block text-uppercase"
								type="button" onclick="login('/login/google')">
								<div class="logo-google"></div>
								<div>
									<span>구글 계정으로 로그인</span>
								</div>
							</button>
							<button class="btn btn-lg btn-facebook btn-block text-uppercase"
								type="button" onclick="login('/login/facebook')">
								<div class="logo-facebook"></div>
								<div>
									<span>페이스북 계정으로 로그인</span>
								</div>
							</button>
							<button class="btn btn-lg btn-kakao btn-block text-uppercase"
								type="button" onclick="login('/login/kakao')">
								<div class="logo-kakao"></div>
								<div>
									<span>카카오 계정으로 로그인</span>
								</div>
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
	
<script type="text/javascript">

	// 로그인
	function login(url) {
		loder_show();
		location.href = url;
	}

	// 회원가입
	function sign() {
		loder_show();
		location.href = "/sign";
	}
	
	function loginFocus() {
		$('#layer2').bPopup().close()
		$("#email").focus();
	}
	
</script>
