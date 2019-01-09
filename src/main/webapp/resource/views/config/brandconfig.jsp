<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../resource/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品管理</title>
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
	var storage=window.sessionStorage;
	$(function(){
		//数据来源
		var queryUrl = '<%=basePath%>system/role/brandConfig';
		//表头接收字段
		var filed = ['showIndex','brandName','id'];
		//表头
		var titles = ['序号','商品名称','操作'];
		var tableBuilder = new createBootstrapTable('#table',queryUrl,filed,titles);
		
		//设置表格列格式
		var m = new Map(); 
		//value:该列值，row：当前行，index:行号
		var formatter = function(value, row, index){
			var brand = {};
			brand.id = row.id;
			brand.brandName = row.brandName;
			brand.showIndex = row.showIndex;
			return '<a class="btn btn-info" onclick="editBrand('+JSON.stringify(brand).replace(/"/g, '&quot;')+')"><i class="glyphicon glyphicon-pencil"></i></a><a style="margin-left:10px;" class="btn btn-danger" onclick="deleteBrand('+value+')"><i class="glyphicon glyphicon-trash"></i></a>';
		};
		m.set('操作', formatter); 
		var formatter2 = function(value, row, index){
			return value;
		};
		m.set('序号', formatter2); 
		tableBuilder.setFormatter(m);
		
		//设置查询从参数，默认只有分页参数
		tableBuilder.setQueryJsonParam(function(params){
			 var param = {
						uid:storage.managerId,
						appId:1,
						sortOrder:params.order,//排序
				        sortName:params.sort//排序字段
			 }
			 return JSON.stringify(param);
		});
		
		tableBuilder.setSortName(["showIndex"]);
		
		tableBuilder.onlyInfoPagination(true);
		//创建表格
		tableBuilder.create();
		
		$("#refresh").click(function(){
			$("#table").bootstrapTable('refresh');
		});
		
	});
	function editBrand(brand){
		$("#updatebtu").show();
		$("#addbtu").hide();
		$("#brandId").val(brand.id);
		$("#brandIndex").val(brand.showIndex);
		$("#brandName").val(brand.brandName);
		$("#modbtu").click();
	}
	
	//删除价格信息
	function deleteBrand(brandId){
		layer.confirm('确定删除?', {icon: 3, title:'提示'}, function(index){
			$.ajax({
		          type: "post",
		          url: "<%=basePath%>system/role/deleteBrandConfig" ,
		          data :JSON.stringify({
						uid:storage.managerId,
						appId:1,
						brandId:brandId
			 	  }),
			 	  contentType: 'application/json; charset=UTF-8',
			      dataType:'json',
		          success: function (result) {
		        	  if(result.rcode ==  "000000"){
		        		  $("#table").bootstrapTable('refresh');
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
	</script>

	<!-- 按钮触发模态框 -->
	<button class="btn btn-primary btn-lg" data-toggle="modal"
		data-target="#myModal" id="modbtu"></button>
	<script type="text/javascript">
$(function(){
	
	$("#modbtu").hide();
	$("#add").click(function(){
		$("#brandIndex").val("");
		$("#brandName").val("");
		$("#modbtu").click();
		$("#updatebtu").hide();
		$("#addbtu").show();
	});
	
});
</script>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">编辑商品配置</h4>
				</div>
				<div class="modal-body">
					<form role="form">
						<div class="form-group">
							<label for="brandIndex">商品序号</label> <input type="text"
								class="form-control" placeholder="请输入商品序号" id="brandIndex">
							<input type="hidden" id="brandId">
							<label for="brandName">商品名称</label> <input type="text"
								class="form-control" placeholder="请输入商品名称" id="brandName">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						id="closebtu">关闭</button>
					<button type="button" class="btn btn-primary" id="updatebtu">提交更改</button>
					<script>
                	$(function(){
                		$("#updatebtu").hide();
                		$("#updatebtu").click(function(){
                			$.ajax({
						          type: "post",
						          url: "<%=basePath%>system/role/updateBrandConfig" ,
						          data :JSON.stringify({
										uid:storage.managerId,
										appId:1,
										brandId:$("#brandId").val(),
										brandIndex:$("#brandIndex").val(),
										brandName:$("#brandName").val()
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
                			if($("#brandName").val()==""){
                				 layer.msg("请输入商品名称", {time : 1500, icon : 5});
                			}else{
                				$.ajax({
							          type: "post",
							          url: "<%=basePath%>system/role/addBrandConfig" ,
							          data :JSON.stringify({
											uid:storage.managerId,
											appId:1,
											brandIndex:$("#brandIndex").val(),
											brandName:$("#brandName").val()
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
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</body>
</html>