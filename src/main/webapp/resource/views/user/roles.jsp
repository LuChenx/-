<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../resource/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>岗位配置</title>
</head>
<body>
	<div id="toolbar" class="btn-group">
      	<button type="button" class="btn btn-primary btn-sm">
          <span class="glyphicon glyphicon-plus"></span> 添加
        </button>
        <button type="button" class="btn btn-success btn-sm" id="refresh">
          <span class="	glyphicon glyphicon-cloud-download"></span> 刷新
        </button>
	</div>
	<table id="table"></table>
	<script type="text/javascript">
				$(function(){
					//数据来源
					var queryUrl = '<%=basePath%>system/role/config';
					//表头接收字段
					var filed = ['','roleName','roleDesc','id'];
					//表头
					var titles = ['序号','岗位名称','岗位描述','操作'];
					var tableBuilder = new createBootstrapTable('#table',queryUrl,filed,titles);
					
					//设置表格列格式
					var m = new Map(); 
					//value:该列值，row：当前行，index:行号
					var formatter = function(value, row, index){
						return '<a class="btn btn-info" href="#"><i class="glyphicon glyphicon-pencil"></i></a><a style="margin-left:10px;" class="btn btn-danger" href="#"><i class="glyphicon glyphicon-trash"></i></a>';
					};
					m.set('操作', formatter); 
					tableBuilder.setFormatter(m);
					
					//设置查询从参数，默认只有分页参数
					tableBuilder.setQueryJsonParam(function(params){
						 var param = {
									uid:1,
									appId:1
						 }
						 return JSON.stringify(param);
					});
					
					//创建表格
					tableBuilder.create();
					
					$("#refresh").click(function(){
						$("#table").bootstrapTable('refresh');
					});
				});
		</script>
</body>
</html>