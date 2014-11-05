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
    
    <title>添加新闻</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=basePath%>js/jquery-1.10.2.min.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>
    <script charset="utf-8" src="<%=basePath%>js/kindeditor-4.1.10/kindeditor-min.js"></script>
	<script charset="utf-8" src="<%=basePath%>js/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script charset="utf-8" src="<%=basePath%>js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
    <script type="text/javascript">
    	KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="xwnr"]', {
				uploadJson : '<c:url value='/uploadJson/file_upload'/>',
				fileManagerJson : '<c:url value='/uploadJson/file_manager'/>',
				allowFileManager : false,
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
   	<form action="newsAction/managerSaveNews" method="post" role="form-control">
   	<div class="panel panel-primary">
  	<div class="panel-heading"><strong>添加新闻信息</strong></div>
    <table class="table table-striped">
    	<tr>
    		<td>新闻标题</td>
    		<td><input name="xwbt" type="text" class="form-control" placeholder="新闻标题(长度不超过50字)" required/></td>
    	</tr>
    	<tr>
    		<td>新闻内容</td>
    		<td><textarea id="editor_id" name="xwnr" rows="20" cols="40">
					&lt;strong&gt;新闻内容&lt;/strong&gt;
				</textarea>
			</td>
    	</tr>
    	<tr>
    		<td colspan="2">
    			<button type="submit" class="btn btn-primary">添加</button>
    		</td>
        </tr>
    </table>
    </div>
    </form>
    </div>
    
  </body>
</html>
