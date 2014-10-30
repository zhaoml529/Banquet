<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <base href="<%=basePath%>">

    <title>邯郸宴会网</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="<%=basePath%>images/favicon.ico" media="screen" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="css/index.css" rel="stylesheet" type="text/css">
    <!-- Custom styles for this template -->
    <script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/bootbox.min.js"></script>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->   
</head>
<body>
<header class="navbar navbar-inverse navbar-fixed-top docs-nav" role="banner">
    <div class="container">
        <div class="navbar-header">
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".bs-navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="./#" class="navbar-brand" alt="Less">
                <img src="<%=basePath %>imges/logo.png">
            </a>
        </div>
        <nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
             <ul class="nav navbar-nav navbar-right">
				<li>
                	<a href="#">首页</a>
                </li>
                <li>
                	<c:choose>
                        <c:when test="${role == 1 }"><a href="userAction/showAdmin" target="content" >超级管理员</a></c:when>
                        <c:otherwise>
                            <a href="#">经理</a>
                        </c:otherwise>
                   	</c:choose>
                </li>
                <li>
                	<a href="loginAction/logout">退出</a>
                </li>
            </ul>
        </nav>
    </div>
</header>
<div class="docs-header" id="content">
    <div class="container">
        <h1>邯郸宴会网</h1>
        <p>酒店信息管理系统</p>

    </div>
</div>
<div class="banner">
    <div class="container">
        This is banner！
    </div>
</div>

<!--Begin -->
<div class="container">
<div class="row">
<div class="col-sm-3">
    <div class="sidebar hidden-print affix-top" role="complementary">
        <div id="navigation">
        <nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
             <ul class="nav navbar-nav navbar-right">
                <li ${role == 1?"":"style='display: none;'" }><a href="hotelAction/listAdminHotel/pageNum/1" target="content"><span
                    class="glyphicon glyphicon-align-justify"></span>&nbsp;&nbsp;&nbsp;&nbsp;酒店列表</a>
                </li>
                <li ${role == 1?"":"style='display: none;'" }><a href="hotelAction/adminAddHotel"
                                                                 target="content"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;&nbsp;&nbsp;添加酒店</a>
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
                               target="content"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;&nbsp;&nbsp;添加宴会厅</a>
                        </c:when>
                        <c:otherwise>
                            <a href="banquetAction/addBanquetRoom"
                               target="content"><span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;&nbsp;&nbsp;添加宴会厅</a>
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
                <li ${role == 1?"":"style='display: none;'" }><a href="userAction/listManager/pageNum/1" target="content"><span
                    class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;&nbsp;&nbsp;用户信息管理</a>
                </li>
                <li ${role == 1?"":"style='display: none;'" }><a href="hotelAction/getHotelAllList/pageNum/1" target="content"><span class="glyphicon glyphicon-cog"></span>&nbsp;&nbsp;&nbsp;&nbsp;轮播图片</a></li>
                <li ${role == 1?"":"style='display: none;'" }><a href="userAction/showAdmin" target="content" ><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;&nbsp;&nbsp;个人信息修改</a>
                </li>
            </ul>
            </nav>
        </div>
    </div>
</div>
<div class="col-sm-9" role="main">

<div class="panel docs-content" >
<div class="docs-section">

    <!-- 4:3 aspect ratio -->
    <div class="embed-responsive embed-responsive-4by3">
    	<iframe id="content" name="content" class="embed-responsive-item" src="${role == 1?'hotelAction/listAdminHotel/pageNum/1':'banquetAction/listBanquet/pageNum/1'}"></iframe>
    </div>

</div>



</div>
</div>
<!-- docs-container -->
</div>
</div>

<!--End -->
<footer class="footer" role="contentinfo">
    <div class="container">
       <div class="col-md-12">
		    <div class="col-sm-12 img-rounded" style="text-align: center;margin-top: 5px;margin-bottom: 20px;padding-top: 5px;">
		        Copyright © 2014 <a href="#">Your Company Name</a> 
		        <a href="#" target="_blank" title="邯郸宴会网">邯郸宴会网</a> | Collect from 
				<a href="#" title="邯郸宴会网" target="_blank">邯郸宴会网</a> &nbsp;&nbsp;
				<a href="loginAction/toLogin">后台登录</a>
		    </div>
	   </div>
    </div>
</footer>

</body>
</html>