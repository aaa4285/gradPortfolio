<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <script type="text/javascript">
    <%
    if (request.getAttribute("errMsg") != null) {
    	%>
    	alert("<%=request.getAttribute("errMsg")%>");
    	<%
    }
    %>
    <%
    if (request.getAttribute("returnPage") != null) {
    	%>
    	location.href = "<%=request.getAttribute("returnPage")%>";
    	<%
    }
    %>
    </script>
</head>
</html>
