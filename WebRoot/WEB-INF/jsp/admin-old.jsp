<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>后台管理</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
<meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" media="screen" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/guanli.js"></script>
</head>

<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-12"
				style="background-color:#f8f8f8;text-align: center">
				<br/>
				<br/>
				<br/>
				<br/>
				<h1>
					<small><strong>酒店信息管理系统</strong> </small>
				</h1>
				<br/>
				<br/>
				<div class="pull-right">
	            <c:choose>
		            <c:when test="${role == 1 }"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;超级管理员</c:when>
  		            <c:otherwise>
  		            	<span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;经理</c:otherwise>
	            </c:choose>
					<span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;<a href="loginAction/logout">退出</a>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-3 pull-left"
				style="background-color:#f8f8f8;padding-top: 20px">
				<ul class="nav nav-pills nav-stacked">
					<li class="active" ${role == 1?"":"style='display: none;'" }><a href="hotelAction/listAdminHotel/pageNum/1" target="content"><span
							class="glyphicon glyphicon-align-justify"></span>&nbsp;&nbsp;&nbsp;&nbsp;酒店列表</a>
					</li>
					<li ${role == 1?"":"style='display: none;'" }><a href="hotelAction/adminAddHotel"
						target="content"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;&nbsp;&nbsp;添加新酒店</a>
					</li>
					<li>
						<c:choose>
							<c:when test="${role == 1 }">
							<a href="banquetAction/listAdminBanquet/pageNum/1" target="content"><span
							class="glyphicon glyphicon-align-justify"></span>&nbsp;&nbsp;&nbsp;&nbsp;宴会厅列表</a>
							</c:when>
							<c:otherwise>
							<a href="banquetAction/listBanquet/pageNum/1" target="content"><span
							class="glyphicon glyphicon-align-justify"></span>&nbsp;&nbsp;&nbsp;&nbsp;宴会厅列表</a>
							</c:otherwise>
						</c:choose>
						
					</li>
					<li>
					<c:choose>
						<c:when test="${role == 1 }">
						<a href="banquetAction/adminaddBanquetRoom"
						target="content"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;&nbsp;&nbsp;添加新宴会厅</a>
						</c:when>
						<c:otherwise>
						<a href="banquetAction/addBanquetRoom"
						target="content"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;&nbsp;&nbsp;添加新宴会厅</a>
						</c:otherwise>
					</c:choose>
					</li>
					<li>
					<c:choose>
						<c:when test="${role == 1 }">
						<a href="menuAction/listAdminMenu/pageNum/1" target="content"><span class="glyphicon glyphicon-align-justify"></span>&nbsp;&nbsp;&nbsp;&nbsp;菜谱列表</a>
						</c:when>
						<c:otherwise>
						<a href="menuAction/listMenu/pageNum/1" target="content"><span class="glyphicon glyphicon-align-justify"></span>&nbsp;&nbsp;&nbsp;&nbsp;菜谱列表</a>
						</c:otherwise>
					</c:choose>
					</li>
					<li>
					<c:choose>
						<c:when test="${role == 1 }">
						<a href="menuAction/adminAddMenu" target="content"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;&nbsp;&nbsp;添加菜谱</a>
						</c:when>
						<c:otherwise>
						<a href="menuAction/addMenu" target="content"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;&nbsp;&nbsp;添加菜谱</a>
						</c:otherwise>
					</c:choose>
                   </li>
                   <li ${role == 2?"":"style='display: none;'" }>
						<a href="orderAction/toListOrder" target="content"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;&nbsp;&nbsp;宴会厅预定管理</a>
                   </li>
                   <li>
						<c:choose>
							<c:when test="${role == 1 }">
							<a href="newsAction/listAdminNews/pageNum/1/1" target="content"><span
							class="glyphicon glyphicon-align-justify"></span>&nbsp;&nbsp;&nbsp;&nbsp;新闻列表</a>
							</c:when>
							<c:otherwise>
							<a href="newsAction/listManagerNews/pageNum/1" target="content"><span
							class="glyphicon glyphicon-align-justify"></span>&nbsp;&nbsp;&nbsp;&nbsp;新闻列表</a>
							</c:otherwise>
						</c:choose>
						
					</li>
                   <li>
                   <c:choose>
						<c:when test="${role == 1 }">
						<a href="newsAction/adminAddNews" target="content"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;&nbsp;&nbsp;添加新闻</a>
						</c:when>
						<c:otherwise>
						<a href="newsAction/managerAddNews" target="content"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;&nbsp;&nbsp;添加新闻</a>
						</c:otherwise>
					</c:choose>
					</li>
                   	<li  ${role == 1?"":"style='display: none;'" }><a href="userAction/listManager/pageNum/1" target="content"><span
							class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;&nbsp;&nbsp;用户信息管理</a>
					</li>
					<li ${role == 1?"":"style='display: none;'" }><a href="hotelAction/getHotelAllList/pageNum/1" target="content"><span class="glyphicon glyphicon-cog"></span>&nbsp;&nbsp;&nbsp;&nbsp;轮播图片
							设置</a></li>
					<li ${role == 1?"":"style='display: none;'" }><a href="userAction/showAdmin" target="content" ><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;&nbsp;&nbsp;管理员信息修改</a>
					</li>
				</ul>


			</div>
			<div class="col-sm-9 panel panel-default " style="padding-top: 20px">
			
				<!-- 16:9 aspect ratio -->
				<div class="embed-responsive embed-responsive-4by3">
				  <iframe id="content" name="content" class="embed-responsive-item" src="${role == 1?'hotelAction/listAdminHotel/pageNum/1':'banquetAction/listBanquet/pageNum/1'}"></iframe>
				</div>		
			</div>
		</div>

		<div class="row" style="background-color:#f8f8f8">
			<div class="col-sm-5"></div>
			<div class="col-sm-2 " style="text-align: center">
				版权<br /> <span class="glyphicon glyphicon-phone-alt"></span>:123456799
			</div>
			<div class="col-smsd-5"></div>
		</div>
		<div class="row ">
			<div class="col-sm-12"></div>
		</div>
	</div>
	
</body>
</html>
