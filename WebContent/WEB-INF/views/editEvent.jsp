<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>EventCalendar</title>
<meta charset='utf-8' />
<link href=<c:url value='/resources/fullcalendar.css'/> rel='stylesheet' />
<link href=<c:url value='/resources/fullcalendar.print.css'/>
	rel='stylesheet' media='print' />
<script src=<c:url value='/resources/lib/moment.min.js'/>></script>
<script src=<c:url value='/resources/lib/jquery.min.js'/>></script>
<script src=<c:url value='/resources/fullcalendar.min.js'/>></script>

<link
	href=<c:url value='/resources/plugins/colorpicker/bootstrap-colorpicker.min.css'/>
	rel="stylesheet" />


<link href=<c:url value='bootstrap/css/bootstrap.min.css'/>
	rel="stylesheet" type="text/css" />
<!-- Font Awesome Icons -->
<link
	href=<c:url value='https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'/>
	rel="stylesheet" type="text/css" />
<!-- Ionicons -->
<link
	href=<c:url value='https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css'/>
	rel="stylesheet" type="text/css" />
<!-- Theme style -->
<link href=<c:url value='dist/css/AdminLTE.min.css'/> rel="stylesheet"
	type="text/css" />

<link href=<c:url value='dist/css/skins/skin-green.min.css'/>
	rel="stylesheet" type="text/css" />
	
	<link href=<c:url value='dist/css/skins/skin-red.min.css'/>
	rel="stylesheet" type="text/css" />
		
	<link href=<c:url value='dist/css/skins/skin-green-light.min.css'/>
	rel="stylesheet" type="text/css" />
	
	<link href=<c:url value='dist/css/skins/skin-red-light.min.css'/>
	rel="stylesheet" type="text/css" />
	
	<link href=<c:url value='dist/css/skins/skin-purple.min.css'/>
	rel="stylesheet" type="text/css" />
	
<link href=<c:url value='dist/css/skins/skin-purple-light.min.css'/>
	rel="stylesheet" type="text/css" />
	
	
	<link href=<c:url value='dist/css/skins/skin-blue.min.css'/>
	rel="stylesheet" type="text/css" />
	
<link href=<c:url value='dist/css/skins/skin-blue-light.min.css'/>
	rel="stylesheet" type="text/css" />
	
	<link href=<c:url value='dist/css/skins/skin-yellow.min.css'/>
	rel="stylesheet" type="text/css" />
	
<link href=<c:url value='dist/css/skins/skin-yellow-light.min.css'/>
	rel="stylesheet" type="text/css" />
	
	<link href=<c:url value='dist/css/skins/skin-black.min.css'/>
	rel="stylesheet" type="text/css" />
	
<link href=<c:url value='dist/css/skins/skin-black-light.min.css'/>
	rel="stylesheet" type="text/css" />
<link
	href="http://www.malot.fr/bootstrap-datetimepicker/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"
	rel="stylesheet">



