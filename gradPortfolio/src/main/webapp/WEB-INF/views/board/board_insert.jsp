<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.body .container{
	border-radius: 8px;
	padding: 10px 15px;
	box-shadow: 0px 2px 1px rgba(0, 0, 0, 0.24);
	min-height: 626px;
}
.body{
	padding-top: 20px;
}
table tr th{
	background: #6504b5;
	color:#fff;
}
</style>
<div class="container">
    <div class="col-xs-12" style="margin:15px auto;">
        <label style="font-size:20px;"><span class="glyphicon glyphicon-edit"></span>게시글 작성</label>
    </div>
    
    <div class="col-xs-12">
        <form id="form" action="/board/insertProc" method="post" enctype="multipart/form-data"> <!-- 추가 -->
          <div class="form-group">
            <label for="subject">제목</label>
            <input type="text" class="form-control" id="subject" name="subject" placeholder="제목을 입력하세요.">
          </div>
          <div class="form-group">
            <label for="writer">작성자</label>
            <div class="col">${sessionScope.userSession.displayName}</div>
          </div>
          <div class="form-group">
            <label for="writer">연락처</label>
            <input type="text" class="form-control" id="telNo" name="telNo" placeholder="내용을 입력하세요.">
          </div>
          <div class="form-group">
            <label for="writer">잃어버린 일자</label>
            <input type="text" class="form-control" id="lost_date" name="lost_date" placeholder="잃어버린 일자">
          </div>
          <div class="form-group">
            <label for="writer">잃어버린 장소</label>
            <input type="text" class="form-control" id="location" name="location" placeholder="내용을 입력하세요.">
          </div>
          <div class="form-group">
            <label for="writer">찾는 반려동물 종류</label>
            <div class="col">
	            <input type="radio" name="kinds" value="1">강아지
	   			<input type="radio" name="kinds" value="2">고양이
	   			<input type="radio" name="kinds" value="3">기타
   			</div>
          </div>
          <div class="form-group">
            <label for="writer">성별</label>
            <div class="col">
	            <input type="radio" name="gender" value="0">암컷
	   			<input type="radio" name="gender" value="1">수컷
   			</div>
          </div>
          <div class="form-group">
            <label for="content">내용</label>
            <textarea class="form-control" id="content" name="content" rows="3"></textarea>
          </div>
          <div class="form-group">
            <label for="content">이미지 업로드</label>
            <div class="input-group input-file">
				<span class="input-group-btn">
					<button class="btn btn-primary btn-choose" type="button">Choose</button>
				</span>
				<input type="text" class="form-control" placeholder='이미지를 선택해주세요.' />
				<span class="input-group-btn">
					<button class="btn btn-warning btn-reset" type="button">Reset</button>
				</span>
			</div>
          </div>
<script>
function sldjfrnf(){
	loder_show();
	$("#form").submit();
}
function bs_input_file() {
	$(".input-file").before(
		function() {
			if ( ! $(this).prev().hasClass('input-ghost') ) {
				var element = $("<input multiple='multiple' type='file' name='files' class='input-ghost' style='visibility:hidden; height:0'>");
				element.attr("name",$(this).attr("name"));
				element.change(function(){
					element.next(element).find('input').val((element.val()).split('\\').pop());
				});
				$(this).find("button.btn-choose").click(function(){
					element.click();
				});
				$(this).find("button.btn-reset").click(function(){
					element.val(null);
					$(this).parents(".input-file").find('input').val('');
				});
				$(this).find('input').css("cursor","pointer");
				$(this).find('input').mousedown(function() {
					$(this).parents('.input-file').prev().click();
					return false;
				});
				return element;
			}
		}
	);
}
$(function() {
	bs_input_file();
});
</script>
			<div class="row">
				<div class="col">
					<button type="button" onclick="sldjfrnf();" class="btn btn-primary btn-sm" style="float:right;">작성</button>
				</div>
			</div>
        </form>
    </div>
</div> 
