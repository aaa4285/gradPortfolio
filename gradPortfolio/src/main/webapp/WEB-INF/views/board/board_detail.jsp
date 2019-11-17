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
	.body{padding-top: 20px;}
	table tr th{background: #6504b5;color:#fff;}
	#reply_area tr{border-bottom: 1px solid #efeef1;}
	#reply_area tr:last-child{border-bottom: 0px;}
	/* 원본보기 */
	#imgOpen{    
		right: 0;
    	opacity: 0.5;
    	position: absolute;
    	z-index: 2;
    }
    #imgOpen:hover{
    	opacity: 1;
    }
    /* //원본보기 */
	tr[reply_type="sub"] td:first-child, #reply_add.sub td:first-child, #reply_modify.sub td:first-child{padding-left:18px;position: relative;}
	tr[reply_type="sub"] td:nth-child(2), #reply_add.sub td:nth-child(2), #reply_modify.sub td:nth-child(2){padding-left:18px;}
	tr[reply_type="sub"] td:first-child::before, #reply_add.sub td:first-child::before, #reply_modify.sub td:first-child::before{
		position:absolute;
		left:0;
		content:'->';
		color: transparent;
		background:url(https://image.flaticon.com/icons/svg/992/992697.svg) no-repeat left top;
	}
</style>
<div class="container">
    <div class="col-xs-12" style="margin:15px auto;">
        <label style="font-size:20px;"><span class="glyphicon glyphicon-list-alt"></span>게시글 상세</label>
    </div>
    <div class="row">
    	<div class="col mb-3">
      		<c:if test="${!empty detail.fullPath}">
      			<a class="btn btn-primary btn-sm" href="javascript:window.open('http://${detail.fullPath}','detail_img');" id="imgOpen">원본보기</a>
		      	<div class="card">
		        	<img class="card-img-top" src="http://${empty detail.fullPath?"toeic.ybmclass.com/toeic/img/noimage.gif":detail.fullPath}">
		        </div>
	        </c:if>
	      	<table class="table" style="width:100%;">
		    	<colgroup>
		    		<col style="width:80px;">
		    		<col style="width:200px;">
		    		<col style="width:80px;">
		    		<col style="width:200px;">
		    	</colgroup>
		    	<tbody>
		    	<tr>
		    		<th>제목</th>
		    		<td colspan="3">${detail.subject}</td>
		    	</tr>
		    	<tr>
		    		<th>작성자</th>
		    		<td>${detail.displayName}</td>
		    		<th>작성일자</th>
		    		<td><fmt:formatDate value="${detail.reg_date}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
		    	</tr>
		    	<tr>
		    		<th>연락처</th>
		    		<td>${detail.telNo}</td>
		    		<th>잃어버린장소</th>
		    		<td>${detail.location}</td>
		    	</tr>
		    	<tr>
		    		<th>종류</th>
		    		<td>
		    			<c:if test="${detail.kinds eq '1'}">강아지</c:if>
		    			<c:if test="${detail.kinds eq '2'}">고양이</c:if>
		    			<c:if test="${detail.kinds eq '3'}">기타</c:if>
		    		</td>
		    		<th>성별</th>
		    		<td>
		    			<c:if test="${detail.gender eq '0'}">암컷</c:if>
		    			<c:if test="${detail.gender eq '1'}">수컷</c:if>
		    		</td>
		    	</tr>
	    	</tbody>
	    	</table>
			<div style="height: 210px; width: 100%; overflow: hidden auto;word-break: break-all;">${detail.content}</p>
			</div>
		</div>
	</div>
 
    <div class="col-xs-12">
         <!-- 댓글목록 -->
		<div class="mb-2" style="border: 1px solid #efeef1;border-radius:8px;width:100%;padding:8px;">
	        <table id="reply_area" style="width:100%;">
	            <tr reply_type="all"  style="display:none"><!-- 뒤에 댓글 붙이기 쉽게 선언 -->
	                <td colspan="4"></td>
	            </tr>
	            <tr reply_type="title"><!-- 뒤에 댓글 붙이기 쉽게 선언 -->
	                <td colspan="4"><h4>댓글 목록</h4></td>
	            </tr>
	            <tr reply_type="empty" style="display:${empty replyList?"":"none"};">
	                <td colspan="4">등록된 댓글이 없습니다.</td>
	            </tr>
	            <!-- 댓글이 들어갈 공간 -->
	            <c:forEach var="replyList" items="${replyList}" varStatus="status">
	             <tr reply_type="<c:if test="${replyList.depth == '0'}">main</c:if><c:if test="${replyList.depth == '1'}">sub</c:if>"><!-- 댓글의 depth 표시 -->
	                 <td width="80px">${replyList.displayName}</td>
	                 <td width="*">${replyList.reply_content}</td>
	                 <td width="172px" style="text-align:right;">
	                     <c:if test="${replyList.depth != '1'}">
	                         <button class="btn btn-sm btn-info" name="reply_reply" parent_id = "${replyList.reply_id}" reply_id = "${replyList.reply_id}">댓글</button><!-- 첫 댓글에만 댓글이 추가 대댓글 불가 -->
	                     </c:if>
	                     <c:if test="${replyList.reply_writer eq sessionScope.userSession.id}">
		                     <button class="btn btn-sm btn-success" name="reply_modify" parent_id = "${replyList.parent_id}" r_type = "<c:if test="${replyList.depth == '0'}">main</c:if><c:if test="${replyList.depth == '1'}">sub</c:if>" reply_id = "${replyList.reply_id}">수정</button>
		                     <button class="btn btn-sm btn-warning" name="reply_del" r_type = "<c:if test="${replyList.depth == '0'}">main</c:if><c:if test="${replyList.depth == '1'}">sub</c:if>" reply_id = "${replyList.reply_id}">삭제</button>
		                 </c:if>
	                 </td>
	             </tr>
	         </c:forEach>
	        </table>
        </div>
        <!-- 댓글작성 -->
        <div class="mb-2" style="border-radius:8px;width:100%;padding:8px;background:#efeef1;">
	        <table style="width:100%;">
	        	<tr>
	        		<td>${sessionScope.userSession.displayName}</td>
	        	</tr>
	            <tr>
	                <td>
	                    <textarea id="reply_content" name="reply_content" rows="4" cols="50" placeholder="댓글을 입력하세요." style="display: inline-block;float: left;width: calc(100% - 87px);"></textarea>
	                    <button type="button" id="reply_save" class="btn btn-primary btn-lg" style="float: left;margin-top: 30px;margin-left: 10px;">등록</button>
	                </td>
	            </tr>
	        </table>
        </div>
		<div role="group" style="width:100%;text-align:right;">
			${sessionScope.userSession.id}/${detail.writer}
			<c:if test="${sessionScope.userSession.id eq detail.writer}">
				<button type="button" class="btn btn-primary btn-sm" onclick="location.href='/board/delete/${detail.board_id}'" style="margin-left: 3px;">삭제</button>
				<button type="button" class="btn btn-primary btn-sm" onclick="location.href='/board/update/${detail.board_id}'" style="margin-left: 3px;">수정</button>
			</c:if>
			<button type="button" class="btn btn-primary btn-sm" onclick="location.href='/board/list'" style="margin-left: 3px;"> 목록 </button>
		</div>
    </div>