</head>
<body class="sidebar-mini <c:out value="${background}" />">
	<div class="wrapper">

		<!--  add or edit?  ----------------------------------------------------------- -->
		<c:choose>
			<c:when test="${not empty event}">
				<c:set var="legend">Change Event: </c:set>
				<c:set var="legendDesc">${event.title}</c:set>
				<c:set var="formAction">changeEvent</c:set>
				<c:set var="submitButton">Change</c:set>
				<c:set var="readonly">readonly</c:set>
			</c:when>
			<c:otherwise>
				<c:set var="legend">New Event</c:set>
				<c:set var="formAction">addEvent</c:set>
				<c:set var="submitButton">Add</c:set>
				<c:set var="readonly"></c:set>
			</c:otherwise>
		</c:choose>
		<!--  add or edit?  ----------------------------------------------------------- -->

		<!-- Main Header -->
		<header class="main-header"> <!-- Logo --> <a
			href=<c:url value='calendar'/> class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
			<span class="logo-mini"><b>E</b>C</span> <!-- logo for regular state and mobile devices -->
			<span class="logo-lg"><b>Event</b>Calendar</span>
		</a> <!-- Header Navbar --> <nav class="navbar navbar-static-top"
			role="navigation"> <!-- Sidebar toggle button--> <a href="#"
			class="sidebar-toggle" data-toggle="offcanvas" role="button"> <span
			class="sr-only">Toggle navigation</span>
		</a> <!-- Navbar Right Menu -->
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
										
				<li class="dropdown messages-menu">
					<!-- Menu toggle button --> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <i class="fa fa-question"></i>
				</a>
					<ul class="dropdown-menu">
						<li class="header">Contact Admin or take a look at the turorial</li>
						<li>
							<!-- inner menu: contains the messages -->
							<ul class="menu">
								<li>
									<!-- start message --> <a href="mailto:admin@ec.com?subject=I need help [<c:out value="${user.username}" />]">
										<div class="pull-left">
												<i class="fa fa-street-view text-aqua "></i> 
										</div> <!-- Message title and timestamp -->
										<h4>
											Contact Admin
										</h4> <!-- The message -->
										<p>You can contact an Admin via E-Mail here!</p>
								</a>
								</li>
								
								<li>
								<a href=<c:url value='/tutorial'/>>
								<div class="pull-left">
										<i class="fa fa-list text-aqua "></i> 
										</div> <!-- Message title and timestamp -->
										<h4>
											Start the tutorial again
										</h4> <!-- The message -->
										<p>You can start the tutorial here again!</p>
								</a>
								</li>
								<!-- end message -->
							</ul> <!-- /.menu -->
						</li>
						
					</ul>
				</li>
				
						
					
					
					
					
				<!-- Messages: style can be found in dropdown.less-->
				
				<li class="dropdown messages-menu">
					<!-- Menu toggle button --> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <i class="fa fa-envelope-o"></i> <span
						class="label label-info"><c:out value="${invitations.size()}"/></span>
				</a>
					<ul class="dropdown-menu">
						<li class="header">You have <c:out value="${invitations.size()}"/> new event(s)</li>
						<li>
							<!-- inner menu: contains the messages -->
							<ul class="menu">
							<c:forEach items="${invitations}" var="invitation">
								<li>
									<!-- start message --> <a href="/EventCalendar/acceptEvent?id=<c:out value="${invitation.eventId}"/>&notId=<c:out value="${invitation.notId}"/>">
										<div class="pull-left">
											<!-- User Image -->
<%-- 											<c:out value="${event.title}"/> --%>
											<i class="fa fa-calendar-o text-aqua "></i> 
										</div> <!-- Message title and timestamp -->
										<h4>
											<c:out value="${invitation.eventTitle}"/>&nbsp;[<c:out value="${invitation.eventGroup}"/>]
