<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="basePath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${path}/"/>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

	<!-- start: CSS -->
	<link href="<%=basePath%>resource/frame/css/bootstrap.min.css" rel="stylesheet" />
	<link href="<%=basePath%>resource/frame/css/bootstrap-responsive.min.css" rel="stylesheet" />
	<link href="<%=basePath%>resource/frame/css/style.min.css" rel="stylesheet" />
	<link href="<%=basePath%>resource/frame/css/style-responsive.min.css" rel="stylesheet" />
	<link href="<%=basePath%>resource/frame/css/retina.css" rel="stylesheet" />
	<!-- end: CSS -->
	

	<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	  	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<link id="ie-style" href="css/ie.css" rel="stylesheet">
	<![endif]-->
	
	<!--[if IE 9]>
		<link id="ie9style" href="css/ie9.css" rel="stylesheet">
	<![endif]-->
	
	<!-- start: Favicon and Touch Icons -->
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=basePath%>resource/frame/ico/apple-touch-icon-144-precomposed.png" />
	<link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=basePath%>resource/frame/ico/apple-touch-icon-114-precomposed.png" />
	<link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=basePath%>resource/frame/ico/apple-touch-icon-72-precomposed.png" />
	<link rel="apple-touch-icon-precomposed" href="<%=basePath%>resource/frame/ico/apple-touch-icon-57-precomposed.png" />
	<link rel="shortcut icon" href="<%=basePath%>resource/ico/admin_24px_534962_easyicon.net.ico" />
	<!-- end: Favicon and Touch Icons -->	

	<script src="<%=basePath%>resource/js/md5.js"></script>
	
<!-- start: JavaScript-->
		<script src="<%=basePath%>resource/frame/js/jquery-1.10.2.min.js"></script>
		<script src="<%=basePath%>resource/frame/js/jquery-migrate-1.2.1.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery-ui-1.10.3.custom.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery.ui.touch-punch.js"></script>	
		<script src="<%=basePath%>resource/frame/js/modernizr.js"></script>	
		<script src="<%=basePath%>resource/frame/js/bootstrap.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery.cookie.js"></script>	
		<script src='<%=basePath%>resource/frame/js/fullcalendar.min.js'></script>	
		<script src='<%=basePath%>resource/frame/js/jquery.dataTables.min.js'></script>
		<script src="<%=basePath%>resource/frame/js/excanvas.js"></script>
		<script src="<%=basePath%>resource/frame/js/jquery.flot.js"></script>
		<script src="<%=basePath%>resource/frame/js/jquery.flot.pie.js"></script>
		<script src="<%=basePath%>resource/frame/js/jquery.flot.stack.js"></script>
		<script src="<%=basePath%>resource/frame/js/jquery.flot.resize.min.js"></script>
		<script src="<%=basePath%>resource/frame/js/jquery.flot.time.js"></script>
		
		<script src="<%=basePath%>resource/frame/js/jquery.chosen.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery.uniform.min.js"></script>		
		<script src="<%=basePath%>resource/frame/js/jquery.cleditor.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery.noty.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery.elfinder.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery.raty.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery.iphone.toggle.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery.uploadify-3.1.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery.gritter.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery.imagesloaded.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery.masonry.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery.knob.modified.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery.sparkline.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/counter.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/raphael.2.1.0.min.js"></script>
		<script src="<%=basePath%>resource/frame/js/justgage.1.0.1.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/jquery.autosize.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/retina.js"></script>
		<script src="<%=basePath%>resource/frame/js/jquery.placeholder.min.js"></script>
		<script src="<%=basePath%>resource/frame/js/wizard.min.js"></script>
		<script src="<%=basePath%>resource/frame/js/core.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/charts.min.js"></script>	
		<script src="<%=basePath%>resource/frame/js/custom.min.js"></script>
	<!-- end: JavaScript-->
