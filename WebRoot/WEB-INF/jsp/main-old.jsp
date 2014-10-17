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
<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" media="screen" />
<meta name="viewport" content="width=device-width" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
<!-- Custom styles for this template -->
<link href="css/justified-nav.css" rel="stylesheet" type="text/css">
<link href="css/templatemo_style.css" rel="stylesheet" type="text/css">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- HTML 5 shim for IE backwards compatibility -->
<!-- [if lt IE 9]>
		<script src="http://html5shim.googlecode.com/svn/trunk/html5.js">
		</script>
		<![endif]-->
</head>

<body>

	<div id="main_container">
		<div class="container" id="home">
			<div class="header">
				<div class="navbar-header">
					<a href="#"> <img src="imges/logo.png" style="width: 200px"
						alt="fantasy" class="templatemo_logo">
					</a>
				</div>

			</div>
		</div>
		<div class="row">
		<div class="col-md-6">
			<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<c:forEach items="${listURL }" var="list" varStatus="i">
						<li data-target="#carousel-example-generic"
							data-slide-to="${i.count }" class="${i.count == 1?' active':'' }"></li>
					</c:forEach>
				</ol>

				<!-- Wrapper for slides -->
				<div class="carousel-inner">
					<c:forEach items="${listURL }" var="list" varStatus="i">
						<div class="item${i.count == 1?' active':'' }" style="height="300px"">
							<a href="hotelAction/listHotel/${list.jdbh }"> <img
								src="${list.jdzp }" width="100%" alt="First slide image">
							</a>
							<div class="carousel-caption">
								<h3>${list.jdmc }</h3>
								<p>${list.jddz }</p>
							</div>
						</div>
					</c:forEach>
				</div>

				<!-- Controls -->
				<a class="left carousel-control" href="#carousel-example-generic"
					data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left"></span> </a> <a
					class="right carousel-control" href="#carousel-example-generic"
					data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right"></span> </a>
			</div>
		</div>
	   <div class="col-md-6">

				<ul class="list-group">
					<c:forEach items="${listNews }" var="list">
						<li class="list-group-item" data-toggle="modal"
							data-target="#${list.xwbh}"><span class="badge">${list.fbsj}</span> ${list.xwbt }</li>
					</c:forEach>
				</ul>
				<div class="row">
				<div id="select" class="col-sm-12"
					style="text-align: center;margin-top: 10px">
					<ul class="pagination">
						<c:if test="${newsPageBean.hasPreviousPage == true}">
							<li><a
								href="newsAction/listNews/pageNum/${newsPageBean.prePage}/${xzq_id}">&laquo;</a>
							</li>
						</c:if>
						<c:forEach varStatus="i" begin="1" end="${newsPageBean.totalPage}"
							step="1">
							<c:if test="${i.count <= 5 }">
								<li><a href="newsAction/listNews/pageNum/${i.count }/${xzq_id}">${i.count
										}</a>
								</li>
							</c:if>
						</c:forEach>
						<c:if test="${newsPageBean.hasNextPage == true}">
							<li><a
								href="newsAction/listNews/pageNum/${newsPageBean.nextPage}/${xzq_id}">&raquo;</a>
							</li>
						</c:if>
					</ul>

				</div>
			</div>
			</div>
		</div>
		<div class="row" style="margin-top: 20px">
			<div class="col-sm-12">
				<div class="masthead" id="masthead">
					<ul class="nav nav-justified">
						<li class="${xzq_id==1?'active':'' }"><a
							href="hotelAction/listHotel/pageNum/1/1">丛台区</a>
						</li>
						<li class="${xzq_id==2?'active':'' }"><a
							href="hotelAction/listHotel/pageNum/1/2">高开区</a>
						</li>
						<li class="${xzq_id==3?'active':'' }"><a
							href="hotelAction/listHotel/pageNum/1/3">复兴区</a>
						</li>
						<li class="${xzq_id==4?'active':'' }"><a
							href="hotelAction/listHotel/pageNum/1/4">邯山区</a>
						</li>
						<li class="${xzq_id==5?'active':'' }"><a
							href="hotelAction/listHotel/pageNum/1/5">新闻及网站介绍</a>
						</li>
					</ul>
				</div>
				<!-- nav -->
			</div>
		</div>
		<c:if test="${xzq_id==1||xzq_id==2||xzq_id==3||xzq_id==4}">
			<div class="row" id="thumbnails_container">
				<c:choose>
					<c:when test="${empty listHotel }">
						<div class="alert alert-warning" style="text-align: center;">暂无酒店信息</div>
					</c:when>
					<c:otherwise>
						<div class="row" style="margin-top: 5px">
							<c:forEach items="${listHotel }" var="list" varStatus="i">
								<div class="col-sm-3" style="text-align: center;margin-top: 5px">
									<a href="hotelAction/listHotel/${list.jdbh }"
										class="item active"> <img class="img-thumbnail"
										style="width: 280px;height: 280px" src="${list.jdzp }"
										alt="${list.jdmc }">
										<div class="carousel-caption">
											<p style="color:  #d43f3a;font-size: 30px;font-weight：900">
												<strong>${list.jdmc }</strong>
											</p>
										</div> </a>
								</div>
							</c:forEach>

						</div>
						<!-- thumbnail area -->


						<div class="row">
							<div id="select" class="col-sm-12"
								style="text-align: center;margin-top: 10px">
								<ul class="pagination">
									<c:if test="${hotelPageBean.hasPreviousPage == true}">
										<li><a href="hotelAction/listHotel/pageNum/1/${xzq_id }">&laquo;</a>
										</li>
									</c:if>
									<c:forEach varStatus="i" begin="1" end="${hotelPageBean.totalPage}"
										step="1">
										<c:if test="${i.count <= 5 }">
											<li><a
												href="hotelAction/listHotel/pageNum/${i.count }/${xzq_id }">${i.count
													}</a>
											</li>
										</c:if>
									</c:forEach>
									<c:if test="${pageBean.hasNextPage == true}">
										<li><a
											href="hotelAction/listHotel/pageNum/${hotelPageBean.nextPage}/${xzq_id }">&raquo;</a>
										</li>
									</c:if>
								</ul>

							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</c:if>
		<c:if test="${xzq_id==5}">
			<div class="row" style="margin-top: 40px">
				<di class="col-sm-12">
				<h1 class="text-center" style="font-size: 45px;">
					<strong>邯郸宴会网</strong>
				</h1>
				</di>
			</div>
			<div class="row" style="margin-top: 40px">
				<div class="col-sm-1"></div>
				<div class="col-sm-10"
					style="background-color:  #6F0015;color: white;">



					<p style="font-size: 26px;margin-top: 20px;margin-bottom: 10px">网站介绍</p>
					<p>邯郸宴会网是一个服务于邯郸市民的酒店婚宴信息查询网站，在这里你可以查看邯郸市所有的酒店详情，了解酒店情况，为您的婚礼预定场地，酒店。</p>

					<h3 style="font-size: 26px;margin-top: 20px;margin-bottom: 10px">
						<strong>联系方式</strong>
					</h3>
					<p>
						网站服务专线：15155151515<br /> QQ：88888888<br />
						邮箱：love.coffee2008@163.com<br /> 网址：www.hdyh.com<br />
						地址：邯郸市学院北路邯郸学院
					</p>

					<h3 style="font-size: 26px;margin-top: 20px;margin-bottom: 10px">
						<strong>服务宗旨</strong>
					</h3>
					<p>简单至本，方您所需</p>



				</div>
				<div class="col-sm-1"></div>

			</div>

		</c:if>
		<c:forEach items="${listNews }" var="t">
				<div class="modal fade" id="${t.xwbh}" tabindex="-1" role="dialog"
					aria-labelledby="${t.xwbh}Label" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
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
		<div class="copyrights">
			Collect from <a href="#">Website Template</a>
		</div>
		<footer class="container">
			<div class="credit row">
				<div class="col-md-12">
					<div class="text-center" id="templatemo_footer">
						Copyright © 2084 <a href="#">Your Company Name</a> <a href="#"
							target="_blank" title="邯郸宴会网">邯郸宴会网</a> | Collect from <a
							href="#" title="邯郸宴会网" target="_blank">邯郸宴会网</a> &nbsp;&nbsp;<a
							href="loginAction/toLogin">后台登录</a>
					</div>
				</div>
			</div>
		</footer>



	</div>


</body>
</html>
