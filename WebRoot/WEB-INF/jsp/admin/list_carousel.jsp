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
    
    <title>轮播管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="<%=basePath%>images/favicon.ico" media="screen" />
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=basePath%>js/jquery-1.10.2.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>
	<script src="<%=basePath%>js/bootbox.min.js"></script>
	<script type="text/javascript">
	function addCarousel(jdbh) {
		$.post('hotelAction/addCarousel/'+jdbh, { }, function(data) {
				if(data == "success"){
					bootbox.confirm("<h5><span class='label label-success'>Success!</span>&nbsp;&nbsp;成功添加轮播图片到首页！ </h5>", function(result) {
						window.location = window.location
					});
				}else{
					bootbox.alert("<h5><span class='label label-danger'>Info!</span>&nbsp;&nbsp;添加失败！ </h5>");
					setTimeout("window.location = window.location;",2000);
				}
			});
	}
	function deleteCarousel(jdbh){
		bootbox.confirm("<h5><span class='label label-warning'>Warning!</span>&nbsp;&nbsp;确定删除此酒店在主页上的轮播图片吗? </h5>", function(result) {
			if(result){
				$.post('hotelAction/deleteCarousel/'+jdbh, { }, function(data) {
					if(data == "success"){
						bootbox.confirm("<h5><span class='label label-success'>Success!</span>&nbsp;&nbsp;删除首页轮播图片成功！ </h5>", function(result) {
							window.location = window.location
						});
					}else{
						bootbox.alert("<h5><span class='label label-danger'>Info!</span>&nbsp;&nbsp;删除失败！ </h5>");
						setTimeout("window.location = window.location;",2000);
					}
				});
            }
		});
	}
	</script>
  </head>
  
  <body>
    <div class="panel panel-primary">
  	<div class="panel-heading"><strong>酒店列表</strong></div>
  	<div class="panel-body">
  	<div class="table-responsive" id="myDiv">
  	<table width="95%" align="center" class="table table-hover">
		<tr class="active">
			<td>酒店ID</td>
			<td>酒店名称</td>
			<td>酒店图片</td>
			<td>操作</td>
		</tr>
		<c:choose>
			<c:when test="${empty listHotel}">
				<tr align="center">
					<td class="danger" colspan="4">无酒店信息</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${listHotel }" var="list">
					<c:set var="isDone" value="0"/>
					<tr>
						<td>${list.jdbh }</td>
						<td>${list.jdmc }</td>
						<td><img id="view" src="<%=basePath%>${!empty list.jdzp?list.jdzp:'images/no_picture.gif' }" width="140px" height="140px" class="img-rounded" alt="Responsive image"></td>
						<td>
							<c:forEach items="${listURL }" var="carousel">
								<c:if test="${carousel.jdbh == list.jdbh  }">
									<c:set var="isDone" value="1"/>
									<input type="button" class="btn btn-default  btn-sm" value="添加到首页图片" disabled="disabled">|
									<input type="button" class="btn btn-primary btn-sm" value="删除首页图片" onclick="deleteCarousel(${list.jdbh});">
								</c:if>
							</c:forEach>
							<c:if test="${isDone != 1 }">
									<input type="button" class="btn btn-primary btn-sm" value="添加到首页图片" onclick="addCarousel(${list.jdbh});"">|
									<input type="button" class="btn btn-default  btn-sm" value="删除首页图片" disabled="disabled" >
							</c:if>
						</td>
					</tr>	   		
	   			</c:forEach>
			</c:otherwise>
		</c:choose>
    </table>
    </div>
    </div>
    <div id="select" class="col-sm-12"
             style="text-align: center;">
      <ul class="pagination">
       <c:if test="${pageBean.hasPreviousPage == true}">
       	<li><a href="hotelAction/getHotelAllList/pageNum/${pageBean.prePage}/${xzq_id }">&laquo;</a></li>
       </c:if>
      	<c:forEach varStatus="i" begin="1" end="${pageBean.totalPage}" step="1">
          	<c:if test="${i.count <= 5 }">
          	<li ${pageBean.currentPage == i.count?"class=active":"" }><a href="hotelAction/getHotelAllList/pageNum/${i.count }/${xzq_id }">${i.count }</a></li>
          	</c:if>
          </c:forEach>
       	<c:if test="${pageBean.hasNextPage == true}">
          <li><a href="hotelAction/getHotelAllList/pageNum/${pageBean.nextPage}/${xzq_id }">&raquo;</a></li>
      	</c:if>
      </ul>
    </div>
    </div>
  </body>
</html>
