<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../resource/common/taglib_frame.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin</title>
</head>
<body>
	<!-- start: Header -->
	<div class="navbar">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="btn btn-navbar" data-toggle="collapse" data-target=".top-nav.nav-collapse,.sidebar-nav.nav-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</a>
				<a id="main-menu-toggle" class="hidden-phone open"><i class="icon-reorder"></i></a>		
				<div class="row-fluid">
				<a class="brand span2" href="<%=basePath%>resource/views/main.jsp"><span>Admin System</span></a>
				</div>		
				<!-- start: Header Menu -->
				<div class="nav-no-collapse header-nav">
					<ul class="nav pull-right">
						<li class="dropdown hidden-phone">
							<a class="btn dropdown-toggle" data-toggle="dropdown" href="#" style="margin-top: 5px">
								<i class="icon-warning-sign"></i>
							</a>
							<ul class="dropdown-menu notifications">
								<li class="dropdown-menu-title">
 									<span>您有2个订单未处理</span>
								</li>	
                
								<li>
                                    <a href="#">
										<span class="icon yellow"><i class="icon-shopping-cart"></i></span>
										<span class="message">未发货</span>
										<span class="time">1 hour</span> 
                                    </a>
                                </li>
								
								<li class="warning">
                                    <a href="#">
										<span class="icon red"><i class="icon-shopping-cart"></i></span>
										<span class="message">订单已取消</span>
										<span class="time">6 hour</span> 
                                    </a>
                                </li>
							
                                <li class="dropdown-menu-sub-footer">
                            		<a>查看所有订单</a>
								</li>	
							</ul>
						</li>
						<!-- start: Notifications Dropdown -->
						<li class="dropdown hidden-phone">
							<a class="btn dropdown-toggle" data-toggle="dropdown" href="#" style="margin-top: 5px">
								<i class="icon-tasks"></i>
							</a>
							<ul class="dropdown-menu tasks">
								<li>
									<span class="dropdown-menu-title">您有1项任务未完成</span>
                            	</li>
								<li>
                                    <a href="#">
										<span class="header">
											<span class="title">库存调度</span>
											<span class="percent"></span>
										</span>
                                        <div class="taskProgress progressSlim progressBlue">80</div> 
                                    </a>
                                </li>
                               
								<li>
                            		<a class="dropdown-menu-sub-footer">查询所有任务</a>
								</li>	
							</ul>
						</li>
						<!-- end: Notifications Dropdown -->
						<!-- start: Message Dropdown -->
						<li class="dropdown hidden-phone">
							<a class="btn dropdown-toggle" data-toggle="dropdown" href="#" style="margin-top: 5px">
								<i class="icon-envelope"></i>
							</a>
							<ul class="dropdown-menu messages">
								<li>
									<span class="dropdown-menu-title">您有2条未读消息</span>
								</li>	
                                <li>
                                    <a href="#">
										<span class="avatar"><img src="<%=basePath%>resource/frame/img/avatar2.jpg" alt="Avatar" /></span>
										<span class="header">
											<span class="from">
										    	Megan Abott
										     </span>
											<span class="time">
										    	56 min
										    </span>
										</span>
                                        <span class="message">
                                            	南京仓需要调度
                                        </span>  
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
										<span class="avatar"><img src="<%=basePath%>resource/frame/img/avatar3.jpg" alt="Avatar" /></span>
										<span class="header">
											<span class="from">
										    	Kate Ross
										     </span>
											<span class="time">
										    	3 hours
										    </span>
										</span>
                                        <span class="message">
                                           	   入库已完成
                                        </span>  
                                    </a>
                                </li>
								<li>
                            		<a class="dropdown-menu-sub-footer">查询所有消息</a>
								</li>	
							</ul>
						</li>
						<!-- end: Message Dropdown -->
						<li>
							<a class="btn" href="#" style="margin-top: 5px">
								<i class="icon-wrench"></i>
							</a>
						</li>
						<!-- start: User Dropdown -->
						<li class="dropdown">
							<a class="btn account dropdown-toggle" data-toggle="dropdown" href="#">
								<img src="<%=basePath%>resource/images/github_black_128px_1109058_easyicon.net.ico" style="width: 40px;height: 40px;margin-top: -20px" alt="Avatar"/>
								<div class="user">
									<span class="hello">陆晨曦</span>
									<span class="name">系统管理员</span>
								</div>
							</a>
							<ul class="dropdown-menu">
								<li class="dropdown-menu-title">
									
								</li>
								<li><a href="#"><i class="icon-user"></i> 账号信息</a></li>
								<li><a href="#"><i class="icon-cog"></i> 我的权限</a></li>
								<li><a href="<%=basePath%>index.jsp"><i class="icon-off"></i> 退出</a></li>
							</ul>
						</li>
						<!-- end: User Dropdown -->
					</ul>
				</div>
				<!-- end: Header Menu -->
				
			</div>
		</div>
	</div>
	<!-- start: Header -->
	
		<div class="container-fluid-full">
		<div class="row-fluid">
				
			<!-- start: Main Menu -->
			<div id="sidebar-left" class="span2">
				
				<div class="nav-collapse sidebar-nav">
					<ul class="nav nav-tabs nav-stacked main-menu">
						
						<li>
							<a class="dropmenu" href="#"><i class="icon-rss"></i><span class="hidden-tablet"> 系统管理</span></a>
							<ul>
								<li><a class="submenu" href="#" onclick='linkto("user/roles.jsp")'><i class="icon-coffee"></i><span class="hidden-tablet"> 岗位设置</span></a></li>
								<li><a class="submenu" href="messages.html"><i class="icon-key"></i><span class="hidden-tablet"> 岗位权限</span></a></li>
								<li><a class="submenu" href="tasks.html"><i class="icon-cog"></i><span class="hidden-tablet"> 系统选项</span></a></li>
								<li><a class="submenu" href="tasks.html"><i class="icon-cogs"></i><span class="hidden-tablet"> 系统配置</span></a></li>
								<li><a class="submenu" href="tasks.html"><i class="icon-sitemap"></i><span class="hidden-tablet"> 地区管理</span></a></li>
								<li><a class="submenu" href="tasks.html"><i class="icon-home"></i><span class="hidden-tablet"> 仓库名称</span></a></li>
								<li><a class="submenu" href="tasks.html"><i class="icon-book"></i><span class="hidden-tablet"> 商品名称</span></a></li>
								<li><a class="submenu" href="tasks.html"><i class="icon-calendar"></i><span class="hidden-tablet"> 价格体系</span></a></li>
								<li><a class="submenu" href="tasks.html"><i class="icon-user"></i><span class="hidden-tablet"> 操作员管理</span></a></li>
								<li><a class="submenu" href="tasks.html"><i class="icon-bar-chart"></i><span class="hidden-tablet"> 初始化进销存</span></a></li>
							</ul>	
						</li>
						
						<li>
							<a class="dropmenu" href="#"><i class="icon-folder-open"></i><span class="hidden-tablet"> 基本信息</span></a>
							<ul>
								<li><a class="submenu" href="#"><i class="icon-ambulance"></i><span class="hidden-tablet"> 供货单位管理</span></a></li>
								<li><a class="submenu" href="messages.html"><i class="icon-group"></i><span class="hidden-tablet"> 客户资料管理</span></a></li>
								<li><a class="submenu" href="tasks.html"><i class="icon-star"></i><span class="hidden-tablet"> 客户品牌授权</span></a></li>
								<li><a class="submenu" href="tasks.html"><i class="icon-tags"></i><span class="hidden-tablet"> 商品信息管理</span></a></li>
								<li><a class="submenu" href="tasks.html"><i class="icon-wrench"></i><span class="hidden-tablet"> 价格表管理</span></a></li>
								<li><a class="submenu" href="tasks.html"><i class="icon-eye-open"></i><span class="hidden-tablet"> 浏览价格表</span></a></li>
							</ul>	
						</li>
						
						<li>
							<a class="dropmenu" href="#"><i class="icon-truck"></i><span class="hidden-tablet"> 进货管理</span></a>
							<ul>
								
							</ul>	
						</li>
						
						<li>
							<a class="dropmenu" href="#"><i class="icon-reorder"></i><span class="hidden-tablet"> 库存管理</span></a>
							<ul>
								
							</ul>	
						</li>
						
						<li>
							<a class="dropmenu" href="#"><i class="icon-bookmark"></i><span class="hidden-tablet"> 销售管理</span></a>
							<ul>
								
							</ul>	
						</li>
						
						<li>
							<a class="dropmenu" href="#"><i class="icon-mobile-phone"></i><span class="hidden-tablet"> APP管理</span></a>
							<ul>
								
							</ul>	
						</li>
					</ul>
				</div>
			</div>
			<!-- end: Main Menu -->
						
			<!-- start: Content -->
	<div id="content" class="span10">
		<iframe id="contentframe" style="width: 100%;height: 80%;" frameborder="0" ></iframe>
		<script>
			function linkto(page){
				$("#contentframe").attr('src',"<%=basePath%>resource/views/"+page);
			}
		</script>
	</div><!--/.fluid-container-->
	
</body>
</html>