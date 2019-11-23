<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="kindsNm" value="기타"/>
<c:set var="genderNm" value="미상"/>
<c:if test="${detail.kinds eq '1'}">
<c:set var="kindsNm" value="강아지"/>
</c:if>
<c:if test="${detail.kinds eq '2'}">
<c:set var="kindsNm" value="고양이"/>
</c:if>
<c:if test="${detail.gender eq '0'}">
<c:set var="genderNm" value="암컷"/>
</c:if>
<c:if test="${detail.gender eq '1'}">
<c:set var="genderNm" value="수컷"/>
</c:if>
<style>
	.show{}
	.hide{display: none;}
	.blog-posts-area .img-fluid{
		max-height: 400px;
    	object-fit: cover;
	}
	.blog-posts-area .link-preview{
		position: absolute;
		top:0;left: 0;
		margin: 5px;
		color: #7d7d7d;
	}
	.blog-posts-area .link-preview:hover{
		color: #5e4baf;
	}
	.media .user,.comment-list .user-img{
		overflow: hidden;width: 50px;height: 50px;background: #7d62f9;line-height: 50px;
	}
</style>
<script>
function modifyBack(_this){
	var parent = $(_this).parents(".comment-list").eq(0);
	var reply_id = parent.attr("reply_id");
	
	parent.addClass("bounceOut animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
		$(this).remove();
		$(".comment-list[reply_id="+reply_id+"]").removeClass("hide"); 
  	});
}
function modifyReply(_this) {
	var parent = $(_this).parents(".comment-list").eq(0);
	var parent_id = parent.attr("parent_id");
	var reply_id = parent.attr("reply_id");
	var r_type = parent.attr("r_type");
    var reply_content = parent.find("textarea[name='reply_content']").val().replace("\n", "<br>"); //개행처리
    var depth = "1";
    
    if(r_type=="main"){
        parent_id = "0";
        depth = "0";
    }
    
    //값 셋팅
    var objParams = {
            board_id        : "${detail.board_id}",
            reply_id        : reply_id,
            parent_id       : parent_id, 
            depth           : depth,
            reply_content   : reply_content
    };
	
    ajax(
    	"/proBoard/reply/update",
    	objParams,
    	function(retVal){
    		if(retVal.code != "OK") {
                alert(retVal.message);
                return false;
            }else{
            	loder_show();
            	location.href = location.href;
            }
    	}
    );
}
function removeReply(_this) {
	var parent = $(_this).parents(".comment-list").eq(0);
	var parent_id = parent.attr("parent_id");
	var reply_id = parent.attr("reply_id");
	var r_type = parent.attr("r_type");
	
    //값 셋팅
    var objParams = {
            reply_id        : reply_id,
            r_type            : r_type
    };
    
    //ajax 호출
    ajax(
    	"/proBoard/reply/del",
    	objParams,
    	function(retVal){
    		if(retVal.code != "OK") {
                alert(retVal.message);
            } else {
            	loder_show();
                location.href = location.href;
            }
    	}
    );
}
function modify(_this){
	// modify_clone
	var parent = $(_this).parents(".comment-list").eq(0);
	var parent_id = parent.attr("parent_id");
	var reply_id = parent.attr("reply_id");
	var r_type = parent.attr("r_type");
	
	var cParent = $("#modify_clone .comment-list");
	cParent.attr("parent_id",parent_id);
	cParent.attr("reply_id",reply_id);
	cParent.attr("r_type",r_type);
	cParent.find("textarea[name='reply_content']").text(parent.find('label[name=reply_content]').text());
	if (r_type=="main") {
		cParent.removeClass("left-padding");
	} else {
		cParent.addClass("left-padding");
	}
	
	parent.after($("#modify_clone").html());
	parent.addClass("hide");
	parent.next().removeClass("hide").addClass("bounceIn animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
		$(this).removeClass("bounceIn animated");  
  	});
}
function reply(_this){
	$("#commentList .comment-list.left-padding.reply_clone").addClass("bounceOutDown animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
		$(this).remove();  
  	});
	
	if ($(_this).hasClass("active")) {
		$(_this).removeClass("active");
	} else {
		$(_this).addClass("active");
		var parent = $(_this).parents(".comment-list").eq(0);
		var parent_id = parent.attr("parent_id");
		var reply_id = parent.attr("reply_id");
		$("#reply_clone .comment-list").attr("parent_id",reply_id);
		$("#reply_clone .comment-list").attr("reply_id",reply_id);
		
		parent.after($("#reply_clone").html());
		
		parent.next().removeClass("hide").addClass("bounceInUp animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
			$(this).removeClass("bounceIn animated");  
	  	});
	}
}
function regReply(_this){
	var parent = $(_this).parents(".comment-list").eq(0);
	var parent_id = parent.attr("parent_id");
	var reply_id = parent.attr("reply_id");
	
	var content = $(_this).parents(".basic-textarea").eq(0).find("textarea[name='reply_content']").val();
	
	//값 셋팅
    var objParams = {
            board_id        : "${detail.board_id}",
            parent_id        : parent_id,    
            depth            : "1",
            reply_content    : content
    };
	
    //ajax 호출
    ajax(
    	"/proBoard/reply/save",
    	objParams,
    	function(retVal){
    		if(retVal.code != "OK") {
                alert(retVal.message);
                status = false;
            }else{
            	loder_show();
            	location.href = location.href; 
            }
    	}
    );
}
function commentToggle(){
	if ($("#commentList").hasClass("hide")) {
		$("#commentList,#commentList2").removeClass("hide").addClass("bounceInUp animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
		      $(this).removeClass("bounceInUp");
		      $(this).removeClass("animated");
	    });
	} else {
		$("#commentList,#commentList2").addClass("bounceOutDown animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
		      $(this).addClass("hide");
		      $(this).removeClass("bounceOutDown");
		      $(this).removeClass("animated");
	    });
	}
	
}
$(document).ready(function() {

	//댓글 저장
    $("#reply_save").click(function(){
        
        //널 검사
        if($("#reply_content").val().trim() == ""){
            alert("내용을 입력하세요.");
            $("#reply_content").focus();
            return false;
        }
        
        var reply_content = $("#reply_content").val().replace("\n", "<br>"); //개행처리
        
        //값 셋팅
        var objParams = {
                board_id        : "${detail.board_id}",
                parent_id        : "0",    
                depth            : "0",
                reply_content    : reply_content
        };
        
        var reply_id;
        
        //ajax 호출
        ajax(
        	"/proBoard/reply/save",
        	objParams,
        	function(retVal){
        		 if(retVal.code != "OK") {
                     alert(retVal.message);
                 } else {
                	loder_show();
                 	location.href = location.href;
                 }
        	}
        );
    });
});
</script>
	<section class="blog-posts-area section-gap">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 post-list blog-post-list">
					<div class="single-post">
						<div style="position:relative;" class="img-overap">
							<c:if test="${!empty detail.fullPath}">
								<a href="https://${detail.fullPath}" data-lightbox="portfolio" data-title="${detail.subject}" title="원본보기">
							</c:if>
							<img class="img-fluid" src="http://${empty detail.fullPath?"toeic.ybmclass.com/toeic/img/noimage.gif":detail.fullPath}" alt="">
							<c:if test="${!empty detail.fullPath}">
								</a>
							</c:if>
						</div>
						<ul class="tags">
							<li><a href="#"><i class="fa fa-hashtag"></i>${kindsNm}</a> , </li>
							<li><a href="#"><i class="fa fa-hashtag"></i>${genderNm}</a> </li>
						</ul>
						<h2><i class="fa fa-quote-left"></i> ${detail.subject} <i class="fa fa-quote-right"></i></h2>
						<h5><i class="fa fa-angle-double-right"></i> ${detail.location}</h5>
						<h5><i class="fa fa-phone"></i> ${detail.telNo}</h5>
						<p>${detail.content}</p>
						<div class="bottom-meta">
							<div class="user-details row align-items-center">
								<div class="comment-wrap col-lg-6">
									<ul>
										<!-- <li><a href="#"><span class="fa fa-heart"></span>	4 likes</a></li> -->
										<li><a href="javascript:commentToggle();"><span class="fa fa-comments-o"></span> ${detail.replyCnt} Comments</a></li>
									</ul>
								</div>
								<!-- 
								<div class="social-wrap col-lg-6">
									<ul>
										<li>${detail.displayName}</li>
										<li><fmt:formatDate value="${detail.reg_date}" pattern="yyyy.MM.dd HH:mm:ss"/></li>
									</ul>
								</div>
								 -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section id="commentList" class="hide" data-wow-duration="1.4s" style="padding-bottom:50px;">
	    <div class="container comment-sec-area">
	        <div class="row flex-column">
	            <c:forEach var="replyList" items="${replyList}" varStatus="status">
	            <!-- 
					<div class="comment-list ${replyList.depth == '1' ? 'left-padding':''}" parent_id="${replyList.reply_id}" reply_id="${replyList.reply_id}" r_type="${replyList.depth == '0' ? 'main' : (replyList.depth == '1' ? 'sub' : '')}">
		                <div class="single-comment justify-content-between d-flex">
		                    <div class="user justify-content-between d-flex">
		                        <div class="thumb">
		                        	<a href="javascript:void(0);" onclick="removeReply(this);"><i aria-hidden="true" class="fa fa-remove"></i></a>
		                            <div class="d-flex rounded-circle avatar z-depth-1-half mr-3 user-img"><h1>${replyList.displayName}</h1></div>
		                        </div>
		                        <div class="desc">
		                            <h5><a href="#">${replyList.displayName}</a></h5>
		                            <p class="date">December 4, 2017 at 3:12 pm </p>
		                            <p class="comment">
		                                <label name="reply_content">${replyList.reply_content}</label> 
		                                <a href="javascript:void(0);" onclick="modify(this);"><i class="fa fa-pencil-square" aria-hidden="true"></i></a>
		                            </p>
		                        </div>
		                    </div>
		                    <c:if test="${replyList.depth != '1'}">
			                    <div class="reply-btn">
			                           <button onclick="reply(this)" class="btn-reply text-uppercase">답글</button> 
			                    </div>
		                    </c:if>
		                </div>
		            </div>
		             -->
	            	<div class="comment-list ${replyList.depth == '1' ? 'left-padding':''}" parent_id="${replyList.parent_id}" reply_id="${replyList.reply_id}" r_type="${replyList.depth == '0' ? 'main' : (replyList.depth == '1' ? 'sub' : '')}">
						<div class="single-comment justify-content-between">
							<div class="user justify-content-between" style="float: left;">
								<div class="thumb">
									<a href="javascript:void(0);" onclick="removeReply(this);"><i aria-hidden="true" class="fa fa-remove"></i></a>
		                            <div class="d-flex rounded-circle avatar z-depth-1-half mr-3 user-img"><h1>${replyList.displayName}</h1></div>
								</div>
				
							</div>
							<div class="media mt-3 shadow-textarea">
								<div class="media-body">
									<h5>
										<a href="#">${sessionScope.userSession.displayName}</a>
									</h5>
									<p class="date">December 4, 2017 at 3:12 pm </p>
									<div class="form-group basic-textarea rounded-corners">
										<p class="comment">
			                                <label name="reply_content">${replyList.reply_content}</label> 
			                                <a href="javascript:void(0);" onclick="modify(this);"><i class="fa fa-pencil-square" aria-hidden="true"></i></a>
			                            </p>
			                            <c:if test="${replyList.depth != '1'}">
					                           <button onclick="reply(this)" class="btn-reply text-uppercase">답글</button> 
					                    </c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
	        </div>
	    </div>    
	</section>
	
	<section id="commentList2" class="comment-sec-area hide" data-wow-duration="1.4s" style="padding-bottom:50px;">
	    <div class="container comment-sec-area">
	        <div class="row flex-column">
	        	<div class="comment-list">
					<div class="single-comment justify-content-between">
						<div class="user justify-content-between" style="float: left;">
							<div class="thumb">
			
								<div
									class="d-flex rounded-circle avatar z-depth-1-half mr-3 user-img">
									<h1>${sessionScope.userSession.displayName}</h1>
								</div>
							</div>
			
						</div>
						<div class="media mt-3 shadow-textarea">
			
							<div class="media-body">
			
								<h5>
									<a href="#">${sessionScope.userSession.displayName}</a>
								</h5>
								<div class="form-group basic-textarea rounded-corners">
									<textarea class="form-control z-depth-1" id="reply_content" rows="3" placeholder="댓글을 입력하세요."></textarea>
									<button id="reply_save" class="btn-reply text-uppercase">등록</button>
								</div>
							</div>
						</div>
					</div>
				</div>
	        </div>
	    </div>
	</section>
	
	<!-- clone -->
