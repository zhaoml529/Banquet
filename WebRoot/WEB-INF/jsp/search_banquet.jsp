<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		
		<title>邯郸宴会网</title>
		
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
		<meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
		<link rel="shortcut icon" type="image/x-icon" href="<%=basePath%>images/favicon.ico" media="screen" />
		<meta name="viewport" content="width=device-width" />
		<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<!-- Custom styles for this template -->
		<script src="<%=basePath%>js/jquery-1.10.2.js"></script>
		<script src="<%=basePath%>js/bootstrap.min.js"></script>
		<script src="<%=basePath%>js/bootbox.min.js"></script>
		<!-- HTML 5 shim for IE backwards compatibility -->
		<!-- [if lt IE 9]>
			<script src="<%=basePath%>js/html5.js"></script>
			<script src="<%=basePath%>js/respond.min.js"></script>
		<![endif]-->
		<script type="text/javascript">
			function search(){
				var hotel_name = document.getElementById("hotel_name").value;
				if(hotel_name != ''){
					document.getElementById("search_hotel").action='hotelAction/searchHotel/1';
					document.getElementById("search_hotel").submit();
				}else{
					bootbox.alert("<h5><span class='label label-warning'>Warning!</span>&nbsp;&nbsp;请输入酒店名称！ </h5>");
				}
			}
			
			function search_banquet(zs, type){
				var banquet_zs = 0;	//桌数
				var banquet_rs = 0;	//人数
				if(type == 1){
					//宴会大厅桌数
					if(zs == 1){
						banquet_zs = 10;
					}else if(zs == 2){
						banquet_zs = 20;
					}else if(zs ==3){
						banquet_zs = 30;
					}else{
						banquet_zs = 40;
					}
					document.getElementById("search_banquet").action='banquetAction/searchBanquet/1/1/'+banquet_zs;
				}else{
					if(zs == 1){
						banquet_rs = 10; //小于10人
					}else if(zs == 2){
						banquet_rs = 15; //10到15人
					}else if(zs ==3){
						banquet_rs = 20; //15到20人
					}else{
						banquet_rs = 25; //20人以上
					}
					document.getElementById("search_banquet").action='banquetAction/searchBanquet/1/2/'+banquet_rs;
				}
				document.getElementById("search_banquet").submit();
				
			}
		</script>	
	</head>
  
  <body style="background-color:#eeeeee">
    <div class="container" style="margin-top: 5px;">
		<div class="row img-rounded">
			<div class="col-sm-9" style="padding-top: 20px;padding-bottom:5px;">
				<img src="<%=basePath%>images/logo.png" style="width: 200px">
			</div>

			<div class="col-sm-3"
				style="padding-top: 20px;padding-bottom:5px;text-align: center">
				<a href="#"><span class="glyphicon glyphicon-qrcode"
					style="font-size: 50px"></span><br />微信关注</a>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12"
				style="padding-top: 20px;padding-bottom:20px;text-align: center">
				<h1>
					<em><strong style="color:#2aabd2 ">简单至本 方你所需</strong>
					</em>
				</h1>
			</div>
		</div>
	<div class="row" style="margin-top: 5px;margin-bottom: 5px;">
			<div class="col-sm-9">
			<div class="panel panel-primary">
		  	<div class="panel-heading"><strong>酒店列表</strong><a href="loginAction/login_view" style="float: right;" class="btn btn-primary btn-sm active" role="button">首页</a></div>
		  	<div class="table-responsive">
		  	<table width="100%" align="center" class="table table-hover">
				<tr class="active">
					<td>酒店名称</td>
					<td>宴会厅名称</td>
					<td>宴会厅图片</td>
					<td>可容纳</td>
					<td>操作</td>
				</tr>
				<c:choose>
					<c:when test="${empty banquetList}">
						<tr align="center">
							<td class="danger" colspan="5">无查询信息</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${banquetList }" var="banquetList">
							<tr>
								<td>${banquetList.hotel.jdmc }</td>
								<td>${banquetList.yhtmc }</td>
								<td><img id="view" src="<%=basePath%>${!empty banquetList.yhttp?banquetList.yhttp:'imges/no_picture.gif' }" width="140px" height="140px" class="img-rounded" alt="${banquetList.yhtmc }"></td>
								<td>${banquetList.zs }桌,每桌${banquetList.mzrs }人</td>
								<td>
									<a href="hotelAction/listHotel/${banquetList.hotel.jdbh }">查看详情</a>
								</td>
							</tr>	   		
			   			</c:forEach>
					</c:otherwise>
				</c:choose>
		    </table>
		    </div>
		    </div>
		    <div class="row">
		        <div id="select" class="col-sm-12" style="text-align: center; margin-top: 10px">
		            <ul class="pagination">
			            <c:if test="${pageBean.hasPreviousPage == true}">
			            	<li><a href="banquetAction/searchBanquet/${pageBean.prePage}/${type }/${zs }">&laquo;</a></li>
			            </c:if>
		            	<c:forEach varStatus="i" begin="1" end="${pageBean.totalPage}" step="1">
		                	<c:if test="${i.count <= 5 }">
		                	<li><a href="banquetAction/searchBanquet/${i.count }/${type }/${zs }">${i.count }</a></li>
		                	</c:if>
		                </c:forEach>
		             	<c:if test="${pageBean.hasNextPage == true}">
		                <li><a href="banquetAction/searchBanquet/${pageBean.nextPage}/${type }/${zs }">&raquo;</a></li>
		            	</c:if>
		            </ul>
		        </div>
		    </div>
			</div>
			<div class="col-sm-3">
				<div class="row">
					<div class="col-sm-12">
						<form id="search_hotel" method="post">
						<div class="input-group">
							<input id="hotel_name" name="hotel_name" type="text" class="form-control" placeholder="酒店名">
							<span class="input-group-btn">
								<button class="btn btn-default" type="button" onclick="search();">
									<span class="glyphicon glyphicon-search" style="color: green"></span>
								</button> </span>
						</div>
						</form>
					</div>
				</div>
				<div class="row">
				<form id="search_banquet" method="post">
					<div class="col-sm-12" style="margin-top: 20px">
						<table class="table table-bordered">
							<tr>
								<td colspan="2"
									style="text-align: center;background-color:#3399e9"><span
									class="glyphicon glyphicon-home" style="color: green"></span> <strong>宴会大厅</strong>
								</td>
							</tr>
							<tr style="background-color:#ffffff">
								<td><input type="radio" id="zs1" name="dating" onclick="search_banquet(1,1);">小于10桌</td>
								<td><input type="radio" id="zs2" name="dating" onclick="search_banquet(2,1);">10-20桌</td>
							</tr>
							<tr style="background-color:#ffffff">
								<td><input type="radio" id="zs3" name="dating" onclick="search_banquet(3,1);">20-30桌</td>
								<td><input type="radio" id="zs4" name="dating" onclick="search_banquet(4,1);">30桌以上</td>
							</tr>
							<tr>
								<td colspan="2"
									style="text-align: center;background-color:#3399e9"><span
									class="glyphicon glyphicon-leaf" style="color: green"></span> <strong>每桌人数</strong>
								</td>
							</tr>
							<tr style="background-color:#ffffff">
								<td><input type="radio" name="yajian" onclick="search_banquet(1,2);">10人以下</td>
								<td><input type="radio" name="yajian" onclick="search_banquet(2,2);">10-15人</td>
							</tr>
							<tr style="background-color:#ffffff">
								<td><input type="radio" name="yajian" onclick="search_banquet(3,2);">15-20人</td>
								<td><input type="radio" name="yajian" onclick="search_banquet(4,2);">大于20人</td>
							</tr>
						</table>
					</div>
				</form>
				</div>
			</div>
		</div>
	</div>
  </body>
</html>