<!-- 											<small><i class="fa fa-clock-o"></i> 5 mins</small> -->
										</h4> <!-- The message -->
										<p>-> accept or decline it!</p>
										</a>
										</li>
							</c:forEach>
							</ul> <!-- /.menu -->
						</li>
					</ul>
				</li>
				<!-- /.messages-menu -->
				
				
				
				<!-- Notifications -->
			<li class="dropdown messages-menu">
					<!-- Menu toggle button --> <a href="#"class="dropdown-toggle"
					data-toggle="dropdown"> <i class="fa fa-bell-o"></i> <span
						class="label label-info"><c:out value="${reminders.size()}"/></span></a>
					<ul class="dropdown-menu">
						<li class="header">You have <c:out value="${reminders.size()}"/> notification(s)</li>
						<li>
							<!-- inner menu: contains the messages -->
							<ul class="menu">
								<c:forEach items="${reminders}" var="reminder">
								<li>
									<!-- start message --> <a href="/EventCalendar/changeEvent?id=<c:out value="${reminder.eventId}"/>&notId=<c:out value="${reminder.notId}"/>">
										<div class="pull-left">
											<i class="fa fa-calendar-o text-aqua "></i> 
										</div> <!-- Message title and timestamp -->
										<h4>
											<c:out value="${reminder.eventTitle}"/>&nbsp;[<c:out value="${reminder.eventGroup}"/>]
										</h4> <!-- The message -->
										<p>->It starts at:&nbsp;<fmt:formatDate value="${reminder.eventStart}" pattern="dd.MM.yyyy HH:mm"/></p>
										</a>
										</li>
							</c:forEach>
								<!-- end notification -->
							</ul> <!-- /.menu -->
						</li>
					</ul>
				</li>
				<!-- /.notifications-menu -->
				
				</li>
				
				<!-- User Account Menu -->
				<li class="dropdown user user-menu">
					<!-- Menu Toggle Button --> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <!-- The user image in the navbar--> <img
						src="${pageContext.request.contextPath}/profilImage" onerror="if (this.src != 'defaultUser.jpg') this.src = 'defaultUser.jpg';" class="user-image"
						alt="User Image" /> <!-- hidden-xs hides the username on small devices so only the image appears. -->
						<span class="hidden-xs"><c:out value="${user.firstname}" />&nbsp;<c:out value="${user.surname}" /></span>
				</a>
					<ul class="dropdown-menu">
						<!-- The user image in the menu -->
						<li class="user-header"><img src="${pageContext.request.contextPath}/profilImage"
							onerror="if (this.src != 'defaultUser.jpg') this.src = 'defaultUser.jpg';"   class="img-circle" alt="User Image" />
							<p>
								<c:out value="${user.username}" />
							</p></li>

						<li class="user-footer">
							<div class="pull-left">
								<a href="<c:url value='profile'/>" class="btn btn-default btn-flat">Profile</a>
							</div>
							<div class="pull-right">
								<form action="logout" method="post">
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" /> <input
										class="btn btn-default btn-flat" type="submit"
										value="Sign out" />
								</form>

							</div>
						</li>
					</ul>
				</li>
				<!-- Control Sidebar Toggle Button -->
				<li><a href="#" data-toggle="control-sidebar"><i
						class="fa fa-gears"></i></a></li>
			</ul>
		</div>
		</nav> </header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar"> <!-- sidebar: style can be found in sidebar.less -->
		<section class="sidebar"> <!-- Sidebar user panel (optional) -->
		<div class="user-panel">
			<div class="pull-left image">
				<img src="${pageContext.request.contextPath}/profilImage" onerror="if (this.src != 'defaultUser.jpg') this.src = 'defaultUser.jpg';" class="img-circle"
					alt="User Image" />
			</div>
			<div class="pull-left info">
				<p>	<c:out value="${user.firstname}" />&nbsp;<c:out value="${user.surname}" /></p>
				<!-- Status -->
				<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
			</div>
		</div>
