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
    
    <title>经理列表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" media="screen" />
	<link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.min.js"></script>

  </head>
  <p>
  <button type="button" class="btn btn-primary btn-sm" onclick="window.location.href='<c:url value='/userAction/addManager'/>'">添加经理</button>
   </p>
  
  <body>
  	<div class="panel panel-primary">
  	<div class="panel-heading"><strong>经理信息管理</strong></div>
  	<div class="table-responsive">
  	<table width="100%" align="center" class="table table-hover">
		<tr class="active">
			<td>用户ID</td>
			<td>用户名</td>
			<td>酒店名</td>
			<td>操作</td>
		</tr>
		<c:choose>
			<c:when test="${empty managerList}">
			</c:when>
			<c:otherwise>
				<c:forEach items="${managerList }" var="managerList">
					<tr>
						<td>${managerList.yhbh }</td>
						<td>${managerList.yhm}</td>
						<td>${managerList.hotel.jdmc }</td>
						<td>
							<a href="userAction/showManagerById/${managerList.yhbh}">查看详情</a>
							|
							<a href="userAction/updateManagerById/${managerList.yhbh}">修改</a>
							|
							<a href="userAction/deleteManager/${managerList.yhbh }" onclick="return confirm('确定删除此酒店?删除后此酒店下的宴会厅和菜谱也将被删除！')">删除</a>
						</td>
					</tr>	   		
	   			</c:forEach>
			</c:otherwise>
		</c:choose>
    </table>
    </div>
    </div>
    <div class="row">
        <div id="select" class="col-sm-12"
             style="text-align: center;margin-top: 10px">
            <ul class="pagination">
	            <c:if test="${pageBean.hasPreviousPage == true}">
	            	<li><a href="/hotelAction/listManager/pageNum/${pageBean.prePage}/${xzq_id }">&laquo;</a></li>
	            </c:if>
            	<c:forEach varStatus="i" begin="1" end="${pageBean.totalPage}" step="1">
                	<c:if test="${i.count <= 5 }">
                	<li ${pageBean.currentPage == i.count?"class=active":"" }><a href="/hotelAction/listManager/pageNum/${i.count }/${xzq_id }">${i.count }</a></li>
                	</c:if>
                </c:forEach>
             	<c:if test="${pageBean.hasNextPage == true}">
                <li><a href="/hotelAction/listManager/pageNum/${pageBean.nextPage}/${xzq_id }">&raquo;</a></li>
            	</c:if>
            </ul>
           
        </div>
    </div>
  </body>
</html>
