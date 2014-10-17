<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>修改酒店</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" media="screen" />
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link type="text/css" rel="stylesheet" href="js/kindeditor-4.1.10/plugins/code/prettify.css" />
    <script src="js/map.js"></script>
    <script charset="utf-8" src="http://map.qq.com/api/js?v=1"></script>
    <script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script charset="utf-8" src="js/kindeditor-4.1.10/kindeditor-min.js"></script>
	<script charset="utf-8" src="js/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script charset="utf-8" src="js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
    <script type="text/javascript">
    	KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="jdjj"]', {
				cssPath : 'js/kindeditor-4.1.10/plugins/code/prettify.css',
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
  
  <body onload="init();">
    <div class="container">
   	<div class="panel panel-primary">
  	<div class="panel-heading"><strong>修改酒店信息</strong></div>
  	<form action="hotelAction/adminUpdateHotel" method="post" role="form-control">
  	<table class="table table-striped">
    	<tr>
    		<td>酒店名称</td>
    		<td><input name="jdmc" type="text" value="${hotel.jdmc }" class="form-control" placeholder="酒店名称" required/></td>
    	</tr>
    	<tr>
    		<td>酒店地址</td>
    		<td><input name="jddz" type="text" value="${hotel.jddz }" class="form-control" placeholder="酒店地址" required/></td>
    	</tr>
    	<tr>
    		<td>联系人</td>
    		<td><input name="lxr" type="text" value="${hotel.lxr}" class="form-control" placeholder="联系电话" required/></td>
    	</tr>
    	<tr>
    		<td>酒店描述</td>
    		<td><textarea id="editor_id1" name="jdjj" rows="3" cols="40">
					${hotel.jdjj }
				</textarea>
			</td>
    	</tr>
    	<tr>
    		<td>联系电话</td>
    		<td><input name="lxdh" type="text" value="${hotel.lxdh }" class="form-control" placeholder="联系电话" required/></td>
    	</tr>
    	<tr>
    		<td>所在行政区</td>
    		<td>
	    		<select name="xzq" class="form-control">
	   				<option value="1">丛台区</option>
	   				<option value="2">邯山区</option>
	   				<option value="3">复兴区</option>
	   				<option value="4">高开区</option>
	   			</select>
   			</td>
    	</tr>
    	<tr>
    		<td>坐标</td>
    		<td>
    		<div><input name="zb" id="latLng" type="text" value="${hotel.zb }" class="form-control" placeholder="点击地图获取坐标" required/>
    			<span style="height:30px;display:none" id="city"></span>
				<div style="width:603px;height:300px" id="mapContainer"></div>
				<p>根据客户端IP定位地图中心位置。</p>
    		
    		</td>
    	</tr>
    	<tr>
    		<td colspan="3">
    			<button type="submit" class="btn btn-primary">确认修改</button>
    		</td>
    	</tr>
    </table>
    <input type="hidden" name="jdbh" value="${hotel.jdbh }"/>
    <input type="hidden" name="jdzp" value="${!empty hotel.jdzp?hotel.jdzp:!empty newURL?newURL:'' }"/>
    </form>
    </div>
    <div >
    <form action="hotelAction/adminUploadHotelPic/${hotel.jdbh }" method="post" enctype="multipart/form-data">
    <div class="media">
    			<img id="view" src="<%=basePath%>${!empty hotel.jdzp?hotel.jdzp:!empty newURL?newURL:'imges/no_picture.gif' }" class="img-thumbnail" alt="${hotel.jdmc }">
    			<div class="media-body">
    				<h3 class="media-heading">酒店照片</h3>
    				<input type="file" id="file" name="file" required />
    				<p class="help-block">请上传格式为800 * 600的图片</p>    
    				<input type="submit" class="btn btn-info" value="上传"> 
    			</div>
    </div>
    </form>
    </div>
   	</div>
  </body>
</html>
