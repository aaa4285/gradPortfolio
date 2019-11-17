<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<style type="text/css">
html,
body {
  height: 100%;
  margin: 0;
}

body {
  background: linear-gradient(#111, #333, #111);
  background-repeat: no-repeat;
  background-size: cover;
  color: #eee;
  position: relative;
  font-family: "Roboto", sans-serif;
}

.message {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  text-align: center;
}
.message h1,
.message h2,
.message h3 {
  margin: 0;
  line-height: 0.8;
}
.message h2,
.message h3 {
  font-weight: 300;
  color: #c8fff4;
}
.message h1 {
  font-weight: 700;
  color: #03dac6;
  font-size: 8em;
}
.message h2 {
  margin: 30px 0;
}
.message h3 {
  font-size: 2.5em;
}
.message h4 {
  display: inline-block;
  margin: 0 15px;
}
.message button {
  background: transparent;
  border: 2px solid #c8fff4;
  color: #c8fff4;
  padding: 5px 15px;
  font-size: 1.25em;
  transition: all 0.15s ease;
  border-radius: 3px;
}
.message button:hover {
  background: #03dac6;
  border: 2px solid #03dac6;
  color: #111;
  cursor: pointer;
  transform: scale(1.05);
}
</style>
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,700" rel="stylesheet">
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div class="message">
		<h1>${code}</h1>
		<h3>error msg : <span>${msg}</span></h3>
		<h2>timestamp: <span>${timestamp}</span></h2>
		<!-- use window.history.back(); to go back -->
		<button>Go Home</button>
	</div>
</body>