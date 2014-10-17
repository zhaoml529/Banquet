<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'map.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.min.js"></script>

  </head>
  
  <body>
    <div class="container text-center">
   <div class="row">
       <div class="col-sm-7" style="padding-top: 50px">
           <img src="http://st.map.qq.com/api?size=600*400&center=${location }&zoom=16&markers=${location }">
       </div>
       <div class="col-sm-5 text-center" style="padding-top: 50px">
           <h1>标题</h1>
           <p>...........................</p>
           <p>...........................</p>
           <p>...........................</p>
           <p>...........................</p>
           <p>...........................</p>
           <iframe height="34" width="372" border='0' vspace='0' hspace='0' marginwidth='0' marginheight='0' framespacing='0' frameborder='0'scrolling='no' src="http://open.map.qq.com/doc/tooles/searchmap.html"></iframe>
       </div>
   </div>

</div>
  </body>
</html>
