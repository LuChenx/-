<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../resource/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>供货单位</title>
<script src="<%=basePath%>resource/Layui/laydate/laydate.js"></script>
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
	<table id="table" class="table-responsive"
		style="word-break: keep-all; word-wrap: keep-all;"></table>
	<script type="text/javascript">
	var storage=window.sessionStorage;
	$(function(){
		//数据来源
		var queryUrl = '<%=basePath%>system/manager/supplierList';
		//表头接收字段
		var filed = ['','companyName','companyAddress','zipCode','companyPhone','companyFax','dutyParagraph','openingBank','companyAccount','companyWebsite','companyEmail','isRebate','companyDesc','managerId','modifiedTime','id'];
		//表头
		var titles = ['','单位名称','地址','邮编','电话','传真','税号','开户行','账号','网址','邮件','是否返利','备注','操作员','最近更新时间','操作'];
		var tableBuilder = new createBootstrapTable('#table',queryUrl,filed,titles);
		
		//设置表格列格式
		var m = new Map(); 
		//value:该列值，row：当前行，index:行号
		var formatter = function(value, row, index){
			return '<div style="display: flex;"><a class="btn btn-info" onclick="editSupplier('+JSON.stringify(row).replace(/"/g, '&quot;')+')"><i class="glyphicon glyphicon-pencil"></i></a><a style="margin-left:10px;" class="btn btn-danger" onclick="deleteSupplier('+value+')"><i class="glyphicon glyphicon-trash"></i></a><div>';
		};
		
		var formatter2 = function(value, row, index){
			if(value){
				return '<a href="#"><span class="glyphicon glyphicon-check"></span></a>';
			}
		};
		
		var formatter3 = function(value, row, index){
			return crtTimeFtt(value);
		};
		
		m.set('操作', formatter);
		m.set('是否返利', formatter2); 
		m.set('最近更新时间', formatter3);
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
		
		tableBuilder.setFixedColumns(true);
		
		tableBuilder.onlyInfoPagination(true);
		//创建表格
		tableBuilder.create();
		
		$("#refresh").click(function(){
			$("#table").bootstrapTable('refresh');
		});
	});
	
	function editSupplier(supplier){
		document.getElementById("companyBaseForm").reset();
		$("#companyId").val(supplier.id);
		$("#companyName").val(supplier.companyName);
		$("#zipCode").val(supplier.zipCode);
		$("#companyAddress").val(supplier.companyAddress);
		$("#phone").val(supplier.companyPhone);
		$("#fax").val(supplier.companyFax);
		$("#duty").val(supplier.dutyParagraph);
		$("#bank").val(supplier.openingBank);
		$("#account").val(supplier.companyAccount);
		$("#website").val(supplier.companyWebsite);
		$("#email").val(supplier.companyEmail);
		$("#rebate").prop("checked",supplier.isRebate);
		$("#note").text(supplier.companyDesc);
		$("#tabuser").show();
		$("#addbtu").hide();
		$("#updatebtu").show();
		//创建表格
		$("#usertable").bootstrapTable('refresh');
		$("#modalbtu").click();
	}
	</script>
	<!-- 按钮触发模态框 -->
	<button class="btn btn-primary btn-lg" data-toggle="modal"
		data-target="#myModal" id="modalbtu"></button>
	<script type="text/javascript">
$(function(){
	$("#modalbtu").hide();
	$("#add").click(function(){
		document.getElementById("companyBaseForm").reset();
		$("#note").text("");
		$('#myTab a:first').tab('show');
		$("#modalbtu").click();
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
					<h4 class="modal-title" id="myModalLabel">编辑供货单位</h4>
				</div>
				<div class="modal-body">
					<ul id="myTab" class="nav nav-tabs">
						<li class="active"><a href="#baseinfo" data-toggle="tab">基本信息</a>
						</li>
						<li><a href="#user" data-toggle="tab" id="tabuser">联系人</a> <script
								type="text/javascript">
						$(function(){
							$("#add").click(function(){
								// 选取第一个标签页
								$('#myTab a:first').tab('show');
								$("#tabuser").hide();
							});
						});
						</script></li>
					</ul>
					<div id="myTabContent" class="tab-content">
						<div class="tab-pane fade in active" id="baseinfo">
							<form class="form-horizontal" role="form" id="companyBaseForm">
								<div class="form-group" style="margin-top: 10px">
									<label for="companyName" class="col-sm-2 control-label">名&nbsp;&nbsp;&nbsp;&nbsp;称</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="companyName"
											placeholder="请输入单位名称"> <input type="hidden"
											id="companyId">
									</div>
								</div>
								<div class="form-group">
									<label for="companyAddress" class="col-sm-2 control-label">地&nbsp;&nbsp;&nbsp;&nbsp;址</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="companyAddress"
											placeholder="请输入单位地址">
									</div>
								</div>
								<div class="form-group">
									<label for="zipCode" class="col-sm-2 control-label">邮&nbsp;&nbsp;&nbsp;&nbsp;编</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="zipCode"
											placeholder="请输入单位邮编">
									</div>
								</div>
								<div class="form-group">
									<label for="phone" class="col-sm-2 control-label">电&nbsp;&nbsp;&nbsp;&nbsp;话</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="phone"
											placeholder="请输入联系电话">
									</div>
								</div>
								<div class="form-group">
									<label for="fax" class="col-sm-2 control-label">传&nbsp;&nbsp;&nbsp;&nbsp;真</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="fax"
											placeholder="请输入传真">
									</div>
								</div>
								<div class="form-group">
									<label for="duty" class="col-sm-2 control-label">税&nbsp;&nbsp;&nbsp;&nbsp;号</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="duty"
											placeholder="请输入税号">
									</div>
								</div>
								<div class="form-group">
									<label for="bank" class="col-sm-2 control-label">开户行</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="bank"
											placeholder="请输入开户行">
									</div>
								</div>
								<div class="form-group">
									<label for="account" class="col-sm-2 control-label">账&nbsp;&nbsp;&nbsp;&nbsp;号</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="account"
											placeholder="请输入账号">
									</div>
								</div>
								<div class="form-group">
									<label for="website" class="col-sm-2 control-label">网&nbsp;&nbsp;&nbsp;&nbsp;址</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="website"
											placeholder="请输入网址">
									</div>
								</div>
								<div class="form-group">
									<label for="email" class="col-sm-2 control-label">邮&nbsp;&nbsp;&nbsp;&nbsp;箱</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="email"
											placeholder="请输入邮箱">
									</div>
								</div>
								<div class="form-group">
									<label for="email" class="col-sm-2 control-label">选&nbsp;&nbsp;&nbsp;&nbsp;项</label>
									<div class="col-sm-10">
										<label class="checkbox-inline"> <input type="checkbox"
											id="rebate"> 计返利
										</label>
									</div>
								</div>
								<div class="form-group">
									<label for="note" class="col-sm-2 control-label">备&nbsp;&nbsp;&nbsp;&nbsp;注</label>
									<div class="col-sm-10">
										<textarea rows="3" id="note" cols="62">
						                </textarea>
									</div>
								</div>
							</form>
						</div>
						<div class="tab-pane fade" id="user">
							<div id="usertoolbar" class="btn-group">
								<button type="button" class="btn btn-primary btn-sm" id="adduser">
									<span class="glyphicon glyphicon-plus"></span> 添加
								</button>
							</div>
							<table id="usertable" class="table-responsive"
								style="word-break: keep-all; word-wrap: keep-all;">
							</table>
							<script type="text/javascript">
							    var userTableBuilder;
								$(function(){
									//数据来源
									var queryUrl = '<%=basePath%>system/manager/supplierUserList';
									//表头接收字段
									var filed = ['','userName','userSex','birthday','apartment','role','phone','fax','mobilePhone','wechat','userEmail','experience','hobby','managerId','modifiedTime','id'];
									//表头
									var titles = ['','姓名','性别','生日','部门','职务','电话','传真','手机','微信','邮箱','经历','爱好','操作员','最近更新时间','操作'];
									userTableBuilder = new createBootstrapTable('#usertable',queryUrl,filed,titles);
									
									//设置表格列格式
									var m = new Map(); 
									//value:该列值，row：当前行，index:行号
									var formatter = function(value, row, index){
										return '<div style="display: flex;"><a class="btn btn-info" onclick="editUser('+JSON.stringify(row).replace(/"/g, '&quot;')+')"><i class="glyphicon glyphicon-pencil"></i></a><a style="margin-left:10px;" class="btn btn-danger" onclick="deleteUser('+value+')"><i class="glyphicon glyphicon-trash"></i></a><div>';
									};
									
									var formatter2 = function(value, row, index){
										return crtTimeFtt(value);
									};
									
									var formatter3 = function(value, row, index){
										return crtShortTimeFtt(value);
									};
									
									var formatter4= function(value, row, index){
										var sex = "男";
										if(value == 2){
											var sex = "女";
										}
										return sex;
									};
									
									m.set('操作', formatter);
									m.set('最近更新时间', formatter2);
									m.set('生日', formatter3);
									m.set('性别', formatter4);
									userTableBuilder.setFormatter(m);
									
									//设置查询从参数，默认只有分页参数
									userTableBuilder.setQueryJsonParam(function(params){
										 var param = {
													uid:storage.managerId,
													appId:1,
													sortOrder:params.order,//排序
											        sortName:params.sort,//排序字段
											        companyId:$("#companyId").val()
										 }
										 return JSON.stringify(param);
									});
									
									userTableBuilder.setHeight(330);
									
									userTableBuilder.setToolbar("#usertoolbar");
									
									userTableBuilder.setSortName(["userName"]);
									
									userTableBuilder.setFixedColumns(true);
									
									userTableBuilder.onlyInfoPagination(true);
									
									userTableBuilder.create();
								});
							</script>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						id="closebtu">关闭</button>
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
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	
	
	<!-- 添加联系人模态框 -->
	<!-- 按钮触发模态框 -->
	<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#userModal" id="userModalBtu"></button>
		<script type="text/javascript">
		$(function(){
			$("#userModalBtu").hide();
		});
		</script>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" id="myModalLabel">编辑供应商联系人</h4>
	            </div>
	            <div class="modal-body">
	            	<form class="form-horizontal" role="form">
					   <div class="form-group">
						    <label for="firstname" class="col-sm-2 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;名</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="firstname" placeholder="请输入姓名">
						    </div>
					    </div>
					    <div class="form-group">
						    <label for="usersex" class="col-sm-2 control-label">性&nbsp;&nbsp;&nbsp;&nbsp;别</label>
						    <div class="col-sm-10">
						       <select class="form-control" id="usersex">
							      <option value="1">男</option>
							      <option value="2">女</option>
							    </select>
						    </div>
					    </div>
					    <div class="form-group">
						    <label for="usersex" class="col-sm-2 control-label">生&nbsp;&nbsp;&nbsp;&nbsp;日</label>
						    <div class="col-sm-10">
						       <input type="text" class="form-control" id="birthday" placeholder="选择生日">
						       <script type="text/javascript">
						       $(function(){
						    	   laydate.render({
							    	     elem: '#birthday'
							    	});
						       });
						       </script>
						    </div>
					    </div>
					    <div class="form-group">
						    <label for="apartment" class="col-sm-2 control-label">部&nbsp;&nbsp;&nbsp;&nbsp;门</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="apartment" placeholder="请输入部门">
						    </div>
					     </div>
					     <div class="form-group">
						    <label for="role" class="col-sm-2 control-label">职&nbsp;&nbsp;&nbsp;&nbsp;务</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="role" placeholder="请输入职务">
						    </div>
					     </div>
					     <div class="form-group">
						    <label for="userphone" class="col-sm-2 control-label">电&nbsp;&nbsp;&nbsp;&nbsp;话</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="userphone" placeholder="请输入电话">
						    </div>
					     </div>
					     <div class="form-group">
						    <label for="userfax" class="col-sm-2 control-label">传&nbsp;&nbsp;&nbsp;&nbsp;真</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="userfax" placeholder="请输入传真">
						    </div>
					     </div>
					     <div class="form-group">
						    <label for="mobile" class="col-sm-2 control-label">手&nbsp;&nbsp;&nbsp;&nbsp;机</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="mobile" placeholder="请输入手机">
						    </div>
					     </div>
					      <div class="form-group">
						    <label for="wechat" class="col-sm-2 control-label">微&nbsp;&nbsp;&nbsp;&nbsp;信</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="wechat" placeholder="请输入微信">
						    </div>
					     </div>
					     <div class="form-group">
						    <label for="useremail" class="col-sm-2 control-label">邮&nbsp;&nbsp;&nbsp;&nbsp;箱</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="useremail" placeholder="请输入邮箱">
						    </div>
					     </div>
					     <div class="form-group">
						    <label for="exprice" class="col-sm-2 control-label">经&nbsp;&nbsp;&nbsp;&nbsp;历</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="exprice" placeholder="请输入经历">
						    </div>
					     </div>
					     <div class="form-group">
						    <label for="hobby" class="col-sm-2 control-label">爱&nbsp;&nbsp;&nbsp;&nbsp;好</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" id="hobby" placeholder="请输入爱好">
						    </div>
					     </div>
					     <div class="form-group">
						    <label class="col-sm-2 control-label">备&nbsp;&nbsp;&nbsp;&nbsp;注</label>
						    <div class="col-sm-10">
						      <textarea rows="3" cols="60" id="usernote">
					     	  </textarea>
						    </div>
					     </div>
					</form>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal" id="userModalClose">关闭</button>
	                <button type="button" class="btn btn-primary" id="userModalAdd">新增</button>
	                <button type="button" class="btn btn-primary" id="userModalUpdate">提交更改</button>
	                <script type="text/javascript">
                	$(function(){
                		$("#adduser").click(function(){
                			$("#userModalAdd").show();
                			$("#userModalUpdate").hide();
                			$("#userModalBtu").click();
                		});
                		
                		$("#userModalAdd").click(function(){
                			if($("#firstname").val()==""){
                				layer.msg("请输入联系人姓名", {time : 1500, icon : 5});
                			}else{
                				$.ajax({
							          type: "post",
							          url: "<%=basePath%>system/manager/addSupplierUser" ,
							          data :JSON.stringify({
											uid:storage.managerId,
											appId:1,
											companyId:$("#companyId").val(),
											userName:$("#firstname").val(),
											userSex:$("#usersex").val(),
											birthday:$("#birthday").val(),
											apartment:$("#apartment").val(),
											role:$("#role").val(),
											userphone:$("#userphone").val(),
											userfax:$("#userfax").val(),
											mobile:$("#mobile").val(),
											wechat:$("#wechat").val(),
											useremail:$("#useremail").val(),
											hobby:$("#hobby").val(),
											exprice:$("#exprice").val(),
											note:$("#usernote").text()
								 	  }),
								 	  contentType: 'application/json; charset=UTF-8',
								      dataType:'json',
							          success: function (result) {
							        	if(result.rcode ==  "000000"){
							        		layer.msg("操作成功", {time : 1500, icon : 1});
							        		$("#userModalClose").click();
							        		$("#usertable").bootstrapTable('refresh');
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