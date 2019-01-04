<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../resource/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>岗位权限</title>
</head>
<body>
	<div id="toolbar" class="btn-group">
        <button type="button" class="btn btn-success btn-sm" id="refresh">
          <span class="	glyphicon glyphicon-cloud-download"></span> 刷新
        </button>
	</div>
	<table id="table"></table>
	<script type="text/javascript">
		$(function(){
			//数据来源
			var queryUrl = '<%=basePath%>system/role/roleAuthConfig';
			//表头接收字段
			var filed = ['','authName','authDesc'];
			//表头
			var titles = ['序号','权限名称','权限说明'];
			// 获取表头
			queryRoleConfig();
			var tableBuilder = new createBootstrapTable('#table',queryUrl,filed,titles);
			//设置查询从参数，默认只有分页参数
			tableBuilder.setQueryJsonParam(function(params){
				 var param = {
							uid:1,
							appId:1,
							sortOrder:params.order,//排序
					        sortName:params.sort//排序字段
				 }
				 return JSON.stringify(param);
			});
			
			//设置表格列格式
			var m = new Map(); 
			titles.forEach(function(element, index){
				if(index>2){
					//value:该列值，row：当前行，index:行号
					var formatter = function(value, row, index){
						if(value){
							return '<a href="#"><span class="glyphicon glyphicon-check"></span></a>';	
						}
					};
					m.set(element, formatter); 
				}
			});
			
			tableBuilder.setFormatter(m);
			
			tableBuilder.setSortName(["authName"]);
			
			tableBuilder.onlyInfoPagination(true);
			
			//创建表格
			tableBuilder.create();
			
			//查询岗位配置
			function queryRoleConfig(){
				$.ajax({
			          type: "post",
			          url: "<%=basePath%>system/role/config" ,
			          data :JSON.stringify({
							uid:1,
							appId:1,
							sortOrder:'desc',//排序
				 	  }),
				 	  contentType: 'application/json; charset=UTF-8',
				      dataType:'json',
				      async: false,
			          success: function (result) {
			        	  if(result.rcode ==  "000000"){
			        		  var roles = result.rows;
			        		  for (var i = 0; i < roles.length; i++) {
			        			  titles.push(roles[i].roleName);
			        			  filed.push(roles[i].id);
			        		  }
			        	  }else{
			        		  layer.msg(result.rmsg, {time : 1500, icon : 5});
			        	  }
			          },
			          error:function(){
			        	  layer.msg("网络异常", {time : 1500, icon : 5});
			          }
			     });
			}
			
			$("#refresh").click(function(){
				$("#table").bootstrapTable('refresh');
			});
		});
	</script>
</body>
</html>