<!-- Sidebar Menu -->
		<ul class="sidebar-menu">
			<li class="header">MENU</li>
			<!-- Optionally, you can add icons to the links -->
			<li class=""><a href=<c:url value='calendar'/>><i
					class='fa fa-calendar'></i> <span>Calendar</span></a></li>
			<li><a href=<c:url value='listGroups'/>><i class='fa fa-th'></i>
					<span>Modify Groups</span></a></li>
			<c:choose>
				<c:when test="${not empty event}">
					<li class=""><a href=<c:url value='addEvent'/>><i
							class='fa fa-edit'></i> <span>Add new Event</span> </a></li>
				</c:when>
				<c:otherwise>
					<li class="active"><a href=<c:url value='addEvent'/>><i
							class='fa fa-edit'></i> <span>Add new Event</span> </a></li>
				</c:otherwise>
			</c:choose>

		</ul>
		<!-- /.sidebar-menu --> </section> <!-- /.sidebar --> </aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
			<h1>
				<c:out value="${legend}" />
				<small><c:out value="${legendDesc}"/></small>
			</h1>




			<!-- Add/Change Form -->

			<div class="container" role="main">

				<div class="row">
					<div class="col-md-8 col-md-offset-2">
						<form class="form-horizontal" enctype="multipart/form-data" method="post" 
						action="${formAction}?${_csrf.parameterName}=${_csrf.token }">
							<fieldset>
								<br> <br>

								<! ----------------  id (hidden) ---------------- -->
								<input class="form-control" id="inputID" type="hidden" name="id"
									${readonly} value="<c:out value="${event.id}"/>">

								<! ----------------  title ---------------- -->
								<div class="form-group">
									<label for="inputTitle" class="col-md-2 control-label">Title</label>
									<div class="col-md-10">
										<input class="form-control" id="inputTitle" type="text"
											required="true" title="Required field!" autofocus="true"
											name="title" value="<c:out value="${event.title}"/>">
									</div>
								</div>
								<! ----------------  description ---------------- -->
								<div class="form-group">
									<label for="inputDescription" class="col-md-2 control-label">Description</label>
									<div class="col-md-10">
										<textarea class="form-control" id="inputDescription"
											type="text" name="description" style="resize: none"><c:out
												value="${event.description}" />
								</textarea>
									</div>
								</div>
								<! ----------------  members ---------------- -->
								<div class="form-group">
									<label for="inputMembers" class="col-md-2 control-label">Members</label>
									<div class="col-md-10">
										<select id="inputMembers" name="members" class="form-control" required
											>
											<c:forEach items="${members}" var="member">
												<c:choose>
													<c:when test="${member.name == event.userGroup.name}">
														<c:set var="selected">selected</c:set>
													</c:when>
													<c:otherwise>
														<c:set var="selected"></c:set>
													</c:otherwise>
												</c:choose>
												<option <c:out value="${selected}"/>>${member.name}</option>
								 </c:forEach>
								 </select>
								 </div>
								</div>
								<! ----------------  location ---------------- -->
								<div class="form-group">
									<label for="inputLocation" class="col-md-2 control-label">Location</label>
									<div class="col-md-10">
										<input class="form-control" id="inputLocation" type="text"
											required="true" title="Required field!" name="location"
											value="<c:out value="${event.location}"/>">
									</div>
								</div>
								<! ----------------  start ---------------- -->
								<div class="form-group">
									<label for="inputStart" class="col-md-2 control-label">Start</label>
									<div class="col-md-10">
										<input class="form_datetime" id="inputStart"
											placeholder="Start" type="text" required="true"
											title="Required field!" readonly name="start"
											value="<fmt:formatDate value="${event.start}" pattern="dd.MM.yyyy HH:mm"/>">
									</div>
								</div>
								<! ----------------  end ---------------- -->
								<div class="form-group">
									<label for="inputEnd" class="col-md-2 control-label">End</label>
									<div class="col-md-10">
										<input class="form_datetime" id="inputEnd" placeholder="End"
											type="text" required="true" title="Required field!" readonly
											name="end"
											value="<fmt:formatDate value="${event.end}" pattern="dd.MM.yyyy HH:mm"/>">
									</div>
								</div>
								<! ----------------  allDay ---------------- -->
								<div class="form-group">
									<label for="inputAllDay" class="col-md-2 control-label">allDay</label>
									<div class="col-md-10">
										<c:choose>
											<c:when test="${event.allDay}">
												<input class="checkbox" id="inputAllDay" type="checkbox"
													checked="checked" name="allDay" value="true">
											</c:when>
											<c:otherwise>
												<input class="checkbox" id="inputAllDay" type="checkbox"
													name="allDay" value="true">
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								<! ----------------  attachment ---------------- -->
								<div class="form-group">
									<label for="inputAttachment" class="col-md-2 control-label">Attachment</label>
									<div class="col-md-10">
										<c:if test="${not empty event.attachment}">
											<a href=<c:url value='/download/${event.id}/${event.attachmentName}'/> target="_blank">
												<button type="button" class="btn btn-default">
												<i class='fa fa-file-o'></i> <span>&nbsp;<c:out value="${event.attachmentName}"/></span></button>
											</a><br><br>
										</c:if>
											<label for="inputNewFile">New File</label>
											<input type="file" name="file" title="Upload ..." accept="application/pdf"></input>
											<p class="help-block">Upload a pdf-file here (max. size 5 MB)!</p>
									</div>
								</div>
								<! ----------------  eventColour ---------------- -->
								<div class="form-group">
									<label for="inputEventColour" class="col-md-2 control-label">Colour</label>
									<div class="col-md-10">
										<input type="text" name="colour"
											class="form-control my-colorpicker1"
											value="<c:out value="${event.colour}"/>" />
									</div>
								</div>


								<! ----------------  buttons ---------------- -->
								<div class="form-group">
									<div class="col-md-10 col-md-offset-2">
										<button type="submit" name="submitButton" value="change"
											class="btn btn-success">${submitButton}</button>
										<c:if test="${not empty event}">
											<button type="submit" name="submitButton" value="remove"
												class="btn btn-danger">Remove</button>
										</c:if>
										<a href="calendar">
											<button type="button" class="btn btn-default">Cancel</button>
										</a>
									</div>
								</div>

							</fieldset>
						</form>
					</div>
				</div>
			</div>


			<!-- Add/Change Form --> </section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<footer class="main-footer"> <!-- To the right -->
		<div class="pull-right hidden-xs"></div>
		<!-- Default to the left --> <strong>EventCalendar.
		</strong>Powered by Cemi, Jocham, Kahmann.</footer>

				<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark"> <!-- Create the tabs -->
		<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
			<li class="active"><a href="#control-sidebar-home-tab"
				data-toggle="tab"><i class="fa fa-home"></i></a></li>
			<li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i
					class="fa fa-gears"></i></a></li>
		</ul>
		<!-- Tab panes -->
		<div class="tab-content">
			<!-- Home tab content -->
			<div class="tab-pane active" id="control-sidebar-home-tab">
			<form method="post" action=<c:url value='/changeSettings?${_csrf.parameterName}=${_csrf.token }'/>>
				<h3 class="control-sidebar-heading">General Settings</h3>
				<ul class='control-sidebar-menu'>
				<li style="float:left; padding: 8px;">
				<div class="form-group">
				<label for="inputFirstDAyOfTheWeek">First day of the week</label>
				<br>
				<select id="inputFirstDayOfTheWeek" name="firstDay">
				<c:choose>
					<c:when test="${user.firstDay == '0'}">
						<option>Monday</option>
						<option selected="selected">Sunday</option>
					</c:when>
					<c:otherwise>
						<option selected="selected">Monday</option>
						<option >Sunday</option>
					</c:otherwise>
				</c:choose>
				</select>
				</div>
				
				<div class="form-group">
				<label>Show Weekends</label>
				<c:choose>
					<c:when test="${user.weekends}">
						<input class="checkbox" id="inputShowWeekends" type="checkbox" checked="checked" name="showWeekends" value="true">
							</c:when>
						<c:otherwise>
							<input class="checkbox" id="inputShowWeekends" type="checkbox" name="showWeekends" value="true">
						</c:otherwise>
				</c:choose>
				</div>
				
				<div class="form-group">
				<label>Show Week Number</label>
				<c:choose>
					<c:when test="${user.weekNumbers}">
						<input class="checkbox" id="inputShowWeekNr" type="checkbox" checked="checked" name="showWeekNr" value="true">
							</c:when>
						<c:otherwise>
							<input class="checkbox" id="inputShowWeekNr" type="checkbox" name="showWeekNr" value="true">
						</c:otherwise>
				</c:choose>
				</div>
				
				
			<div class="form-group">
				<label>Default View</label>
				<br>
				<select id="inputDefaultView" name="defaultView">
				<c:choose>
					<c:when test="${user.defaultView == 'month'}">
						<option selected="selected">month</option>
						<option>week</option>
						<option>day</option>
					</c:when>
					<c:when test="${user.defaultView == 'agendaWeek'}">
						<option>month</option>
						<option selected="selected">week</option>
						<option>day</option>
					</c:when>
					<c:otherwise>
						<option>month</option>
						<option>week</option>
						<option selected="selected">day</option>
					</c:otherwise>
				</c:choose>
				</select>
				</div>
				
				<br>
				<button type="submit" class="btn btn-default">Confirm Settings</button>


				</li></ul></form>
