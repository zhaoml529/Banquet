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
    
    <title>酒店详细信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" media="screen" />
	<link href="css/bootstrap.min.css" rel="stylesheet">
    <script charset="utf-8" src="http://map.qq.com/api/js?v=1"></script>
    <script src="js/hotel.js"></script>
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/guanli.js"></script>
	<script type="text/javascript">
		var init = function() {
			var zb = document.getElementById("zb").value;
			var str = zb.split(",") ;
			if( null == zb ){
				str[0] = 36.576075 ;
				str[1] = 114.508544 ;
			}
		    var center = new soso.maps.LatLng(str[0],str[1]);
		    var map = new soso.maps.Map(document.getElementById('container'),{
		        center: center,
		        zoomLevel: 13
		    });
		    var marker = new soso.maps.Marker({
		        position: center,
		        map: map
		    });
		    var zoomControl = new soso.maps.ZoomHintControl({map:map});
		    var maptypectrl = new soso.maps.MapTypeControl({map:map});
		    var navControl = new soso.maps.NavigationControl({
		        align: soso.maps.ALIGN.TOP_LEFT,
		        margin: new soso.maps.Size(5, 15),
		        map: map
		    });
		}
	</script>
  </head>
  <!-- 管理员查看酒店详情 -->
  <body style="background-color:#eeeeee" onload="init()">
<form id="form1" name="form1" method="post" action="">
  <table class="table table-striped">
    <tr>
      <td width="5" rowspan="5"><img src="<%=basePath%>${hotel.jdzp}" width="500" height="500"/></td>
    </tr>
    <tr>
      <td colspan="4" style="font-size: 20px;color:black;font-weight: bold;height:20">酒店名称：</td>
    </tr>
    <tr>
      <td colspan="4">${hotel.jdmc}</td>
    </tr>
    <tr>
      <td colspan="4" style="font-size: 20px;color:black;font-weight: bold;height:20">酒店简介：</td>
    </tr>
    <tr>
      <td colspan="4">${hotel.jdjj}</td>
    </tr>
        <tr>
      <td colspan="4" style="font-size: 20px;color:black;font-weight: bold;height:20">行政区：</td>
    </tr>
<tr>
      <td colspan="4">
						<c:choose>
							<c:when test="${hotel.xzq == 1 }"> 丛台区</c:when>
							<c:when test="${hotel.xzq == 2 }">高开区</c:when>
								<c:when test="${hotel.xzq == 3 }">复兴区</c:when>
									<c:otherwise >邯山区</c:otherwise>
						</c:choose>
					</td>
				</tr>	
   <tr>
      <td colspan="4" style="font-size: 20px;color:black;font-weight: bold;height:20">联系人：</td>
    </tr>
    <tr>
      <td colspan="2">${hotel.lxr}</td>
      <td>	   
    </tr>
        <tr>
      <td colspan="4" style="font-size: 20px;color:black;font-weight: bold;height:20">联系电话：</td>
    </tr>
    <tr>
      <td colspan="4">${hotel.lxdh}</td>
    </tr>
        <tr>
      <td colspan="4" style="font-size: 20px;color:black;font-weight: bold;height:20">地址：</td>
    </tr>
    <tr>
      <td colspan="4">${hotel.jddz}</td>
    </tr>
            <tr>
      <td colspan="4" style="font-size: 20px;color:black;font-weight: bold;height:20">详细位置：</td>
    </tr>
    <tr>
      <td colspan="4">
        <input type="hidden" id="zb" value="${hotel.zb}">
     	<div style="width:603px;height:300px" id="container"></div>
      
      </td>
      
    </tr>
  </table>
</form>
</body>
</html>
