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
    
    <title>菜单列表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="<%=basePath%>images/favicon.ico" media="screen" />
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=basePath%>js/jquery-1.10.2.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>
  </head>
  
  <body>
    <div class="panel panel-primary">
	  	<div class="panel-heading"><strong>菜单列表</strong></div>
	  	<div class="panel-body">
	  	<div class="table-responsive">
	  	<table width="100%" align="center" class="table table-hover">
		<tr class="active">
			<td>菜单ID</td>
			<td>菜单名称</td>
			<td>菜单图片</td>
			<td>操作</td>
		</tr>
		<c:choose>
			<c:when test="${empty menuList}">
				<div class="alert alert-warning" style="text-align: center;">暂无套餐信息</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${menuList }" var="menuList">
					<tr>
						<td>${menuList.tcbh }</td>
						<td>${menuList.tcmc }</td>
						<td><img id="view" src="<%=basePath%>${!empty menuList.zttp?menuList.zttp:'images/no_picture.gif' }" width="140px" height="140px" class="img-rounded" alt="${menuList.zttp }"></td>
						<td>
							<a href="menuAction/showMenu/${menuList.tcbh }">查看详情</a>
							|
							<a href="menuAction/updateMenuById/${menuList.tcbh }/${hotel_id}">修改</a>
							|
							<a href="menuAction/deleteMenu/${menuList.tcbh }">删除</a>
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
          	<li><a href="menuAction/listMenu/pageNum/${pageBean.prePage}">&laquo;</a></li>
          </c:if>
         	<c:forEach varStatus="i" begin="1" end="${pageBean.totalPage}" step="1">
             	<c:if test="${i.count <= 5 }">
             	<li ${pageBean.currentPage == i.count?"class=active":"" }><a href="menuAction/listMenu/pageNum/${i.count }">${i.count }</a></li>
             	</c:if>
             </c:forEach>
          	<c:if test="${pageBean.hasNextPage == true}">
             <li><a href="menuAction/listMenu/pageNum/${pageBean.nextPage}">&raquo;</a></li>
         	</c:if>
         </ul>
    </div>
  	</div>
        
  </body>
</html>