<!-- 				/.control-sidebar-menu -->


<!-- 				/.control-sidebar-menu -->

			</div>
			<!-- /.tab-pane -->
			<!-- Stats tab content -->
			<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab
				Content</div>
			<!-- /.tab-pane -->
			<!-- Settings tab content -->
			<div class="tab-pane" id="control-sidebar-settings-tab">
				<form method="post">
					<div>
<h4 class="control-sidebar-heading">Skins</h4>
<ul class="list-unstyled clearfix">



<li style="float:left; width: 33.33333%; padding: 5px;">
<a href=<c:url value='/changeSkin?skinName=skin-blue'/> data-skin="skin-blue" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
<div>
<span style="display:block; width: 20%; float: left; height: 7px; background: #367fa9;"></span>
<span class="bg-light-blue" style="display:block; width: 80%; float: left; height: 7px;">
</span>
</div>
<div>
<span style="display:block; width: 20%; float: left; height: 20px; background: #222d32;"></span>
<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
</div></a><p class="text-center no-margin">Blue</p>
</li>




<li style="float:left; width: 33.33333%; padding: 5px;">
<a href=<c:url value='/changeSkin?skinName=skin-black'/> data-skin="skin-black" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
<div style="box-shadow: 0 0 2px rgba(0,0,0,0.1)" class="clearfix">
<span style="display:block; width: 20%; float: left; height: 7px; background: #fefefe;"></span>
<span style="display:block; width: 80%; float: left; height: 7px; background: #fefefe;"></span>
</div>
<div>
<span style="display:block; width: 20%; float: left; height: 20px; background: #222;"></span>
<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
</div>
</a>
<p class="text-center no-margin">Black</p>
</li>



