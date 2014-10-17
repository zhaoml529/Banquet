<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'NoRights.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link type="text/css" rel="stylesheet" href="css/default.css" />
  </head>
  
  <body>
	<table cellSpacing=0 cellPadding=5 style="" width="100%" border=0 style=" margin-top:0px">
	        <tr>
	          <td class="manageHead">当前位置：权限管理</td>
	        </tr>
	        <tr>
	        <td height=2></td></tr>
	  </table><br><br>
	<table border="0" cellpadding="0" cellspacing="1" class="default" style="width:50%" align="center">
		<tr class="title">
			<td style="text-align:center;color:red">权限不足</td>
		</tr>
		<tr>
			<td align="center" style="line-height:150%;padding:10px">
			<table width="90%"><tr><td style="padding:10px;background:#FFCCCC;border:1px solid black;width:90%">对不起,您没有相应的操作权限！</td></tr></table>
			<br>
			请选择以下任务继续：<br><br>
			<a href="javascript:history.go(-1)">返回</a>
			</td>
		</tr>
	</table>
  </body>
</html>
