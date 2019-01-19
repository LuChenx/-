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
				        			$("#configType").append("<option value="+value.id+">"+value.settingName+"</option>");
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
	var tableBuilder;
	$(function(){
		//数据来源
		var queryUrl = '<%=basePath%>system/config/options';
		//表头接收字段
		var filed = ['','settingTypeName','showIndex','optionName','optionDesc','id'];
		//表头
		var titles = ['','选项类别','序号','选项名称','说明','操作'];
		tableBuilder = new createBootstrapTable('#table',queryUrl,filed,titles);
		
		//设置表格列格式
		var m = new Map(); 
		//value:该列值，row：当前行，index:行号
		var formatter = function(value, row, index){
			var config = {};
			config.id = row.id;
			config.optionType = row.settingTypeId;
			config.optionName = row.optionName;
			config.optionDesc = row.optionDesc;
			config.showIndex = row.showIndex;
			return '<a class="btn btn-info" onclick="editConfig('+JSON.stringify(config).replace(/"/g, '&quot;')+')"><i class="glyphicon glyphicon-pencil"></i></a><a style="margin-left:10px;" class="btn btn-danger" onclick="deleteConfig('+value+')"><i class="glyphicon glyphicon-trash"></i></a>';
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
			tableBuilder.create();
		});
		
		$("#add").click(function(){
			$("#configType").val(1);
			$("#optionName").val("");
			$("#showIndex").val("");
			$("#optionDesc").val("");
			$("#addbtu").show();
			$("#modifiedbtu").hide();
			$("#modal").click();
		});
	});
	//删除
	function deleteConfig(optionId){
		layer.confirm('确定删除?', {icon: 3, title:'提示'}, function(index){
			$.ajax({
		          type: "post",
		          url: "<%=basePath%>system/config/deleteOptionConfig" ,
		          data :JSON.stringify({
						uid:storage.managerId,
						appId:1,
						optionId:optionId
			 	  }),
			 	  contentType: 'application/json; charset=UTF-8',
			      dataType:'json',
		          success: function (result) {
		        	  if(result.rcode ==  "000000"){
		        		  tableBuilder.create();
		        	  }else{
		        		  layer.msg(result.rmsg, {time : 1500, icon : 5});
		        	  }
		          },
		          error:function(){
		        	  layer.msg("网络异常", {time : 1500, icon : 5});
		          }
		     });
			 layer.close(index);
		});
	}
	
	function editConfig(option){
		$("#optionId").val(option.id);
		$("#configType").val(option.optionType);
		$("#optionName").val(option.optionName);
		$("#showIndex").val(option.showIndex);
		$("#optionDesc").val(option.optionDesc);
		$("#addbtu").hide();
		$("#modifiedbtu").show();
		$("#modal").click();
	}
	</script>
	
<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal" id="modal"></button>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">编辑系统选项</h4>
            </div>
            <div class="modal-body">
            	<form role="form">
            	     <div class="form-group">
					    <label for="configType">选项类别</label>
					    <select class="form-control" id="configType">
					     
					    </select>
					    </div>
            		 <div class="form-group">
					    <label for="showIndex">选项序号</label>
					    <input type="text" class="form-control" id="showIndex" placeholder="请输入选项序号">
					  </div>
					  <div class="form-group">
					    <label for="optionName">选项名称</label>
					    <input type="text" class="form-control" id="optionName" placeholder="请输入选项名称">
					  </div>
					  <div class="form-group">
					    <label for="optionDesc">选项说明</label>
					    <input type="text" class="form-control" id="optionDesc" placeholder="请输入选项说明">
					  </div>
					  <input type="hidden" id="optionId">
            	</form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="closebtu">关闭</button>
                <button type="button" class="btn btn-primary" id="modifiedbtu">提交更改</button>
                <script>
                	$(function(){
                		$("#modal").hide();
                		$("#modifiedbtu").hide();
                		$("#modifiedbtu").click(function(){
                			$.ajax({
						          type: "post",
						          url: "<%=basePath%>system/config/updateOptionConfig" ,
						          data :JSON.stringify({
										uid:storage.managerId,
										appId:1,
										optionId:$("#optionId").val(),
							            optionName:$("#optionName").val(),
										showIndex:$("#showIndex").val(),
										optionDesc:$("#optionDesc").val(),
										optionType:$("#configType").val(),
										optionTypeName:$("#configType option:selected").text()
							 	  }),
							 	  contentType: 'application/json; charset=UTF-8',
							      dataType:'json',
						          success: function (result) {
						        	if(result.rcode ==  "000000"){
						        		layer.msg("操作成功", {time : 1500, icon : 1});
						        		$("#closebtu").click();
						        		$("#table").bootstrapTable('refresh');
						        	}else{
						        		layer.msg(result.rmsg, {time : 1500, icon : 5});
						        	}
						          },
						          error:function(){
						        	layer.msg("网络异常！", {time : 1500, icon : 5});
						          }
						       });
                		});
                	});
                </script>
				<button type="button" class="btn btn-primary" id="addbtu">新增</button>
					<script type="text/javascript">
                	$(function(){
                		$("#addbtu").click(function(){
                			if($("#optionName").val()==""){
                				layer.msg("请输入选项名称", {time : 1500, icon : 5});
                			}else if($("#showIndex").val()==""){
                				layer.msg("请输入选项序号", {time : 1500, icon : 5});
                			}else{
                				$.ajax({
							          type: "post",
							          url: "<%=basePath%>system/config/addSystemOption" ,
							          data :JSON.stringify({
											uid:storage.managerId,
											appId:1,
											optionName:$("#optionName").val(),
											showIndex:$("#showIndex").val(),
											optionDesc:$("#optionDesc").val(),
											optionType:$("#configType").val(),
											optionTypeName:$("#configType option:selected").text()
								 	  }),
								 	  contentType: 'application/json; charset=UTF-8',
								      dataType:'json',
							          success: function (result) {
							        	if(result.rcode ==  "000000"){
							        		layer.msg("操作成功", {time : 1500, icon : 1});
							        		$("#closebtu").click();
							        		$("#table").bootstrapTable('refresh');
							        	}else{
							        		layer.msg(result.rmsg, {time : 1500, icon : 5});
							        	}
							          },
							          error:function(){
							        	layer.msg("网络异常！", {time : 1500, icon : 5});
							          }
							       });
                			}
                		});
                	});
                </script>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>