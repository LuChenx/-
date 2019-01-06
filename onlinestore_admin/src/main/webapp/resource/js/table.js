/**
 * 定制化表格
 */
(function () {  
    function init(table,url,params,titles,formatter,cellStyle,hasCheckbox,sef,search,columns,showHeader,btnExportId,devaultSize,pageSize,queryJsonParam,pagination,sidePagination,onlyInfoPagination,sortName) {  
    	var h = $(document).height();
        $(table).bootstrapTable('destroy').bootstrapTable({  
            url: url,                           //请求后台的URL（*）  
            method: 'POST',                     //请求方式（*）  
            pagination: pagination,                   //是否显示分页（*）  
            onlyInfoPagination:onlyInfoPagination,
            queryParams: queryJsonParam,           //传递参数（*），这里应该返回一个object，即形如{param1:val1,param2:val2}  
            sidePagination: sidePagination,           //分页方式：client客户端分页，server服务端分页（*）  
            pageNumber:1,                       //初始化加载第一页，默认第一页  
            height:h,
            pageSize: devaultSize,                       //每页的记录行数（*）  
            pageList: pageSize,            //可供选择的每页的行数（*）  
            paginationPreText: "上一页",
            paginationNextText: "下一页",
            undefinedText: '-',
            striped: true,                      //是否显示行间隔色  
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）  
            sortable: true,                    //是否启用排序  
            sortName: sortName[0],
            sortOrder: "asc",                   //排序方式  
            search: search,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大  
            strictSearch: true,  
            showColumns: false,                  //是否显示所有的列  
            showHeader: showHeader,              //是否显示列头。 
            showRefresh: false,                  //是否显示刷新按钮  
            minimumCountColumns: 2,             //最少允许的列数  
            clickToSelect: true,                //是否启用点击选中行  
            dataType: 'json',
            contentType: 'application/json;charset=UTF-8',//这里我就加了个utf-8
            showToggle:false,                    //是否显示详细视图和列表视图的切换按钮  
            cardView: false,                    //是否显示详细视图  
            detailView: false,                  //是否显示父子表  
            toolbar: '#toolbar',                   //工具按钮用哪个容器  
            rowStyle:rowStyle,
			queryParamsType: 'limit', // undefined (这里是根据不同的参数，选择不同的查询的条件)		    
			responseHandler: function (res) {//这里我查看源码的，在ajax请求成功后，发放数据之前可以对返回的数据进行处理，返回什么部分的数据，比如我的就需要进行整改的！
				return res;
			},
            columns: createCols(params,titles,formatter,cellStyle,hasCheckbox,sef,sortName),  
            onLoadSuccess: function(data){ //加载成功时执行
				layer.msg("数据加载成功", {time : 1000, icon : 1});
			},
			onLoadError: function(data){ //加载失败时执行
				layer.msg("加载数据失败", {time : 1500, icon : 5});
			},
			
		    showExport: false,              //是否显示导出按钮(此方法是自己写的目的是判断终端是电脑还是手机,电脑则返回true,手机返回falsee,手机不显示按钮)
		    exportDataType: "all",              //basic', 'all', 'selected'.
		    exportTypes:['xlsx'],	    //导出类型['json', 'xml', 'csv', 'txt', 'sql',  'xlsx', 'excel'],若想要绑定自己的按钮的话数组第一个为导出类型，默认xlsx
		    exportButton: $(btnExportId),     //为按钮btn_export  绑定导出事件  自定义导出按钮(可以不用)
		    exportOptions:{
		        fileName: '导出数据',              //文件名称设置  
		        worksheetName: 'Sheet1',          //表格工作区名称  
		        tableName: '数据表',  
		        excelstyles: ['background-color', 'color', 'font-size', 'font-weight']
		    }
        }); 

    }  
    function createCols(params,titles,formatter,cellStyle,hasCheckbox,sef,sortName) {  
        if(params.length!=titles.length)  
            return null;  
        var arr = [];  
        if(sef){
        	var arr2 = [];  
        	var title1 ={};
        	title1.title="TITLE";
        	title1.align="center";
        	title1.colspan=params.length;
        	title1.rowspan=1;
        	arr2.push(title1);  
        	arr.push(arr2);
        	
        	var arr3 = []; 
        	var title2 ={};
        	title2.field=params[0];
        	title2.title=titles[0];
        	title2.align="center";
        	title2.valign="middle";
        	title2.colspan=1;
        	title2.rowspan=2;
        	arr3.push(title2);  
        	
        	
        	var title3 ={};
        	title3.title=titles[1];
        	title3.align="center";
        	title3.colspan=2;
        	title3.rowspan=1;
        	arr3.push(title3);  
        
        	var title4 ={};
        	title4.title=titles[2];
        	title4.align="center";
        	title4.colspan=2;
        	title4.rowspan=1;
        	arr3.push(title4);  
        	arr.push(arr3);
        	
        	var arr4 = []; 
        	var title5 ={};
        	title5.field=params[3];
        	title5.title=titles[3];
        	title5.align="center";
        	title5.colspan=1;
        	title5.rowspan=1;
        	arr4.push(title5);  
        	
        	var title6 ={};
        	title6.field=params[4];
        	title6.title=titles[4];
        	title6.align="center";
        	title6.colspan=1;
        	title6.rowspan=1;
        	arr4.push(title6); 
        	
            var title7 ={};
        	title7.field=params[3];
        	title7.title=titles[3];
        	title7.align="center";
        	title7.colspan=1;
        	title7.rowspan=1;
        	arr4.push(title7);  
        	
        	var title8 ={};
        	title8.field=params[4];
        	title8.title=titles[4];
        	title8.align="center";
        	title8.colspan=1;
        	title8.rowspan=1;
        	arr4.push(title8); 
        	arr.push(arr4);
        	return arr;
    	}
    	if(hasCheckbox)  
        {  
            var objc = {};  
            objc.checkbox = true;  
            arr.push(objc);  
        }  
        for(var i = 0;i<params.length;i++)  
        {  
            var obj = {};  
            obj.field = params[i];  
            obj.title = titles[i];  
            obj.align="center";
            obj.valign="middle";
            obj.formatter=formatter[i];
            if(cellStyle!=null){
            	obj.cellStyle=cellStyle[i];
            }
            for(var k = 0;k<sortName.length;k++){
            	if(obj.field == sortName[k]){
            		obj.sortable = true;
            	}
            }
           // obj.searchable=true;
            arr.push(obj);  
        }  
        return arr;  
    }  
    //可发送给服务端的参数：limit->pageSize,offset->pageNumber,search->searchText,sort->sortName(字段),order->sortOrder('asc'或'desc')  
    function queryParams(params) {  
        var param = {
				//这里是在ajax发送请求的时候设置一些参数 params有什么东西，自己看看源码就知道了
				pageOffset: params.offset,
				pageSize: params.limit
		}
		return JSON.stringify(param);
    }
    
	 function rowStyle(row, index) {
			    var classes = ['success', 'info'];
			    if (index % 2 === 0) {//偶数行
			        return { classes: classes[0]};
			    } else {//奇数行
			        return {classes: classes[1]};
			    }
	}

	var formatterSimple = function(value, row, index){
				return value;
	};
	var formatterIndex = function(value, row, index){
				return index +1;
	};
	var cellStyleSimple = function(value, row, index){
				return "";
	};
    // 传'#table'  
//    createBootstrapTable = function (table,url,params,titles,formatter,cellStyle,hasCheckbox,sef,search,columns,showHeader) {
      createBootstrapTable = function (table,url,params,titles) {
      	
      	this.formatter = [formatterIndex];
      	var formatterArr = this.formatter;
      	$.each(titles,function(index,value){
        	formatterArr.push(formatterSimple);
    	});
    	
      	this.queryJsonParam = queryParams;
      	
    	this.cellStyle = [];
    	var cellStyleArr = this.cellStyle;
      	$.each(titles,function(index,value){
        	cellStyleArr.push(cellStyleSimple);
    	});
    	
    	this.hasCheckbox = false;
    	this.sortName=[];
    	this.sef = false;
    	this.sidePagination = "server";
    	this.search = false;
    	this.columns = false;
    	this.showHeader = true;
    	this.pagination = true;
    	this.onlyInfoPagination = false;
    	this.btnExportId = '';
    	this.pageSize = [5, 10, 15, 20 ,50, 'All'];
    	this.devaultSize = 10;
    	this.formatter = formatterArr;
    	this.cellStyle = cellStyleArr;
    	
    	this.setFormatter = function(param){
    		param.forEach(function (value, key, map) {
    			var til = key;
    			var tilformatter = value;
    			$.each(titles,function(index,value){
        			if(til == value){
        				formatterArr[index] = tilformatter;
        			}
    			});
			});
			this.formatter = formatterArr;
			return this;
    	}
    	
    	this.setCellStyle = function(param){
    		param.forEach(function (value, key, map) {
    			var til = key;
    			var tilcellStyle = value;
    			$.each(titles,function(index,value){
        			if(til == value){
        				cellStyleArr[index] = tilcellStyle;
        			}
    			});
			});
			this.cellStyle = cellStyleArr;
			return this;
    	}
    	
    	
    	this.setSidePagination = function(param){
    		this.sidePagination = param;
    		return this;
    	}
    	
    	this.setSortName = function(param){
    		this.sortName = param;
    		return this;
    	}
    	
    	this.setQueryJsonParam = function(param){
    		this.queryJsonParam = param;
    		return this;
    	}
    	
    	this.setPagination = function(param){
    		this.pagination = param;
    		return this;
    	}
    	
    	this.onlyInfoPagination = function(param){
    		this.onlyInfoPagination = param;
    		return this;
    	}
    	
    	this.setHasCheckbox = function (param) {
    		this.hasCheckbox = param;
    		return this;
    	} 
    	this.setSef = function (param) {
    		this.sef = param;
    		return this;
    	} 
    	this.setSearch = function (param) {
    		this.search = param;
    		return this;
    	} 
    	this.setColumns = function (param) {
    		this.columns = param;
    		return this;
    	} 
    	this.setShowHeader = function (param) {
    		this.showHeader = param;
    		return this;
    	}
    	this.setBtnExportId = function (param) {
    		this.btnExportId = param;
    		return this;
    	}
    	this.setPageSize = function (pageSize,devaultSize) {
    		this.pageSize = pageSize;
    		this.devaultSize = devaultSize;
    		return this;
    	} 
    	this.create = function () {
    		init(table,url,params,titles,this.formatter,this.cellStyle,this.hasCheckbox,this.sef,this.search,this.columns,this.showHeader,this.btnExportId,this.devaultSize,this.pageSize,this.queryJsonParam,this.pagination,this.sidePagination,this.onlyInfoPagination,this.sortName); 
    		//设置表头颜色
		//	$("#table thead").css("background","linear-gradient(180deg, rgba(166, 221, 242, 1) 0%, rgba(166, 221, 242, 1) 0%, rgba(78, 175, 252, 1) 99%, rgba(78, 175, 252, 1) 100%)");
    	}
//    	init(table,url,params,titles,formatter,cellStyle,hasCheckbox,sef,search,columns,showHeader); 
    }
})();  
