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
        <form action="/board/insertProc" method="post" enctype="multipart/form-data"> <!-- 추가 -->
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
            <label for="writer">잃어버린 장소</label>
            <input type="text" class="form-control" id="location" name="location" placeholder="내용을 입력하세요.">
          </div>
          <div class="form-group">
            <label for="writer">찾는 반려동물 종류</label>
            <div class="cal">
	            <input type="radio" name="kinds" value="1">강아지
	   			<input type="radio" name="kinds" value="2">고양이
	   			<input type="radio" name="kinds" value="3">기타
   			</div>
          </div>
          <div class="form-group">
            <label for="writer">성별</label>
            <div class="cal">
	            <input type="radio" name="gender" value="0">암컷
	   			<input type="radio" name="gender" value="1">수컷
   			</div>
          </div>
          <div class="form-group">
            <label for="content">내용</label>
            <textarea class="form-control" id="content" name="content" rows="3"></textarea>
          </div>
          <div class="form-group">
            <label for="content">파일 업로드</label>
            <input multiple="multiple" type="file" name="files" />
          </div>

          <button type="submit" class="btn btn-primary btn-sm" style="float:right;">작성</button>
          
        </form>
    </div>
</div> 
