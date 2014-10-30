<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<base href="<%=basePath%>">

<title>邯郸宴会网</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
<meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
<link rel="shortcut icon" type="image/x-icon" href="<%=basePath%>images/favicon.ico" media="screen" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
<!-- Custom styles for this template -->
<script src="js/jquery-1.10.2.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootbox.min.js"></script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src="js/html5shiv.js"></script>
<script src="js/respond.min.js"></script>
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
				<img src="imges/logo.png" style="width: 200px">
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
	 	<div class="row" style="margin-top: 30px;margin-bottom: 5px;">
	<!--	<div class="col-sm-6" style="text-align: center"></div>
			<div class="col-sm-6 ">
				<form class="form-inline">
					<div class="form-group">
						<label class="sr-only" for="exampleInputEmail2">Email
							address</label> <input type="email" class="form-control"
							id="exampleInputEmail2" placeholder="帐号">
					</div>
					<div class="form-group">
						<label class="sr-only" for="exampleInputPassword2">Password</label>
						<input type="password" class="form-control"
							id="exampleInputPassword2" placeholder="密码">
					</div>
					<div class="checkbox">
						<label> <input type="checkbox"> 记住密码 </label>
					</div>
					<button type="submit" class="btn btn-default">
						<span class="glyphicon glyphicon-user"></span> 登录
					</button>
				</form>
			</div>	-->

		</div> 
		<div class="row" style="margin-top: 5px;margin-bottom: 5px;">
			<div class="col-sm-4 img-thumbnail">
				<marquee direction="left" scrollamount="4" behavior="alternate">
		            <c:forEach items="${listURL }" var="list" varStatus="i">
						<a href="hotelAction/listHotel/${list.jdbh }"> 
							<img class="img-thumbnail" src="<%=basePath%>${list.jdzp }" style="width: 386px;height: 280px" alt="${list.jdmc }">
						</a>
					</c:forEach>
		        </marquee>
			</div>
			<div class="col-sm-5">
				<ul class="list-group">
					<c:forEach items="${listNews }" var="list">
						<li class="list-group-item" data-toggle="modal" data-target="#${list.xwbh}"><span class="badge">${list.fbsj}</span> ${list.xwbt }</li>
					</c:forEach>
				</ul>
				<div class="row">
				<div id="select" class="col-sm-12" style="text-align: center;">
					<ul class="pagination">
						<c:if test="${newsPageBean.hasPreviousPage == true}">
							<li><a
								href="newsAction/listNews/pageNum/${newsPageBean.prePage}/${xzq_id}/${hotelPage}">&laquo;</a>
							</li>
						</c:if>
						<c:forEach varStatus="i" begin="1" end="${newsPageBean.totalPage}"
							step="1">
							<c:if test="${i.count <= 5 }">
								<li ${newsPageBean.currentPage == i.count?"class=active":"" }><a href="newsAction/listNews/pageNum/${i.count }/${xzq_id}/${hotelPage}">${i.count }</a>
								</li>
							</c:if>
						</c:forEach>
						<c:if test="${newsPageBean.hasNextPage == true}">
							<li><a
								href="newsAction/listNews/pageNum/${newsPageBean.nextPage}/${xzq_id}/${hotelPage}">&raquo;</a>
							</li>
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
		<div class="row" style="margin-top: 20px">
		    <div id="nav" class="col-sm-12">
		        <ul class="nav nav-pills nav-justified">
		            <li class="${xzq_id==1?'active':'' }">
		            	<a href="hotelAction/listHotel/pageNum/1/1">
		            		<span class="glyphicon glyphicon-map-marker" style="color: #ff0000"></span> 丛台区
		            	</a>
		            </li>
		            <li class="${xzq_id==2?'active':'' }">
		            	<a href="hotelAction/listHotel/pageNum/1/2">
		            		<span class="glyphicon glyphicon-map-marker" style="color: #ff0000"></span> 邯山区
		            	</a>
		            </li>
		            <li class="${xzq_id==3?'active':'' }">
		            	<a href="hotelAction/listHotel/pageNum/1/3">
		            		<span class="glyphicon glyphicon-map-marker" style="color: #ff0000"></span> 复兴区
		            	</a>
		            </li>
		            <li class="${xzq_id==4?'active':'' }">
		            	<a href="hotelAction/listHotel/pageNum/1/4">
		            		<span class="glyphicon glyphicon-map-marker" style="color: #ff0000"></span> 高开区
		            	</a>
		            </li>
		        </ul>
		    </div>
		</div>
		<!-- nav -->
		<div class="row" style="margin-top: 20px">
			<c:choose>
					<c:when test="${empty listHotel }">
						<div class="alert alert-warning" style="text-align: center; height: 300px;">暂无酒店信息</div>
					</c:when>
					<c:otherwise>
						<div class="row" style="margin-top: 5px">
							<c:forEach items="${listHotel }" var="list" varStatus="i">
								<div class="col-sm-3" style="text-align: center;margin-top: 5px">
									<a href="hotelAction/listHotel/${list.jdbh }" class="item active"> <img class="img-thumbnail" style="width: 280px;height: 280px" src="<%=basePath%>${list.jdzp }" alt="${list.jdmc }">
										<div class="carousel-caption">
											<p style="color:  #d43f3a;font-size: 30px;font-weight：900">
												<strong>${list.jdmc }</strong>
											</p>
										</div> 
									</a>
								</div>
							</c:forEach>

						</div>
						<!-- thumbnail area -->


						<div class="row">
							<div id="select" class="col-sm-12"
								style="text-align: center;margin-top: 10px">
								<ul class="pagination">
									<c:if test="${hotelPageBean.hasPreviousPage == true}">
										<li><a href="hotelAction/listHotel/pageNum/1/${xzq_id }/${newsPage }">&laquo;</a>
										</li>
									</c:if>
									<c:forEach varStatus="i" begin="1" end="${hotelPageBean.totalPage}"
										step="1">
										<c:if test="${i.count <= 5 }">
											<li ${hotelPageBean.currentPage == i.count?"class=active":"" }><a
												href="hotelAction/listHotel/pageNum/${i.count }/${xzq_id }/${newsPage }">${i.count}</a>
											</li>
										</c:if>
									</c:forEach>
									<c:if test="${hotelPageBean.hasNextPage == true}">
										<li><a
											href="hotelAction/listHotel/pageNum/${hotelPageBean.nextPage}/${xzq_id }/${newsPage }">&raquo;</a>
										</li>
									</c:if>
								</ul>

							</div>
						</div>
					</c:otherwise>
				</c:choose>
		</div>
		<!-- 模态框 主页新闻内容 -->
		<c:forEach items="${listNews }" var="t">
				<div class="modal fade" id="${t.xwbh}" tabindex="-1" role="dialog"
					aria-labelledby="${t.xwbh}Label" aria-hidden="true">
					<div class="modal-dialog modal-lg">
						<div class="modal-content modal-lg">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h3 class="modal-title" id="${t.xwbh}Label">
									${t.xwbt} <small class="pull-right">${t.fbsj}</small>
								</h3>
							</div>
							<div class="modal-body">${t.xwnr}</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->

		</c:forEach>
		<div class="row">
		<footer class="container">
			<div class="credit row">
				<div class="col-md-12">
					    <div class="col-sm-12 img-rounded" style="text-align: center;margin-top: 5px;margin-bottom: 20px;padding-top: 5px;">
					        Copyright © 2014 <a href="#">Your Company Name</a> 
					        <a href="#" target="_blank" title="邯郸宴会网">邯郸宴会网</a> | Collect from 
							<a href="#" title="邯郸宴会网" target="_blank">邯郸宴会网</a> &nbsp;&nbsp;
							<a href="loginAction/toLogin">后台登录</a>
					    </div>
				</div>
			</div>
		</footer>
		</div>
	</div>
</body>
</html>
