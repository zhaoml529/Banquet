<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'register.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="js/jquery-1.10.2.js"></script>
	<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
	<script src="js/bootstrap.min.js"></script>
	<script src="js/calendar.js"></script>
  </head>
  
  <body>
  	<div class="row">
  	<div class="col-md-4"></div>
  	<div class="col-md-4"><br/><br/><br/>
	<form class="form-horizontal" role="form" action="loginAction/saveUser" method="post" target="_top">
	  <div class="form-group">
	    <label for="inputUserName" class="col-sm-2 control-label">UserName</label>
	    <div class="col-sm-10">
	      <input type="text" name="username" class="form-control" id="inputUserName" placeholder="UserName" required>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputNickName" class="col-sm-2 control-label">NickName</label>
	    <div class="col-sm-10">
	      <input type="text" name="nickname" class="form-control" id="inputNickName" placeholder="NickName" required>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputPassword" class="col-sm-2 control-label">Password</label>
	    <div class="col-sm-10">
	      <input type="password" name="password" class="form-control" id="inputPassword" placeholder="Password" required>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputEmail" class="col-sm-2 control-label">Email</label>
	    <div class="col-sm-10">
	      <input type="email" name="email" class="form-control" id="inputEmail" placeholder="Email" required>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputMotto" class="col-sm-2 control-label">Motto</label>
	    <div class="col-sm-10">
	      <input type="text" name="motto" class="form-control" id="inputMotto" placeholder="Motto" required>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="inputBirthday" class="col-sm-2 control-label">Birthday</label>
	    <div class="col-sm-10">
	      <input type="text" name="birthDay" class="form-control" id="inputBirthday" onclick="calendar.show(this);" placeholder="Birthday" required>
	    </div>
	  </div>
	  <div class="form-group">
	    <div class="col-sm-offset-2 col-sm-10">
	      <button type="submit" class="btn btn-default">Register</button>
	    </div>
	  </div>
	</form>
	</div>
	<div class="col-md-4"></div>
	</div>
	
	

<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div align="center" class="col-xs-12 col-md-6">
  <div class="carousel-inner">
          <div class="item active">
          	<a href="#">
            <img src="imges/dating1.jpg" width="500px" height="300px" alt="First slide image">
            </a>
            <div class="carousel-caption">
              <h3>First slide label</h3>
              <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
            </div>
          </div>
          <div class="item">
          	<a href="#">
            <img src="imges/dating2.jpg" width="500px" height="300px" alt="Second slide image">
            </a>
            <div class="carousel-caption">
              <h3>Second slide label</h3>
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </div>
          </div>
          <div class="item">
          	<a href="#">
            <img src="imges/dating3.jpg" width="500px" height="300px" alt="Third slide image">
            </a>
            <div class="carousel-caption">
              <h3>Third slide label</h3>
              <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur.</p>
            </div>
          </div>
          <div class="item">
          	<a href="#">
            <img src="imges/dating4.jpg" width="500px" height="300px" alt="Second slide image">
            </a>
            <div class="carousel-caption">
              <h3>Second1 slide label</h3>
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </div>
          </div>
          <div class="item">
          	<a href="#">
            <img src="imges/dating5.jpg" width="500px" height="300px" alt="Second slide image">
            </a>
            <div class="carousel-caption">
              <h3>Second2 slide label</h3>
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </div>
          </div>
          
          
          
          
        </div>
  <!-- Controls -->
  <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left"></span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right"></span>
  </a>
</div>
</div>
	
  </body>
</html>
