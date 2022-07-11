package com.tech.blog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.Helper;
import com.tech.blog.helper.connectionProvider;

/**
 * Servlet implementation class EditServlet
 */
@WebServlet("/EditServlet")
@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		//fetch all data
		String userEmail = request.getParameter("user_email");
		String userName = request.getParameter("user_name");
		String userPassword = request.getParameter("user_password");
		String userAbout = request.getParameter("user_about");
		Part part = request.getPart("images");
		String imageName = part.getSubmittedFileName();

		//get user from the session
		HttpSession s =  request.getSession();
		User user = (User)s.getAttribute("currentUser");
		user.setEmail(userEmail);
		user.setName(userName);
		user.setPassword(userPassword);
		user.setAbout(userAbout);
		String oldFile = user.getProfile();
		user.setProfile(imageName);
		
		//update database
		UserDao userDao = new UserDao(connectionProvider.getConnection());
		
		boolean ans = userDao.updateUser(user);
		if(ans) {
			out.println("updated to db");
			String path =request.getRealPath("/")+"pics" +File.separator+user.getProfile();
			//out.print(path);
			
			//delete code
			
			String pathToOldFile =request.getRealPath("/")+"pics" +File.separator+ oldFile;
			if(oldFile.equals("default.png")){
			Helper.deleteFile(pathToOldFile);
			}

			
				if(Helper.saveFile(part.getInputStream(), path) ){
					Message msg = new Message("Profile updated", "success", "alert-success");
					s.setAttribute("msg", msg);
					//out.println("Profile updated");
				}else {
				          //
				}
				
			}else {
				Message msg = new Message("Something went wrong...", "error", "alert-danger");
				s.setAttribute("msg", msg);
				out.println("file error");
	}
		response.sendRedirect("profile.jsp");

}

}
