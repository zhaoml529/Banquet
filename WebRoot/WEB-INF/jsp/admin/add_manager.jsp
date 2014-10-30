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
    
    <title>添加酒店经理</title>
    
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" media="screen" />
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link type="text/css" rel="stylesheet" href="js/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script charset="utf-8" src="js/kindeditor-4.1.10/kindeditor-min.js"></script>
	<script charset="utf-8" src="js/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script charset="utf-8" src="js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
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
   	 <form action="userAction/saveManager" method="post" role="form-control">
   	<div class="panel panel-primary">
  	<div class="panel-heading"><strong>添加酒店经理</strong></div>
  	<div class="table-responsive">
    <table class="table table-striped">
       
		<tr>
			<td align="center"  >用户名</td>
			<td><input name="yhm" type="text" class="form-control"  placeholder="用户名" required/></td>
		</tr>
   
		<tr>
			<td align="center"  >密码</td>
			<td><input name="mm" type="text" class="form-control"  placeholder="密码" required/></td>
		</tr>
		<tr>
			<td align="center"  >姓名</td>
			<td><input name="xm" type="text" class="form-control"  placeholder="姓名" required/></td>
		</tr>
		<tr>
		    <td align="center" >角色</td>
			<td>
				<input type="hidden" validatorType="radio" fieldName="jx" errorInfo="请选择角色">
				<input type="radio" name="jx" id="1" value="1" checked/>管理员
	 			<input type="radio" name="jx" id="0" value="0"/>经理
			</td>
		</tr>
 	    <tr>
          <td align="center">所属酒店</td>
           <td><select name="hotel.jdbh" emptyInfo="请选择酒店" style="width:150px;">
	 	    <option value="">--请选酒店--</option>
	 	    <c:forEach items="${hotelList}" var="hotelList">
	 		<option value="${hotelList.jdbh}">${hotelList.jdmc}</option>
	 	    </c:forEach>
           </select>
          </td>    
    	</tr>
		<tr>
			<td align="center" >电话号码</td>
			<td><input name="dhhm" type="text" class="form-control"  placeholder="电话号码" required/></td>
		</tr>
    	<tr>
    		<td colspan="2">
    			<button type="submit" class="btn btn-primary btn-sm">确认添加</button>
    		</td>
        </tr>
    </table>
    </div>
    </div>
    </form>
    </div>
  </body>
</html>