<div class="hide" id="reply_clone">
	<div class="comment-list left-padding reply_clone hide">
		<div class="single-comment justify-content-between">
			<div class="user justify-content-between" style="float: left;">
				<div class="thumb">

					<div
						class="d-flex rounded-circle avatar z-depth-1-half mr-3 user-img">
						<h1>${sessionScope.userSession.displayName}</h1>
					</div>
				</div>

			</div>
			<div class="media mt-3 shadow-textarea">

				<div class="media-body">

					<h5>
						<a href="#">${sessionScope.userSession.displayName}</a>
					</h5>
					<div class="form-group basic-textarea rounded-corners">
						<textarea class="form-control z-depth-1" name="reply_content" rows="3" placeholder="입력하세요."></textarea>
						<button onclick="regReply(this)" class="btn-reply text-uppercase">등록</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="hide" id="modify_clone">
	<div class="comment-list modify_clone hide">
		<div class="single-comment justify-content-between">
			<div class="user justify-content-between" style="float: left;">
				<div class="thumb">
					<a href="javascript:void(0);" onclick="modifyBack(this);"><i aria-hidden="true" class="fa fa-remove"></i></a>
					<div class="d-flex rounded-circle avatar z-depth-1-half mr-3 user-img">
						<h1>${sessionScope.userSession.displayName}</h1>
					</div>
				</div>

			</div>
			<div class="media mt-3 shadow-textarea">

				<div class="media-body">

					<h5>
						<a href="#">${sessionScope.userSession.displayName}</a>
					</h5>
					<div class="form-group basic-textarea rounded-corners">
						<textarea class="form-control z-depth-1" name="reply_content" rows="3" placeholder="댓글을 입력하세요."></textarea>
						<button onclick="modifyReply(this)" class="btn-reply text-uppercase">수정</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>