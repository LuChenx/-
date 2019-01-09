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
	var storage=window.sessionStorage;
				$(function(){
					$("#modal").hide();
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
						return '<a class="btn btn-info" onclick="editRole('+value+')"><i class="glyphicon glyphicon-pencil"></i></a><a style="margin-left:10px;" class="btn btn-danger" onclick="deleteRole('+value+')"><i class="glyphicon glyphicon-trash"></i></a>';
					};
					m.set('操作', formatter); 
					tableBuilder.setFormatter(m);
					
					//设置查询从参数，默认只有分页参数
					tableBuilder.setQueryJsonParam(function(params){
						 var param = {
									uid:storage.managerId,
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
						$("#rolename").val();
						$("#roledesc").val();
						$('#auth').treeview('uncheckAll');
						$('#priceauth').treeview('uncheckAll');
						$("#modal").click();
					});
				});
				
				//删除岗位信息
				function deleteRole(roleId){
					$.ajax({
				          type: "post",
				          url: "<%=basePath%>system/role/deleteConfig" ,
				          data :JSON.stringify({
								uid:storage.managerId,
								appId:1,
								roleId:roleId
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
				}
				//编辑岗位信息
				function editRole(roleId){
					$.ajax({
				          type: "post",
				          url: "<%=basePath%>system/role/configDetail" ,
				          data :JSON.stringify({
								uid:storage.managerId,
								appId:1,
								roleId:roleId
					 	  }),
					 	  contentType: 'application/json; charset=UTF-8',
					      dataType:'json',
				          success: function (result) {
				        	  if(result.rcode ==  "000000"){
				        		  
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
                   	 新增岗位
                </h4>
            </div>
            <div class="modal-body" style="height: 300px">
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
				<form role="form">
				<div id="myTabContent" class="tab-content">
				    <div class="tab-pane fade in active" id="basic">
				    	 <div class="form-group">
						    <label for="rolename">岗位名称：</label>
						    <input type="text" class="form-control" placeholder="岗位名称" id="rolename">
						  </div>
						   <div class="form-group">
						    <label for="roledesc">岗位说明：</label>
						    <input type="text" class="form-control" placeholder="岗位说明" id="roledesc">
						  </div>
				    </div>
				    <div class="tab-pane fade" id="auth">
				    	<script type="text/javascript">
				    		$(function(){
				    			getTree();
				    			function getTree() {
				    				$.ajax({
								          type: "post",
								          url: "<%=basePath%>system/role/authConfig" ,
								          data :JSON.stringify({
												uid:storage.managerId,
												appId:1
									 	  }),
									 	  contentType: 'application/json; charset=UTF-8',
									      dataType:'json',
								          success: function (result) {
									          if(result.rcode ==  "000000"){
									        	  var tree = [];
									        	  var mainnode = {text:"岗位权限"};
									        	  var nodes = result.nodes;
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
								        	  layer.msg("岗位权限配置获取失败！", {time : 1500, icon : 5});
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
				    <div class="tab-pane fade" id="priceauth">
				    	<script type="text/javascript">
				    		$(function(){
				    			getTree();
				    			function getTree() {
				    				$.ajax({
								          type: "post",
								          url: "<%=basePath%>system/role/priceAuthConfig" ,
								          data :JSON.stringify({
												uid:storage.managerId,
												appId:1
									 	  }),
									 	  contentType: 'application/json; charset=UTF-8',
									      dataType:'json',
								          success: function (result) {
									          if(result.rcode ==  "000000"){
									        	  var tree = [];
									        	  var mainnode = {text:"价格权限"};
									        	  var nodes = result.nodes;
									        	  mainnode.nodes = nodes;
									        	  tree.push(mainnode);
									        	  $('#priceauth').treeview({
									        		  data: tree,
									        		  showBorder:false,
									        		  showCheckbox:true,
									        		  onNodeChecked: function(event, node) { //选中节点
			        			                          var selectNodes = getChildNodeIdArr(node); //获取所有子节点
			        			                          if (selectNodes) { //子节点不为空，则选中所有子节点
			        			                              $('#priceauth').treeview('checkNode', [selectNodes, { silent: true }]);
			        			                          }
			        			                          var parentNode = $("#priceauth").treeview("getNode", node.parentId);
			        			                          setParentNodeCheck(node,$('#priceauth'));
			        			                      },
			        			                      onNodeUnchecked: function(event, node) { //取消选中节点
			        			                          var selectNodes = getChildNodeIdArr(node); //获取所有子节点
			        			                          if (selectNodes) { //子节点不为空，则取消选中所有子节点
			        			                              $('#priceauth').treeview('uncheckNode', [selectNodes, { silent: true }]);
			        			                          }
			        			                      }
									        	});  
									          }
									          else{
									        	  layer.msg(result.rmsg, {time : 1500, icon : 5});
										      }
								          },
								          error : function() {
								        	  layer.msg("价格权限配置获取失败！", {time : 1500, icon : 5});
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
                        data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" id="subtu">
                    		提交更改
                    		<script type="text/javascript">
                    			$(function(){
                    				$("#subtu").click(function(){
                    					//查选择的询岗位权限
                    					var auth = "";
                    					var autharray = $('#auth').treeview('getChecked');
                    					autharray.forEach(function(value,i){
                    						if(value.nodeId != 0 ){
                    							auth = auth + value.nodeId+",";
                    						}
                    					});
                    					//查询价格权限
                    					var priceauth = "";
                    					var priceautharray = $('#priceauth').treeview('getChecked');
                    					priceautharray.forEach(function(value,i){
                    						if(value.nodeId != 0 ){
                    							priceauth = priceauth + value.nodeId+",";
                    						}
                    					});
                    					if($("#rolename").val() == ""){
                    						layer.msg("请输入岗位名称", {time : 1500, icon : 5});
                    					}else if(auth == ""){
                    						layer.msg("请选择岗位权限", {time : 1500, icon : 5});
                    					}else if(priceauth == ""){
                    						layer.msg("请选择价格权限", {time : 1500, icon : 5});
                    					}else{
                    						saveRole(auth,priceauth);
                    					}
                    				});
                    				
                    				function saveRole(auth,priceauth){
                    					$.ajax({
  								          type: "post",
  								          url: "<%=basePath%>system/role/addconfig" ,
  								          data :JSON.stringify({
  												uid:storage.managerId,
  												appId:1,
  												roleName:$("#rolename").val(),
  												roleDesc:$("#roledesc").val(),
  												auth:auth,
  												priceAuth:priceauth
  									 	  }),
  									 	  contentType: 'application/json; charset=UTF-8',
  									      dataType:'json',
  								          success: function (result) {
  								        	if(result.rcode ==  "000000"){
  								        		layer.msg("操作成功", {time : 1500, icon : 1});
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
                    		</script>
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
</html>