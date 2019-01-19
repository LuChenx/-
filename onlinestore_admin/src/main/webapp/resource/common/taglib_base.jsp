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
<link rel="Shortcut Icon" href="<%=basePath%>resource/ico/admin_24px_534962_easyicon.net.ico">
<script type="text/javascript" src="<%=basePath%>resource/Jquery/jquery-3.2.1.min.js"></script>

<!-- bootstrap -->
<link rel="stylesheet" type="text/css" href="<%=basePath%>resource/Bootstrap/css/bootstrap-theme.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>resource/Bootstrap/css/bootstrap.min.css">
<script src="<%=basePath%>resource/Bootstrap/js/bootstrap.min.js"></script>

<!-- table -->
<link rel="stylesheet" href="<%=basePath%>resource/Bootstrap/table/dist/bootstrap-table.min.css">  
<script src="<%=basePath%>resource/Bootstrap/table/dist/bootstrap-table.min.js"></script>  
<link rel="stylesheet" href="<%=basePath%>resource/Bootstrap/table/src/bootstrap-table-fixed-columns.css">  
<script src="<%=basePath%>resource/Bootstrap/table/src/bootstrap-table-fixed-columns.js"></script>  
<script src="<%=basePath%>resource/Bootstrap/table/src/locale/bootstrap-table-zh-CN.js"></script>

<script src="<%=basePath%>resource/Layui/layer/layer.js"></script>