<li style="float:left; width: 33.33333%; padding: 5px;">
<a href=<c:url value='/changeSkin?skinName=skin-purple'/> data-skin="skin-purple" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
<div>
<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-purple-active"></span>
<span class="bg-purple" style="display:block; width: 80%; float: left; height: 7px;"></span>
</div>
<div>
<span style="display:block; width: 20%; float: left; height: 20px; background: #222d32;"></span>
<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
</div>
</a>
<p class="text-center no-margin">Purple</p>
</li>




<li style="float:left; width: 33.33333%; padding: 5px;">
<a href=<c:url value='/changeSkin?skinName=skin-green'/> data-skin="skin-green" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
<div>
<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-green-active"></span>
<span class="bg-green" style="display:block; width: 80%; float: left; height: 7px;"></span>
</div>
<div>
<span style="display:block; width: 20%; float: left; height: 20px; background: #222d32;"></span>
<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
</div>
</a>
<p class="text-center no-margin">Green</p>
</li>



<li style="float:left; width: 33.33333%; padding: 5px;">
<a href=<c:url value='/changeSkin?skinName=skin-red'/> data-skin="skin-red" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
<div>
<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-red-active"></span>
<span class="bg-red" style="display:block; width: 80%; float: left; height: 7px;"></span>
</div>
<div>
<span style="display:block; width: 20%; float: left; height: 20px; background: #222d32;"></span>
<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
</div>
</a>
<p class="text-center no-margin">Red</p>
</li>



<li style="float:left; width: 33.33333%; padding: 5px;">
<a href=<c:url value='/changeSkin?skinName=skin-yellow'/> data-skin="skin-yellow" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
<div>
<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-yellow-active"></span>
<span class="bg-yellow" style="display:block; width: 80%; float: left; height: 7px;"></span>
</div>
<div>
<span style="display:block; width: 20%; float: left; height: 20px; background: #222d32;"></span>
<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
</div>
</a>
<p class="text-center no-margin">Yellow</p>
</li>




<li style="float:left; width: 33.33333%; padding: 5px;">
<a href=<c:url value='/changeSkin?skinName=skin-blue-light'/> data-skin="skin-blue-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
<div>
<span style="display:block; width: 20%; float: left; height: 7px; background: #367fa9;"></span>
<span class="bg-light-blue" style="display:block; width: 80%; float: left; height: 7px;"></span>
</div>
<div>
<span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc;"></span>
<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
</div>
</a>
<p class="text-center no-margin" style="font-size: 12px">Blue Light</p>
</li>



<li style="float:left; width: 33.33333%; padding: 5px;">
<a href=<c:url value='/changeSkin?skinName=skin-black-light'/> data-skin="skin-black-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
<div style="box-shadow: 0 0 2px rgba(0,0,0,0.1)" class="clearfix">
<span style="display:block; width: 20%; float: left; height: 7px; background: #fefefe;"></span>
<span style="display:block; width: 80%; float: left; height: 7px; background: #fefefe;"></span>
</div>
<div>
<span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc;"></span>
<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
</div>
</a>
<p class="text-center no-margin" style="font-size: 12px">Black Light</p>
</li>




