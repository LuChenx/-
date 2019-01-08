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
	<form class="form-inline" role="form" style="float: right;margin-right: 10px;margin-top: 10px">
		  <div class="form-group">
		    <label class="sr-only" for="searchinfo">名称</label>
		    <input type="text" class="form-control" id="searchinfo" placeholder="用户名、姓名、手机号">
		  </div>
		  <a href="#">
		  	<span class="glyphicon glyphicon-search" id="searchbtu"></span>
		  	<script type="text/javascript">
		  		$(function(){
		  			$("#searchbtu").click(function(){
						$("#table").bootstrapTable('refresh');
					});
		  		});
		  	</script>
		  </a>
	</form>
	<table id="table"></table>
	<script type="text/javascript">
				$(function(){
					$("#modal").hide();
					//数据来源
					var queryUrl = '<%=basePath%>system/user/list';
					//表头接收字段
					var filed = ['accountName','userName','userPhone','status','areaStatus','repertoryStatus','brandStatus','priceStatus','createTime','createTime','id'];
					//表头
					var titles = ['用户名','姓名','手机号','状态','不限地区','不限仓库','不限品牌','不限价格','添加时间','最后登录时间','操作'];
					var tableBuilder = new createBootstrapTable('#table',queryUrl,filed,titles);
					
					//设置表格列格式
					var m = new Map(); 
					//value:该列值，row：当前行，index:行号
					
					var formatter = function(value, row, index){
						return value;
					};
					m.set('用户名', formatter);
					
					var formatter1 = function(value, row, index){
						if(value){
							return '<a href="#"><span class="glyphicon glyphicon-check"></span></a>';
						}else {
							return '-';
						}
					};
					m.set('状态', formatter1);
					
					var formatter2 = function(value, row, index){
						if(value){
							return '<a href="#"><span class="glyphicon glyphicon-check"></span></a>';
						}else {
							return '-';
						}
					};
					m.set('不限地区', formatter2);
					
					var formatter3 = function(value, row, index){
						if(value){
							return '<a href="#"><span class="glyphicon glyphicon-check"></span></a>';
						}else {
							return '-';
						}
					};
					m.set('不限仓库', formatter3);
					
					var formatter4 = function(value, row, index){
						if(value){
							return '<a href="#"><span class="glyphicon glyphicon-check"></span></a>';
						}else {
							return '-';
						}
					};
					m.set('不限品牌', formatter4);
					
					var formatter5 = function(value, row, index){
						if(value){
							return '<a href="#"><span class="glyphicon glyphicon-check"></span></a>';
						}else {
							return '-';
						}
					};
					m.set('不限价格', formatter5);
					
					var formatter6 = function(value, row, index){
						return crtTimeFtt(value);
					};
					m.set('添加时间', formatter6);
					
					var formatter7 = function(value, row, index){
						return crtTimeFtt(value);
					};
					m.set('最后登录时间', formatter7);
					
					var formatter8 = function(value, row, index){
						var user = {};
						user.id = value;
						user.accountName = row.accountName;
						user.userName = row.userName;
						user.userPhone = row.userPhone;
						user.status = row.status;
						user.areaStatus = row.areaStatus;
						user.repertoryStatus = row.repertoryStatus;
						user.brandStatus = row.brandStatus;
						return '<a class="btn btn-info" onclick="editUser('+JSON.stringify(user).replace(/"/g, '&quot;')+')"><i class="glyphicon glyphicon-pencil"></i></a><a style="margin-left:10px;" class="btn btn-danger" onclick="deleteUser('+JSON.stringify(user).replace(/"/g, '&quot;')+')"><i class="glyphicon glyphicon-trash"></i></a>';
					};
					m.set('操作', formatter8); 
					tableBuilder.setFormatter(m);
					
					//设置查询从参数，默认只有分页参数
					tableBuilder.setQueryJsonParam(function(params){
						 var param = {
									uid:1,
									appId:1,
									searchInfo:$("#searchinfo").val()
						 }
						 return JSON.stringify(param);
					});
					
					//创建表格
					tableBuilder.create();
					
					$("#refresh").click(function(){
						$("#table").bootstrapTable('refresh');
					});
					
					$("#add").click(function(){
						$("#account").val("");
						$("#username").val("");
						$("#password").val("");
						$("#userphone").val("");
						$("#areaStatus").prop("checked",false);
						$("#repertoryStatus").prop("checked",false);
						$("#brandStatus").prop("checked",false);
						$('#auth').treeview('uncheckAll');
						$('#areaauth').treeview('uncheckAll');
						$('#repertoryauth').treeview('uncheckAll');
						$('#brandauth').treeview('uncheckAll');
						$("#repertoryauthtab").show();
						$("#areaauthtab").show();
						$("#brandauthtab").show();
						$("#modifiedbtu").hide();
		        		$("#subtu").show();
						$("#modal").click();
					});
				});
				
				//删除用户信息
				function deleteUser(user){
					layer.confirm('确定删除?', {icon: 3, title:'提示'}, function(index){
						$.ajax({
					          type: "post",
					          url: "<%=basePath%>system/user/deleteUser" ,
					          data :JSON.stringify({
									uid:1,
									appId:1,
									deleteUserId:user.id
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
					});
				}
				//编辑用户信息
				function editUser(user){
					$('#auth').treeview('uncheckAll');
					$('#areaauth').treeview('uncheckAll');
					$('#repertoryauth').treeview('uncheckAll');
					$('#brandauth').treeview('uncheckAll');
					$("#account").val(user.accountName);
					$("#username").val(user.userName);
					$("#password").val("");
					$("#userphone").val(user.userPhone);
					if(user.status){
						$("#status").val("1");
					}else{
						$("#status").val("0");
					}
					if(user.areaStatus){
						$("#areaStatus").prop("checked","checked");

						$("#areaauthtab").hide();
					}
					if(user.repertoryStatus){
						$("#repertoryStatus").prop("checked","checked");
						$("#repertoryauthtab").hide();
					}
					if(user.brandStatus){
						$("#brandStatus").prop("checked","checked");
						$("#brandauthtab").hide();
					}
					
					$("#modifiedbtu").show();
	        		$("#subtu").hide();
					$("#modal").click();
					
					$.ajax({
				          type: "post",
				          url: "<%=basePath%>system/user/authList" ,
				          data :JSON.stringify({
								uid:1,
								appId:1,
								userId:user.id
					 	  }),
					 	  contentType: 'application/json; charset=UTF-8',
					      dataType:'json',
				          success: function (result) {
				        	  if(result.rcode ==  "000000"){
				        		  var roles = result.roles;
				        		  var areas = result.areas;
				        		  var repertorys = result.repertorys;
				        		  var brands = result.brands;
				        		  roles.forEach(function(role,index){
				        			  roleIdList.forEach(function(r,index){
				        				  if(role.id == r){
				        					  $('#auth').treeview('checkNode',
						        					  [ index+1, { silent: true }
						        			  ]);
				        				  }
				        			  });
				        		  });
				        		  
				        		  areas.forEach(function(area,index){
				        			  areaIdList.forEach(function(a,index){
				        				  if(area.id == a){
				        					  $('#areaauth').treeview('checkNode',
						        					  [ index+1, { silent: true }
						        			  ]);
				        				  }
				        			  });
				        		  });
				        		  
				        		  repertorys.forEach(function(repertory,index){
				        			  repertoryIdList.forEach(function(r,index){
				        				  if(repertory.id == r){
				        					  $('#repertoryauth').treeview('checkNode',
						        					  [ index+1, { silent: true }
						        			  ]);
				        				  }
				        			  });
				        		  });
				        		  
				        		  brands.forEach(function(brand,index){
				        			  brandIdList.forEach(function(b,index){
				        				  if(brand.id == b){
				        					  $('#brandauth').treeview('checkNode',
						        					  [ index+1, { silent: true }
						        			  ]);
				        				  }
				        			  });
				        		  });
				        		  
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
                   	 编辑操作员
                </h4>
            </div>
            <div class="modal-body" >
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
				    
				    	 <div class="form-group">
						    <label for="account" class="col-sm-2 control-label">用户名</label>
						   <div class="col-sm-10">
						    <input type="text" class="form-control" id="account" placeholder="请输入用户名">
						   </div>
						  </div>
						  
						  <div class="form-group">
						    <label for="password" class="col-sm-2 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
						     <div class="col-sm-10">
						    <input type="password" class="form-control" id="password" placeholder="请输入密码">
						  	</div>
						  </div>
						  
						  <div class="form-group">
						    <label for="username" class="col-sm-2 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;名</label>
						   <div class="col-sm-10">
						    <input type="text" class="form-control" id="username" placeholder="请输入姓名">
						   </div>
						  </div>
						  
						  <div class="form-group">
						    <label for="userphone" class="col-sm-2 control-label">手机号</label>
						     <div class="col-sm-10">
						    <input type="text" class="form-control" id="userphone" placeholder="请输入手机号">
						    </div>
						 </div>
						 
						 <div class="form-group">
						    <label for="status" class="col-sm-2 control-label">状&nbsp;&nbsp;&nbsp;&nbsp;态</label>
						    <div class="col-sm-10">
							    <select class="form-control" id="status">
							      <option value="1">启用</option>
							      <option value="0">禁用</option>
							    </select>
						    </div>
						 </div>
						 
						 <div style="margin-left: 30px">
						   <div class="checkbox">
							    <label id="arealabel"><input type="checkbox" id="areaStatus">不限制地区权限</label>
							    <script type="text/javascript">
							    	$("#arealabel").click(function(){
							    		if($("#areaStatus").is(':checked')){
							    			$("#areaauthtab").hide();
							    		}else{
							    			$("#areaauthtab").show();
							    			$('#areaauth').treeview('uncheckAll');
							    		}
							    	});
							    </script>
							</div>
							<div class="checkbox">
							    <label id="repertorylabel"><input type="checkbox" id="repertoryStatus">不限制仓库权限</label>
							    <script type="text/javascript">
							    	$("#repertorylabel").click(function(){
							    		if($("#repertoryStatus").is(':checked')){
							    			$("#repertoryauthtab").hide();
							    		}else{
							    			$("#repertoryauthtab").show();
							    			$('#repertoryauth').treeview('uncheckAll');
							    		}
							    	});
							    </script>
							</div>
							<div class="checkbox">
							    <label id="brandlabel"><input type="checkbox" id="brandStatus">不限制品牌权限</label>
							    <script type="text/javascript">
							    	$("#brandlabel").click(function(){
							    		if($("#brandStatus").is(':checked')){
							    			$("#brandauthtab").hide();
							    		}else{
							    			$("#brandauthtab").show();
							    			$('#brandauth').treeview('uncheckAll');
							    		}
							    	});
							    </script>
							</div>
						</div>	
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
												uid:1,
												appId:1,
												sortOrder:'asc'
									 	  }),
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
									        		  showCheckbox:true,
									        		  onNodeChecked: function(event, node) { //选中节点
			        			                          var selectNodes = getChildNodeIdArr(node); //获取所有子节点
			        			                          if (selectNodes) { //子节点不为空，则选中所有子节点
			        			                              $('#auth').treeview('checkNode', [selectNodes, { silent: true }]);
			        			                          }
			        			                          var parentNode = $("#auth").treeview("getNode", node.parentId);
			        			                          setParentNodeCheck(node,$('#auth'));
			        			                      },
			        			                      onNodeUnchecked: function(event, node) { //取消选中节点
			        			                          var selectNodes = getChildNodeIdArr(node); //获取所有子节点
			        			                          if (selectNodes) { //子节点不为空，则取消选中所有子节点
			        			                              $('#auth').treeview('uncheckNode', [selectNodes, { silent: true }]);
			        			                          }
			        			                      }
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
				    		
				    		function getChildNodeIdArr(node) {
				                var ts = [];
				                if (node.nodes) {
				                    for (x in node.nodes) {
				                        ts.push(node.nodes[x].nodeId);
				                        if (node.nodes[x].nodes) {
				                            var getNodeDieDai = getChildNodeIdArr(node.nodes[x]);
				                            for (j in getNodeDieDai) {
				                                ts.push(getNodeDieDai[j]);
				                            }
				                        }
				                    }
				                } else {
				                    ts.push(node.nodeId);
				                }
				                return ts;
				            }

				            function setParentNodeCheck(node,tree) {
				                var parentNode = tree.treeview("getNode", node.parentId);
				                if (parentNode.nodes) {
				                    var checkedCount = 0;
				                    for (x in parentNode.nodes) {
				                        if (parentNode.nodes[x].state.checked) {
				                            checkedCount ++;
				                        } 
				                    }
				                    if (checkedCount === parentNode.nodes.length) {
				                    	tree.treeview("checkNode", parentNode.nodeId);
				                        setParentNodeCheck(parentNode,tree);
				                    }else{
				                    	tree.treeview("uncheckNode", parentNode.nodeId);
				                    }
				                }
				            }
				            
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
												uid:1,
												appId:1,
												sortOrder:'asc'
									 	  }),
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
									        		  showCheckbox:true,
									        		  onNodeChecked: function(event, node) { //选中节点
			        			                          var selectNodes = getChildNodeIdArr(node); //获取所有子节点
			        			                          if (selectNodes) { //子节点不为空，则选中所有子节点
			        			                              $('#areaauth').treeview('checkNode', [selectNodes, { silent: true }]);
			        			                          }
			        			                          var parentNode = $("#areaauth").treeview("getNode", node.parentId);
			        			                          setParentNodeCheck(node,$('#areaauth'));
			        			                          
			        			                          //根节点
			        			                          var rootNode = $("#areaauth").treeview("getNode", 0);
			        			                          if(rootNode.state.checked){
			        			                        	  $("#areaStatus").prop("checked","checked");
			        			                          }
			        			                      },
			        			                      onNodeUnchecked: function(event, node) { //取消选中节点
			        			                          var selectNodes = getChildNodeIdArr(node); //获取所有子节点
			        			                          if (selectNodes) { //子节点不为空，则取消选中所有子节点
			        			                              $('#areaauth').treeview('uncheckNode', [selectNodes, { silent: true }]);
			        			                          }
			        			                      }
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
												uid:1,
												appId:1,
												sortOrder:'asc'
									 	  }),
									 	  contentType: 'application/json; charset=UTF-8',
									      dataType:'json',
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
									        		  showCheckbox:true,
									        		  onNodeChecked: function(event, node) { //选中节点
			        			                          var selectNodes = getChildNodeIdArr(node); //获取所有子节点
			        			                          if (selectNodes) { //子节点不为空，则选中所有子节点
			        			                              $('#repertoryauth').treeview('checkNode', [selectNodes, { silent: true }]);
			        			                          }
			        			                          var parentNode = $("#repertoryauth").treeview("getNode", node.parentId);
			        			                          setParentNodeCheck(node,$('#repertoryauth'));
			        			                          
			        			                          //根节点
			        			                          var rootNode = $("#repertoryauth").treeview("getNode", 0);
			        			                          if(rootNode.state.checked){
			        			                        	  $("#repertoryStatus").prop("checked","checked");
			        			                          }
			        			                      },
			        			                      onNodeUnchecked: function(event, node) { //取消选中节点
			        			                          var selectNodes = getChildNodeIdArr(node); //获取所有子节点
			        			                          if (selectNodes) { //子节点不为空，则取消选中所有子节点
			        			                              $('#repertoryauth').treeview('uncheckNode', [selectNodes, { silent: true }]);
			        			                          }
			        			                      }
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
												uid:1,
												appId:1,
												sortOrder:'asc'
									 	  }),
									 	  contentType: 'application/json; charset=UTF-8',
									      dataType:'json',
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
									        		  showCheckbox:true,
									        		  onNodeChecked: function(event, node) { //选中节点
			        			                          var selectNodes = getChildNodeIdArr(node); //获取所有子节点
			        			                          if (selectNodes) { //子节点不为空，则选中所有子节点
			        			                              $('#brandauth').treeview('checkNode', [selectNodes, { silent: true }]);
			        			                          }
			        			                          var parentNode = $("#brandauth").treeview("getNode", node.parentId);
			        			                          setParentNodeCheck(node,$('#brandauth'));
			        			                          
			        			                          //根节点
			        			                          var rootNode = $("#brandauth").treeview("getNode", 0);
			        			                          if(rootNode.state.checked){
			        			                        	  $("#brandStatus").prop("checked","checked");
			        			                          }
			        			                      },
			        			                      onNodeUnchecked: function(event, node) { //取消选中节点
			        			                          var selectNodes = getChildNodeIdArr(node); //获取所有子节点
			        			                          if (selectNodes) { //子节点不为空，则取消选中所有子节点
			        			                              $('#brandauth').treeview('uncheckNode', [selectNodes, { silent: true }]);
			        			                          }
			        			                      }
									        	});  
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
            <div class="modal-footer">
                <button type="button" class="btn btn-default" 
                        data-dismiss="modal" id="closebtu">关闭
                </button>
                <button type="button" class="btn btn-primary" id="modifiedbtu">
                	提交更改
                	<script type="text/javascript">
                		$(function(){
                			$("#modifiedbtu").hide();
                		});
                	</script>
                </button>
                <button type="button" class="btn btn-primary" id="subtu">
                    		新增
                    		<script type="text/javascript">
                    			$(function(){
                    				$("#subtu").click(function(){
                    					//查选择的岗位权限
                    					var auth = "";
                    					var autharray = $('#auth').treeview('getChecked');
                    					autharray.forEach(function(value,i){
                    						if(value.nodeId != 0 ){
                    							auth = auth + roleIdList[value.nodeId-1]+",";
                    						}
                    					});
                    					//查询地区权限
                    					var areaauth = "";
                    					if($("#areaStatus").is(':checked')){
                    						areaIdList.forEach(function(value,i){
                    							areaauth = areaauth + areaIdList[i]+",";
                    						});
                    					}else{
	                    					var areaautharray = $('#areaauth').treeview('getChecked');
	                    					areaautharray.forEach(function(value,i){
	                    						if(value.nodeId != 0 ){
	                    							areaauth = areaauth + areaIdList[value.nodeId-1]+",";
	                    						}
	                    					});
                    					}
                    					
                    					//查询仓库权限
                    					var repertoryauth = "";
                    					if($("#repertoryStatus").is(':checked')){
                    						repertoryIdList.forEach(function(value,i){
                    							repertoryauth = repertoryauth + repertoryIdList[i]+",";
                    						});
                    					}else{
	                    					var repertoryautharray = $('#repertoryauth').treeview('getChecked');
	                    					repertoryautharray.forEach(function(value,i){
	                    						if(value.nodeId != 0 ){
	                    							repertoryauth = repertoryauth + repertoryIdList[value.nodeId-1]+",";
	                    						}
	                    					});
                    					}
                    					
                    					//查询仓库权限
                    					var brandauth = "";
                    					if($("#brandStatus").is(':checked')){
                    						brandIdList.forEach(function(value,i){
                    							brandauth = brandauth + brandIdList[i]+",";
                    						});
                    					}else{
	                    					var brandautharray = $('#brandauth').treeview('getChecked');
	                    					brandautharray.forEach(function(value,i){
	                    						if(value.nodeId != 0 ){
	                    							brandauth = brandauth + brandIdList[value.nodeId-1]+",";
	                    						}
	                    					});
                    					}
                    					
                    					var repertoryStatus = false;
                    					if($("#repertoryStatus").is(':checked')){
                    						repertoryStatus = true;
							    		}
                    					
                    					var areaStatus = false;
                    					if($("#areaStatus").is(':checked')){
                    						areaStatus = true;
							    		}
                    					
                    					var brandStatus = false;
                    					if($("#brandStatus").is(':checked')){
                    						brandStatus = true;
							    		}
                    					
                    					if($("#account").val() == ""){
                    						layer.msg("请输用户名", {time : 1500, icon : 5});
                    					}else if($("#password").val() == ""){
                    						layer.msg("请输入密码", {time : 1500, icon : 5});
                    					}else if($("#username").val() == ""){
                    						layer.msg("请输入用户姓名", {time : 1500, icon : 5});
                    					}else if($("#userphone").val() == ""){
                    						layer.msg("请输入用户联系电话", {time : 1500, icon : 5});
                    					}else if(auth == ""){
                    						layer.msg("请选择用户岗位权限", {time : 1500, icon : 5});
                    					}else if(areaauth == ""){
                    						layer.msg("请选择用户地区权限", {time : 1500, icon : 5});
                    					}else if(repertoryauth == ""){
                    						layer.msg("请选择用户仓库权限", {time : 1500, icon : 5});
                    					}else if(brandauth == ""){
                    						layer.msg("请选择用户品牌权限", {time : 1500, icon : 5});
                    					}else{
                    						var status = true;
                    						if($("#status").val()==0){
                    							var status = false;
                    						}
                    						$.ajax({
        								          type: "post",
        								          url: "<%=basePath%>system/user/addUser" ,
        								          data :JSON.stringify({
        												uid:1,
        												appId:1,
        												account:$("#account").val(),
        												password:$("#password").val(),
        												userName:$("#username").val(),
        												userPhone:$("#userphone").val(),
        												status:status,
        												auth:auth,
        												areaStatus:areaStatus,
        												areaAuth:areaauth,
        												repertoryStatus:repertoryStatus,
        												repertoryAuth:repertoryauth,
        												brandStatus:brandStatus,
        												brandAuth:brandauth
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
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
</html>