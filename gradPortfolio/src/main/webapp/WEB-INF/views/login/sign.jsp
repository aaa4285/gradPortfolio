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
</style>
<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
				<div class="card card-signin my-5">
					<div class="card-body">
						<h5 class="card-title text-center">회원가입</h5>
						<form class="form-signin" id="signForm" method="POST" action="/login/signUp">
							<div class="form-label-group">
								<input type="email" id="email" name="email" class="form-control"
									placeholder="Email address" required autofocus> <label
									for="name"></label>
							</div>
							<div class="form-label-group">
								<input type="text" id="nickname" name="nickname"
									class="form-control" placeholder="Full name" required autofocus>
								<label for="password"></label>
							</div>
							<div class="form-label-group">
								<input type="password" id="password" name="password"
									class="form-control" placeholder="Password" required> <label
									for="repatPassword"></label>
							</div>
							<div class="form-label-group">
								<input type="password" id="repatPassword" name="repatPassword"
									class="form-control" placeholder="Repeat Password" required>
								<label for=""></label>
							</div>
							<button class="btn btn-lg btn-primary btn-block text-uppercase"
								type="submit" name="signBtn" id="signBtn">회원가입</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#signForm").validate({
			//validation이 끝난 이후의 submit 직전 추가 작업할 부분
			submitHandler : function(frm) {
				var f = confirm("회원가입을하시겠습니까?");
				if (f) {
					console.log(frm);	
					duplicateCheck(frm);
				} else {
					return false;
				}
			},
			//규칙
			rules : {
				password : {
					required : true,
					minlength : 3
				},
				repatPassword : {
					required : true,
					minlength : 3,
					equalTo : password
				},
				nickname : {
					required : true,
					minlength : 2
				},
				email : {
					required : true,
					minlength : 2,
					email : true
				}
			},
			//규칙체크 실패시 출력될 메시지
			messages : {
				password : {
					required : "필수로입력하세요",
					minlength : "최소 {0}글자이상이어야 합니다"
				},
				repatPassword : {
					required : "필수로입력하세요",
					minlength : "최소 {0}글자이상이어야 합니다",
					equalTo : "비밀번호가 일치하지 않습니다."
				},
				nickname : {
					required : "필수로입력하세요",
					minlength : "최소 {0}글자이상이어야 합니다"
				},
				email : {
					required : "필수로입력하세요",
					minlength : "최소 {0}글자이상이어야 합니다",
					email : "메일규칙에 어긋납니다"
				}
			},
			tooltip_options : {
				_all_: {placement: "right"}
			}
		});
		
		// ID중복 체크
		function duplicateCheck(frm) {
			ajax("/sign/duplicateCheck",$("#signForm").serialize(),function(r){
				if (r.result) {
					frm.submit();
				} else {
					$.alert({
                        title: '알림',
                        content: r.msg,
                        boxWidth: '300px',
                        useBootstrap: false,
                        icon: 'fa fa-question',
                        theme: 'material',
                        closeIcon: true,
                        animation: 'scale',
                        type: 'orange',
                        buttons: {
                            okay: {
                                text: '확인',
                                btnClass: 'btn-blue'
                            }
                        }
                    });
				}
			});
		}
		

	});
</script>
</html>
