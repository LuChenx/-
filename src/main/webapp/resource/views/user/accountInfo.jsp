<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../resource/common/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>账号信息</title>
<script src="<%=basePath%>resource/Bootstrap/js/bootstrap-treeview.js"></script>  
</head>
<body>
<script type="text/javascript">
var storage=window.sessionStorage;
layer.msg('此处仅限修改账号基本信息，相关权限请联系管理员进行修改！', {
    time: 20000, //20s后自动关闭
    offset:'rt',
    btn: ['明白了', '知道了', '哦']
}); 
queryUserBaseInfo();
function queryUserBaseInfo(){
	$.ajax({
	    type: "post",
	    url: "<%=basePath%>system/user/baseInfo" ,
	    data :JSON.stringify({
				uid:storage.managerId,
				appId:1,
				userId:storage.managerId
		  }),
		contentType: 'application/json; charset=UTF-8',
	    dataType:'json',
	    success: function (result) {
	      if(result.rcode ==  "000000"){
	    	    $("#account").val(result.account);
				$("#username").val(result.userName);
				$("#password").val(result.password);
				$("#userphone").val(result.userPhone);
				$("#uid").val(result.uid);
				storage.managerName = result.userName;
	  	  }else{
	  		  layer.msg(result.rmsg, {time : 1500, icon : 5});
	  	  }
	    },
	    error:function(){
	  	  layer.msg("网络异常", {time : 1500, icon : 5});
	    }
	});
	    
}
</script>
<ul id="myTab" class="nav nav-tabs">
					<li class="active">
						<a href="#basic" data-toggle="tab">基本信息</a>
					</li>
					<li><a href="#auth" data-toggle="tab">岗位权限</a>
					</li>
					<li id="areaauthtab" ><a href="#areaauth" data-toggle="tab">地区权限</a>
					</li>
					<li id="repertoryauthtab" ><a href="#repertoryauth" data-toggle="tab">仓库权限</a>
					</li>
					<li id="brandauthtab" ><a href="#brandauth" data-toggle="tab">品牌权限</a>
					</li>
				</ul>
				<br>
				<form class="form-horizontal" role="form">
				<div id="myTabContent" class="tab-content">
				    <div class="tab-pane fade in active" id="basic">
				    
				    	 <div class="form-group" style="width: 50%">
						    <label for="account" class="col-sm-2 control-label">用户名</label>
						   <div class="col-sm-10">
						    <input type="text" class="form-control" id="account" placeholder="请输入用户名">
						    <input type="hidden" class="form-control" id="uid">
						   </div>
						  </div>
						  
						  <div class="form-group" style="width: 50%">
						    <label for="password" class="col-sm-2 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
						     <div class="col-sm-10">
						    <input type="password" class="form-control" id="password" placeholder="请输入密码">
						  	</div>
						  </div>
						  
						  <div class="form-group" style="width: 50%">
						    <label for="username" class="col-sm-2 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;名</label>
						   <div class="col-sm-10">
						    <input type="text" class="form-control" id="username" placeholder="请输入姓名">
						   </div>
						  </div>
						  
						  <div class="form-group" style="width: 50%">
						    <label for="userphone" class="col-sm-2 control-label">手机号</label>
						     <div class="col-sm-10">
						    <input type="text" class="form-control" id="userphone" placeholder="请输入手机号">
						    </div>
						 </div>
						 
						 <button type="button" class="btn btn-default btn-sm" id="savebtu" style="margin-left: 35px"> 
          					<span class="glyphicon glyphicon-cloud-upload"></span> 保存修改
 						 </button>
					 <script type="text/javascript">
					 		$("#savebtu").click(function(){
					 			if($("#account").val() == ""){
									layer.msg("请输用户名", {time : 1500, icon : 5});
								}else if($("#password").val() == ""){
									layer.msg("请输入密码", {time : 1500, icon : 5});
								}else if($("#username").val() == ""){
									layer.msg("请输入用户姓名", {time : 1500, icon : 5});
								}else if($("#userphone").val() == ""){
									layer.msg("请输入用户联系电话", {time : 1500, icon : 5});
								}else{
									$.ajax({
								          type: "post",
								          url: "<%=basePath%>system/user/updateUserBaseInfo" ,
								          data :JSON.stringify({
												uid:storage.managerId,
												appId:1,
												account:$("#account").val(),
												password:$("#password").val(),
												userName:$("#username").val(),
												userPhone:$("#userphone").val(),
									 	  }),
									 	  contentType: 'application/json; charset=UTF-8',
									      dataType:'json',
								          success: function (result) {
								        	if(result.rcode ==  "000000"){
								        		layer.msg("操作成功", {time : 1500, icon : 1});
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
					 </script>
 
				    </div>
				    <div class="tab-pane fade" id="auth">
				    	<script type="text/javascript">
				    	    var roleIdList = [];
				    		$(function(){
				    			getTree();
				    			function getTree() {
				    				$.ajax({
								          type: "post",
								          url: "<%=basePath%>system/role/config" ,
								          data :JSON.stringify({
												uid:storage.managerId,
												appId:1,
												sortOrder:'asc'
									 	  }),
									 	  async: false,
									 	  contentType: 'application/json; charset=UTF-8',
									      dataType:'json',
								          success: function (result) {
									          if(result.rcode ==  "000000"){
									        	  var tree = [];
									        	  var mainnode = {text:"所属岗位"};
									        	  var rows = result.rows;
									        	  var nodes = [];
									        	  rows.forEach(function(value,index){
									        		  var node = {};
									        		  node.text = value.roleName;
									        		  roleIdList.push(value.id);
									        		  nodes.push(node);
									        	  });
									        	  mainnode.nodes = nodes;
									        	  tree.push(mainnode);
									        	  $('#auth').treeview({
									        		  data: tree,
									        		  showBorder:false,
									        		  showCheckbox:true
									        	  });  
									          }
									          else{
									        	  layer.msg(result.rmsg, {time : 1500, icon : 5});
										      }
								          },
								          error : function() {
								        	  layer.msg("岗位配置获取失败！", {time : 1500, icon : 5});
								          }
								      });
				    			}
				    		});
				    	</script>
				    </div>
				    <div class="tab-pane fade" id="areaauth">
				    	<script type="text/javascript">
				    	    var areaIdList = [];
				    		$(function(){
				    			getTree();
				    			function getTree() {
				    				$.ajax({
								          type: "post",
								          url: "<%=basePath%>system/role/areaConfig" ,
								          data :JSON.stringify({
												uid:storage.managerId,
												appId:1,
												sortOrder:'asc'
									 	  }),
									 	  async: false,
									 	  contentType: 'application/json; charset=UTF-8',
									      dataType:'json',
								          success: function (result) {
									          if(result.rcode ==  "000000"){
									        	  var tree = [];
									        	  var mainnode = {text:"地区列表"};
									        	  var rows = result.rows;
									        	  var nodes = [];
									        	  rows.forEach(function(value,index){
									        		  var node = {};
									        		  node.text = value.areaName;
									        		  areaIdList.push(value.id);
									        		  nodes.push(node);
									        	  });
									        	  mainnode.nodes = nodes;
									        	  tree.push(mainnode);
									        	  $('#areaauth').treeview({
									        		  data: tree,
									        		  showBorder:false,
									        		  showCheckbox:true
									        	});  
									          }
									          else{
									        	  layer.msg(result.rmsg, {time : 1500, icon : 5});
										      }
								          },
								          error : function() {
								        	  layer.msg("区域配置获取失败！", {time : 1500, icon : 5});
								          }
								      });
				    			}
				    		});
				    	</script>
				    </div>
				    
				    <div class="tab-pane fade" id="repertoryauth">
				    	<script type="text/javascript">
				    	    var repertoryIdList = [];
				    		$(function(){
				    			getTree();
				    			function getTree() {
				    				$.ajax({
								          type: "post",
								          url: "<%=basePath%>system/role/repertoryConfig" ,
								          data :JSON.stringify({
												uid:storage.managerId,
												appId:1,
												sortOrder:'asc'
									 	  }),
									 	  contentType: 'application/json; charset=UTF-8',
									      dataType:'json',
									      async: false,
								          success: function (result) {
									          if(result.rcode ==  "000000"){
									        	  var tree = [];
									        	  var mainnode = {text:"仓库列表"};
									        	  var rows = result.rows;
									        	  var nodes = [];
									        	  rows.forEach(function(value,index){
									        		  var node = {};
									        		  node.text = value.repertoryName;
									        		  repertoryIdList.push(value.id);
									        		  nodes.push(node);
									        	  });
									        	  mainnode.nodes = nodes;
									        	  tree.push(mainnode);
									        	  $('#repertoryauth').treeview({
									        		  data: tree,
									        		  showBorder:false,
									        		  showCheckbox:true
									        	});  
									          }
									          else{
									        	  layer.msg(result.rmsg, {time : 1500, icon : 5});
										      }
								          },
								          error : function() {
								        	  layer.msg("仓库配置获取失败！", {time : 1500, icon : 5});
								          }
								      });
				    			}
				    		});
				    	</script>
				    </div>
				    
				    <div class="tab-pane fade" id="brandauth">
				    	<script type="text/javascript">
				    	    var brandIdList = [];
				    		$(function(){
				    			getTree();
				    			function getTree() {
				    				$.ajax({
								          type: "post",
								          url: "<%=basePath%>system/role/brandConfig" ,
								          data :JSON.stringify({
												uid:storage.managerId,
												appId:1,
												sortOrder:'asc'
									 	  }),
									 	  contentType: 'application/json; charset=UTF-8',
									      dataType:'json',
									      async: false,
								          success: function (result) {
									          if(result.rcode ==  "000000"){
									        	  var tree = [];
									        	  var mainnode = {text:"品牌列表"};
									        	  var rows = result.rows;
									        	  var nodes = [];
									        	  rows.forEach(function(value,index){
									        		  var node = {};
									        		  node.text = value.brandName;
									        		  brandIdList.push(value.id);
									        		  nodes.push(node);
									        	  });
									        	  mainnode.nodes = nodes;
									        	  tree.push(mainnode);
									        	  $('#brandauth').treeview({
									        		  data: tree,
									        		  showBorder:false,
									        		  showCheckbox:true
									        	}); 
									        	getAuthList();
									          }
									          else{
									        	  layer.msg(result.rmsg, {time : 1500, icon : 5});
										      }
								          },
								          error : function() {
								        	  layer.msg("商品配置获取失败！", {time : 1500, icon : 5});
								          }
								      });
				    			}
				    		});
				    	</script>
				    </div>
				    
				</div>
				</form>
            </div>
            
<script type="text/javascript">
function getAuthList(){
	$.ajax({
	    type: "post",
	    url: "<%=basePath%>system/user/authList" ,
	    data :JSON.stringify({
				uid:storage.managerId,
				appId:1,
				userId:storage.managerId
		  }),
		contentType: 'application/json; charset=UTF-8',
		async: false,
	    dataType:'json',
	    success: function (result) {
	  	  if(result.rcode ==  "000000"){
	  		  var roles = result.roles;
	  		  var areas = result.areas;
	  		  var repertorys = result.repertorys;
	  		  var brands = result.brands;
	  		  roles.forEach(function(role,index){
	  			  roleIdList.forEach(function(r,index){
	  				  if(role.roleId == r){
	  					  $('#auth').treeview('checkNode',
		        					  [ index+1, { silent: true }
		        			  ]);
	  				  }
	  			  });
	  		  });
	  		
	  		
	  		  areas.forEach(function(area,index){
	  			  areaIdList.forEach(function(a,index){
	  				  if(area.areaId == a){
	  					  $('#areaauth').treeview('checkNode',
		        					  [ index+1, { silent: true }
		        			  ]);
	  				  }
	  			  });
	  		  });
	  		  
	  		
	  		  repertorys.forEach(function(repertory,index){
	  			  repertoryIdList.forEach(function(r,index){
	  				  if(repertory.repertoryId == r){
	  					  $('#repertoryauth').treeview('checkNode',
		        					  [ index+1, { silent: true }
		        			  ]);
	  				  }
	  			  });
	  		  });
	  		  
	  		
	  		  brands.forEach(function(brand,index){
	  			  brandIdList.forEach(function(b,index){
	  				  if(brand.brandId == b){
	  					  $('#brandauth').treeview('checkNode',
		        					  [ index+1, { silent: true }
		        			  ]);
	  				  }
	  			  });
	  		  });
	  		  
	  		 $("input[type='checkbox']").attr("disabled","disabled")
	  		
	  	  }else{
	  		  layer.msg(result.rmsg, {time : 1500, icon : 5});
	  	  }
	    },
	    error:function(){
	  	  layer.msg("网络异常", {time : 1500, icon : 5});
	    }
	});
}
</script>
</body>
</html>