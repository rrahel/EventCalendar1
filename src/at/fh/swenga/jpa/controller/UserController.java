package at.fh.swenga.jpa.controller;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import at.fh.swenga.jpa.dao.SimpleEventRepository;
import at.fh.swenga.jpa.dao.SimpleGroupRepository;
import at.fh.swenga.jpa.dao.SimpleUserRepository;
import at.fh.swenga.jpa.dao.SimpleUserRoleRepository;
import at.fh.swenga.jpa.model.Event;
import at.fh.swenga.jpa.model.User;
import at.fh.swenga.jpa.model.UserGroup;
import at.fh.swenga.jpa.model.UserRole;

@Controller
public class UserController {

	@Autowired
	SimpleUserRepository userDao;

	@Autowired
	SimpleUserRoleRepository userRoleDao;

	@Autowired
	SimpleEventRepository eventDao;

	@Autowired
	SimpleGroupRepository groupDao;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String handleLogin() {
		return "login";
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String handleRegister() {
		return "register";
	}

	

	
	
	@RequestMapping(value = "/profile", method = RequestMethod.POST)
	public String changeProfile(HttpServletRequest request,User user, BindingResult bindingResult, Model model,@RequestParam("file") CommonsMultipartFile file){
		
		
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User userfound = userDao.findOne(username);
		
		changeProfile(model, request, userfound, file);
		
		
		model.addAttribute("message",
				"Profile is changed " + userfound.getUsername());
		return "forward:/calendar";
	}
	

	
	public void changeProfile(Model model, HttpServletRequest request,
			User user, CommonsMultipartFile file) {

		String sName = request.getParameter("surname");
		user.setSurname(sName);
		String fName = request.getParameter("firstname");
		user.setFirstname(fName);
		String bDay = request.getParameter("dayOfBirth");
		Date date = convertDateToString(bDay, model);
		user.setDayOfBirth(date);
		
		
		// file upload
				if (!file.isEmpty() && file.getSize() < 5000000 && file.getContentType().equals("image/jpeg")){
					try {
						byte[] bytes = file.getBytes();

						user.setPicture(bytes);
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				} else if (!file.isEmpty()) {
					model.addAttribute("errorMessage", "Only jpeg-files with a maximum length of 5MB are allowed!");
				}
		
		
		
		userDao.save(user);

	}
	
	public Date convertDateToString(String dateString, Model model) {

		Date date = new Date();

		try {
			SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
			date = sdf.parse(dateString);
		} catch (Exception e) {
			model.addAttribute("errorMessage",
					"Date is invalid!");
		}
		return date;
	}
	
	
	
	

	
	
	
	@RequestMapping(value = "/createUser", method = RequestMethod.POST)
	public String createUser(@ModelAttribute User newUserModel,
			HttpServletRequest request, Model model) {
		
		if(userDao.findOneByUsername(newUserModel.getUsername()) == null){
			newUserModel.setEnabled(true);
			newUserModel.setStatus(false);
			newUserModel.setBackground("skin-green");
			newUserModel.setFirstDay(1);
			newUserModel.setWeekNumbers(false);
			newUserModel.setWeekends(true);
			newUserModel.setDefaultView("month");
			UserRole userRole = new UserRole(newUserModel, "ROLE_USER");
			userRoleDao.save(userRole);
			return "userGuide";
		} else {
			model.addAttribute("errorMessage", "The user already exists! You can login with it.");
			return "login";
		}
		
		
		
	}

	@RequestMapping(value = "/tutorial")
	public String showTutorial() {
		return "userGuide";
	}
	
	@RequestMapping(value = "/changeSkin", method = RequestMethod.GET)
	public String changeSkin(@RequestParam String skinName){
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		User user = userDao.findOne(username);
		user.setBackground(skinName);
		userDao.save(user);
		
		return "redirect:/calendar";
	}
	
	@RequestMapping(value = "/changeSettings", method = RequestMethod.POST)
	public String changeSettings(HttpServletRequest request) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		User user = userDao.findOne(username);
		
		String firstday = request.getParameter("firstDay");
		String weekends = request.getParameter("showWeekends");
		String weekNumbers = request.getParameter("showWeekNr");
		String defaultView = request.getParameter("defaultView");

		if(firstday.equals("Monday")) {
			user.setFirstDay(1);
		} else if (firstday.equals("Sunday")) {
			user.setFirstDay(0);
		}
		if (weekends == null) {
			user.setWeekends(false);
		} else if (weekends.equals("true")) {
			user.setWeekends(true);
		}
		if (weekNumbers == null) {
			user.setWeekNumbers(false);
		} else if (weekNumbers.equals("true")) {
			user.setWeekNumbers(true);
		}
		if (defaultView.equals("month")) {
			user.setDefaultView("month");
		} else if (defaultView.equals("week")) {
			user.setDefaultView("agendaWeek");
		} else if (defaultView.equals("day")) {
			user.setDefaultView("agendaDay");
		}
		
		userDao.save(user);
		
		return "redirect:/calendar";
	}
	
	@RequestMapping("/profilImage")
	public String getImage(HttpServletResponse response) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		User user = userDao.findOne(username);
		
		if (user.getPicture() != null){
			try {
				response.setHeader("Content-Disposition", "inline;filename=\""
						+ user.getSurname() + user.getFirstname() + "\"");
				OutputStream out = response.getOutputStream();
				response.setContentType("image/jpg");
				out.write(user.getPicture());
				out.flush();
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

}
