<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../resource/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>供货单位</title>
</head>
<body>
   <div id="toolbar" class="btn-group">
		<button type="button" class="btn btn-primary btn-sm" id="add">
			<span class="glyphicon glyphicon-plus"></span> 添加
		</button>
		<button type="button" class="btn btn-info btn-sm" id="outexport">
			<span class="glyphicon glyphicon-export"></span> 导出
		</button>
		<button type="button" class="btn btn-warning btn-sm" id="inexport">
			<span class="glyphicon glyphicon-import"></span> 导入
		</button>
		<button type="button" class="btn btn-success btn-sm" id="refresh">
			<span class="glyphicon glyphicon-cloud-download"></span> 刷新
		</button>
	</div>
	<table id="table" class="table-responsive" style="word-break:keep-all; word-wrap:keep-all;"></table>
	<script type="text/javascript">
	var storage=window.sessionStorage;
	$(function(){
		//数据来源
		var queryUrl = '<%=basePath%>system/manager/supplierList';
		//表头接收字段
		var filed = ['','companyName','companyAddress','zipCode','companyPhone','companyFax','dutyParagraph','openingBank','companyAccount','companyWebsite','companyEmail','isRebate','companyDesc','managerId','id'];
		//表头
		var titles = ['','单位名称','地址','邮编','电话','传真','税号','开户行','账号','网址','邮件','是否返利','备注','操作员','操作'];
		var tableBuilder = new createBootstrapTable('#table',queryUrl,filed,titles);
		
		//设置表格列格式
		var m = new Map(); 
		//value:该列值，row：当前行，index:行号
		var formatter = function(value, row, index){
			var supplier = {};
			supplier.id = row.id;
			supplier.areaName = row.companyName;
			return '<a class="btn btn-info" onclick="editSupplier('+JSON.stringify(supplier).replace(/"/g, '&quot;')+')"><i class="glyphicon glyphicon-pencil"></i></a><a style="margin-left:10px;" class="btn btn-danger" onclick="deleteSupplier('+value+')"><i class="glyphicon glyphicon-trash"></i></a>';
		};
		
		var formatter2 = function(value, row, index){
			if(value){
				return '<a href="#"><span class="glyphicon glyphicon-check"></span></a>';
			}
		};
		m.set('操作', formatter);
		m.set('是否返利', formatter2); 
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
		
		tableBuilder.setSortName(["companyName"]);
		
		tableBuilder.onlyInfoPagination(true);
		//创建表格
		tableBuilder.create();
		
		$("#refresh").click(function(){
			$("#table").bootstrapTable('refresh');
		});
	});
	</script>
	<!-- 按钮触发模态框 -->
<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal" id="modalbtu"></button>
<script type="text/javascript">
$(function(){
	$("#modalbtu").hide();
	$("#add").click(function(){
		$("#modalbtu").click();
	});
});
</script>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">编辑供货单位</h4>
            </div>
            <div class="modal-body">
            	<ul id="myTab" class="nav nav-tabs">
				    <li class="active">
				        <a href="#baseinfo" data-toggle="tab">基本信息</a>
				    </li>
				    <li>
				    	<a href="#user" data-toggle="tab" id="tabuser">联系人</a>
				    	<script type="text/javascript">
						$(function(){
							$("#add").click(function(){
								$("#tabuser").hide();
							});
						});
						</script>
				    </li>
				</ul>
				<div id="myTabContent" class="tab-content">
				    <div class="tab-pane fade in active" id="baseinfo">
				    	<form class="form-horizontal" role="form">
						  <div class="form-group" style="margin-top: 10px">
						    <label for="companyName" class="col-sm-2 control-label">名&nbsp;&nbsp;&nbsp;&nbsp;称</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="companyName" placeholder="请输入单位名称">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="companyAddress" class="col-sm-2 control-label">地&nbsp;&nbsp;&nbsp;&nbsp;址</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="companyAddress" placeholder="请输入单位地址">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="zipCode" class="col-sm-2 control-label">邮&nbsp;&nbsp;&nbsp;&nbsp;编</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="zipCode" placeholder="请输入单位邮编">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="phone" class="col-sm-2 control-label">电&nbsp;&nbsp;&nbsp;&nbsp;话</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="phone" placeholder="请输入联系电话">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="fax" class="col-sm-2 control-label">传&nbsp;&nbsp;&nbsp;&nbsp;真</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="fax" placeholder="请输入传真">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="duty" class="col-sm-2 control-label">税&nbsp;&nbsp;&nbsp;&nbsp;号</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="duty" placeholder="请输入税号">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="bank" class="col-sm-2 control-label">开户行</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="bank" placeholder="请输入开户行">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="account" class="col-sm-2 control-label">账&nbsp;&nbsp;&nbsp;&nbsp;号</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="account" placeholder="请输入账号">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="website" class="col-sm-2 control-label">网&nbsp;&nbsp;&nbsp;&nbsp;址</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="website" placeholder="请输入网址">
						    </div>
						  </div>
						  <div class="form-group">
						    <label for="email" class="col-sm-2 control-label">邮&nbsp;&nbsp;&nbsp;&nbsp;箱</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="email" placeholder="请输入邮箱">
						    </div>
						  </div>
						  <div class="form-group">
						  	<label for="email" class="col-sm-2 control-label">选&nbsp;&nbsp;&nbsp;&nbsp;项</label>
						    <div class="col-sm-10">
						       <label class="checkbox-inline">
							        <input type="checkbox" id="rebate"> 计返利
							    </label>
						    </div>
						  </div>
						  <div class="form-group">
						   <label for="note" class="col-sm-2 control-label">备&nbsp;&nbsp;&nbsp;&nbsp;注</label>
						    <div class="col-sm-10">
						      <textarea rows="3" id="note" cols="60">
						      		
						      </textarea>
						    </div>
						  </div>
						</form>
				    </div>
				    <div class="tab-pane fade" id="user">
				       
				    </div>
				</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="closebtu">关闭</button>
                <button type="button" class="btn btn-primary" id="addbtu">新增</button>
                <script type="text/javascript">
                	$(function(){
                		$("#addbtu").click(function(){
                			if($("#companyName").val()==""){
                				layer.msg("请输入供货商名称！", {time : 1500, icon : 5});
                			}else{
                				$.ajax({
							          type: "post",
							          url: "<%=basePath%>system/manager/addSupplier" ,
							          data :JSON.stringify({
											uid:storage.managerId,
											appId:1,
											companyName:$("#companyName").val(),
											companyAddress:$("#companyAddress").val(),
											zipCode:$("#zipCode").val(),
											phone:$("#phone").val(),
											companyFax:$("#fax").val(),
											duty:$("#duty").val(),
											bank:$("#bank").val(),
											account:$("#account").val(),
											website:$("#website").val(),
											email:$("#email").val(),
											note:$("#note").text(),
											rebate:$("#rebate").is(':checked')
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
                <button type="button" class="btn btn-primary" id="updatebtu">提交更改</button>
                <script type="text/javascript">
                	$(function(){
                		$("#add").click(function(){
                			$("#addbtu").show();
                			$("#updatebtu").hide();
                		});
                	});
                </script>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>