package com.adwb.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.adwb.dao.api.CompanyDAO;
import com.adwb.dao.api.UserDAO;
import com.adwb.dao.entity.CompanyData;
import com.adwb.dao.entity.UserData;

@Controller
public class BaseController {

	@Autowired
	UserDAO userDAO;
	
	@Autowired
	CompanyDAO companyDao;
	

	@RequestMapping(value = "/")
	public String getHomePage(HttpServletRequest request) {
		request.setAttribute("status", "");
		return "index";
	}

	@RequestMapping(value = "/register")
	public String getRegistrationPage(HttpServletRequest request) {
		request.setAttribute("status", "");
		return "registration";
	}

	@RequestMapping(value = "/insertData", method = RequestMethod.POST)
	public String insertData(HttpServletRequest request) {
		UserData userData = new UserData(0, request.getParameter("inputName"), request.getParameter("inputEmail"),
				request.getParameter("inputMobile"), request.getParameter("inputPassword"),
				request.getParameter("inputUsername"), request.getParameter("role"));
		String urlStr = "https://www.google.com/recaptcha/api/siteverify";
		try {
			URL url = new URL(urlStr);
			HttpURLConnection httpURLConnection = (HttpURLConnection) url.openConnection();
			httpURLConnection.setRequestMethod("POST");
			httpURLConnection.setDoInput(true);
			httpURLConnection.setDoOutput(true);

			OutputStream outputStream = (OutputStream) httpURLConnection.getOutputStream();
			String postParams = "secret=6Lc_N24UAAAAAOuextQjObE7vUMwk2H_qeNvPTKj" + "&response="
					+ request.getParameter("g-recaptcha-response");
			outputStream.write(postParams.getBytes());
			outputStream.flush();
			outputStream.close();

			BufferedReader bufferedReader = new BufferedReader(
					new InputStreamReader(httpURLConnection.getInputStream()));
			StringBuilder stringBuilder = new StringBuilder();
			String data = "";
			while ((data = bufferedReader.readLine()) != null) {
				stringBuilder.append(data);
			}

			JSONObject jsonObject = new JSONObject(stringBuilder.toString());
			if ((boolean) jsonObject.get("success")) {
				userDAO.insert(userData);
				request.setAttribute("status", "Registration Successfull! Thank You!");
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "registration";
	}

	@RequestMapping(value = "/checkLogin", method = RequestMethod.POST)
	public String checkLogin(HttpServletRequest request, RedirectAttributes redirectAttributes) {

		String urlStr = "https://www.google.com/recaptcha/api/siteverify";
		try {
			URL url = new URL(urlStr);
			HttpURLConnection httpURLConnection = (HttpURLConnection) url.openConnection();
			httpURLConnection.setRequestMethod("POST");
			httpURLConnection.setDoInput(true);
			httpURLConnection.setDoOutput(true);

			OutputStream outputStream = (OutputStream) httpURLConnection.getOutputStream();
			String postParams = "secret=6Lc_N24UAAAAAOuextQjObE7vUMwk2H_qeNvPTKj" + "&response="
					+ request.getParameter("g-recaptcha-response");
			outputStream.write(postParams.getBytes());
			outputStream.flush();
			outputStream.close();

			BufferedReader bufferedReader = new BufferedReader(
					new InputStreamReader(httpURLConnection.getInputStream()));
			StringBuilder stringBuilder = new StringBuilder();
			String data = "";
			while ((data = bufferedReader.readLine()) != null) {
				stringBuilder.append(data);
			}

			JSONObject jsonObject = new JSONObject(stringBuilder.toString());
			if ((boolean) jsonObject.get("success")) {
				List<UserData> userDatas = userDAO.getAllData();

				for (UserData userData : userDatas) {
					if (userData.getUsername().equalsIgnoreCase(request.getParameter("inputUsername"))
							&& userData.getPassword().equalsIgnoreCase(request.getParameter("inputPassword"))
							&& userData.getRole().equalsIgnoreCase("admin")) {
						redirectAttributes.addAttribute("id", userData.getId());
						return "redirect:/adminpanel";
					} else if (userData.getUsername().equalsIgnoreCase(request.getParameter("inputUsername"))
							&& userData.getPassword().equalsIgnoreCase(request.getParameter("inputPassword"))
							&& userData.getRole().equalsIgnoreCase("user")) {
						redirectAttributes.addAttribute("id", userData.getId());
						return "redirect:/userpanel";
					} else {
						request.setAttribute("status", "Invalid Username or Password!");
					}
				}

			} else {
				request.setAttribute("status", "Please check the recapcha!");
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "index";
	}

	@RequestMapping(value = "/adminpanel")
	public String openAdminPanel(HttpServletRequest request, @ModelAttribute("id") int id) {
		UserData userData = userDAO.getOne(id);
		request.setAttribute("uid", id);
		request.setAttribute("username", userData.getName());
		request.setAttribute("listOfCompanies", companyDao.getAll());
		return "adminpanel";
	}

	@RequestMapping(value = "/userpanel")
	public String openUserPanel(HttpServletRequest request, @ModelAttribute("id") int id) {
		UserData userData = userDAO.getOne(id);
		request.setAttribute("uid", id);
		request.setAttribute("username", userData.getName());
		return "userpanel";
	}
	
	@RequestMapping(value = "/compCreatebyAdmin")
	public String openCompCreatebyAdmin(HttpServletRequest request, @ModelAttribute("id") int id, RedirectAttributes redirectAttributes) {
		UserData userData = userDAO.getOne(id);
		request.setAttribute("uid", id);
		request.setAttribute("username", userData.getName());
		CompanyData companyData = new CompanyData(0, request.getParameter("compName"),request.getParameter("compAddress"), id, "Admin" , true);
		companyDao.insert(companyData);
		redirectAttributes.addAttribute("id", userData.getId());
		return "redirect:/adminpanel";
	}
	
	@RequestMapping(value = "/compUpdatebyAdmin")
	public String openCompUpdatebyAdmin(HttpServletRequest request, @ModelAttribute("id") int id,@ModelAttribute("compId") int compId,@ModelAttribute("status") boolean status, RedirectAttributes redirectAttributes) {
		UserData userData = userDAO.getOne(id);
		request.setAttribute("uid", id);
		request.setAttribute("username", userData.getName());
		CompanyData companyData = new CompanyData(compId, request.getParameter("compName"),request.getParameter("compAddress"), id, "Admin" , status);
		companyDao.update(companyData);
		redirectAttributes.addAttribute("id", userData.getId());
		return "redirect:/adminpanel";
	}
	
	@RequestMapping(value = "/compDeletebyAdmin")
	public String openCompDeletebyAdmin(HttpServletRequest request, @ModelAttribute("id") int id,@ModelAttribute("compId") int compId, RedirectAttributes redirectAttributes) {
		UserData userData = userDAO.getOne(id);
		request.setAttribute("uid", id);
		request.setAttribute("username", userData.getName());
		companyDao.delete(compId);
		redirectAttributes.addAttribute("id", userData.getId());
		return "redirect:/adminpanel";
	}

}