</div>
<script type="text/javascript">
	function setEmptyReply(){
		if ($("#reply_area tr[reply_type='main']").length == 0) {
        	$("#reply_area tr[reply_type='empty']").css("display",""); // 댓글없음 보이기
        } else {
        	$("#reply_area tr[reply_type='empty']").css("display","none"); // 댓글없음 숨기기
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
            	"/board/reply/save",
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
        
        //댓글 삭제
        $(document).on("click","button[name='reply_del']", function(){
            
            var check = false;
            var reply_id = $(this).attr("reply_id");
            var r_type = $(this).attr("r_type");
            
            var _this = $(this);
            //값 셋팅
            var objParams = {
                    reply_id        : reply_id,
                    r_type            : r_type
            };
            
            //ajax 호출
            ajax(
            	"/board/reply/del",
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
        
        //댓글 수정 입력
        $(document).on("click","button[name='reply_modify']", function(){
            var check = true;
            var reply_id = $(this).attr("reply_id");
            var parent_id = $(this).attr("parent_id");
            var r_type = $(this).attr("r_type");
             
            if(check){
                //자기 위에 댓글 수정창 입력하고 기존값을 채우고 자기 자신 삭제
                var txt_reply_content = $(this).parent().prev().prev().html().trim(); //댓글내용 가져오기
                if(r_type=="sub"){
                    txt_reply_content = txt_reply_content.replace("→ ","");//대댓글의 뎁스표시(화살표) 없애기
                }
                var txt_reply_writer = $(this).parent().prev().html().trim(); //댓글작성자 가져오기
                //입력받는 창 등록
                var replyEditor = 
                   '<tr id="reply_modify" class="reply_modify '+r_type+'">'+
                   '   <td width="80px">${sessionScope.userSession.displayName}</td>'+
                   '   <td width="*">'+
                   '       <textarea style="width:100%;height:50px;" name="reply_modify_content_'+reply_id+'" id="reply_modify_content_'+reply_id+'" rows="3" cols="50">'+txt_reply_content+'</textarea>'+ //기존 내용 넣기
                   '   </td>'+
                   '   <td width="172px" style="text-align:right;">'+
                   '       <button class="btn btn-sm btn-success" name="reply_modify_save" r_type = "'+r_type+'" parent_id="'+parent_id+'" reply_id="'+reply_id+'">수정</button>'+
                   '       <button class="btn btn-sm btn-warning" name="reply_modify_cancel" r_type = "'+r_type+'" r_content = "'+txt_reply_content+'" r_writer = "'+txt_reply_writer+'" parent_id="'+parent_id+'"  reply_id="'+reply_id+'">취소</button>'+
                   '   </td>'+
                   '</tr>';
                var prevTr = $(this).parent().parent();
                //자기 위에 붙이기
                prevTr.after(replyEditor);
                
                //자기 자신 삭제
                $(this).parent().parent().remove(); 
            }
             
        });
        
        //댓글 수정 취소
        $(document).on("click","button[name='reply_modify_cancel']", function(){
            //원래 데이터를 가져온다.
            var r_type = $(this).attr("r_type");
            var r_content = $(this).attr("r_content");
            var r_writer = $(this).attr("r_writer");
            var reply_id = $(this).attr("reply_id");
            var parent_id = $(this).attr("parent_id");
            
            var reply;
            //자기 위에 기존 댓글 적고 
            if(r_type=="main"){
                reply = 
                    '<tr reply_type="main">'+
                    '   <td width="80px">${sessionScope.userSession.displayName}</td>'+
                    '   <td width="*">'+
                    r_content+
                    '   </td>'+
                    '   <td width="172px" style="text-align:right;">'+
                    '       <button class="btn btn-sm btn-info" name="reply_reply" reply_id = "'+reply_id+'">댓글</button>'+
                    '       <button class="btn btn-sm btn-success" name="reply_modify" r_type = "main" parent_id="0" reply_id = "'+reply_id+'">수정</button>      '+
                    '       <button class="btn btn-sm btn-warning" name="reply_del" reply_id = "'+reply_id+'">삭제</button>      '+
                    '   </td>'+
                    '</tr>';
            }else{
                reply = 
                    '<tr reply_type="sub">'+
                    '   <td width="80px">${sessionScope.userSession.displayName}</td>'+
                    '   <td width="*">'+
                    r_content+
                    '   </td>'+
                    '   <td width="172px" style="text-align:right;">'+
                    '       <button class="btn btn-sm btn-success" name="reply_modify" r_type = "sub" parent_id="'+parent_id+'" reply_id = "'+reply_id+'">수정</button>'+
                    '       <button class="btn btn-sm btn-warning" name="reply_del" reply_id = "'+reply_id+'">삭제</button>'+
                    '   </td>'+
                    '</tr>';
            }
            
            var prevTr = $(this).parent().parent();
               //자기 위에 붙이기
            prevTr.after(reply);
               
              //자기 자신 삭제
            $(this).parent().parent().remove(); 
              
            status = false;
            
        });
        
          //댓글 수정 저장
        $(document).on("click","button[name='reply_modify_save']", function(){
            
            var reply_id = $(this).attr("reply_id");
         	
            //널 체크
            if($("#reply_modify_content_"+reply_id).val().trim() == ""){
                alert("내용을 입력하세요.");
                $("#reply_modify_content_"+reply_id).focus();
                return false;
            }
            //DB에 업데이트 하고
            //ajax 호출 (여기에 댓글을 저장하는 로직을 개발)
            var reply_content = $("#reply_modify_content_"+reply_id).val().replace("\n", "<br>"); //개행처리
            
            var r_type = $(this).attr("r_type");
            
            var parent_id;
            var depth;
            if(r_type=="main"){
                parent_id = "0";
                depth = "0";
            }else{
                parent_id = $(this).attr("parent_id");
                depth = "1";
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
            	"/board/reply/update",
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
            
        });
          
        //대댓글 입력창
        $(document).on("click","button[name='reply_reply']",function(){ //동적 이벤트
            
            $("#reply_add").remove();
            
            var reply_id = $(this).attr("reply_id");
            var last_check = false;//마지막 tr 체크
            
            //입력받는 창 등록
             var replyEditor = 
                '<tr id="reply_add" class="reply_reply sub">'+
                '    <td width="80px">${sessionScope.userSession.displayName}</td>'+
                '    <td width="*">'+
                '        <textarea name="reply_reply_content" rows="3" cols="50" style="width:100%;"></textarea>'+
                '    </td>'+
                '    <td align="center" width="172px" style="text-align:right;">'+
                '        <button class="btn btn-sm btn-info" name="reply_reply_save" parent_id="'+reply_id+'">등록</button>'+
                '        <button class="btn btn-sm btn-warning" name="reply_reply_cancel">취소</button>'+
                '    </td>'+
                '</tr>';
                
            var prevTr = $(this).parent().parent().next();
            
            //부모의 부모 다음이 sub이면 마지막 sub 뒤에 붙인다.
            //마지막 리플 처리
            if(prevTr.attr("reply_type") == undefined){
                prevTr = $(this).parent().parent();
            }else{
                while(prevTr.attr("reply_type")=="sub"){//댓글의 다음이 sub면 계속 넘어감
                    prevTr = prevTr.next();
                }
                
                if(prevTr.attr("reply_type") == undefined){//next뒤에 tr이 없다면 마지막이라는 표시를 해주자
                    last_check = true;
                }else{
                    prevTr = prevTr.prev();
                }
                
            }
            
            if(last_check){//마지막이라면 제일 마지막 tr 뒤에 댓글 입력을 붙인다.
                $('#reply_area tr:last').after(replyEditor);    
            }else{
                prevTr.after(replyEditor);
            }
            
        });
        
        //대댓글 등록
        $(document).on("click","button[name='reply_reply_save']",function(){
                                
            var reply_reply_content = $("textarea[name='reply_reply_content']");
            var reply_reply_content_val = reply_reply_content.val().replace("\n", "<br>"); //개행처리
            
            var _this = $(this);

            //널 검사
            if(reply_reply_content.val().trim() == ""){
                alert("내용을 입력하세요.");
                reply_reply_content.focus();
                return false;
            }
            
            //값 셋팅
            var objParams = {
                    board_id        : "${detail.board_id}",
                    parent_id        : $(this).attr("parent_id"),    
                    depth            : "1",
                    reply_content    : reply_reply_content_val
            };
            
            var reply_id;
            var parent_id;
            
            //ajax 호출
            ajax(
            	"/board/reply/save",
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
        });
        
        //대댓글 입력창 취소
        $(document).on("click","button[name='reply_reply_cancel']",function(){
            $("#reply_add").remove();
            
            status = false;
        });
	});

</script>
