package at.fh.swenga.jpa.controller;

import java.awt.image.BufferedImage;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.mysql.jdbc.Blob;

import at.fh.swenga.jpa.dao.SimpleEventRepository;
import at.fh.swenga.jpa.dao.SimpleGroupRepository;
import at.fh.swenga.jpa.dao.SimpleNotificationRepository;
import at.fh.swenga.jpa.dao.SimpleUserRepository;
import at.fh.swenga.jpa.dao.SimpleUserRoleRepository;
import at.fh.swenga.jpa.model.Event;
import at.fh.swenga.jpa.model.Notification;
import at.fh.swenga.jpa.model.User;
import at.fh.swenga.jpa.model.UserGroup;
import at.fh.swenga.jpa.model.UserRole;

@Controller
public class EventCalendarController {

	@Autowired
	SimpleUserRepository userDao;

	@Autowired
	SimpleUserRoleRepository userRoleDao;

	@Autowired
	SimpleEventRepository eventDao;

	@Autowired
	SimpleGroupRepository groupDao;
	
	@Autowired
	SimpleNotificationRepository notificationDao;

	@RequestMapping(value = { "/", "calendar" })
	public String index(Model model) {
		setReminders();
		getNotifications(model);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User user = userDao.findOne(username);
		String skinName = user.getBackground();
		model.addAttribute("background", skinName);
		model.addAttribute("user", user);
		
		List<User> users = userDao.findAll();
		model.addAttribute("users", users);

		Set<Event> myEvents = user.getEvents();

		model.addAttribute("myEvents", myEvents);

		return "index";
	}

	@RequestMapping(value = "/addEvent", method = RequestMethod.GET)
	public String addEvent(Model model) {
		setReminders();
		getNotifications(model);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User user = userDao.findOne(username);
		String skinName = user.getBackground();
		model.addAttribute("background", skinName);
		model.addAttribute("user", user);
		
		Set<UserGroup> myUserGroups = user.getUserGroups();
		model.addAttribute("members", myUserGroups);
		return "editEvent";
	}

	@Transactional
	@RequestMapping(value = "/addEvent", method = RequestMethod.POST)
	public String addEventRequest(@RequestParam("file") CommonsMultipartFile file, HttpServletRequest request, Event eventModel,
			BindingResult bindingResult, Model model) {

		Event event = new Event();
		List<User> membersList = groupDao.findByName(request.getParameter("members")).getUsers();
		String overlappedUser = "";
		
		for(User u : membersList){
			createOrChangeEvent(event, request, model, file);
			overlappedUser = checkOverlapping(event, model, u, overlappedUser);
		}
		
		if (bindingResult.hasErrors()) {
			String errorMessage = "";
			for (FieldError fieldError : bindingResult.getFieldErrors()) {
				errorMessage += fieldError.getField() + " is invalid<br>";
			}
			model.addAttribute("errorMessage", errorMessage);
			return "forward:/calendar";
		}
		System.out.println(overlappedUser);
		if (!overlappedUser.isEmpty()){
			String errorMessage = "Could not create event for: " + overlappedUser + " because there is an overlapping.";
			model.addAttribute("errorMessage", errorMessage);
		}
		
		if (model.containsAttribute("errorMessage") == false) {
			model.addAttribute("message", "New event " + event.getTitle()
					+ " added.");
		}
		return "forward:/calendar";
	}

	@RequestMapping(value = "/changeEvent", method = RequestMethod.GET)
	public String changeEvent(Model model, @RequestParam int id, @RequestParam(value = "notId", required=false) Integer notId) {
		setReminders();
		getNotifications(model);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User user = userDao.findOne(username);
		String skinName = user.getBackground();
		model.addAttribute("background", skinName);
		model.addAttribute("user", user);
		
		Event event = eventDao.findEventById(id);
		if (event != null && user.getEvents().contains(event)) {
			if(notId != null){
				notificationDao.removeByNotId(notId);
			}
			Set<UserGroup> myUserGroups = user.getUserGroups();
			model.addAttribute("members", myUserGroups);
			model.addAttribute("event", event);
			return "editEvent";
		} else {
			model.addAttribute("errorMessage", "Access denied!");
			return "forward:/calendar";
		}
	}

