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

<title>My JSP 'fullcalendar-dragging.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script src="js/jquery-1.10.2.js"></script>
<script src='js/jquery-ui.custom.min.js'></script>
<link href="css/ace.min.css" rel="stylesheet" />
<link href='css/fullcalendar.css' rel='stylesheet' />
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"
	media="screen">
<link href="css/fullcalendar.print.css" rel="stylesheet" media='print'>
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<script src="js/bootstrap.min.js"></script>
<script src="js/fullcalendar.min.js"></script>
<script src="js/ace.min.js"></script>
<script src="js/bootbox.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"
	charset="UTF-8"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.zh-CN.js"
	charset="UTF-8"></script>
<!-- inline scripts related to this page -->
<script type="text/javascript">
	$(document).ready(function() {

/* initialize the external events
	-----------------------------------------------------------------*/
	//从从日历外拖拽事件到日历中
	//设置相应div的drop操作
	$('#external-events div.external-event').each(function() {

		// create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
		// it doesn't need to have a start or end
		var str = $(this).text();
		var title = str.substring(str.indexOf('.')+1);
		var eventObject = {
			title: $.trim(title) // use the element's text as the event title
		};

		// store the Event Object in the DOM element so we can get to it later
		$(this).data('eventObject', eventObject);

		// make the event draggable using jQuery UI
		$(this).draggable({
			zIndex: 999,
			revert: true,      // will cause the event to go back to its
			revertDuration: 0  //  original position after the drag
		});
		
	});




	/* initialize the calendar
	-----------------------------------------------------------------*/

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();

	
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
		events: [
		  {
			title: 'All Day Event',
			start: new Date(y, m, 1),
			className: 'label-important'
		  },
		  {
			title: 'Long Event',
			start: new Date(y, m, d-5),
			end: new Date(y, m, d-2),
			className: 'label-success'
		  },
		  {
			title: 'Some Event',
			start: new Date(y, m, d-3, 16, 0),
			allDay: false
		  }
		],
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
		editable: true,
		eventDrop: function(event,dayDelta,minuteDelta,allDay,revertFunc) {
		//拖动日程触发
			bootbox.confirm("<h5><span class='label label-warning'>Warning!</span>&nbsp;&nbsp;预定时间已改变,您确定改变为当前的预定时间吗?</h5>", function(result) {
			if(result){
				var para = {order_id: event.id, qt: allDay, start: $.fullCalendar.formatDate(event.start,'yyyy-MM-dd HH:mm'), end: $.fullCalendar.formatDate(event.end,'yyyy-MM-dd HH:mm')};
				$.ajax({
                   type: "POST", //使用post方法访问后台
                   url: "orderAction/dropUpdateOrders", //要访问的后台地址
                   data: para, //要发送的数据
                   success: function (data) {
                     //对话框里面的数据提交完成，data为操作结果
                     bootbox.alert("<h4><span class='label label-success'>Success!</span>&nbsp;&nbsp;修改成功！</h4>");
                  },
                  error:function(){
                  	alert("改变日程出错,日程已还原为改变之前！");
                  	revertFunc();//还原到拖动之前
                  }
                });
               }else{
	        	revertFunc();
	           }
			}); 
	    },
	    eventResize: function(event,dayDelta,minuteDelta,revertFunc) {
	    //拖动日程大小改变时间触发
	    	bootbox.confirm("<h5><span class='label label-warning'>Warning!</span>&nbsp;&nbsp;预定时间已改变,您确定改变为当前的预定时间吗? </h5>", function(result) {
			if(result){
				var para = {order_id: event.id, start: $.fullCalendar.formatDate(event.start,'yyyy-MM-dd HH:mm'), end: $.fullCalendar.formatDate(event.end,'yyyy-MM-dd HH:mm')};
				$.ajax({
                   type: "POST", //使用post方法访问后台
                   url: "orderAction/dropUpdateOrders", //要访问的后台地址
                   data: para, //要发送的数据
                   success: function (data) {
                     //对话框里面的数据提交完成，data为操作结果
                     bootbox.alert("<h4><span class='label label-success'>Success!</span>&nbsp;&nbsp;修改成功！</h4>");
                  },
                  error:function(){
                  	alert("改变日程出错,日程已还原为改变之前！");
                  	revertFunc();//还原到拖动之前
                  }
                });
               }else{
	        	revertFunc();
	           }
			}); 
	    },
		droppable: true, // this allows things to be dropped onto the calendar !!!
		drop: function(date, allDay) { // this function is called when something is dropped
			//拖动菜单栏上面的日程触发，可以显示到日程上面。
			// retrieve the dropped element's stored Event Object
			var originalEventObject = $(this).data('eventObject');
			var $extraEventClass = $(this).attr('data-class');
			
			// we need to copy it, so that multiple events don't have a reference to the same object
			var copiedEventObject = $.extend({}, originalEventObject);
			
			// assign it the date that was reported
			copiedEventObject.start = date;
			copiedEventObject.allDay = allDay;
			if($extraEventClass) copiedEventObject['className'] = [$extraEventClass];
			bootbox.confirm("<h5><span class='label label-warning'>Warning!</span>&nbsp;&nbsp;您需要编辑此预定信息！ </h5>", function(result) {
			if(result){
				var para = {title: copiedEventObject.title,banquet_name:copiedEventObject.title , start: $.fullCalendar.formatDate(date,'yyyy-MM-dd HH:mm'), end: $.fullCalendar.formatDate(date,'yyyy-MM-dd HH:mm')};
				$.ajax({
                   type: "POST", //使用post方法访问后台
                   url: "orderAction/saveOrders", //要访问的后台地址
                   data: para, //要发送的数据
                   success: function (data) {
                     //对话框里面的数据提交完成，data为操作结果
                     var obj = new Object();  
                     obj.id = data.bh;  
                     obj.title = data.zt==null?'无':data.zt;  
                     obj.allDay = data.qt;  
                     obj.start = data.kssj;
                     obj.end =   data.jssj;
                     obj.className = [$extraEventClass];
                     $("#calendar").fullCalendar('renderEvent',obj,true);//把从后台取出的数据进行封装以后在页面上以fullCalendar的方式进行显示  
                  }
                });
            }
			});
			
			
			
			// render the event on the calendar
			// the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
			//$('#calendar').fullCalendar('renderEvent', copiedEventObject, true);
			
			// is the "remove after drop" checkbox checked?
			if ($('#drop-remove').is(':checked')) {
				// if so, remove the element from the "Draggable Events" list
				$(this).remove();
			}
			
		}
		,
		selectable: true,
		selectHelper: true,
		select: function(start, end, allDay) {
			var modal = 
			'<div class="modal fade">\
			  <div class="modal-dialog">\
			   <div class="modal-content">\
				 <div class="modal-body">\
				   <button type="button" class="close" data-dismiss="modal" style="margin-top:-10px;">&times;</button>\
				   <form class="no-margin" action="orderAction/saveOrders" method="post">\
				   	<h4 class="modal-title" id="myModalLabel">添加预定信息</h4><br/>\
					<table class="table table-hover">\
					<tr>\
			    		<td>主题</td>\
			    		<td><input name="zt" type="text" value="" class="form-control" placeholder="预定主题" required/></td>\
			    	</tr>\
			    	<tr>\
			    		<td>宴会厅</td>\
			    		<td>\
			    		<select name="yhtmc" class="form-control" style="width:300px;" required autofocus>\
						 	<option value="">--请选择宴会厅--</option>\
						 	<c:forEach items="${banquetList}" var="banquetList">\
						 		<option value="${banquetList.yhtmc}">${banquetList.yhtmc}</option>\
						 	</c:forEach>\
					      </select>\
			    		</td>\
			    	</tr>\
			    	<tr>\
			    		<td>开始时间</td>\
			    		<td>\
			    		<div class="input-group date form_datetime col-md-5" style="width: 400px" data-date="' + $.fullCalendar.formatDate(start,'yyyy-MM-dd HH:mm') + '" data-date-format="dd MM yyyy - HH:ii p" data-link-field="dtp_input1">\
		                    <input class="form-control" name="startTime" size="16" type="text" value="' + $.fullCalendar.formatDate(start,'yyyy-MM-dd HH:mm') + '" readonly required>\
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>\
							<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>\
		                </div>\
						<input type="hidden" id="dtp_input1" value="" /><br/>\
			    		</td>\
			    	</tr>\
			    	<tr>\
			    		<td>结束时间</td>\
			    		<td>\
			    		<div class="input-group date form_datetime col-md-5" style="width: 400px" data-date="' + $.fullCalendar.formatDate(end,'yyyy-MM-dd HH:mm') + '" data-date-format="dd MM yyyy - HH:ii p" data-link-field="dtp_input2">\
		                    <input class="form-control" name="endTime" size="16" type="text" value="' + $.fullCalendar.formatDate(end,'yyyy-MM-dd HH:mm') + '" readonly required>\
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>\
							<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>\
		                </div>\
						<input type="hidden" id="dtp_input2" value="" /><br/>\
			    		</td>\
			    	</tr>\
			    	<tr>\
			    		<td>联系人</td>\
			    		<td><input name="lxfs" type="text" value="" class="form-control" placeholder="联系电话" required/></td>\
			    	</tr>\
			    	<tr>\
			    		<td>备注</td>\
			    		<td><textarea name="remark" class="form-control" rows="3" cols="53"></textarea></td>\
			    	</tr>\
			    	<tr>\
			    		<td colspan="2">\
			    		<button type="submit" class="btn btn-primary">Save</button>\
			    		<button type="button" class="btn btn-sm" data-dismiss="modal">Cancel</button>\
			    		</td>\
			    	</tr>\
			    	</table>\
			    	</form>\
				 </div>\
			  </div>\
			 </div>\
			</div>';
		
			//modal.find('button[data-action=delete]').on('click', function() {
			var modal = $(modal).appendTo('body');
			modal.find('form').on('submit', function(ev){
				ev.preventDefault();
				var _title = $(this).find("input[name=zt]").val();
				var _start = $(this).find("input[name=startTime]").val();
				var _end = $(this).find("input[name=endTime]").val();
				var _yhtmc = $(this).find("select[name=yhtmc]").val();
				var _tel = $(this).find("input[name=lxfs]").val();
				var _remark = $(this).find("textarea[name=remark]").val();
				var para = {banquet_name: _yhtmc, title: _title, start: _start, end: _end, lxfs: _tel, bz: _remark };
				$.ajax({
                   type: "POST", //使用post方法访问后台
                   url: "orderAction/saveOrders", //要访问的后台地址
                   data: para, //要发送的数据
                   success: function (data) {
                     //对话框里面的数据提交完成，data为操作结果
                     var obj = new Object();  
                     obj.id = data.bh;  
                     obj.title = data.yhtmz+" ( "+data.zt+" ) ";  
                     obj.allDay = data.qt;  
                     //如果后台穿过来的是字符串格式的日期类型那么就要用到$.fullCalendar.parseDate(data[i].kssj,"yyyy-MM-dd HH:mm:ss")
					//这个方法来解析日期，将一个字符串日期，格式成一个javascript的Date对象
                     obj.start = data.kssj;
                     obj.end =   data.jssj;
                     //alert($.fullCalendar.formatDate(obj.start,"yyyy-MM-dd HH:mm:ss"));  
                     $("#calendar").fullCalendar('renderEvent',obj,true);//把从后台取出的数据进行封装以后在页面上以fullCalendar的方式进行显示  
                     modal.modal("hide");
                  }
                });
			});
			modal.modal('show').on('hidden', function(){
				modal.remove();
			});
			$('.form_datetime').datetimepicker({
		        language:  'zh-CN',
		        format: 'yyyy-mm-dd hh:ii',
		        weekStart: 1,
		        todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				forceParse: 0,
		        showMeridian: 1
		    });
		},
		loading: function (bool) {
                if (bool) $('#loading').show();
                else $('#loading').hide();
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
				   <form class="no-margin" action="orderAction/updateOrders" method="post">\
				   	<h4 class="modal-title" id="myModalLabel">修改预定信息</h4><br/>\
					<table class="table table-hover">\
					<tr>\
			    		<td>主题</td>\
			    		<td><input name="zt" type="text" value="' + zt + '" class="form-control" placeholder="预定主题" required/></td>\
			    	</tr>\
			    	<tr>\
			    		<td>宴会厅</td>\
			    		<td>\
			    		<select name="yhtmc" style="width:300px;" required autofocus>\
						 	<option value="">--请选择宴会厅--</option>\
						 	<c:forEach items="${banquetList}" var="banquetList">\
						 	<option value="${banquetList.yhtmc}">${banquetList.yhtmc}</option>\
						 	</c:forEach>\
					    </select>\
					          <span class="label label-info">'+yhtmc+'</span>\
			    		</td>\
			    	</tr>\
			    	<tr>\
			    		<td>开始时间</td>\
			    		<td>\
			    		<div class="input-group date form_datetime col-md-5" style="width: 400px" data-date="' + $.fullCalendar.formatDate(calEvent.start,'yyyy-MM-dd HH:mm') + '" data-date-format="dd MM yyyy - HH:ii p" data-link-field="dtp_input1">\
		                    <input class="form-control" name="startTime" size="16" type="text" value="' + $.fullCalendar.formatDate(calEvent.start,'yyyy-MM-dd HH:mm') + '" readonly required>\
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>\
							<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>\
		                </div>\
						<input type="hidden" id="dtp_input1" value="" /><br/>\
			    		</td>\
			    	</tr>\
			    	<tr>\
			    		<td>结束时间</td>\
			    		<td>\
			    		<div class="input-group date form_datetime col-md-5" style="width: 400px" data-date="' + $.fullCalendar.formatDate(calEvent.end,'yyyy-MM-dd HH:mm') + '" data-date-format="dd MM yyyy - HH:ii p" data-link-field="dtp_input2">\
		                    <input class="form-control" name="endTime" size="16" type="text" value="' + $.fullCalendar.formatDate(calEvent.end,'yyyy-MM-dd HH:mm') + '" readonly required>\
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>\
							<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>\
		                </div>\
						<input type="hidden" id="dtp_input2" value="" /><br/>\
			    		</td>\
			    	</tr>\
			    	<tr>\
			    		<td>联系人</td>\
			    		<td><input name="lxfs" type="text" value="' + lxfs + '" class="form-control" placeholder="联系电话" required/></td>\
			    	</tr>\
			    	<tr>\
			    		<td>备注</td>\
			    		<td><textarea name="remark" class="form-control" rows="3" cols="53">' + remark + '</textarea></td>\
			    	</tr>\
			    	<tr>\
			    		<td colspan="2"><button type="submit" class="btn btn-sm btn-success">Save</button></td>\
			    	</tr>\
			    	</table>\
			    	</form>\
				 </div>\
				 <div class="modal-footer">\
				 	<button type="button" class="btn btn-sm btn-danger" data-action="delete">Delete Event</button>\
					<button type="button" class="btn btn-sm" data-dismiss="modal">Cancel</button>\
				 </div>\
			  </div>\
			 </div>\
			</div>';
			
			var modal = $(modal).appendTo('body');
			modal.find('form').on('submit', function(ev){
				ev.preventDefault();
				calEvent.title = $(this).find("input[name=zt]").val();
				calEvent.start = $(this).find("input[name=startTime]").val();
				calEvent.end = $(this).find("input[name=endTime]").val();
				var yhtmc = $(this).find("select[name=yhtmc]").val();
				var tel = $(this).find("input[name=lxfs]").val();
				var remark = $(this).find("textarea[name=remark]").val();
				var para = { order_id: calEvent._id,banquet_name: yhtmc, title: calEvent.title, start: calEvent.start, end: calEvent.end, allDay: calEvent.allDay,lxfs:tel, bz: remark };
				$.ajax({
                   type: "POST", //使用post方法访问后台
                   url: "orderAction/updateOrders", //要访问的后台地址
                   data: para, //要发送的数据
                   success: function (data) {
                     //对话框里面的数据提交完成，data为操作结果
                     calEvent.title = yhtmc+" ( "+calEvent.title+" )";
                     calendar.fullCalendar('updateEvent', calEvent);
					 modal.modal("hide");
                  }
                });
			});
			modal.find('button[data-action=delete]').on('click', function() {
				//用bootbox弹框
				bootbox.confirm("<h5><span class='label label-warning'>Warning!</span>&nbsp;&nbsp;确定删除这条预定信息吗? </h5>", function(result) {
				  if(result){
					  $.ajax({
	                   type: "POST", //使用post方法访问后台
	                   url: "orderAction/deletOrders", //要访问的后台地址
	                   data: {order_id:calEvent._id}, //要发送的数据
	                   success: function (data) {
	                     //对话框里面的数据提交完成，data为操作结果
	                     calendar.fullCalendar('removeEvents' , function(ev){
							return (ev._id == calEvent._id);
						 })
	                  }
	                });
					modal.modal("hide");
				  }
				}); 
			});
			
			modal.modal('show').on('hidden', function(){
				modal.remove();
			});

			 $('.form_datetime').datetimepicker({
		        //language:  'fr',
		        format: 'yyyy-mm-dd hh:ii',
		        weekStart: 1,
		        todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				forceParse: 0,
		        showMeridian: 1
		    });
                  }
            });
			//<input name="kssj" type="text" value="' + $.fullCalendar.formatDate(calEvent.start,'yyyy-MM-dd HH:mm:ss') + '" class="form-control" placeholder="开始时间" required/>
			
			//console.log(calEvent.id);
			//console.log(jsEvent);
			//console.log(view);

			// change the border color just for fun
			//$(this).css('border-color', 'red');

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
            }
		
	});
})

function show(){
	bootbox.alert("<h4><span class='label label-warning'>提示!</span></h4><p>可直接拖拽右边宴会厅名称到日历当中进行快速预约，拖拽后需再次修改详细预定信息进行确认！</p>");
}
</script>

</head>

<body>
	<div class="row">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->
			<div class="row">
				<div class="col-sm-9">
					<div class="space"></div>
					<div id="calendar"></div>
				</div>

				<div class="col-sm-3">
					<div class="widget-box transparent">
						<div class="widget-header">
							<h4>宴会厅  (<a href="javascript:void(0);" onclick="show();">提示</a>)</h4>
						</div>

						<div class="widget-body">
							<div class="widget-main no-padding">
								<div id="external-events">
									<c:forEach items="${banquetList }" var="banquetList" varStatus="i">
										<div class="external-event label-purple" data-class="label-purple">
											<i class="ace-icon fa fa-arrows">${i.count }.</i><span id="yhtmc">${banquetList.yhtmc }</span>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- PAGE CONTENT ENDS -->
		</div>
	</div>
</body>
</html>
