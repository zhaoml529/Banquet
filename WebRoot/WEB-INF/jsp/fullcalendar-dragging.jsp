<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>预定详情</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script src="<%=basePath%>js/jquery-1.10.2.js"></script>
<script src='<%=basePath%>js/jquery-ui.custom.min.js'></script>
<link href="<%=basePath%>css/ace.min.css" rel="stylesheet" />
<link href='<%=basePath%>css/fullcalendar.css' rel='stylesheet' />
<link href="<%=basePath%>css/bootstrap-datetimepicker.min.css" rel="stylesheet"
	media="screen">
<link href="<%=basePath%>css/fullcalendar.print.css" rel="stylesheet" media='print'>
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet" media="screen">
<script src="<%=basePath%>js/bootstrap.min.js"></script>
<script src="<%=basePath%>js/fullcalendar.min.js"></script>
<script src="<%=basePath%>js/ace.min.js"></script>
<script src="<%=basePath%>js/bootbox.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap-datetimepicker.min.js"
	charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<!-- inline scripts related to this page -->
<script type="text/javascript">
	$(document).ready(function() {
	var calendar = $('#calendar').fullCalendar({
		//isRTL: true,
		monthNames: ["01月", "02月", "03月", "04月", "05月", "06月", "07月", "08月", "09月", "10月", "11月", "12月"],
        monthNamesShort: ["01月", "02月", "03月", "04月", "05月", "06月", "07月", "08月", "09月", "10月", "11月", "12月"],
        dayNames: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
        dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
        today: ["今天"],
        firstDay: 1,
		 buttonText: {
			today: '本月',
            month: '月',
            week: '周',
            day: '日',
            prev: '上一月',
            next: '下一月'
		},
	
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		},
		titleFormat:{
		    month: 'yyyy年MMMM ',                             // September 2009
		    week: "yyyy年MMM d[ yyyy]日{ '&#8212;'[ MMM] d日 }", // Sep 7 - 13 2009
		    day: 'yyyy年MMMd dddd'                  // Tuesday, Sep 8, 2009
		},
		
		viewDisplay: function(view) {  
                    var viewStart = $.fullCalendar.formatDate(view.start,"yyyy-MM-dd HH:mm");  
                    var viewEnd = $.fullCalendar.formatDate(view.end,"yyyy-MM-dd HH:mm");  
                    var viewName = view.name;  
                    var _id = ${hotel_id};
                    $("#calendar").fullCalendar('removeEvents');  
                   var para = {hotel_id: _id, start:viewStart,end:viewEnd,viewName:viewName};
                   $.ajax({
                   type: "POST", //使用post方法访问后台
                   url: "orderAction/listOrder", //要访问的后台地址
                   data: para, //要发送的数据
                   success: function (data) {
                        for(var i=0;i<data.length;i++) {  
                            var obj = new Object();  
                            obj.id = data[i].bh;  
                            obj.title = data[i].yhtmz==null?'无':data[i].yhtmz +" ( "+data[i].zt+" ) ";  
                            obj.allDay = data[i].qt;  
                            //如果后台穿过来的是字符串格式的日期类型那么就要用到$.fullCalendar.parseDate(data[i].kssj,"yyyy-MM-dd HH:mm:ss")
							//这个方法来解析日期，将一个字符串日期，格式成一个javascript的Date对象
                            obj.start = data[i].kssj;
                            obj.end =   data[i].jssj;
                            obj.description = data[i].bz;
                            //alert($.fullCalendar.formatDate(obj.start,"yyyy-MM-dd HH:mm:ss"));  
                            $("#calendar").fullCalendar('renderEvent',obj,true);//把从后台取出的数据进行封装以后在页面上以fullCalendar的方式进行显示  
                        }  
                  }
                });
                    
                     
                }, 
        eventMouseover: function (calEvent, jsEvent, view) {
                var fstart = $.fullCalendar.formatDate(calEvent.start, "yyyy/MM/dd HH:mm");
                var fend = $.fullCalendar.formatDate(calEvent.end, "yyyy/MM/dd HH:mm");
                $(this).attr('title', fstart + " - " + fend + " " + "标题" + " : " + calEvent.title);
                $(this).css('font-weight', 'normal');
                $(this).tooltip({
                    effect: 'toggle',
                    cancelDefault: true
                });
            },
		eventClick: function(calEvent, jsEvent, view) {

			//display a modal
			var para = { order_id: calEvent._id};
			$.ajax({
               type: "POST", //使用post方法访问后台
               url: "orderAction/toUpdateOrders", //要访问的后台地址
               data: para, //要发送的数据
               success: function (data) {
               //对话框里面的数据提交完成，data为操作结果
               var zt = data.zt;
               var lxfs = data.lxfs==null?'无':data.lxfs;
               var yhtmc = data.yhtmz==null?'无':data.yhtmz;
               var remark = data.bz==null?'无':data.bz;
               var modal = 
				'<div class="modal fade">\
			  	<div class="modal-dialog">\
			   	<div class="modal-content">\
				 <div class="modal-body">\
				   <button type="button" class="close" data-dismiss="modal" style="margin-top:-10px;">&times;</button>\
				   	<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-cog"></span>查看预定信息</h4><br/>\
					<table class="table table-hover">\
					<tr>\
			    		<td>主题</td>\
			    		<td>' + zt + '</td>\
			    	</tr>\
			    	<tr>\
			    		<td>宴会厅</td>\
			    		<td>'+yhtmc+'</td>\
			    	</tr>\
			    	<tr>\
			    		<td>开始时间</td>\
			    		<td>' + $.fullCalendar.formatDate(calEvent.start,'yyyy-MM-dd HH:mm') + '</td>\
			    	</tr>\
			    	<tr>\
			    		<td>结束时间</td>\
			    		<td>' + $.fullCalendar.formatDate(calEvent.end,'yyyy-MM-dd HH:mm') + '</td>\
			    	</tr>\
			    	</table>\
			    	<h3><span class="label label-info">如需预定宴会厅，请先致电酒店进行预约！</span></h3>\
				 </div>\
				 <div class="modal-footer">\
					<button type="button" class="btn btn-primary" data-dismiss="modal">Ok</button>\
				 </div>\
			  </div>\
			 </div>\
			</div>';
			
			var modal = $(modal).appendTo('body');
			modal.modal('show').on('hidden', function(){
				modal.remove();
			});

            }
            });
		},
	});
})
		</script>


</head>

<body>
	
	<div class="row">
		<div class="col-xs-1">
		</div>
		<div class="col-xs-10">
			<br/>
			<p>点击月份进行查看</p>
			<br/>
			<div id="calendar"></div>
		</div>
		<div class="col-xs-1">
		</div>
	</div>
</body>
</html>