<li style="float:left; width: 33.33333%; padding: 5px;">
<a href=<c:url value='/changeSkin?skinName=skin-purple-light'/> data-skin="skin-purple-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
<div>
<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-purple-active"></span>
<span class="bg-purple" style="display:block; width: 80%; float: left; height: 7px;"></span>
</div>
<div>
<span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc;"></span>
<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
</div>
</a>
<p class="text-center no-margin" style="font-size: 12px">Purple Light</p>
</li>




<li style="float:left; width: 33.33333%; padding: 5px;">
<a href=<c:url value='/changeSkin?skinName=skin-green-light'/> data-skin="skin-green-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
<div>
<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-green-active"></span>
<span class="bg-green" style="display:block; width: 80%; float: left; height: 7px;"></span>
</div>
<div>
<span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc;"></span>
<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
</div>
</a>
<p class="text-center no-margin" style="font-size: 12px">Green Light</p>
</li>




<li style="float:left; width: 33.33333%; padding: 5px;">
<a href=<c:url value='/changeSkin?skinName=skin-red-light'/> data-skin="skin-red-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
<div>
<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-red-active"></span>
<span class="bg-red" style="display:block; width: 80%; float: left; height: 7px;"></span>
</div>
<div>
<span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc;"></span>
<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
</div>
</a>
<p class="text-center no-margin" style="font-size: 12px">Red Light</p>
</li>




<li style="float:left; width: 33.33333%; padding: 5px;">
<a href=<c:url value='/changeSkin?skinName=skin-yellow-light'/> data-skin="skin-yellow-light" style="display: block; box-shadow: 0 0 3px rgba(0,0,0,0.4)" class="clearfix full-opacity-hover">
<div>
<span style="display:block; width: 20%; float: left; height: 7px;" class="bg-yellow-active"></span>
<span class="bg-yellow" style="display:block; width: 80%; float: left; height: 7px;"></span>
</div>
<div>
<span style="display:block; width: 20%; float: left; height: 20px; background: #f9fafc;"></span>
<span style="display:block; width: 80%; float: left; height: 20px; background: #f4f5f7;"></span>
</div>
</a>
<p class="text-center no-margin" style="font-size: 12px;">Yellow Light</p>
</li>
</ul>
</div>

		<!-- /.form-group -->
				</form>
			</div>
			<!-- /.tab-pane -->
		</div>
		</aside>
		<!-- /.control-sidebar -->
		<!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
		<div class='control-sidebar-bg'></div>
	</div>

	<!-- REQUIRED JS SCRIPTS -->

	<!-- jQuery 2.1.4 -->
	<!--     <script src=<c:url value='plugins/jQuery/jQuery-2.1.4.min.js'/>> </script> -->
	<!-- Bootstrap 3.3.2 JS -->
	<script src=<c:url value='bootstrap/js/bootstrap.min.js'/>
		type="text/javascript"></script>
	<!-- AdminLTE App -->
	<script src=<c:url value='dist/js/app.min.js'/> type="text/javascript"></script>

	<!-- Optionally, you can add Slimscroll and FastClick plugins.
          Both of these plugins are recommended to enhance the
          user experience. Slimscroll is required when using the
          fixed layout. -->

	<!-- JS for Bootstrap -->
	<%-- 	<%@include file="includes/bootstrapJs.jsp"%> --%>
	<!-- JS for Bootstrap -->

	<script
		src=<c:url value='/resources/plugins/colorpicker/bootstrap-colorpicker.min.js'/>
		type="text/javascript"></script>



	<!-- date picker script -->

	<script type="text/javascript"
		src="http://www.malot.fr/bootstrap-datetimepicker/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>

	<script type="text/javascript">
		$(function() {

			$(".form_datetime").datetimepicker({
				format : "dd.mm.yyyy hh:ii",
				autoclose : true,
				todayBtn : true,
				pickerPosition : "bottom-left",
				minView : 0,
				startView : 2,
				weekStart : 1
			});
			
			//Colorpicker
	        $(".my-colorpicker1").colorpicker();

		});
	</script>

</body>
</html>