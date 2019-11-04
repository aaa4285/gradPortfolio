<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div layout:fragment="content">
		<h1>Error Page</h1>
		error code : <span>${code}</span> 
			<br>error msg : <span>${msg}</span>
			<br>timestamp : <span>${timestamp}</span>
	</div>
</body>
</html>