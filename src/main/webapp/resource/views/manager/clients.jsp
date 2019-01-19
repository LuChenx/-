<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../resource/common/taglib_base.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户资料管理</title>
<script src="<%=basePath%>resource/Bootstrap/table/dist/extensions/export/bootstrap-table-export.min.js"></script>
<script src="<%=basePath%>resource/js/tableExport.min.js"></script>
</head>
<body>
<div id="toolbar" class="btn-group">
		<select class="form-control" id="searchArea" style="width: 150px;float: left;">
			<option value="0">全部区域</option>
		</select>
		<script type="text/javascript">
		var storage=window.sessionStorage;
		$(function(){
			$.ajax({
		          type: "post",
		          url: "<%=basePath%>system/role/areaConfig" ,
		          data :JSON.stringify({
		        	    uid:storage.managerId,
						appId:1,
						sortOrder:'ASC'//排序
			 	  }),
			 	  contentType: 'application/json; charset=UTF-8',
			      dataType:'json',
		          success: function (result) {
		        	  if(result.rcode ==  "000000"){
		        		  var rows = result.rows;
		        		  rows.forEach(function(area,index){
		        			  $("#searchArea").append('<option value="'+area.id+'">'+area.areaName+'</option>');
		        		  });
		        	  }else{
		        		  layer.msg(result.rmsg, {time : 1500, icon : 5});
		        	  }
		          },
		          error:function(){
		        	  layer.msg("网络异常", {time : 1500, icon : 5});
		          }
		     });
		});
		</script>
		<select class="form-control" id="clientType" style="width: 150px;float: left;margin-left: 5px">
			<option value="0">全部类型</option>
		</select>
		<script type="text/javascript">
		$(function(){
			$.ajax({
		          type: "post",
		          url: "<%=basePath%>system/config/querySystemConfig" ,
		          data :JSON.stringify({
		        	    uid:storage.managerId,
						appId:1,
						conifgType:3
			 	  }),
			 	  contentType: 'application/json; charset=UTF-8',
			      dataType:'json',
		          success: function (result) {
		        	  if(result.rcode ==  "000000"){
		        		  var options = result.options;
		        		  options.forEach(function(option,index){
		        			  $("#clientType").append('<option value="'+option.id+'">'+option.optionName+'</option>');
		        		  });
		        	  }else{
		        		  layer.msg(result.rmsg, {time : 1500, icon : 5});
		        	  }
		          },
		          error:function(){
		        	  layer.msg("网络异常", {time : 1500, icon : 5});
		          }
		     });
		});
		</script>
		<select class="form-control" id="searchTrain" style="width: 120px;float: left;margin-left: 5px">
			<option value="0">所有业务员</option>
		</select>
		<button type="button" class="btn btn-success btn-sm" id="refresh" style="margin-top: 2px;margin-left: 5px">
			<span class="glyphicon glyphicon-cloud-download"></span> 刷新
		</button>
		<button type="button" class="btn btn-primary btn-sm" id="add" style="margin-top: 2px;">
			<span class="glyphicon glyphicon-plus"></span> 添加
		</button>
		<button style="margin-top: 2px;" type="button" class="btn btn-info btn-sm" id="outexport" onClick ="$('#table').tableExport({ type: 'excel', escape: 'false' })">
			<span class="glyphicon glyphicon-export"></span> 导出
		</button>
		<button style="margin-top: 2px;" type="button" class="btn btn-warning btn-sm" id="upload">
			<span class="glyphicon glyphicon-import"></span> 导入
		</button>
		<script type="text/javascript">
		layer.tips('支持后缀为  xls 的Excel，若用此页面导出的xls文件做模板导入，请将文件另存一次。', '#upload', {
			  tips: [1, '#3595CC'],
			  time: 10000
		});
		</script>
</div>

<table id="table" class="table-responsive"
		style="word-break: keep-all; word-wrap: keep-all;">
