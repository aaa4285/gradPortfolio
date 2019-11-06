<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
 
<h2> 게시글 목록 </h2>
 
<button class="btn btn-primary" onclick="location.href='/board/insert'">글쓰기</button>
 
<div class="container">
    <table class="table table-hover">
        <tr>
            <th>No</th>
            <th>Subject</th>
            <th>Writer</th>
            <th>Date</th>
        </tr>
          <c:forEach var="l" items="${list}" varStatus="status">
              <tr onclick="location.href='/board/detail/${l.bno}'" style="cursor:pointer;">
                  <td>${status.count}</td>
                  <td>${l.subject}</td>
                  <td>${l.writer}</td>
                  <td>${l.reg_date}</td>
              </tr>
          </c:forEach>
          
    </table>
</div>
</body>
</html>