	@Transactional
	@RequestMapping(value = "/changeEvent", method = RequestMethod.POST)
	public String changeEventRequest(@RequestParam("file") CommonsMultipartFile file, HttpServletRequest request, Event eventModel,
			BindingResult bindingResult, Model model) {

		Integer id = Integer.parseInt(request.getParameter("id"));
		String button = request.getParameter("submitButton");
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User user = userDao.findOne(username);

		if (button.equals("remove")) {
			Event deletedEvent = eventDao.findEventById(id);
			List<Notification> foundNotifications = notificationDao.findByEventId(id);
			for(Notification note : foundNotifications){
				notificationDao.removeByNotId(note.getNotId());
			}
			
			
			List<User> users = deletedEvent.getUsers();

			user.removeEvent(deletedEvent);
			userDao.save(user);
			
			deletedEvent.removeUser(user);
			eventDao.save(deletedEvent);
			
			
			
			model.addAttribute("warningMessage", "Removed event "
					+ deletedEvent.getTitle());
			return "forward:/calendar";
		} else {
			
			Event deletedEvent = eventDao.findEventById(id);
			eventDao.delete(id);
			List<User> users = deletedEvent.getUsers();
			for(User u : users){
				List<Notification> foundNotifications = notificationDao.findByEventId(id);
				for(Notification note : foundNotifications){
					notificationDao.removeByNotId(note.getNotId());
				}
				u.removeEvent(deletedEvent);
				userDao.save(u);
			}
			


			Event event = new Event();
			List<User> membersList = groupDao.findByName(request.getParameter("members")).getUsers();
			String overlappedUser = "";
			
			for(User u : membersList){
				createOrChangeEvent(event, request, model, file);
				overlappedUser = checkOverlapping(event, model, u, overlappedUser);
			}
			
			if (bindingResult.hasErrors()) {
				String errorMessage = "";
				for (FieldError fieldError : bindingResult.getFieldErrors()) {
					errorMessage += fieldError.getField() + " is invalid<br>";
				}
				model.addAttribute("errorMessage", errorMessage);
				return "forward:/calendar";
			}

			if (model.containsAttribute("errorMessage") == false) {
				model.addAttribute("message", "Event " + event.getTitle()
						+ " changed.");
			}
			return "forward:/calendar";

		}

	}

	// get all groups
	@RequestMapping(value = "/listGroups")
	public String showAllGroups(Model model) {
		setReminders();
		getNotifications(model);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User user = userDao.findOne(username);
		String skinName = user.getBackground();
		model.addAttribute("groups", user.getUserGroups());
		System.out.println(user.getUserGroups());
		model.addAttribute("background", skinName);
		model.addAttribute("user", user);
		return "listGroups";
	}

	// add Groups
	@RequestMapping(value = "/addGroup", method = RequestMethod.GET)
	public String addGroup(Model model) {
		setReminders();
		getNotifications(model);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User user = userDao.findOne(username);
		String skinName = user.getBackground();
		model.addAttribute("background", skinName);
		model.addAttribute("user", user);
		
		List<User> myUser = userDao.findAll();
		model.addAttribute("userMembers", myUser);
		
		return "editGroup";
	}

	@RequestMapping(value = "/addGroup", method = RequestMethod.POST)
	public String addGroupRequest(HttpServletRequest request, UserGroup ugroup,
			BindingResult bindingResult, Model model) {

		UserGroup newGroup = new UserGroup();
				
		createOrChangeGroup(model, request, newGroup);

		if (bindingResult.hasErrors()) {
			String errorMessage = "";
			for (FieldError fieldError : bindingResult.getFieldErrors()) {
				errorMessage += fieldError.getField() + " is invalid<br>";
			}
			model.addAttribute("errorMessage", errorMessage);
			return "forward:/listGroups";
		}

		model.addAttribute("message", "New group " + newGroup.getName()
				+ " added.");
		return "forward:/listGroups";
	}

