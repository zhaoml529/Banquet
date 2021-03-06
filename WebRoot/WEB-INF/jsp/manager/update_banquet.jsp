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
    
    <title>修改宴会厅</title>
    
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="<%=basePath%>images/favicon.ico" media="screen" />
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
	<link type="text/css" rel="stylesheet" href="<%=basePath%>js/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script src="<%=basePath%>js/jquery-1.10.2.min.js"></script>
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
   	<form action="banquetAction/adminUpdateBanquetRoom" method="post" role="form-control">
   	<div class="panel panel-primary">
  	<div class="panel-heading"><strong>修改宴会厅信息</strong></div>
    <table class="table table-striped">
       
    	<tr>
    		<td>宴会厅名称</td>
    		<td><input name="yhtmc" type="text" class="form-control" value="${banquetRoom.yhtmc }" placeholder="宴会厅名称" required/></td>
    	</tr>
   
    	<tr>
    		<td>桌数</td>
    		<td><input name="zs" type="text" value="${banquetRoom.zs }" class="form-control" placeholder="桌数" required/></td>
    	</tr>
    	<tr>
    		<td>每桌人数</td>
    		<td><input name="mzrs" type="text" class="form-control" value="${banquetRoom.mzrs }"  placeholder="每桌人数" required/></td>
    	</tr>
 	    <tr>
    		<td>宴会厅描述</td>
    		<td>
    		    <textarea id="editor_id1" name="yhtjj" rows="3" cols="40">
					${banquetRoom.yhtjj }
				</textarea>
    		</td>
    	</tr>
    	
    	<tr>
    		<td colspan="2">
    			<button type="submit" class="btn btn-primary">修改</button>
    		</td>
        </tr>
    </table>
    </div>
    <input type="hidden" name="yhtbh" value="${banquetRoom.yhtbh }"/>
    <input type="hidden" name="hotel.jdbh" value="${banquetRoom.hotel.jdbh }"/>
    <input type="hidden" name="yhttp" value="${banquetRoom.yhttp }"/>
    </form>
    <form action="banquetAction/uploadBanquetPic/${banquetRoom.yhtbh }" method="post" enctype="multipart/form-data">
    <div class="media">
    			<img id="view" src="<%=basePath%>${!empty banquetRoom.yhttp?banquetRoom.yhttp:'images/no_picture.gif' }" class="img-thumbnail" alt="${banquetRoom.yhtmc }">
    			<div class="media-body">
    				<h3 class="media-heading">宴会厅照片</h3>
    				<input type="file" id="file" name="file" required />  
    				<p class="help-block">请上传格式为800 * 600的图片</p> 
    				<input type="submit" class="btn btn-info" value="上传"> 
    			</div>
    </div>
    </form>
    </div>
  </body>
</html>
