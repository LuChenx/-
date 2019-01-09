<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../resource/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统选项</title>
</head>
<body>
	<div id="toolbar" class="btn-group">
      	<button type="button" class="btn btn-primary btn-sm" id="add">
          <span class="glyphicon glyphicon-plus"></span> 添加
        </button>
        <button type="button" class="btn btn-success btn-sm" id="refresh">
          <span class="	glyphicon glyphicon-cloud-download"></span> 刷新
        </button>
	</div>
	<form class="form-inline" role="form" style="float: right;margin-right: 10px;margin-top: 10px">
		  <div class="form-group">
		     <label for="optionType">类型：</label>
		     <select class="form-control" id="optionType">
		     <option value="all">所有类型</option>
		     </select>
		     <script type="text/javascript">
		        var storage=window.sessionStorage;
		        //获取选项类型
		        queryOptionType()
		        function queryOptionType(){
		        	$.ajax({
				          type: "post",
				          url: "<%=basePath%>system/config/optionTypeList" ,
				          data :JSON.stringify({
				        	    uid:storage.managerId,
								appId:1
					 	  }),
					 	  contentType: 'application/json; charset=UTF-8',
					      dataType:'json',
				          success: function (result) {
				        	if(result.rcode ==  "000000"){
				        		var types = result.settingTypes;
				        		types.forEach(function(value,index){
				        			$("#optionType").append("<option value="+value.id+">"+value.settingName+"</option>");
				        		});
				        	}else{
				        		layer.msg(result.rmsg, {time : 1500, icon : 5});
				        	}
				          },
				          error:function(){
				        	layer.msg("网络异常！", {time : 1500, icon : 5});
				          }
				       });
		        }
		     	$("#optionType").change(function(){
		     		$("#table").bootstrapTable('refresh');
		     	});
		     </script>
		  </div>
	</form>
	<table id="table"></table>
	<script type="text/javascript">
	var storage=window.sessionStorage;
	$(function(){
		//数据来源
		var queryUrl = '<%=basePath%>system/config/options';
		//表头接收字段
		var filed = ['','settingTypeName','showIndex','optionName','optionDesc','id'];
		//表头
		var titles = ['编号','选项类别','序号','选项名称','说明','操作'];
		var tableBuilder = new createBootstrapTable('#table',queryUrl,filed,titles);
		
		//设置表格列格式
		var m = new Map(); 
		//value:该列值，row：当前行，index:行号
		var formatter = function(value, row, index){
			return '<a class="btn btn-info" onclick="editRole('+value+')"><i class="glyphicon glyphicon-pencil"></i></a><a style="margin-left:10px;" class="btn btn-danger" onclick="deleteRole('+value+')"><i class="glyphicon glyphicon-trash"></i></a>';
		};
		m.set('操作', formatter); 
		tableBuilder.setFormatter(m);
		
		//设置查询从参数，默认只有分页参数
		tableBuilder.setQueryJsonParam(function(params){
			 var param = {
						uid:storage.managerId,
						appId:1,
						sortOrder:params.order,//排序
				        sortName:params.sort,//排序字段
				        settingType:$("#optionType").val()
			 }
			 return JSON.stringify(param);
		});
		
		tableBuilder.setSortName(["settingTypeName"]);
		
		tableBuilder.onlyInfoPagination(true);
		//创建表格
		tableBuilder.create();
		
		$("#refresh").click(function(){
			$("#table").bootstrapTable('refresh');
		});
	});
	</script>
</body>
</html>