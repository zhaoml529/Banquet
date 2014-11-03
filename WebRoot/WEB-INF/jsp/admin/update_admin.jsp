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
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>js/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script src="<%=basePath%>js/jquery-1.10.2.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>
    <script charset="utf-8" src="<%=basePath%>js/kindeditor-4.1.10/kindeditor-min.js"></script>
	<script charset="utf-8" src="<%=basePath%>js/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script charset="utf-8" src="<%=basePath%>js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
    <script type="text/javascript">
    	KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="yhtjj"]', {
				cssPath : '<%=basePath%>js/kindeditor-4.1.10/plugins/code/prettify.css',
				uploadJson : 'uploadJson/file_upload',
				fileManagerJson : 'uploadJson/file_manager',
				allowFileManager : true,
				items : [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
					});
				}
			});
			prettyPrint();
		});
    </script>

  </head>
  
  <body>
    <div class="container">
   	<form action="userAction/upadteAdmin"  method="post" role="form-control">
   	<div class="panel panel-primary">
  	<div class="panel-heading"><strong>管理员信息修改</strong></div>
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
   <input type="hidden"  name="hotel.jdbh" value="${users.hotel.jdbh}" required/>
   <input type="hidden" name="yhbh" value="${users.yhbh}" required/>
    <input type="hidden" name="jx" value="${users.jx}" required/>
    </form>
    </div>
  </body>
</html>
