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
    <script src="<%=basePath%>js/bootstrap-tooltip.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>
    <script src="<%=basePath%>js/bootbox.min.js"></script>
	<script type="text/javascript">
		function subForm(){
			var url="<c:url value='/newsAction/listAdminNews/pageNum/1'/>";
			var selValue=$("select option:selected").val();
			if(selValue==null||selValue==''){
				bootbox.alert("<h4><span class='label label-warning'>Warning!</span>&nbsp;&nbsp;请选择要查看新闻的酒店！ </h4>");
			}else{
			url=url+"/"+selValue;
			location.href=url;
			}
		}
		
	</script>
  </head>
  
  <body style="width: 96%">
    <div class="panel panel-primary">
  	<div class="panel-heading"><strong>新闻列表</strong></div>
  	<br>
  	<form action="newsAction/listAdminNews/pageNum/1" method="post">
  	&nbsp;&nbsp;
    <select name="hotel_id" id="hotel_id" style="width:150px;" required>
	 	<option value="">--请选酒店--</option>
	 	<option value="admin">管理员的新闻</option>
	 	<c:forEach items="${hotelList}" var="hotelList">
	 		<option value="${hotelList.jdbh}">${hotelList.jdmc}</option>
	 	</c:forEach>
     </select>  &nbsp;&nbsp;
     <input type="button" class="btn btn-primary btn-sm"  value="查找" onclick="subForm();">&nbsp;&nbsp;
     <a href="newsAction/listPendingNews/pageNum/1/1" class="btn btn-primary btn-sm" role="button" data-toggle="tooltip" data-placement="right" title="查看所有酒店待审核新闻">待审核 &nbsp;<span class="badge">${newsCount }</span></a>
     </form>
  	<div class="panel-body">
  	<div class="table-responsive">
  	<table align="center" class="table table-hover">
		<tr class="active" align="center">
			<td>编号</td>
			<td width="25%">新闻标题</td>
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
					<tr valign="middle" style="vertical-align: middle;">
						<td>${list.xwbh }</td>
						<td width="25%">${list.xwbt }</td>
						<td>${list.fbsj }</td>
						<td align="center">${list.xs == 1?'<span class="label label-primary">是</span>':'<span class="label label-danger">否</span>' }</td>
						<td align="center">${list.sh == 1?'<span class="label label-primary">是</span>':'<span class="label label-danger">否</span>' }</td>
						<td>
							<a href="newsAction/adminPassNewsById/${list.xwbh }">审核</a>
							|
							<c:choose>
								<c:when test="${list.xs == 1 }">
									<a href="newsAction/adminDisplayNews/${list.xwbh }/0">不显示</a>|
								</c:when>
								<c:otherwise>
									<a href="newsAction/adminDisplayNews/${list.xwbh }/1">显示</a>|
								</c:otherwise>
							</c:choose>
							<a href="newsAction/adminUpdateNewsById/${list.xwbh }">修改</a>
							|
							<a href="newsAction/adminDeleteNews/${list.xwbh }" onclick="return confirm('确定删除此条新闻？');">删除</a>
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
         	<li><a href="newsAction/${pageAction }/pageNum/${pageBean.prePage}/${hotel_id }">&laquo;</a></li>
         </c:if>
        	<c:forEach varStatus="i" begin="1" end="${pageBean.totalPage}" step="1">
            	<c:if test="${i.count <= 5 }">
            	<li ${pageBean.currentPage == i.count?"class=active":"" }><a href="newsAction/${pageAction }/pageNum/${i.count }/${hotel_id }">${i.count }</a></li>
            	</c:if>
            </c:forEach>
         	<c:if test="${pageBean.hasNextPage == true}">
            <li><a href="newsAction/${pageAction }/pageNum/${pageBean.nextPage}/${hotel_id }">&raquo;</a></li>
        	</c:if>
        </ul>
    </div>
	</div>
        
	<script>
		$(function () {
		  $('[data-toggle="tooltip"]').tooltip()
		})
	</script>
  </body>
</html>
