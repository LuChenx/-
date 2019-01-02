<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../resource/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>岗位配置</title>
<script src="<%=basePath%>resource/Bootstrap/js/bootstrap-treeview.js"></script>  
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
	<table id="table"></table>
	<script type="text/javascript">
				$(function(){
					$("#modal").hidden();
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
					
					$("#add").click(function(){
						$("#modal").click();
					});
				});
		</script>

<!-- 按钮触发模态框 -->
<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal" id="modal">
</button>		
		<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" 
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                   	 新增岗位
                </h4>
            </div>
            <div class="modal-body">
               <ul id="myTab" class="nav nav-tabs">
					<li class="active">
						<a href="#basic" data-toggle="tab">基本信息</a>
					</li>
					<li><a href="#auth" data-toggle="tab">岗位权限</a>
					</li>
					<li><a href="#priceauth" data-toggle="tab">价格权限</a>
					</li>
				</ul>
				<br>
				<div id="myTabContent" class="tab-content">
					<form role="form">
				    <div class="tab-pane fade in active" id="basic">
				    	 <div class="form-group">
						    <label for="name">岗位名称：</label>
						    <input type="text" class="form-control" placeholder="岗位名称">
						  </div>
						   <div class="form-group">
						    <label for="name">岗位说明：</label>
						    <input type="text" class="form-control" placeholder="岗位说明">
						  </div>
				    </div>
				    <div class="tab-pane fade" id="auth">
				    	<script type="text/javascript">
				    		$(function(){
				    			function getTree() {
				    				var data = {text:"岗位权限"};
				    			    return data;
				    			}
				    			$('#auth').treeview({data: getTree()});       
				    		});
				    	</script>
				    </div>
				    <div class="tab-pane fade" id="priceauth">
				    	<script type="text/javascript">
				    		$(function(){
				    			function getTree() {
				    				var data = {text:"价格权限"};
				    			    return data;
				    			}
				    			$('#priceauth').treeview({data: getTree()});       
				    		});
				    	</script>
				    </div>
				    </form>
				</div>
			<script>
			    $(function () {
			        $('#myTab li:eq(1) a').tab('show');
			    });
			</script>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" 
                        data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary">
                    提交更改
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
</html>