</table>
<script type="text/javascript">
var $table;
InitMainTable();
//初始化bootstrap-table的内容
function InitMainTable () {
    //记录页面bootstrap-table全局变量$table，方便应用
    var queryUrl = "";
    $table = $('#table').bootstrapTable({
        url: queryUrl,                      //请求后台的URL（*）
        method: 'post',                      //请求方式（*）
        toolbar: '#toolbar',              //工具按钮用哪个容器
        paginationPreText: "上一页",
        paginationNextText: "下一页",
        dataType: 'json',
        contentType: 'application/json;charset=UTF-8',//这里我就加了个utf-8
        undefinedText: '-',
        striped: true,                      //是否显示行间隔色
        cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
        pagination: true,                   //是否显示分页（*）
        sortable: true,                     //是否启用排序
        sortOrder: "asc",                   //排序方式
        sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
        pageNumber: 1,                      //初始化加载第一页，默认第一页,并记录
        pageSize: 15,                     //每页的记录行数（*）
        pageList: [15, 25, 50, 100],        //可供选择的每页的行数（*）
        search: true,                      //是否显示表格搜索
        strictSearch: true,
        showColumns: true,                  //是否显示所有的列（选择显示的列）
        showRefresh: false,                  //是否显示刷新按钮
        minimumCountColumns: 2,             //最少允许的列数
        clickToSelect: true,                //是否启用点击选中行
        height: $(document).height(),                      //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
        cardView: false,                    //是否显示详细视图
        detailView: false,                  //是否显示父子表
        fixedColumns: true,
        fixedNumber:2,
        queryParamsType: 'limit', // undefined (这里是根据不同的参数，选择不同的查询的条件)	
        responseHandler: function (res) {//这里我查看源码的，在ajax请求成功后，发放数据之前可以对返回的数据进行处理，返回什么部分的数据，比如我的就需要进行整改的！
				return res;
		},
        //得到查询的参数
        queryParams : function (params) {
            //这里的键的名字和控制器的变量名必须一致，这边改动，控制器也需要改成一样的
            var temp = {
            		pageNo: params.offset,
    				pageSize: params.limit,
            		uid:storage.managerId,
					appId:1,
					sortOrder:params.order,//排序
			        sortName:params.sort//排序字段
            };
            return temp;
        },
        columns: [
			[{
				title: '',
				field: '',
				align: 'center',
				valign: 'middle',
				colspan: 1,
				rowspan: 2
			},{
				title: '操作',
				field: '',
				align: 'center',
				valign: 'middle',
				colspan: 1,
				rowspan: 2
			}, {
				title: '基本信息',
				field: '',
				align: 'center',
				valign: 'middle',
				colspan: 18,
				rowsapn: 1
			}, {
				title: '开票信息',
				field: '',
				align: 'center',
				valign: 'middle',
				colspan: 6,
				rowsapn: 1
			},{
				title: '操作员',
				field: '',
				align: 'center',
				valign: 'middle',
				colspan: 1,
				rowspan: 2
			},{
				title: '更新时间',
				field: '',
				align: 'center',
				valign: 'middle',
				colspan: 1,
				rowspan: 2
			}],
			[{
					field: 'title1', //列ID同时也是指定要显示的数据的ID   
					title: '客户类别',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				}, {
					field: 'title2', //列ID同时也是指定要显示的数据的ID   
					title: '地区名称',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				}, {
					field: 'title3', //列ID同时也是指定要显示的数据的ID   
					title: '客户编码',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				}, {
					field: 'title4', //列ID同时也是指定要显示的数据的ID   
					title: '客户名称',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true

				}, {
					field: 'title5', //列ID同时也是指定要显示的数据的ID   
					title: '享受价格',
					width: 100,
					align: 'right',
					valign: 'middle',
					sortable: true
				}, {
					field: 'title6', //列ID同时也是指定要显示的数据的ID   
					title: '授信方式',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title7', //列ID同时也是指定要显示的数据的ID   
					title: '授信额度',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title8', //列ID同时也是指定要显示的数据的ID   
					title: '已用额度',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '授信天数',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title8', //列ID同时也是指定要显示的数据的ID   
					title: '业务员',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '经营地址',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '姓名',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '邮编',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '电话',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '传真',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '计返利',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '打印单价',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '开票',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '发票抬头',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '税号',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '开户行',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '账号',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '地址',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				},
				{
					field: 'title9', //列ID同时也是指定要显示的数据的ID   
					title: '电话',
					width: 100,
					align: 'center',
					valign: 'middle',
					sortable: true
				}
			]
		],
		 onLoadSuccess: function(data){ //加载成功时执行
				layer.msg("数据加载成功", {time : 1000, icon : 1});
			},
			onLoadError: function(data){ //加载失败时执行
				layer.msg("加载数据失败", {time : 1500, icon : 5});
			},
			
		    showExport: false,              
		    exportDataType: "basic",              //basic', 'all', 'selected'.
		    exportOptions:{
		        fileName: '导出数据',              //文件名称设置  
		        worksheetName: 'Sheet1',          //表格工作区名称  
		        tableName: '数据表',  
		        excelstyles: ['background-color', 'color', 'font-size', 'font-weight']
		    }
    });
};
</script>
</body>
</html>