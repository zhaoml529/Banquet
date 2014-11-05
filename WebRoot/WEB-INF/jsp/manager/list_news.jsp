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
    
    <title>新闻列表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="<%=basePath%>images/favicon.ico" media="screen" />
	<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=basePath%>js/jquery-1.10.2.min.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>

  </head>
  
  <body>
    <div class="panel panel-primary">
  	<div class="panel-heading"><strong>新闻列表</strong></div> 	
  	<div class="panel-body">
  	<div class="table-responsive">
  	<table width="100%" align="center" class="table table-hover">
		<tr class="active">
			<td>新闻编号</td>
			<td>新闻标题</td>
			<td>发布时间</td>
			<td>是否显示</td>
			<td>是否通过</td>
			<td>操作</td>
		</tr>
		<c:choose>
			<c:when test="${empty newsList}">
				<tr align="center">
					<td class="danger" colspan="6">无新闻信息</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${newsList }" var="list">
					<tr>
						<td>${list.xwbh }</td>
						<td>${list.xwbt }</td>
						<td>${list.fbsj }</td>
						<td>${list.xs == 1?'<span class="label label-primary">是</span>':'<span class="label label-danger">否</span>' }</td>
						<td>${list.sh == 1?'<span class="label label-primary">是</span>':'<span class="label label-danger">否</span>' }</td>
						<td>
							<a href="newsAction/managerShowNewsById/${list.xwbh }">详情</a>
							|
							<a href="newsAction/managerUpdateNewsById/${list.xwbh }">修改</a>
							|
							<a href="newsAction/managerDeleteNews/${list.xwbh }" onclick="return confirm('确定删除此新闻?')">删除</a>
							|
							<c:choose>
								<c:when test="${list.xs == 1 }">
									<a href="newsAction/managerDisplayNews/${list.xwbh }/0/${pageBean.currentPage}">不显示</a>
								</c:when>
								<c:otherwise>
									<a href="newsAction/managerDisplayNews/${list.xwbh }/1/${pageBean.currentPage}">显示</a>
								</c:otherwise>
							</c:choose>
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
         	<li><a href="newsAction/listManagerNews/pageNum/${pageBean.prePage}">&laquo;</a></li>
         </c:if>
        	<c:forEach varStatus="i" begin="1" end="${pageBean.totalPage}" step="1">
            	<c:if test="${i.count <= 5 }">
            	<li ${pageBean.currentPage == i.count?"class=active":"" }><a href="newsAction/listManagerNews/pageNum/${i.count }">${i.count }</a></li>
            	</c:if>
            </c:forEach>
         	<c:if test="${pageBean.hasNextPage == true}">
            <li><a href="newsAction/listManagerNews/pageNum/${pageBean.nextPage}">&raquo;</a></li>
        	</c:if>
        </ul>           
    </div>
	</div>
  </body>
</html>
