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
    
    <title>修改经理信息</title>
    
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="<%=basePath%>images/favicon.ico" media="screen" />
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=basePath%>js/jquery-1.10.2.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>
  </head>
  
  <body>
    <div class="container">
   	<form action="userAction/updateManager"  method="post" role="form-control">
   	<div class="panel panel-primary">
  	<div class="panel-heading"><strong>修改经理信息</strong></div>
    <table class="table table-striped">
       
		<tr>
			<td align="center"  >用户名</td>
			<td><input name="yhm" type="text" class="form-control" value="${users.yhm}" placeholder="用户名" required/></td>
		</tr>
   
		<tr>
			<td align="center"  >密码</td>
			<td><input name="mm" type="text" class="form-control" value="${users.mm}" placeholder="密码" required/></td>
		</tr>
		<tr>
			<td align="center"  >姓名</td>
			<td><input name="xm" type="text" class="form-control" value="${users.xm }" placeholder="姓名" required/></td>
		</tr>
 	    <tr>
		     <td align="center">所属酒店</td>
	     <td>
	 		<select name="hotel.jdbh" emptyInfo="所属酒店">
	 		    <option value=""> -- 请选择酒店-- </option>
	 		    <c:forEach items="${hotelList}" var="hotelList">
	 		    	<c:choose>
	 		    		<c:when test="${hotelList.jdbh == users.hotel.jdbh}">
	 		    			<option value="<c:out value='${users.hotel.jdbh}'/>" selected="selected"><c:out value='${users.hotel.jdmc}'/></option>
	 		    		</c:when>
	 		    		<c:otherwise>
	 		    			<option value="<c:out value='${hotelList.jdbh}'/>"><c:out value='${hotelList.jdmc}'/></option>
	 		    		</c:otherwise>
	 		    	</c:choose>
	 		    </c:forEach>
	 		</select>
	 	</td>
		</tr>
		<tr>
			<td align="center" >电话号码</td>
			<td><input name="dhhm" type="text" class="form-control" value="${users.dhhm }" placeholder="电话号码" required/></td>
		</tr>
    	<tr>
    		<td colspan="2">
    			<button type="submit" class="btn btn-primary">确认修改</button>
    		</td>
        </tr>
    </table>
    </div>
   <input type="hidden" name="yhbh" value="${users.yhbh}" required/>
    <input type="hidden" name="jx" value="${users.jx}" required/>
    </form>
    </div>
  </body>
</html>