	// edit or change groups
	@RequestMapping(value = "/editGroup", method = RequestMethod.GET)
	public String changeGroup(Model model, @RequestParam int id) {
		setReminders();
		getNotifications(model);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User user = userDao.findOne(username);
		String skinName = user.getBackground();
		model.addAttribute("background", skinName);
		model.addAttribute("user", user);

		UserGroup ugroup = groupDao.findGroupBygroupID(id);
		if (ugroup != null && user.getUserGroups().contains(ugroup) ) {
			List<User> myUser = ugroup.getUsers();
			List<User> allUser = userDao.findAll();
			model.addAttribute("groupMembers", myUser);
			model.addAttribute("userMembers", allUser);
			model.addAttribute("ugroup", ugroup);
			return "editGroup";
		} else {
			model.addAttribute("groups", user.getUserGroups());
			model.addAttribute("errorMessage", "Access denied!");
			return "listGroups";
		}

	}

	@RequestMapping(value = "/editGroup", method = RequestMethod.POST)
	public String changeGroupRequest(HttpServletRequest request,
			UserGroup ugroup, BindingResult bindingResult, Model model) {

		Integer id = Integer.parseInt(request.getParameter("id"));
		String button = request.getParameter("submitButton");

		if (button.equals("remove")) {
			UserGroup delGroup = groupDao.findGroupBygroupID(id);
			groupDao.delete(id);
			List<User> users = delGroup.getUsers();
			for(User u : users){
				u.removeGroup(delGroup);
				userDao.save(u);
			}
			
			model.addAttribute("warningMessage",
					"Removed Group " + delGroup.getName());
			return "forward:/listGroups";
		} else {
			UserGroup foundGroup = groupDao.findGroupBygroupID(id);
			createOrChangeGroup(model, request, foundGroup);
			model.addAttribute("message",
					"Changed Group " + foundGroup.getName());
			return "forward:/listGroups";

		}

	}
	
