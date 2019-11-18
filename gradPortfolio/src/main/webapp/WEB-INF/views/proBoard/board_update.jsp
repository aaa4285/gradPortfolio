<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <label style="font-size:20px;"><span class="glyphicon glyphicon-edit"></span>게시글 수정</label>
    </div>
 
    <div class="col-xs-12">
        <form action="/proBoard/updateProc" method="post">
          <div class="form-group">
            <label for="subject">제목</label>
            <input type="text" class="form-control" id="subject" name="subject" value="${detail.subject}">
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
