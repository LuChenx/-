<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../resource/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统配置</title>
</head>
<body>
	<div id="toolbar" class="btn-group">
        <button type="button" class="btn btn-success btn-sm" id="refresh">
          <span class="	glyphicon glyphicon-cloud-download"></span> 刷新
        </button>
	</div>
	<table id="table"></table>
	<script type="text/javascript">
	    var storage=window.sessionStorage;
		$(function(){
			//数据来源
			var queryUrl = '<%=basePath%>system/config/systemConfig';
			//表头接收字段
			var filed = ['','settingName','settingValue','settingDesc','id'];
			//表头
			var titles = ['','配置名称','配置值','配置说明','编辑'];
			var tableBuilder = new createBootstrapTable('#table',queryUrl,filed,titles);
			//设置查询从参数，默认只有分页参数
			tableBuilder.setQueryJsonParam(function(params){
				 var param = {
							uid:storage.managerId,
							appId:1
				 }
				 return JSON.stringify(param);
			});
			
			//设置表格列格式
			var m = new Map(); 
			var formatter = function(value, row, index){
				var config = {};
				config.id= value;
				config.settingName = row.settingName;
				config.settingValue = row.settingValue;
				config.settingType = row.settingType;
				config.settingOption = row.settingOption;
				return '<a class="btn btn-info" onclick="editConfig('+JSON.stringify(config).replace(/"/g, '&quot;')+')"><i class="glyphicon glyphicon-pencil"></i></a>';
			};
			m.set("编辑", formatter); 
			tableBuilder.setFormatter(m);
			
			tableBuilder.onlyInfoPagination(true);
			
			//创建表格
			tableBuilder.create();
			
			$("#refresh").click(function(){
				$("#table").bootstrapTable('refresh');
			});
		});
		
		function editConfig(config){
			$("#configName").val(config.settingName);
			$("#configId").val(config.id);
			$("#configType").val(config.settingType);
			$("#configValueOption").empty();
			if(config.settingType == 1){
				$("#configValueInput").val(config.settingValue).show();
	    		$("#configValueDisable").hide();
	    		$("#configValueOption").hide();
			}else if(config.settingType == 2){
				$("#configValueDisable").val(config.settingValue).show();
				$("#configValueInput").hide();
	    		$("#configValueOption").hide();
			}else if(config.settingType == 3){
				var options = config.settingOption;
				var optionarr = options.split(",");
				optionarr.forEach(function(value,index){
					$("#configValueOption").append("<option value="+(index+1)+">"+value+"</option>");
				});
				$("#configValueOption").val(config.settingValue).show();
				$("#configValueInput").hide();
	    		$("#configValueDisable").hide();
			}
			$("#modalbtu").click();
			layer.msg('请在对配置属性充分了解的情况下，谨慎修改！', {
		        time: 20000, //20s后自动关闭
		        btn: ['明白了', '知道了', '哦']
		    }); 
		}
	</script>
	
	<!-- 按钮触发模态框 -->
<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal" id="modalbtu"></button>
<script type="text/javascript">
	$(function(){
		$("#modalbtu").hide();
	});
</script>
	<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">编辑系统配置</h4>
            </div>
            <div class="modal-body">
            	<form role="form">
            	  <input type="hidden" id="configId">
            	  <input type="hidden" id="configType">
				  <div class="form-group">
				    <label for="configName">配置名称</label>
				    <input type="text" class="form-control" id="configName" readonly="readonly">
				  </div>
				  <div class="form-group">
				    <label for="configValue">配置值</label>
				    <input type="text" class="form-control" id="configValueInput" >
				    <select class="form-control" id="configValueDisable">
				      <option value="1">启用</option>
				      <option value="0">不启用</option>
				    </select>
				    <select class="form-control" id="configValueOption">
				    </select>
				    <script type="text/javascript">
				    	$(function(){
				    		$("#configValueInput").hide();
				    		$("#configValueDisable").hide();
				    		$("#configValueOption").hide();
				    	});
				    </script>
				  </div>
				</form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="closebtu">关闭</button>
                <button type="button" class="btn btn-primary" id="subtu">提交更改</button>
                <script type="text/javascript">
				    	$(function(){
				    		$("#subtu").click(function(){
				    			layer.confirm('确定修改?', {icon: 3, title:'提示'}, function(index){
				    				var type = $("#configType").val();
					    			var value = "";
					    			if(type==1){
					    				value = $("#configValueInput").val();
					    			}else if(type == 2){
					    				value = $("#configValueDisable").val();
					    			}else if(type == 3){
					    				value = $("#configValueOption").val();
					    			}
					    			
					    			$.ajax({
								          type: "post",
								          url: "<%=basePath%>system/config/updateSystemConfig" ,
								          data :JSON.stringify({
												uid:storage.managerId,
												appId:1,
												configId:$("#configId").val(),
												configValue:value
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
				    	});
				</script>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>