<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加菜单</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="<%=basePath%>images/favicon.ico" media="screen" />
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>js/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script src="<%=basePath%>js/jquery-1.10.2.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>
    <script charset="utf-8" src="<%=basePath%>js/kindeditor-4.1.10/kindeditor-min.js"></script>
	<script charset="utf-8" src="<%=basePath%>js/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script charset="utf-8" src="<%=basePath%>js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
    <script type="text/javascript">
    	KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="tcjj"]', {
				cssPath : '<%=basePath%>js/kindeditor-4.1.10/plugins/code/prettify.css',
				uploadJson : 'uploadJson/file_upload',
				fileManagerJson : 'uploadJson/file_manager',
				allowFileManager : false,
				items : ['bold', 'italic', 'underline','removeformat'],
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
   	<form action="menuAction/saveMenu" encType="multipart/form-data" method="post" role="form-control">
   	<div class="panel panel-primary">
  	<div class="panel-heading"><strong>添加套餐信息</strong></div>
    <table class="table table-striped">
    	<tr>
    		<td>套餐名称</td>
    		<td><input name="tcmc" type="text" class="form-control" placeholder="套餐名称" required/></td>
    	</tr>
   
    	<tr>
    		<td>套餐简介</td>
    		<td>
    		<textarea id="editor_id" name="tcjj" rows="3" cols="40">
					&lt;strong&gt;套餐简介&lt;/strong&gt;
			</textarea>
    		</td>
    	</tr>
    	<tr>
    		<td>价格</td>
    		<td><input name="jg" type="text" class="form-control" placeholder="价格" required/></td>
    	</tr>
    	<tr>
    		<td>折扣价</td> 
    		<td><input name="zk" type="text" class="form-control" placeholder="折扣"/></td>
    	</tr>
    	<tr>
    		<td>菜单列表</td>
    		<td><input name="cdlb" type="text" class="form-control" placeholder="菜单列表" required/></td>
    	</tr>
 	    
         <tr>
    		<td>整体图片</td>
    		<td><input type="file" id="file" name="file" required/>
    			<p class="help-block">请上传格式为800 * 600的图片</p>
    		</td>
    	</tr>
    	<tr>
    		<td colspan="2">
    			<button type="submit" class="btn btn-primary">添加</button>
    		</td>
        </tr>
    </table>
    </div>
    <input type="hidden" name="hotel.jdbh" value="${hotel_id }">
    </form>
    </div>
  </body>
</html>
