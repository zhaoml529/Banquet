<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<%@ page import="java.io.PrintWriter"%>
<%
	Exception e = (Exception) request.getAttribute("exception");
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'Exception.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/bootstrap.min.js"></script>
<link type="text/css" rel="stylesheet" href="css/default.css" />
<script language="JavaScript">
	function showDetail() {
		document.getElementById("explaintab").style.display = "";
	}
</script>
</head>

<body  style="background-color:#f3f3f3">
<div class="container" style="margin-top: 5px;">
    <div class="row" style="padding-top:5px;margin-top: 5px;text-align: center">
        <div class="col-md-8"></div>
        <div class="col-md-2"></div>
        <div class="col-md-2"></div>
    </div>
   

	<section class="row" style="text-align: center">
        <h3 style="color: #ff0000;font-size: 30px;">出现错误了!</h3>
        <span class="glyphicon glyphicon-warning-sign" style="font-size: 100px;color: #ff0000; "></span>
        <div class="col-md-12" style="margin-top: 20px">
        <div class="row">
        <div class="col-md-4" ></div>
            <div class="col-md-4 alert" style="text-align: center;background-color:dodgerblue;margin-bottom: 200px;">
                <p>错误原因：<%=e.getMessage()%></p>
            </div>
        <div class="col-md-4"></div>
        </div>
        </div>

    </section>
	<table border="0" cellpadding="0" cellspacing="1" class="default"
		style="width:50%" align="center">
		
		<tr>
			<td align="center" style="line-height:150%;padding:10px">
				 <br> 请选择以下任务继续：<br>
			<br> <a href="javascript:history.go(-1)">返回</a> | <a
				href="javascript:showDetail();">查看错误详细信息</a></td>
		</tr>
	</table>
	<table class="explain" width="100%" align="center" style="display:none"
		id="explaintab">
		<tr>
			<td><textarea rows="20"
					style="width:100%;font-family:Courier New">：<%
				e.printStackTrace(new PrintWriter(out));
			%>
				</textarea></td>
		</tr>
	</table>
	
</body>
</html>
