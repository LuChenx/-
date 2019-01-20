<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../resource/common/taglib_frame.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>初始化进销存</title>
</head>
<body>
<ul id="myTab" class="nav nav-tabs">
    <li class="active">
        <a href="#init" data-toggle="tab">
                    初始数据
        </a>
    </li>
    <li>
    	<a href="#cageinit" data-toggle="tab">
    	期初库存
    	</a>
    </li>
    <li>
        <a href="#brand" data-toggle="tab">
                    进货往来账
        </a>
    </li>
    <li>
    	<a href="#customer" data-toggle="tab">
    	客户往来账
    	</a>
    </li>
</ul>
<div id="myTabContent" class="tab-content">
    <div class="tab-pane fade in active" id="init">
    </div>
    <div class="tab-pane fade" id="cageinit">
    </div>
    <div class="tab-pane fade" id="brand">
    </div>
    <div class="tab-pane fade" id="customer">
    </div>
</div>
</body>
</html>