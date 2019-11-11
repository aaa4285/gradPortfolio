<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.body .container{
border-radius: 8px;
padding: 10px 15px;
box-shadow: 0px 2px 1px rgba(0, 0, 0, 0.24);
min-height: 626px;
}
</style>
<div class="container">
    <div class="col-xs-12" style="margin:15px auto;">
        <label style="font-size:20px;"><span class="glyphicon glyphicon-list-alt"></span>게시글 목록</label>
        <button class="btn btn-primary btn-sm" style="float:right;" onclick="location.href='/board/insert'">글쓰기</button>
    </div>
    
    <div class="col-xs-12">
        <table class="table table-hover">
            <tr>
                <th>No</th>
                <th>Subject</th>
                <th>Writer</th>
                <th>Date</th>
            </tr>
              <c:forEach var="l" items="${list}" varStatus="status" >
                  <tr onclick="location.href='/board/detail/${l.bno}'" style="cursor:pointer;">
                      <td>${status.count}</td>
                      <td>${l.subject}</td>
                      <td>${l.writer}</td>
                      <td>
                        <fmt:formatDate value="${l.reg_date}" pattern="yyyy.MM.dd HH:mm:ss"/>
                    </td>
                  </tr>
              </c:forEach>
        </table>
    </div>
    <ul class="btn-group pagination">
	    <c:if test="${pageMaker.prev}">
	    <li>
	        <a href='<c:url value="/board/list?page=${pageMaker.startPage-1 }"/>'><i class="fa fa-chevron-left"></i></a>
	    </li>
	    </c:if>
	    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
	    <li>
	        <a href='<c:url value="/board/list?page=${idx }"/>'><i class="fa">${idx }</i></a>
	    </li>
	    </c:forEach>
	    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
	    <li>
	        <a href='<c:url value="/board/list?page=${pageMaker.endPage+1}"/>'><i class="fa fa-chevron-right"></i></a>
	    </li>
	    </c:if>
	</ul>
</div>
