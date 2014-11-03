<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>经理详细信息</title>
    
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
  <!-- 管理员查看经理详细信息 -->
  <body style="background-color:#eeeeee">
<div class="container" style="margin-top: 5px;">

 <div class="row" style="margin-top: 10px;margin-bottom: 10px">
     <div class="col-sm-12">
         <div class="row">
         </div>
     </div>
     <br><br>
<div align="center">
	<div class="table-responsive">
  	<table width="50%" align="center" class="table table-hover">		
		<tr>
			<td align="center" width="200"  class="success" >用户ID</td>
			<td align="center">${users.yhbh }</td>
		</tr>
		<tr>
			<td align="center"  class="success">用户名</td>
			<td align="center" >${users.yhm}</td>
		</tr>
				<tr>
			<td align="center"  class="success">密码</td>
			<td align="center" >${users.mm}</td>
		</tr>
		<tr>
			<td align="center"  class="success">姓名</td>
			<td align="center" >${users.xm}</td>
		</tr>
		<tr>
			<td align="center"  class="success">所属酒店</td>
			<td align="center">${users.hotel.jdmc}</td>
		</tr>
		<tr>
			<td align="center"  class="success">电话号码</td>
			<td align="center">${users.dhhm}</td>
		</tr>
	</table>
	  <p>
  <button type="button" class="btn btn-primary btn-lg" onclick="window.location.href='userAction/updateManagerById/${users.yhbh}'">修改</button>
   </p>
	</div>
</div>
</div>
</div>
</body>
</html>