	@RequestMapping("/download/{id}/{attachment}")
	public String download(@PathVariable("id") Integer id, HttpServletResponse response) {
		
		Event event = eventDao.findOne(id);
		try {
			response.setHeader("Content-Disposition", "inline;filename=\""
					+ event.getTitle() + "\"");
			OutputStream out = response.getOutputStream();
			response.setContentType("application/pdf");
			out.write(event.getAttachment());
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	
	
	
	
	@RequestMapping(value = "/acceptEvent", method = RequestMethod.GET)
	public String acceptEvent(Model model, @RequestParam int id, @RequestParam int notId){
		setReminders();
		getNotifications(model);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User user = userDao.findOne(username);
		String skinName = user.getBackground();
		model.addAttribute("background", skinName);
		model.addAttribute("user", user);
		
		if(notificationDao.findByUsername(username) != null){
			notificationDao.removeByNotId(notId);
			
			Event event = eventDao.findOne(id);
			model.addAttribute("event", event);
			return "showEvent";
		} else {
			model.addAttribute("errorMessage", "Access denied!");
			return "redirect:/calendar";
		}
		
	}
	
	@Transactional
	@RequestMapping(value ="/acceptEvent", method = RequestMethod.POST)
	public String acceptOrDeclineEvent(HttpServletRequest request, Event eventModel,
			BindingResult bindingResult, Model model){
		
		Integer id = Integer.parseInt(request.getParameter("id"));
		String button = request.getParameter("submitButton");
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User user = userDao.findOne(username);
		
		Event event = eventDao.findEventById(id);
		
		
		if(button.equals("decline")){
			System.out.println(button);
			List<Notification> foundNotifications = notificationDao.findByEventId(id);
			for(Notification note : foundNotifications){
				notificationDao.removeByNotId(note.getNotId());
			}
			user.removeEvent(event);
			userDao.save(user);
			model.addAttribute("warningMessage", "You have unsubscribed to the event!");
		} 
		
		
		
		return "forward:/calendar";
		
		
		
		
	}
	
	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public String userProfile(Model model) {
		setReminders();
		getNotifications(model);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		model.addAttribute("background", userDao.findOne(username).getBackground());
		model.addAttribute("user", userDao.findOne(username));
		return "profile";
	}

	/*
	 * from here helper methods
	 * be careful the if the requestMethod is @Transactional also the following must be declared @Transactional
	 */
	
	@Transactional
	public void getNotifications(Model model) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		List<Notification> notifications = notificationDao.findAllByUsername(username);
		List<Notification> invitations = new ArrayList<Notification>();
		List<Notification> reminders = new ArrayList<Notification>();
		
		for(Notification n : notifications) {
			if (n.getNotificationType() == 1) {
				invitations.add(n);
			} else if (n.getNotificationType() == 2) {
				reminders.add(n);
			}
		}
		model.addAttribute("invitations", invitations);
		model.addAttribute("reminders", reminders);
	}
	
	public void setReminders(){
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User user = userDao.findOne(username);
		
		Set<Event> myEvents = user.getEvents();
		
		Set<Event> upcomingEvents = new HashSet<Event>();
				
		Date tomorrow = new Date(System.currentTimeMillis() + 86400000);
		Date now = new Date(System.currentTimeMillis());
		
		for(Event e : myEvents){
			if(e.getStart().before(tomorrow) && e.getStart().after(now)){
				upcomingEvents.add(e);
				if((notificationDao.findByEventIdAndNotificationTypeAndEventStartAndUsername(e.getId(), 2, e.getStart(), username)) == null){
					Notification note = new Notification(e.getId(), e.getTitle(), e.getUserGroup().getName(), 2, false, username);
					note.setEventStart(e.getStart());
					notificationDao.save(note);
				}
				
			}
		}
		
		
	}

	public Date convertDateToString(String dateString, Model model) {

		Date date = new Date();

		try {
			SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy HH:mm");
			date = sdf.parse(dateString);
		} catch (Exception e) {
			model.addAttribute("errorMessage",
					"Date is invalid! (The event has now the actual date as start and end)");
		}
		return date;
	}

	@Transactional
	public String checkOverlapping(Event event, Model model, User user, String overlappedUser) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User actualUser = userDao.findOne(username);
		
		Boolean overlapping = false;
		Set<Event> myEvents = user.getEvents();
		for (Event e : myEvents) {
			if ((event.getStart().after(e.getStart())
					&& event.getStart().before(e.getEnd())
					|| event.getEnd().after(e.getStart())
					&& event.getEnd().before(e.getEnd()) || event.getStart()
					.before(e.getStart()) && event.getEnd().after(e.getEnd()))
					&& e.getId() != event.getId()) {
				overlapping = true;
			}
		}

		if (overlapping == true) {
			overlappedUser = overlappedUser + user.getUsername();
			event = null;
		} else if (event.getEnd().before(event.getStart())) {
			model.addAttribute("errorMessage",
					"Date is invalid! (end before start)");
			event = null;
		} else {
			eventDao.save(event);
			
			user.addEvent(event);
			userDao.save(user);
		
			// set notifications
			System.out.println(event.getId());
			System.out.println(event.getTitle());
			System.out.println(event.getUserGroup().getName());
			System.out.println(user.getUsername());
			if(!user.equals(actualUser)){
				Notification note = new Notification(event.getId(), event.getTitle(), event.getUserGroup().getName(), 1, false, user.getUsername());
				notificationDao.save(note);
			}
			
		}
		
		return overlappedUser;
	}

