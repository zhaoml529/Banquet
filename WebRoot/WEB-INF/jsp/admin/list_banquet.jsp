<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>宴会厅列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" media="screen" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link type="text/css" rel="stylesheet"
	href="js/kindeditor-4.1.10/plugins/code/prettify.css" />
<script src="js/jquery-1.10.2.js"></script>
<script src="js/bootstrap.min.js"></script>
<script charset="utf-8" src="js/kindeditor-4.1.10/kindeditor-min.js"></script>
<script charset="utf-8" src="js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script charset="utf-8"
	src="js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
</head>


<body>
	<div class="panel panel-primary">
		<div class="panel-heading">
			<strong>宴会厅列表</strong>
		</div>
		<form action="banquetAction/listAdminBanquet/pageNum/1" method="post">
			<select name="hotel_id" style="width:150px;" required>
				<option value="">--请选酒店--</option>
				<c:forEach items="${hotelList}" var="hotelList">
					<option value="${hotelList.jdbh}">${hotelList.jdmc}</option>
				</c:forEach>
			</select> <input type="submit" class="btn btn-primary btn-sm" value="查找">
		</form>
		<div class="table-responsive">
			<table width="500px" align="center" class="table table-hover">
				<tr class="active">
					<td>宴会厅ID</td>
					<td>宴会厅名称</td>
					<td>宴会厅图片</td>
					<td>操作</td>
				</tr>
				<c:choose>
					<c:when test="${empty banquetList}">
						<tr align="center">
							<td class="danger" colspan="4">无宴会厅信息</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${banquetList }" var="banquetList">
							<tr>
								<td>${banquetList.yhtbh }</td>
								<td>${banquetList.yhtmc }</td>
								<td><img id="view" src="<%=basePath%>${!empty banquetList.yhttp?banquetList.yhttp:'imges/no_picture.gif' }" width="140px" height="140px" class="img-rounded" alt="${banquetList.yhtmc }"></td>
								<td><a
									href="banquetAction/showBanquetRoom/${banquetList.yhtbh }">查看详情</a>
									| <a
									href="banquetAction/adminUpdateBanquetById/${banquetList.yhtbh }">修改</a>
									| <a
									href="banquetAction/adminDeleteBanquetRoom/${banquetList.yhtbh }">删除</a>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		<div id="select" class="col-sm-12"
			style="text-align: center;margin-top: 10px">
			<ul class="pagination">
				<c:if test="${pageBean.hasPreviousPage == true}">
					<li><a
						href="banquetAction/listAdminBanquet/pageNum/${pageBean.prePage}/${xzq_id }">&laquo;</a>
					</li>
				</c:if>
				<c:forEach varStatus="i" begin="1" end="${pageBean.totalPage}"
					step="1">
					<c:if test="${i.count <= 5 }">
						<li ${pageBean.currentPage == i.count?"class=active":"" }><a
							href="banquetAction/listAdminBanquet/pageNum/${i.count }/${xzq_id }">${i.count
								}</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${pageBean.hasNextPage == true}">
					<li><a
						href="banquetAction/listAdminBanquet/pageNum/${pageBean.nextPage}/${xzq_id }">&raquo;</a>
					</li>
				</c:if>
			</ul>
		</div>
	</div>
</body>
</html>
