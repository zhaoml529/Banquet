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
    
    <title>待审核新闻</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=basePath%>js/jquery-1.10.2.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>

  </head>
  
  <body>
    <div class="">
    	<h2>${news.xwbt }</h2><h5>来源：${hotel_name}&nbsp;&nbsp;&nbsp; 发布时间： ${news.fbsj }</h5>
    	<p>${news.xwnr }</p>
    	<p>
    		<c:choose>
    			<c:when test="${news.sh == 1 }">
    				<button type="button" onclick="location.href='<c:url value='/newsAction/adminPassNews/${news.xwbh}/0'/>'" class="btn btn-danger">退回</button>
    			</c:when>
    			<c:otherwise>
    				<button type="button" onclick="location.href='<c:url value='/newsAction/adminPassNews/${news.xwbh}/1'/>'" class="btn btn-primary">通过</button>
    			</c:otherwise>
    		</c:choose>
    	</p>
	</div>
  </body>
</html>
