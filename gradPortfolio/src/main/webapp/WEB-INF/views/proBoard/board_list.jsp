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
.body{
	padding-top: 20px;
}
table tr th{
	background: #6504b5;
	color:#fff;
}
.card:hover * {
opacity: 0.5;
cursor:pointer;
}
.card.active * {
opacity: 0.5;
cursor:pointer;
}
</style>
<script>
function goDetail(board_id,_this) {
	$(_this).addClass("active");
	loder_show();
	location.href='/proBoard/detail/'+board_id;
}
function goPage(url,_this) {
	$(".page-item").removeClass("active");
	$(_this).addClass("active");
	loder_show();
	location.href=url;
}
</script>
<!-- Page Content -->
<div class="container">

  <!-- Page Heading -->
  <h1 class="my-4">
    <small>게시글목록</small>
    <button class="btn btn-primary btn-sm" style="float:right;" onclick="location.href='/proBoard/insert'">글쓰기</button>
  </h1>
  <div class="row">
  	<c:forEach var="l" items="${list}" varStatus="status" >
	    <div class="col-lg-4 col-sm-6 mb-4">
	      <div class="card h-100" onclick="goDetail('${l.board_id}',this);">
	        <img class="card-img-top" src="http://${empty l.fullPath?"toeic.ybmclass.com/toeic/img/noimage.gif":l.fullPath}" alt="" height="348px">
	        <label class="label btn-primary btn-sm">${l.replyCnt} 댓글</label>
	        <div class="card-body">
	          <h4 class="card-title">
	            <a href="javascript:void(0);">${l.subject}</a>
	          </h4>
	          <p class="card-text">${l.displayName}</p>
	          <p class="card-text"><fmt:formatDate value="${l.reg_date}" pattern="yyyy.MM.dd HH:mm:ss"/></p>
	        </div>
	      </div>
	    </div>
    </c:forEach>
  </div>
  <!-- /.row -->

  <!-- Pagination -->
  <ul class="pagination justify-content-center">
  	<c:if test="${pageMaker.prev}">
	    <li class="page-item">
	      <a class="page-link" href="javascript:void(0);" aria-label="Previous">
	            <span aria-hidden="true">&laquo;</span>
	            <span class="sr-only">Previous</span>
	          </a>
	    </li>
    </c:if>
    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		<li class="page-item ${pageMaker.cri.page eq idx?" active":""}" onclick="goPage('<c:url value="/proBoard/list?page=${idx }"/>',this)">
			<a class="page-link waves-effect waves-effect" href='javascript:void(0);'>${idx}</a>
		</li>
	</c:forEach>
    <c:if test="${pageMaker.next && pageMaker.endPage >0 }">
	    <li class="page-item">
	      <a class="page-link" href="javascript:void(0);" aria-label="Next">
	            <span aria-hidden="true">&raquo;</span>
	            <span class="sr-only">Next</span>
	          </a>
	    </li>
    </c:if>
  </ul>
</div>

