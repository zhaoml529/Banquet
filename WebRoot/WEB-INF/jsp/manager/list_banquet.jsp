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
    
    <title>宴会厅列表</title>
    
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
  	<div class="panel-heading"><strong>宴会厅列表</strong></div>
  	<div class="panel-body">
  	<div class="table-responsive">
  	<table width="100%" align="center" class="table table-hover">
		<tr class="active">
			<td>宴会厅ID</td>
			<td>宴会厅名称</td>
			<td>宴会厅图片</td>
			<td>操作</td>
		</tr>
		<c:choose>
			<c:when test="${empty banquetList}">
				<div class="alert alert-warning" style="text-align: center;">暂无宴会厅信息</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${banquetList }" var="banquetList">
					<tr>
						<td>${banquetList.yhtbh }</td>
						<td>${banquetList.yhtmc }</td>
						<td><img id="view" src="<%=basePath%>${!empty banquetList.yhttp?banquetList.yhttp:'images/no_picture.gif' }" width="140px" height="140px" class="img-rounded" alt="${banquetList.yhtmc }"></td>
						<td>
							<a href="banquetAction/showBanquetRoom/${banquetList.yhtbh }">查看详情</a>
							|
							<a href="banquetAction/updateBanquetById/${banquetList.yhtbh }">修改</a>
							|
							<a href="banquetAction/deleteBanquetRoom/${banquetList.yhtbh }">删除</a>
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
         	<li><a href="banquetAction/listBanquet/pageNum/${pageBean.prePage}/${xzq_id }">&laquo;</a></li>
         </c:if>
        	<c:forEach varStatus="i" begin="1" end="${pageBean.totalPage}" step="1">
            	<c:if test="${i.count <= 5 }">
            	<li ${pageBean.currentPage == i.count?"class=active":"" }><a href="banquetAction/listBanquet/pageNum/${i.count }/${xzq_id }">${i.count }</a></li>
            	</c:if>
            </c:forEach>
         	<c:if test="${pageBean.hasNextPage == true}">
            <li><a href="banquetAction/listBanquet/pageNum/${pageBean.nextPage}/${xzq_id }">&raquo;</a></li>
        	</c:if>
        </ul>
           
    </div>
    </div>
        
  </body>
</html>
