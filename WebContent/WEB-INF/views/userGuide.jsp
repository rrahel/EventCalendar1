<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="includes/bootstrapMeta.jsp" />
<jsp:include page="includes/bootstrapCss.jsp" />
<title>EventCalendar User Guide</title>
</head>
<body>
<div align="center">
	<h1>Welcome to EventCalendar.</h1>
	<h2>The core features are presented and explained here.</h2>
	<br>
	<h1><span id="Summary">Summary</span></h1>
	<li><a href="#Calendar"><span>Calendar</span></a></li>
	<li><a href="#Modify Groups"><span>Modify Groups</span></a></li>
	<li><a href="#Add new Group"><span>Add new Groups</span></a></li>
	<li><a href="#Change Event"><span>Change Event</span></a></li>
	<li><a href="#Profile"><span>Profile</span></a></li>
	<li><a href="#Options"><span>Options</span></a></li>
	<br>
	<br>
	<div>
	<h3><span id="Calendar">Calendar tab</span></h3>
	<img src="/EventCalendar/dist/img/screenshots/Calendar Ansicht.png" alt="HomeScreen Image" />
	<p>
		Here you see the homescreen of your calendar. On the left side you can
		switch to modify groups or add a new event.<br>At the top you see
		your notifications and on the top right side you can change some settings as well as your own profile.
	</p>
	<a href="#Summary"><p>to the top</p></a>
	</div>
	<br>
	<h3><span id="Modify Groups">Modify Groups tab</span></h3>
	<img src="/EventCalendar/dist/img/screenshots/List Groups.png" alt="NewEvent Image" />
	<p>
		Here you see the screen list all your groups. You have the possibility to change those groups<br>
		In order to create a new group you have to press the "Add new Group" button at the top.<br>
	</p>
	<a href="#Summary"><p>to the top</p></a>
	<br>
	<h3><span id="Add new Group">Add new Groups</span></h3>
	<img src="/EventCalendar/dist/img/screenshots/New Group input.png" alt="ChangeEvent Image" />
	<p>
		You can see that you only need to fill the "Name" field for an appropriate Group name.<br>
		Insert members into your group by selecting them in the field below.
	</p>
	<a href="#Summary"><p>to the top</p></a>
	
	
	<br>
	<h3><span id="Add new Event">Add new Events tab view</span></h3>
	<img src="/EventCalendar/dist/img/screenshots/New Event input.png" alt="ChangeEvent Image" />
	<p>
		In order to create a new event you simply have to fill the fields with data (an appropriate name, location, choose a group).<br>
		You can change the colour of your event (that is shown in the calendar) by clicking into the "Colour" field.<br>
		If you want to attach files to your event just go for it.
	</p>
	<br>
	<h3><span>Event added</span></h3>
	<img src="/EventCalendar/dist/img/screenshots/Event was added.png" alt="ChangeEvent Image" />
	<p>
		As you can see here your event will added to your calendar with the colour you want it to.
	</p>
	<a href="#Summary"><p>to the top</p></a>
	
	<br>
	<h3><span id="Change Event">Change Event</span></h3>
	<img src="/EventCalendar/dist/img/screenshots/change Event.png" alt="ChangeEvent Image" />
	<p>
		You can change the events represented in your calendar by clicking on them.<br>
		As you can see you get the same possibilities as in the Add Event menu.
	</p>
	<a href="#Summary"><p>to the top</p></a>
	
	
	<br>
	<h3><span id="Profile">Profile tab</span></h3>
	<img src="/EventCalendar/dist/img/screenshots/Profil Tab.png" alt="ChangeEvent Image" />
	<p>
		If you click on your name on the top right you get a dropdown tab.<br>
		You've got the possibility to sign out or get to your own profile to change some settings or set your own profile picture via upload.
	</p>
	
	<br>
	<img src="/EventCalendar/dist/img/screenshots/Profil View.png" alt="ChangeEvent Image" />
	<p>
		As you can see here you can change your name, set your day of birth as well as set your individual profile picture.</p>
	<a href="#Summary"><p>to the top</p></a>
	<br>
	<h3><span id="Options">Options</span></h3>
	<img src="/EventCalendar/dist/img/screenshots/Options Menu.png" alt="ChangeEvent Image" />
	<p>
		The gear symbol on the top right of the screen shows you the option menu.<br>
		The first option menu will show up is for the general calendar settings and how you want the calendar to be displayed.
	</p>
	<br>
	<img src="/EventCalendar/dist/img/screenshots/Options Skin Menu.png" alt="ChangeEvent Image" />
	<p>
		The second option menu displays a variety of color designs for the whole layout.
	</p>
	<a href="#Summary"><p>to the top</p></a>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<form action="<c:url value="/calendar"  />">
		<br>
		<button class="btn btn-lg  btn-success" type="submit">Let's start!</button>
	</form>
</div>
</body>
</html>