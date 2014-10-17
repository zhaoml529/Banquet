<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>后台登陆</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" media="screen" />
	<script src="js/jquery-1.10.2.js"></script>
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<link href="css/signin.css" rel="stylesheet">
	<script src="js/bootstrap.min.js"></script>
  </head>
  <body>
  	<div class="container">
      <form class="form-signin" role="form" action="loginAction/login" method="post" target="_top">
        <h2 class="form-signin-heading">管理员登录</h2><br/>
        <input type="text" name="username"  class="form-control" placeholder="用户名" required autofocus/>
        <input type="password" name="userpwd"  class="form-control" placeholder="密码" required>
        <br/>
        <c:if test="${!empty errorMessage }">
          	<span class="label label-danger">${errorMessage }</span>
        </c:if>
        <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
      </form>
    </div> <!-- /container -->
  </body>
</html>
