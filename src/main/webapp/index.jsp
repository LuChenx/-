<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../../resource/common/taglib_frame.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>Admin System</title>
</head>
<style>
</style>
<body>
<div class="container-fluid-full">
		<div class="row-fluid">
					
			<div class="row-fluid">
				<div class="login-box">
					<h2>Welcome to Admin System</h2>
					<form class="form-horizontal" action="<%=basePath%>resource/views/main.jsp" method="post" />
						<fieldset>
							
							<input class="input-large span12" name="username" id="username" type="text" placeholder="账号" />

							<input class="input-large span12" name="password" id="password" type="password" placeholder="密码" />

							<div class="clearfix"></div>
							
							<label class="remember" for="remember"><input type="checkbox" id="remember" />记住我</label>
							
							<div class="clearfix"></div>
							
							<button type="submit" class="btn btn-primary span12">登录</button>
						</fieldset>	

					</form>
					<hr />
					<h3>访问异常?</h3>
					<p>
						请使用火狐、谷歌或者ie7以上的浏览器访问！
					</p>	
				</div>
			</div><!--/row-->
			
				</div><!--/fluid-row-->
				
	</div><!--/.fluid-container-->


</body>
</html>