	@Transactional
	public void createOrChangeEvent(Event event, HttpServletRequest request,
			Model model, CommonsMultipartFile file) {
		String startAsString = request.getParameter("start");
		String endAsString = request.getParameter("end");
		String allDayValue = request.getParameter("allDay");
		UserGroup members = groupDao.findByName(request.getParameter("members"));

		Date start = convertDateToString(startAsString, model);
		Date end = convertDateToString(endAsString, model);
		
		String title = request.getParameter("title");

		
			event.setTitle(title);
			event.setDescription(request.getParameter("description"));
			event.setLocation(request.getParameter("location"));
			
			event.setUserGroup(members);
			if (allDayValue == null) {
				event.setAllDay(false);
				event.setStart(start);
				event.setEnd(end);
			} else if (allDayValue.equals("true")) {
				event.setAllDay(true);
				try {
					
					Calendar calS = Calendar.getInstance();
					calS.setTime(start);
					calS.set(Calendar.HOUR_OF_DAY, 0);
					calS.set(Calendar.MINUTE, 0);
					Date newStart = calS.getTime();
					event.setStart(newStart);
					
					Calendar calE = Calendar.getInstance();
					calE.setTime(end);
					calE.set(Calendar.HOUR_OF_DAY, 23);
					calE.set(Calendar.MINUTE, 59);
					Date newEnd = calE.getTime();
					event.setEnd(newEnd);
					
				} catch (Exception e) {
					model.addAttribute("errorMessage", "Date of allDay event is invalid!");
				}
				
			}
			event.setColour(request.getParameter("colour"));
			
			// file upload
			if (!file.isEmpty() && file.getSize() < 5000000 && file.getContentType().equals("application/pdf")){
				try {
					byte[] bytes = file.getBytes();

					event.setAttachment(bytes);
					event.setAttachmentName(file.getOriginalFilename());
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (!file.isEmpty()) {
				model.addAttribute("errorMessage", "Only pdf-files with a maximum length of 5MB are allowed!");
			}
			
	}
		
	
	@Transactional
	public void createOrChangeGroup(Model model, HttpServletRequest request,
			UserGroup uGroup) {
		
		String gName = request.getParameter("name");
		uGroup.setName(gName);
		groupDao.save(uGroup);

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String owner = authentication.getName();
		User oUser = userDao.findOne(owner);
		oUser.addGroup(uGroup);
		userDao.save(oUser);
		
		
		String username[] = request.getParameterValues("userMembers");
		if(username != null){
			for(int i=0; i<username.length; i++){
			
				User user = userDao.findOneByUsername(username[i]);
				user.addGroup(uGroup);
				userDao.save(user);
			}
		}

	}
	
    /**
	 * fill data for testing
	 */
	@RequestMapping(value = "/fillData")
	@Transactional
	public String fillData(){
		
		UserGroup uGroup = new UserGroup("GroupA");
		uGroup = groupDao.save(uGroup);
		
		UserGroup uGroup2 = new UserGroup("GroupB");
		uGroup2 = groupDao.save(uGroup2);
		
		User userA = userDao.findOneByUsername("admin@ec.com");
		User userB = userDao.findOneByUsername("TDunst@ec.com");
		User userC = userDao.findOneByUsername("JCobe@ec.com");
		User userD = userDao.findOneByUsername("CTaylor@ec.com");
		
		userA.addGroup(uGroup);
		userA.addGroup(uGroup2);
		userB.addGroup(uGroup2);
		userC.addGroup(uGroup);
		userD.addGroup(uGroup);
		
		userDao.save(userA);
		userDao.save(userB);
		userDao.save(userC);
		userDao.save(userD);
		
		Event event = new Event();
		Date start = new Date();
		Date end = new Date();
		
		String title = "SWENGA Presentation";

		
			event.setTitle(title);
			event.setDescription("Present our awesome event calendar.");
			event.setLocation("FH Joanneum");
			
			event.setUserGroup(uGroup);

			Calendar calS = Calendar.getInstance();
			calS.setTime(start);
			calS.set(Calendar.DATE, 26);
			calS.set(Calendar.MONTH, 5); //start with 0
			calS.set(Calendar.YEAR, 2015);
			calS.set(Calendar.HOUR_OF_DAY, 9);
			calS.set(Calendar.MINUTE, 0);
			Date newStart = calS.getTime();
			event.setStart(newStart);
			
			Calendar calE = Calendar.getInstance();
			calE.setTime(end);
			calE.set(Calendar.DATE, 26);
			calE.set(Calendar.MONTH, 5);
			calE.set(Calendar.YEAR, 2015);
			calE.set(Calendar.HOUR_OF_DAY, 11);
			calE.set(Calendar.MINUTE, 40);
			Date newEnd = calE.getTime();
			event.setEnd(newEnd);
			event.setAllDay(false);
			
			eventDao.save(event);
			
			userA.addEvent(event);
			userC.addEvent(event);
			userD.addEvent(event);
			userDao.save(userA);
			userDao.save(userC);
			userDao.save(userD);
		

			Notification note1 = new Notification(event.getId(), event.getTitle(), event.getUserGroup().getName(), 1, false, userC.getUsername());
			Notification note2 = new Notification(event.getId(), event.getTitle(), event.getUserGroup().getName(), 1, false, userD.getUsername());
			notificationDao.save(note1);
			notificationDao.save(note2);
		
		
		return "redirect:/calendar";
	}
}
