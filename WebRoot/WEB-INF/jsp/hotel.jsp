<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> -->

<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> 
<![endif]-->
<!--[if IE 7]> <html class="no-js lt-ie9 lt-ie8" lang="en"> 
<![endif]-->
<!--[if IE 8]> <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->

  <head>
    <base href="<%=basePath%>">
    
    <title>宴会网</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
    <meta http-equiv="keywords" content="宴会网,邯郸宴会网,酒店,婚宴,婚宴预定">
    <meta http-equiv="description" content="邯郸宴会网  简单至本  方你所需">
    <link rel="shortcut icon" type="image/x-icon" href="<%=basePath%>images/favicon.ico" media="screen" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script charset="utf-8" src="http://map.qq.com/api/js?v=1"></script>
	<!-- CSS Bootstrap & Custom -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/animate.css">
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css">
	<link rel="stylesheet" href="<%=basePath%>css/templatemo_misc.css">
	<script src="<%=basePath%>js/jquery-1.10.2.js"></script>
	<script src="<%=basePath%>js/bootstrap.min.js"></script>
	<script src="<%=basePath%>js/bootbox.min.js"></script>
	<!-- Main CSS -->
	<link rel="stylesheet" href="<%=basePath%>css/templatemo_style.css">

    <script type="text/javascript">
    	var init = function() {
			var zb = document.getElementById("zb").value;
			var str = zb.split(",") ;
			if( null == zb ){
				str[0] = 36.576075 ;
				str[1] = 114.508544 ;
			}
		    var center = new soso.maps.LatLng(str[0],str[1]);
		    var map = new soso.maps.Map(document.getElementById('mapContainer'),{
		        center: center,
		        zoomLevel: 13
		    });
		    map.notifyResize();
		    var marker = new soso.maps.Marker({
		        position: center,
		        map: map
		    });
		    var zoomControl = new soso.maps.ZoomHintControl({map:map});
		    var maptypectrl = new soso.maps.MapTypeControl({map:map});
		    var navControl = new soso.maps.NavigationControl({
		        align: soso.maps.ALIGN.TOP_LEFT,
		        margin: new soso.maps.Size(5, 15),
		        map: map
		    });
		}

    	function showMenu(menu_lb,menu_jj){
    		bootbox.alert("<h4>套餐简介:</h4><br/>"+menu_jj+"<br/><br/>"+"<h4>套餐列表:</h4><br/>"+menu_lb);
    	}
    </script>
  </body>
  </head>
  
  <body onload="init()">
    <div class="site-header">
		<div class="main-navigation">
		<div class="responsive_menu">
				<ul>
					<li><a href="loginAction/login_view">首页</a></li>
					<li><a class="show-1 templatemo_home" href="#">大厅</a></li>
					<li><a class="show-2 templatemo_page2" href="#">套餐</a></li>
					<li><a class="show-3 templatemo_page3" href="#">预定详情</a></li>
					<li><a class="show-4 templatemo_page4" href="#">酒店简介</a></li>
					<li><a class="show-5 templatemo_page5" href="#">新闻动态</a></li>
				</ul>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-md-12 responsive-menu">
						<a href="#" class="menu-toggle-btn">
				            <i class="fa fa-bars"></i>
				        </a>
					</div> <!-- /.col-md-12 -->
					<div class="col-md-12 main_menu">
						<ul>
							<li><a href="loginAction/login_view">首页</a></li>
							<li><a class="show-1 templatemo_home" href="#">大厅</a></li>
							<li><a class="show-2 templatemo_page2" href="#">套餐</a></li>
							<li><a class="show-3 templatemo_page3" href="#">预定详情</a></li>
							<li><a class="show-4 templatemo_page4" href="#">酒店简介</a></li>
							<li><a class="show-5 templatemo_page5" href="#">新闻动态</a></li>
						</ul>
					</div> <!-- /.col-md-12 -->
				</div> <!-- /.row -->
			</div> 
            
		</div> <!-- /.main-navigation -->
		
		<div class="container">
			<div class="row">
			<div class="col-md-4"></div>
				<div class="col-md-4 text-center">
						<h1 class="templatemo_logo">${hotel.jdmc }</h1>
				</div> <!-- /.col-md-4 -->
				<div class="col-md-4"></div>
			</div> <!-- /.row -->
		</div> <!-- /.container -->
	</div> <!-- /.site-header -->
	
	<div id="menu-container">

		<div class="content homepage" id="menu-1">
			<div class="container-fluid">
				<div class="row" style="margin: 5px">
					<c:forEach items="${banquetList }" var="list" varStatus="i">
						<div class="col-md-2 col-sm-6" id="news_top${list.yhtbh}" rel="popover" data-content="${list.yhtjj }" data-original-title="${list.yhtmc }简介:">
							<div class="gallery-item">
								<img src="<%=basePath%>${list.yhttp }" style="width:100%;" alt="${list.yhtmc }" >
								<div class="overlay">
									<a href="<%=basePath%>${list.yhttp }" data-rel="lightbox" class="fa fa-expand"></a>
								</div>
								<div class="content-gallery">
									<h3>${list.yhtmc }</h3><br/>
									<small>桌数:${list.zs }&nbsp;&nbsp;每桌人数:${list.mzrs }</small>
								</div>
							</div>
							<!-- /.gallery-item -->
						</div>
						<!-- /.col-md-2 -->
						
					</c:forEach>
					
				</div> <!-- /.row -->
			</div> <!-- /.slide-item -->
		</div> <!-- /.homepage -->

		<div class="content products" id="menu-2">
			<div class="container">
					<div class="row">
						<c:forEach items="${menuList }" var="list">
						<div class="col-md-4 col-sm-6" onclick="showMenu('${list.cdlb}','${list.tcjj}');">
							<div class="product-item" >
								<img src="<%=basePath%>${list.zttp }" alt="${list.tcmc }">
								<h3 class="product-title">${list.tcmc } 
							        <small>
							        <c:choose>
							        	<c:when test="${empty list.zk}">
							        		<b>现价： ￥${list.jg}</b>
							        	</c:when>
							        	<c:otherwise>
							        		<font style="font-size: 20px;color:#B10021;">折扣价:￥${list.zk}</font>&nbsp;
							      			<font style="font-size: 13px;color:gray;"><del>原价:￥${list.jg}</del></font>
							        	</c:otherwise>
							        </c:choose>
							      	</small>
						      	</h3>
								<hr style="border:1px solid #B10021;"/>
						        <h4 style="color: blue;">套餐列表:</h4>
						        <p>${list.cdlb }</p>
							</div> <!-- /.product-item -->
						</div> <!-- /.col-md-4 -->
						

						</c:forEach>
					</div> <!-- /.row -->
			</div> <!-- /.slide-item -->
		</div> <!-- /.products -->
		<div class="content services" id="menu-3">
			
			<div class="container1">
				<div class="row">
					<c:import url="/banquetAction/toListOrder/${hotel.jdbh }"></c:import>
				</div> <!-- /.row -->
			</div> <!-- /.container -->
		</div> <!-- /.services -->
		<div class="copyrights">Collect from <a href="http://www.cssmoban.com/" >Website Template</a></div>
		<div class="content about" id="menu-4">
			<div class="container">
				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="thumbnail">
					      <img id="view" src="<%=basePath%>${!empty hotel.jdzp?hotel.jdzp:'imges/no_picture.gif' }" class="img-thumbnail" alt="${menu.cdlb }">
					      <div class="caption">
					        <h3><b>${hotel.jdmc }</b><small style="float: right;"><abbr title="联系人">联系人:</abbr>${hotel.lxr }&nbsp;&nbsp;<abbr title="电话">联系电话:</abbr>${hotel.lxdh }</small></h3>
					      	<hr style="border:1px solid #B10021;"/>
					        <h4 style="color: blue;">酒店简介：</h4>
					        <p>${hotel.jdjj }</p>
					      </div>
					    </div>
					
					</div> <!-- /.col-md-9 -->
				</div> <!-- /.row -->
			</div> <!-- /.container -->
		</div> <!-- /.services -->

		<div class="content contact" id="menu-5">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<div class="widget-content">
							<div class="page-title" style="margin-bottom: 25px;"><span class="glyphicon glyphicon-comment">&nbsp;</span>新闻信息</div>
							<ul class="list-group" style="border:1px solid;border-color: #B10021">
							<c:choose>
								<c:when test="${empty newsList}">
								<div class="alert alert-warning" style="text-align: center;">暂无新闻信息</div>
								</c:when>
								<c:otherwise>
								<c:forEach items="${newsList }" var="list">
								<li class="list-group-item"  data-toggle="modal" data-target="#${list.xwbh }">
					                <span class="badge">${list.fbsj }</span>
					               	${list.xwbt }
					            </li>
								</c:forEach>
								</c:otherwise>
							</c:choose>
        					</ul>
						</div> <!-- /.inner-content -->
					</div> <!-- /.col-md-6 -->
					<div class="col-md-6">
						<div class="widget-content">
							<div class="page-title"><span class="glyphicon glyphicon-map-marker">&nbsp;</span>位置</div>
                            <div class="contact-information" style="border:1px solid red;border-color: #B10021">
                           	        <input type="hidden" id="zb" value="${hotel.zb}">
     								<div style="width: 485px;height: 360px" id="mapContainer"></div>
                            </div> <!-- /.contact-information -->
						</div> <!-- /.inner-content -->
					</div> <!-- /.col-md-6 -->
				</div> <!-- /.row -->
			</div> <!-- /.container -->
		</div> <!-- /.contact -->

	</div> <!-- /#menu-container -->

