<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../../resource/common/taglib_frame.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
		function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- //custom-theme -->
<link href="<%=basePath%>resource/css/404style.css" rel="stylesheet" type="text/css" media="all" />
<!-- //js --> 
<!-- font-awesome icons -->
<link href="<%=basePath%>resource/css/font-awesome.css" rel="stylesheet"> 
<!-- //font-awesome icons -->
<link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">
<link href="http://fonts.googleapis.com/css?family=Alfa+Slab+One" rel="stylesheet">
<!-- layer[提示对话框] -->
<script src="<%=basePath%>resource/Layui/layer/layer.js"></script>
<title>Admin System</title>
</head>
<style>
</style>
<body>
<div class="main">
	<canvas id="myCanvas"></canvas>
	<div class="container-fluid-full" style="margin-top: -55%">
		<div class="row-fluid">
					
			<div class="row-fluid">
				<div class="login-box">
					<h2>Welcome to Admin System</h2>
					<form class="form-horizontal"/>
						<fieldset>
							
							<input class="input-large span12" name="username" id="username" type="text" placeholder="账号" />

							<input class="input-large span12" name="password" id="password" type="password" placeholder="密码" />

							<div class="clearfix"></div>
							
							<label class="remember" for="remember"><input type="checkbox" id="remember" />记住我</label>
							
							<div class="clearfix"></div>
							
							<button type="button" class="btn btn-primary span12" id="loginbtu">登录</button>
							
						</fieldset>	
					<script type="text/javascript">
						$(function(){
							$("#loginbtu").click(function(){
								if($("#username").val()==""){
									layer.msg("请输入用户名", {time : 1500, icon : 5});
								}else if($("#password").val()==""){
									layer.msg("请输入账号密码", {time : 1500, icon : 5});
								}
								else{
									$.ajax({
								          type: "post",
								          url: "<%=basePath%>system/user/login" ,
								          data :JSON.stringify({
												appId:1,
												account:$("#username").val(),
												password:$("#password").val()
									 	  }),
									 	  contentType: 'application/json; charset=UTF-8',
									      dataType:'json',
								          success: function (result) {
								        	if(result.rcode ==  "000000"){
								        		window.location.href = "<%=basePath%>resource/views/main.jsp";
								        		var storage=window.sessionStorage;
								        		storage.managerId = result.uid;
								        		storage.managerName = result.userName;
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
					</form>
					<hr />
					<h3>访问异常?</h3>
					<p>
						请使用火狐、谷歌或者ie7以上的浏览器访问！最佳像素为1600*900。
					</p>	
				</div>
			</div><!--/row-->
			
				</div><!--/fluid-row-->
				
	</div><!--/.fluid-container-->
	
</div>
	<script src="<%=basePath%>resource/js/particles.min.js"></script>
    <script>
      $(document.body).css({
    	   "overflow-x":"hidden",
    	   "overflow-y":"hidden"
      });
      window.onload = function() {
        Particles.init({
          selector: '#myCanvas',
          color: '#6b6b6b',
          connectParticles: true,
          minDistance: 100
        });
      };
    </script>

</body>
</html>