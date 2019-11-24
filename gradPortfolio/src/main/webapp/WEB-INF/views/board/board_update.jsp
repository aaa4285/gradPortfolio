<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<section class="blog-posts-area section-gap">
	 <div class="container">
	    <div class="col-xs-12" style="margin:15px auto;">
	        <label style="font-size:20px;"><span class="glyphicon glyphicon-edit"></span>게시글 수정</label>
	    </div>
	 
	    <div class="col-xs-12">
	        <form action="/board/updateProc" method="post">
	        	<div class="form-group">
	            <label for="subject">제목</label>
	            <input type="text" class="form-control" id="subject" name="subject" placeholder="제목을 입력하세요." value="${detail.subject}">
	          </div>
	          <div class="form-group">
	            <label for="writer">작성자</label>
	            <div class="col">${sessionScope.userSession.displayName}</div>
	          </div>
	          <div class="form-group">
	            <label for="writer">연락처</label>
	            <input type="text" class="form-control" id="telNo" name="telNo" placeholder="내용을 입력하세요." value="${detail.telNo}">
	          </div>
	          <div class="form-group">
	            <label for="writer">잃어버린 일자</label>
	            <input type="text" class="form-control" id="lost_date" name="lost_date" placeholder="잃어버린 일자" value="${detail.lost_date}">
	          </div>
	          <div class="form-group">
	            <label for="writer">잃어버린 장소</label>
	            <input type="text" class="form-control" id="location" name="location" placeholder="내용을 입력하세요." value="${detail.location}">
	          </div>
	          <div class="form-group">
	            <label for="writer">찾는 반려동물 종류</label>
	            <div class="col">
		            <input type="radio" name="kinds" value="1" ${detail.kinds eq "1" ? "checked='checked'" : ""}>강아지
		   			<input type="radio" name="kinds" value="2" ${detail.kinds eq "2" ? "checked='checked'" : ""}>고양이
		   			<input type="radio" name="kinds" value="3" ${detail.kinds eq "3" ? "checked='checked'" : ""}>기타
	   			</div>
	          </div>
	          <div class="form-group">
	            <label for="writer">성별</label>
	            <div class="col">
		            <input type="radio" name="gender" value="0" ${detail.gender eq "0" ? "checked='checked'" : ""}>암컷
		   			<input type="radio" name="gender" value="1" ${detail.gender eq "1" ? "checked='checked'" : ""}>수컷
	   			</div>
	          </div>
	          <div class="form-group">
	            <label for="content">내용</label>
	            <textarea class="form-control" id="content" name="content" rows="3">${detail.content}</textarea>
	          </div>
	        	
	          <input type="hidden" name="board_id" value="${detail.board_id}"/>
	          <button type="submit" class="btn btn-primary btn-sm" style="float:right;">수정</button>
	        </form>
	    </div>
	</div>
