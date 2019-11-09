<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<div class="container">
    <div class="col-xs-12" style="margin:15px auto;">
        <label style="font-size:20px;"><span class="glyphicon glyphicon-list-alt"></span>게시글 상세</label>
    </div>
 
    <div class="col-xs-12">
        <form action="/insertProc" method="post">
            <dl class="dl-horizontal">
              <dt>제목</dt>
              <dd>${detail.subject}</dd>
              
              <dt>작성자</dt>
              <dd>${detail.writer}</dd>
              
              <dt>작성날짜</dt>
              <dd>
                  <fmt:formatDate value="${detail.reg_date}" pattern="yyyy.MM.dd HH:mm:ss"/>
              </dd>

              <dt>내용</dt>
              <dd>${detail.content}</dd>
            </dl>
        </form>
        <div class="btn-group btn-group-sm" role="group" style="float:right;">
          <button type="button" class="btn btn-primary btn-sm" onclick="location.href='/board/delete/${detail.bno}'" style="margin-left: 3px;">삭제</button>
          <button type="button" class="btn btn-primary btn-sm" onclick="location.href='/board/update/${detail.bno}'" style="margin-left: 3px;">수정</button>
          <button type="button" class="btn btn-primary btn-sm" onclick="location.href='/board/list'" style="margin-left: 3px;"> 목록 </button>
        </div>
    </div>
</div>
</body>
</html>
