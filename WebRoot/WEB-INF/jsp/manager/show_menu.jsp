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
    
    <title>菜单详细信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="<%=basePath%>images/favicon.ico" media="screen" />
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=basePath%>js/jquery-1.10.2.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>
    <script src="<%=basePath%>js/hotel.js"></script>

  </head>
  <!-- 经理查看菜单详情 -->
  <body >
  
  <div class="row">
  <div class="col-sm-12 col-md-12">
    <div class="thumbnail">
      <img id="view" src="<%=basePath%>${!empty menu.zttp?menu.zttp:'images/no_picture.gif' }" class="img-thumbnail" alt="${menu.cdlb }">
      <div class="caption">
        <h3>${menu.tcmc } 
	        <small>
	        <c:choose>
	        	<c:when test="${empty menu.zk}">
	        		<b>现价： ￥${menu.jg}</b>
	        	</c:when>
	        	<c:otherwise>
	        		<font style="font-size: 20px;color:red;">折扣价:￥${menu.zk}</font>&nbsp;
	      			<font style="font-size: 13px;color:gray;"><strike>原价:￥${menu.jg}</strike></font>
	        	</c:otherwise>
	        </c:choose>
	      	</small>
      	</h3>
      	<hr style="border:1px solid #B10021;"/>
        <h4 style="color: blue;">套餐简介:</h4>
        <p>${menu.tcjj }</p>
        <h4 style="color: blue;">套餐列表:</h4>
        <p>${menu.cdlb }</p>
      </div>
    </div>
  </div>
</div>
  
</body>
</html>
