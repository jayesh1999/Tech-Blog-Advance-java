package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.connectionProvider;

@WebServlet("/LoginServlet")
@MultipartConfig
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();

		String userEmail = request.getParameter("email");
		String userPassword = request.getParameter("password");

		// call dao method
		UserDao dao = new UserDao(connectionProvider.getConnection());
		User u = dao.getUserByEmailAndPassword(userEmail, userPassword);
		if (u == null) {
			// out.println("Invalid details try again");
			Message msg = new Message("Invalid Details ! Try with another", "error", "alert-danger");
			response.sendRedirect("login_page.jsp");
			HttpSession s = request.getSession();
			s.setAttribute("msg", msg);
			
		} else {
			out.println("Login Success");
			HttpSession s = request.getSession();
			s.setAttribute("currentUser", u);
			response.sendRedirect("profile.jsp");
		}

	}

}