<c:forEach items="${newsList }" var="t">
<div class="modal fade" id="${t.xwbh }" tabindex="-1" role="dialog" aria-labelledby="${t.xwbh }Label" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="${t.xwbh }Label">${t.xwbt}</h4>
            </div>
            <div class="modal-body" >
               ${t.xwnr}
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</c:forEach>

	<div id="templatemo_footer">
		<div class="container">
			<div class="row">
				<div class="col-md-12 text-center">
					<p>Copyright &copy; 2084 Your  <a href="#" target="_blank" title="邯郸宴会网">邯郸宴会网</a> | Collect from <a href="#" target="_blank" title="邯郸宴会网">邯郸宴会网</a>
					&nbsp;&nbsp;<a href="loginAction/toLogin">后台登录</a></p>
				</div> <!-- /.col-md-12 -->
			</div> <!-- /.row -->
		</div> <!-- /.container -->
	</div> <!-- /.templatemo_footer -->

	<!-- Scripts -->
    <script src="<%=basePath%>js/jquery-migrate-1.2.1.min.js"></script>
    <script src="<%=basePath%>js/modernizr.js"></script>
	<script src="<%=basePath%>js/tabs.js"></script>
	<script src="<%=basePath%>js/jquery.lightbox.js"></script>
	<script src="<%=basePath%>js/templatemo_custom.js"></script>
	<!-- 
    	Free Responsive Template by templatemo
    	http://www.cssmoban.com
	-->
    <script src="<%=basePath%>js/bootstrap-tooltip.js"></script>
	<script src="<%=basePath%>js/bootstrap-popover.js"></script>
	<c:forEach items="${banquetList }" var="list" varStatus="i">
      <script>
			$("#news_top${list.yhtbh}").click(function(){
			  if(${list.yhtbh%6 == 1}){
			  	$("#news_top${list.yhtbh}").popover();
			  }else{
			  	$("#news_top${list.yhtbh}").popover({placement:'top'});
			  }
			  
			}());
    </script>
	</c:forEach>
</html>
