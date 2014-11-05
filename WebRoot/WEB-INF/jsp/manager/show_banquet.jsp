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
    
    <title>宴会厅详细信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="<%=basePath%>images/favicon.ico" media="screen" />
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=basePath%>js/jquery-1.10.2.min.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>
    <script src="<%=basePath%>js/hotel.js"></script>

  </head>
  <!-- 经理查看宴会厅详情 -->
  <body >
  
  <div class="row">
  <div class="col-sm-12 col-md-12">
    <div class="thumbnail">
      <img id="view" src="<%=basePath%>${!empty banquetRoom.yhttp?banquetRoom.yhttp:'images/no_picture.gif' }" class="img-thumbnail" >
      <div class="caption">
        <h3>${banquetRoom.yhtmc }</h3>
      	<hr style="border:1px solid #B10021;"/>
        <h4 class="badge">所容纳的桌数：</h4>
        <p>${banquetRoom.zs }</p>
        <h4 class="badge" style="color: white;">每桌的人数：</h4>
        <p>${banquetRoom.mzrs }</p>
        <h4 class="badge" style="color: white;">宴会厅简介</h4>
        <p>${banquetRoom.yhtjj }</p>
      </div>
    </div>
  </div>
</div>
  
</body>
  <!--
  <body style="background-color:#eeeeee">
<form id="form1" name="form1" method="post" action="">
<table class="table table-striped">
  <tr>
    <td colspan="2"><img src="${banquetRoom.yhttp }" width="1000" height="500"/></td>
    </tr>
  <tr>
    <td style="font-size: 20px;color:black;font-weight: bold;height:20;text-align:center">宴会厅名称：</td>
    <td>${banquetRoom.yhtmc}</td>
  </tr>
  <tr>
    <td style="font-size: 20px;color:black;font-weight: bold;height:20;text-align:center">所容纳的桌数：</td>
    <td>${banquetRoom.zs}</td>
  </tr>
  <tr>
    <td style="font-size: 20px;color:black;font-weight: bold;height:20;text-align:center">每桌的人数：</td>
    <td>${banquetRoom.mzrs}</td>
  </tr>
  <tr>
    <td style="font-size: 20px;color:black;font-weight: bold;height:20;text-align:center">宴会厅简介：</td>
    <td>${banquetRoom.yhtjj}</td>
  </tr>
</table>
</form>
</body>-->
</html>
