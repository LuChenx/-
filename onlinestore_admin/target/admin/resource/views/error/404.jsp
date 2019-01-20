<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../resource/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- //custom-theme -->
<link href="<%=basePath%>resource/css/404style.css" rel="stylesheet" type="text/css" media="all" />
<!-- //js --> 
<!-- font-awesome icons -->
<link href="<%=basePath%>resource/css/font-awesome.css" rel="stylesheet"> 
<!-- //font-awesome icons -->
<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">
<link href="http://fonts.googleapis.com/css?family=Alfa+Slab+One" rel="stylesheet">
<title>404</title>
</head>
<body>
	<div class="main">
		<canvas id="myCanvas"></canvas>
		<div class="agileinfo_404_main">
			<h1>Effective Error Page</h1>
			<div class="w3_agile_main">
				<h2>Oooops.... Could not find it</h2>
				<p>For some reason the page you requested could not be found on Our server.</p>
				<div class="agile_404 w3layouts">
					<div class="agile_404_pos">
						<h3>4<span>0</span>4<img src="<%=basePath%>resource/images/1.png" alt=" " /> </h3>
					</div>
					<img src="<%=basePath%>resource/images/3.png" alt=" " class="w3l"/>
				</div>
			</div>
	</div>
	<script src="<%=basePath%>resource/js/particles.min.js"></script>
    <script>
      window.onload = function() {
        Particles.init({
          selector: '#myCanvas',
          color: '#6b6b6b',
          connectParticles: true,
          minDistance: 100
        });
      };
    </script>
</body>
</html>